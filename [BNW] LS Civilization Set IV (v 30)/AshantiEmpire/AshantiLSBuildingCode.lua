print("Golden Stool - Ashanti Building Code")

local ValidPlayerTable = {}
local buildingUB = GameInfoTypes.BUILDING_LS_KENTE_LOOM;
local ActivePlayer = Game.GetActivePlayer();
local rIron = GameInfoTypes.RESOURCE_IRON;
local bDummyIron = GameInfoTypes.BUILDING_DUMMY_LS_ASHANTI_IRON;
local iPromotion = GameInfoTypes.PROMOTION_AKAN_LS_HERALDIC_2;
local DummyUB = GameInfoTypes.UNIT_AKAN_LS_MOD_WRITERCB;
local TourismB = MissionTypes.MISSION_ONE_SHOT_TOURISM;
local base = GameInfoTypes.PROMOTION_AKAN_LS_HERALDIC_1;

function GiveTableOfValidBuildingPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
		if iplayer == ActivePlayer then
			Events.SerialEventCityInfoDirty.Add(OnChangeEvent)
		end
	end
end

--promotion stuff

function DoTourismBoost(iUnit, iPlayer)
	local jUnit = Players[iPlayer]:InitUnit(DummyUB, iUnit:GetX(), iUnit:GetY());
	jUnit:PushMission(TourismB);
end

GameEvents.UnitPromoted.Add(function(ownerId, unitId, ePromotion)
	if iPromotion == ePromotion then
		local iUnit = Players[ownerId]:GetUnitByID(unitId);
		iUnit:SetHasPromotion(iPromotion, false)
		DoTourismBoost(iUnit, ownerId)
	end
end)

function IsInProperTerritoryForAction(iUnit, iPlayer, bAI)
	local pOwner = iUnit:GetPlot():GetOwner();
	if pOwner ~= -1 then
		if Players[pOwner]:GetTeam() ~= Players[iPlayer]:GetTeam() then
			if not Players[pOwner]:IsMinorCiv() then
				if not Players[pOwner]:IsBarbarian() then
					if (not bAI) or (Players[iPlayer]:GetInfluenceLevel(pOwner) < 4) then
						return true;
					end
				end
			end
		end
	end
	return false;
end

GameEvents.CanHavePromotion.Add(function(ownerId, unitId, ePromotion)
	if ePromotion == iPromotion then
		local iUnit = Players[ownerId]:GetUnitByID(unitId);
		if iUnit:GetLevel() > 3 then
			return IsInProperTerritoryForAction(iUnit, ownerId, false);
		else
			return false;
		end
	end
	return true;
end)

--can be built stuff

function GetShouldHaveCost(iCity)
	if iCity:IsHasBuilding(buildingUB) or (iCity:GetProductionBuilding() == buildingUB) then
		if not iCity:IsHasResourceLocal(rIron) then
			return 1;
		end
	end
	return 0;
end

function CheckAllCities(iPlayer)
	for iCity in Players[iPlayer]:Cities() do
		iCity:SetNumRealBuilding(bDummyIron, GetShouldHaveCost(iCity))
	end
end

GameEvents.CityCanConstruct.Add(function(playerID, cityID, buildingID)
	if buildingID == buildingUB then
		local iCity = Players[playerID]:GetCityByID(cityID);
		if not iCity:IsHasResourceLocal(rIron) then
			iCity:SetNumRealBuilding(bDummyIron, 1)
			if Players[playerID]:GetNumResourceAvailable(rIron, true) < 0 then
				iCity:SetNumRealBuilding(bDummyIron, 0)
				return false;				
			end
			if iCity:GetProductionBuilding() ~= buildingID then
				iCity:SetNumRealBuilding(bDummyIron, 0)
			end				
		end
	end
	return true;
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		CheckAllCities(iPlayer)
		if not Players[iPlayer]:IsHuman() then
			for iUnit in Players[iPlayer]:Units() do
				if iUnit:IsHasPromotion(base) then
					if iUnit:GetExperience() >= iUnit:ExperienceNeeded() then
						if iUnit:GetLevel() > 3 then
							if IsInProperTerritoryForAction(iUnit, iPlayer, true) then
								iUnit:SetLevel(iUnit:GetLevel() + 1);
								DoTourismBoost(iUnit, iPlayer)
							end
						end
					end
				end
			end
		end
	end
end)

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		CheckAllCities(iPlayer)
	end
end)

function OnChangeEvent()
	CheckAllCities(ActivePlayer)
end

