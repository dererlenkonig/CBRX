print ("Philosophy - Athens UU code ")

include("FLuaVector.lua")

local AthensCivIDBuilding = {}
local AthensLeaderIDTrait = {}
local AthensPlayersBuilding = {}
local AthensPlayersTrait = {}
local TJJapanCivIDUnit = {}
local TJJapanValidUnitPlayers = {}

for row in GameInfo.Civilization_UnitClassOverrides() do
	if row.UnitType == "UNIT_LS_DELIAN_TRIREME" then
		TJJapanCivIDUnit[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_ATHENS" then
		AthensLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_LONG_WALLS" then
		AthensCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if AthensCivIDBuilding[player:GetCivilizationType()] then
			table.insert(AthensPlayersBuilding, i)
		end
		if AthensLeaderIDTrait[player:GetLeaderType()] then
			table.insert(AthensPlayersTrait, i)
		end
		if TJJapanCivIDUnit[player:GetCivilizationType()] then
			TJJapanValidUnitPlayers[i] = 1;
		end
	end
end

if #AthensPlayersTrait > 0 then
	include("AthensLSTraitCode")
	GiveTableOfValidTraitPlayers(AthensPlayersTrait)
end
if #AthensPlayersBuilding > 0 then
	include("AthensLSBuildingCode")
	GiveTableOfValidBuildingPlayers(AthensPlayersBuilding)
end

-- Unique unit code 

local bTrireme = GameInfoTypes.UNIT_LS_DELIAN_TRIREME;
local dSave = GameInfoTypes.BUILDINGCLASS_DUMMY_LS_ATHENS_SAVE;
local TLSHT = {}
local TLSOT = {}
local TLSOC = 0;
local TLSOV = {}
local hMinorT = {}
local HTHP = {}
local HPT = {}
local HST = {}

for i,v in pairs(Players) do
	if v:IsMinorCiv() then
		if v:IsEverAlive() then
			table.insert(hMinorT, i)
		end
	end
end

function OceanTahCh(iPlot)
	for i = 1, TLSOC do
		if TLSOT[i][iPlot] then
			return i;
		end
	end
	print("Tahitian Mod reporting in: Failure")
	return 0;
end

function DoRecalculatePossibleStuff()
	TLSHT = {}
	TLSOT = {}
	TLSOC = 0;
	TLSOV = {}
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if not TLSHT[fPlot] then
			if fPlot:IsWater() then
				TLSOC = TLSOC + 1;
				TLSOT[TLSOC] = {}
				TLSOV[TLSOC] = {}
				OceanITP(fPlot, TLSOC)
			end
		end
	end
	TLSHT = nil;
end

Events.SequenceGameInitComplete.Add(function()
	DoRecalculatePossibleStuff()
end)

function OceanITP(iPlot, oceanID)
	TLSHT[iPlot] = 1;
	TLSOT[oceanID][iPlot] = 1;
	for j = 0, 5 do
		local jPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), j);
		if jPlot then
			if not TLSHT[jPlot] then
				if jPlot:IsWater() then
					OceanITP(jPlot, oceanID)
				else
					TLSOV[oceanID][jPlot] = 1;
				end
			end
		end
	end
end

function GetTableOfSurroundingOceans(iCity)
	local tTab = {}
	for i = 0, 5 do
		local iPlot = Map.PlotDirection(iCity:GetX(), iCity:GetY(), i);
		if iPlot then
			if iPlot:IsWater() then
				tTab[OceanTahCh(iPlot)] = 1;
			end
		end
	end
	return tTab;
end

--End of Continent Stuff

function GetProperTableOfNearbyOceans(iPlot)
	local hTab = {}
	for i = 0, 5 do
		local jPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), i);
		if jPlot then
			if jPlot:IsWater() then
				hTab[OceanTahCh(jPlot)] = 1;
			end
		end
	end
	return hTab;
end

