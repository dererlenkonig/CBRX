print("Golden Stool - Ashanti Trait Code")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LS4AshantiUA";
local ValidPlayerTable = {}
local DummyUB = GameInfoTypes.UNIT_AKAN_LS_MOD_WRITERCB;
local TourismB = MissionTypes.MISSION_ONE_SHOT_TOURISM;
local HelpB = {GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER, GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER2,GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER3,GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER4,GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER5, GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER6, GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER7, GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER8, GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER9, GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER10, GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER11, GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER12, GameInfoTypes.BUILDING_DUMMY_ASHANTI_DISABLER13}
local KeeperPromotionT = {GameInfoTypes.PROMOTION_LS_KEEPER_OF_GOLDEN_STOOL_I, GameInfoTypes.PROMOTION_LS_KEEPER_OF_GOLDEN_STOOL_II, GameInfoTypes.PROMOTION_LS_KEEPER_OF_GOLDEN_STOOL_III}
local dLand = GameInfoTypes.DOMAIN_LAND;

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end

function GetCurrentCombatBonusFromUA(iPlot, player)
	local iOwner = iPlot:GetOwner();
	if iOwner ~= -1 then
		if Players[player]:GetTeam() ~= Players[iOwner]:GetTeam() then
			if not Players[iOwner]:IsMinorCiv() then
				if not Players[iOwner]:IsBarbarian() then
					return math.min(3, Players[player]:GetInfluenceLevel(iOwner) - Players[iOwner]:GetInfluenceLevel(player))
				end
			end
		end
	end
	return 0;
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		for cUnit in Players[iPlayer]:Units() do
			if cUnit:IsCombatUnit() then
				if cUnit:GetDomainType() == dLand then
					local cBonus = GetCurrentCombatBonusFromUA(cUnit:GetPlot(), iPlayer)
					for i, promID in pairs(KeeperPromotionT) do
						cUnit:SetHasPromotion(promID, i == cBonus);
					end
				end
			end
		end
	end
end)

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	if ValidPlayerTable[player] then
		local iPlot = Map.GetPlot(x,y);
		if iPlot then
		local cUnit = Players[player]:GetUnitByID(unit);
			if cUnit:IsCombatUnit() then
				if cUnit:GetDomainType() == dLand then
					local cBonus = GetCurrentCombatBonusFromUA(iPlot, player)
					for i, promID in pairs(KeeperPromotionT) do
						cUnit:SetHasPromotion(promID, i == cBonus);
					end
				end
			end
		end
	end
end)

function IsCapitalVeryOrigin(iPlayer, iPlot)
	local iCity = iPlot:GetPlotCity();
	if iCity:GetOriginalOwner() == iPlayer then
		return iCity:IsOriginalMajorCapital();
	end
	return false;
end

GameEvents.SetPopulation.Add(function(x, y, o, n)
	if n == 0 then
		local iPlot = Map.GetPlot(x,y);
		local iOwner = iPlot:GetOwner();
		for i = 0, iPlot:GetNumUnits() - 1 do
			local rOwner = iPlot:GetUnit(i):GetOwner();
			if rOwner ~= iOwner then
				if ValidPlayerTable[rOwner] then
					if not Players[iOwner]:IsMinorCiv() then
						if not Players[iOwner]:IsBarbarian() then
							if not load(Players[rOwner], "LS4Acp" .. x .. "x" .. y) then
								save(Players[rOwner], "LS4Acp" .. x .. "x" .. y, 1)
								DoDominoNeFunction(rOwner, iPlot, iOwner, IsCapitalVeryOrigin(iOwner, iPlot))
							end
						end
					end
				end
				return;
			end
		end
	end
end)

function GetValidPlotForDomino(iPlot, rOwner, iOwner)
	for i = 0, 5 do
		local nPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), i);
		if nPlot then
			if nPlot:GetNumUnits() == 0 then
				if iPlot:GetOwner() == iOwner or iPlot:GetOwner() == rOwner then
					return nPlot;
				end
			elseif nPlot:GetUnit(0):GetOwner() == rOwner then
				return nPlot;
			end
		end
	end
	return nil;
end

function DoDominoNeFunction(iPlayer, iPlot, bPlayer, bOriginCapital)
	local nPlot = GetValidPlotForDomino(iPlot, iPlayer, bPlayer);
	if nPlot then
		local pPlayer = Players[iPlayer];
		local kCity;
		if bOriginCapital then
			local TourismBlast = 2 * Players[bPlayer]:GetJONSCultureEverGenerated() - pPlayer:GetInfluenceOn(bPlayer) - pPlayer:GetTourism();
			kCity = Players[iPlayer]:GetCapitalCity();
			if kCity then
				for i = 0, 12 do
					if TourismBlast >= (10 * math.pow(2, 12 - i)) then
						TourismBlast = TourismBlast - (10 * math.pow(2, 12 - i));
						kCity:SetNumRealBuilding(HelpB[13 - i], 1);
					end
				end
			end
		end
		local nUnit = pPlayer:InitUnit(DummyUB, nPlot:GetX(), nPlot:GetY());
		nUnit:PushMission(TourismB);
		if bOriginCapital then
			if kCity then
				for i = 0, 12 do
					kCity:SetNumRealBuilding(HelpB[13 - i], 0);
				end
			end
		end
	end
end
