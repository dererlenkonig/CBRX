print ("Scalping - Haida UB code")

include( "LSSaveUtils.lua" )
local ValidPlayerTable = {}
local bTotemPole = GameInfoTypes.BUILDING_LS_TOTEM_POLE;
local hTT = {}
local SpecialUnitTab = {}
SpecialUnitTab[GameInfoTypes.UNITCLASS_SCIENTIST] = GameInfoTypes.BUILDING_LS_HAIDA_DUMMY_SCIENTIST;
SpecialUnitTab[GameInfoTypes.UNITCLASS_ENGINEER] = GameInfoTypes.BUILDING_LS_HAIDA_DUMMY_ENGINEER;
SpecialUnitTab[GameInfoTypes.UNITCLASS_PROPHET] = GameInfoTypes.BUILDING_LS_HAIDA_DUMMY_PROPHET;
SpecialUnitTab[GameInfoTypes.UNITCLASS_ARTIST] = GameInfoTypes.BUILDING_LS_HAIDA_DUMMY_ARTIST;
SpecialUnitTab[GameInfoTypes.UNITCLASS_WRITER] = GameInfoTypes.BUILDING_LS_HAIDA_DUMMY_ARTIST;
SpecialUnitTab[GameInfoTypes.UNITCLASS_MUSICIAN] = GameInfoTypes.BUILDING_LS_HAIDA_DUMMY_ARTIST;
SpecialUnitTab[GameInfoTypes.UNITCLASS_MERCHANT] = GameInfoTypes.BUILDING_LS_HAIDA_DUMMY_MERCHANT;
SpecialUnitTab[GameInfoTypes.UNITCLASS_GREAT_GENERAL] = GameInfoTypes.BUILDING_LS_HAIDA_DUMMY_GREAT_GENERAL;
SpecialUnitTab[GameInfoTypes.UNITCLASS_GREAT_ADMIRAL] = GameInfoTypes.BUILDING_LS_HAIDA_DUMMY_GREAT_GENERAL;

for i,v in pairs(Players) do
	for iUnit in v:Units() do
		hTT[iUnit] = 1;
	end
end

function GiveTableOfValidBuildingPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = load(player .. "LSHaidaUB") or -1;
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		DoCheckAllCities(iPlayer);
	end
end)

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	if ValidPlayerTable[player] then
		local cPlot = Map.GetPlot(x,y);
		if cPlot then
			local cUnit = Players[player]:GetUnitByID(unit);
			if not hTT[cUnit] then
				hTT[cUnit] = 1;
				if SpecialUnitTab[cUnit:GetUnitClassType()] then
					ValidPlayerTable[player] = cUnit:GetUnitClassType();
					DoCheckAllCities(player)
				end
			end
		end
	end
end)

function DoCheckAllCities(iPlayer)
	for iCity in Players[iPlayer]:Cities() do
		for iclass, ibuilding in pairs(SpecialUnitTab) do
			iCity:SetNumRealBuilding(ibuilding, 0);
		end
		if iCity:IsHasBuilding(bTotemPole) then
			for iclass, ibuilding in pairs(SpecialUnitTab) do
				if (ValidPlayerTable[iPlayer] == iclass) then
					iCity:SetNumRealBuilding(ibuilding, 1);
				end
			end
		end
	end
end