function DoCheckByWater(iPlot, iPlayer, tab, val, plot)
	local hminor;
	local mindis = 999;
	for i, minor in pairs(hMinorT) do
		if Teams[Players[iPlayer]:GetTeam()]:IsHasMet(Players[minor]:GetTeam()) then
			if not Teams[Players[iPlayer]:GetTeam()]:IsAtWar(Players[minor]:GetTeam()) then
				for iCity in Players[minor]:Cities() do
					for coastID, sth in pairs(tab) do
						if TLSOV[coastID][iCity:Plot()] then
							if Map.PlotDistance(iCity:GetX(), iCity:GetY(), iPlot:GetX(), iPlot:GetY()) < mindis then
								mindis = Map.PlotDistance(iCity:GetX(), iCity:GetY(), iPlot:GetX(), iPlot:GetY());
								hminor = minor;
							end
							break;
						end
					end
				end
			end
		end
	end
	if hminor then
		Players[hminor]:ChangeMinorCivFriendshipWithMajor(iPlayer, val)
		if plot then
			if iPlayer == Game.GetActivePlayer() then
				Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(plot:GetX(), plot:GetY()))), "+" .. val .. "[ICON_INFLUENCE]", 0)
			end
		end
	end
end

GameEvents.UnitPrekill.Add(function(unitOwnerId, unitId, unitType, unitX, unitY, bDelay, eKillingPlayer)
	if bDelay then
		if eKillingPlayer ~= -1 then
			local kUnit = Players[unitOwnerId]:GetUnitByID(unitId);
			if kUnit:IsBarbarian() then
				if kUnit:GetPlot():IsWater() then
					if kUnit:GetBaseCombatStrength() > 0 then
						local gID = unitId .. "x" .. unitOwnerId .. "x" .. Game.GetGameTurn();
						HTHP[gID] = {}
						HPT[gID] = Map.GetPlot(unitX, unitY);
						HST[gID] = kUnit:GetBaseCombatStrength();
						for iUnit in Players[eKillingPlayer]:Units() do
							if iUnit:GetUnitType() == bTrireme then
								HTHP[gID][iUnit] = {iUnit:GetDamage(), iUnit:IsOutOfAttacks(), iUnit:GetExperience()};
							end
						end
					end
				end
			end
		end
	else
		local gID = unitId .. "x" .. unitOwnerId .. "x" .. Game.GetGameTurn();
		if HTHP[gID] then
			for iUnit, data in pairs(HTHP[gID]) do
				if (data[1] < iUnit:GetDamage()) or (iUnit:GetPlot() == HPT[gID]) or (iUnit:GetExperience() > data[3]) or (iUnit:IsOutOfAttacks() ~= data[2]) then
					DoCheckByWater(iUnit:GetPlot(), iUnit:GetOwner(), {[OceanTahCh(HPT[gID])] = 1}, HST[gID], iUnit:GetPlot())
					break;
				end
			end
			HTHP[gID] = {}
		end
	end
end)

function AdjustTeppuProductionJustRight(iCity, fcBonus)
	local pBonus = iCity:GetBuildingYieldChange(dSave, yFaith);
	local cBonus = fcBonus;
	if cBonus ~= pBonus then
		local cProdBonus = math.floor(iCity:GetUnitProductionNeeded(bTrireme) * 0.01 * cBonus + 0.49)
		local pProdBonus = math.floor(iCity:GetUnitProductionNeeded(bTrireme) * 0.01 * pBonus + 0.49)
		iCity:ChangeUnitProduction(uTeppu, cProdBonus - pProdBonus);
		iCity:SetBuildingYieldChange(dSave, yFaith, cBonus)
	end
end

function GetBonusTowardsTrireme(iPlayer)
	for i, v in pairs(Players) do
		if v:IsMinorCiv() and v:IsAlive() and v:GetAlly() == iPlayer then
			return 75;
		end
	end
	return 0;
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if TJJapanValidUnitPlayers[iPlayer] then
		local gbonus = GetBonusTowardsTrireme(iPlayer);
		for iCity in Players[iPlayer]:Cities() do
			if iCity:CanTrain(bTrireme, 1) then
				AdjustTeppuProductionJustRight(iCity, gbonus)
			end
		end
	end
end)