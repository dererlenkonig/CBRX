print ("Ndongo - Ndongo UU code ")

local NdongoCivIDBuilding = {}
local NdongoLeaderIDTrait = {}
local NdongoPlayersBuilding = {}
local NdongoPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_NDONGO" then
		NdongoLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_NDONGO_UB" then
		NdongoCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if NdongoCivIDBuilding[player:GetCivilizationType()] then
			table.insert(NdongoPlayersBuilding, i)
		end
		if NdongoLeaderIDTrait[player:GetLeaderType()] then
			table.insert(NdongoPlayersTrait, i)
		end
	end
end

if #NdongoPlayersTrait > 0 then
	include("NdongoLSTraitCode")
	GiveTableOfValidTraitPlayers(NdongoPlayersTrait)
end
if #NdongoPlayersBuilding > 0 then
	include("NdongoLSBuildingCode")
	GiveTableOfValidBuildingPlayers(NdongoPlayersBuilding)
end

--Unit
local hTab = {GameInfoTypes.PROMOTION_LS_NDONGO_CHARGE_BASE_I, GameInfoTypes.PROMOTION_LS_NDONGO_CHARGE_BASE_II, GameInfoTypes.PROMOTION_LS_NDONGO_CHARGE_BASE_III, GameInfoTypes.PROMOTION_LS_NDONGO_CHARGE_BASE_IV, GameInfoTypes.PROMOTION_LS_NDONGO_CHARGE_BASE_V};
local pBase = GameInfoTypes.PROMOTION_LS_NDONGO_CHARGE_BASE;

function GetValidProm(iUnit)
	for i, prom in pairs(hTab) do
		if iUnit:IsHasPromotion(prom) then
			return math.min(i + 1, 5);
		end
	end
	return 1;
end

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:IsHasPromotion(pBase) then
			local type = GetValidProm(iUnit);
			for i, prom in pairs(hTab) do
				iUnit:SetHasPromotion(prom, i == type);
			end
		end
	end
end)