print("One thousand nights - Durrani Building Code")

local Amphi = GameInfoTypes.BUILDINGCLASS_AMPHITHEATER;
local bUnique = GameInfoTypes.BUILDING_LS_LITERATURE_NIGHT;
local DummyHap = GameInfoTypes.BUILDING_DUMMY_DUR_GW1;
local DurMountains = {}
local ValidPlayerTable = {}
local HitPolTab = {GameInfoTypes.POLICY_LS_DUR_R1, GameInfoTypes.POLICY_LS_DUR_R2, GameInfoTypes.POLICY_LS_DUR_R4, GameInfoTypes.POLICY_LS_DUR_R8, GameInfoTypes.POLICY_LS_DUR_R16, GameInfoTypes.POLICY_LS_DUR_R32, GameInfoTypes.POLICY_LS_DUR_F1, GameInfoTypes.POLICY_LS_DUR_F2, GameInfoTypes.POLICY_LS_DUR_F4, GameInfoTypes.POLICY_LS_DUR_F8, GameInfoTypes.POLICY_LS_DUR_F16, GameInfoTypes.POLICY_LS_DUR_F32}

function GiveTableOfValidBuildingPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
		local player = Players[iplayer];
		if not ( player:HasPolicy(HitPolTab[1]) or player:HasPolicy(HitPolTab[7]) ) then
			for i = 1, 6 do
				player:SetNumFreePolicies(1);
				player:SetNumFreePolicies(0);
				player:SetHasPolicy(HitPolTab[i+6], true);
			end
			player:ChangeScoreFromFutureTech(-24);
		end
	end
end

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:IsMountain() then
			table.insert(DurMountains, fPlot)
		end
	end
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		DurraniHapAndGWPointsCheck(iPlayer)
	end
end)

function EndTurnFunc(iPlayer)
	if ValidPlayerTable[iPlayer] then
		DurraniHapAndGWPointsCheck(iPlayer)
	end
end
Events.AIProcessingEndedForPlayer.Add(EndTurnFunc)

function GetBonusFromMountains(dCity, iPlayer)
	local cbonus = 1;
	for i, iPlot in pairs(DurMountains) do
		if iPlot:GetOwner() == iPlayer then
			if Map.PlotDistance(dCity:GetX(), dCity:GetY(), iPlot:GetX(), iPlot:GetY()) < 3 then
				cbonus = 2;
				if Map.PlotDistance(dCity:GetX(), dCity:GetY(), iPlot:GetX(), iPlot:GetY()) < 2 then
					return 3;
				end
			end
		end
	end
	return cbonus;
end

GameEvents.CityConstructed.Add(function(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if buildingType == bUnique then
		DurraniHapAndGWPointsCheck(ownerId)
	end
end)

function DurraniHapAndGWPointsCheck(iPlayer)
	local dBonus = 0;
	for dCity in Players[iPlayer]:Cities() do
		dCity:SetNumRealBuilding(DummyHap, 0)
		if dCity:IsHasBuilding(bUnique) then
			dBonus = dBonus + GetBonusFromMountains(dCity, DurPrePlayer)
			if dCity:GetBuildingGreatWork(Amphi, 0) ~= -1 then
				dCity:SetNumRealBuilding(DummyHap, 1)
			end
		end
	end
	for i = 0, 5 do
		local UberHit = false;
		if dBonus >= math.pow(2, 5 - i) then
			dBonus = dBonus - math.pow(2, 5 - i);
			UberHit = true;
		end
		Players[iPlayer]:SetHasPolicy(HitPolTab[6-i], UberHit);
		Players[iPlayer]:SetHasPolicy(HitPolTab[12-i], not UberHit);
	end
end