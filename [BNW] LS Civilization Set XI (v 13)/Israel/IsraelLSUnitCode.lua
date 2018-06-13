print ("Exodus - Israeli Unit Code")

local IsraelCivIDBuilding = {}
local IsraelLeaderIDTrait = {}
local IsraelPlayersBuilding = {}
local IsraelPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_EXODUS" then
		IsraelLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_YESHIVA" then
		IsraelCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if IsraelCivIDBuilding[player:GetCivilizationType()] then
			table.insert(IsraelPlayersBuilding, i)
		end
		if IsraelLeaderIDTrait[player:GetLeaderType()] then
			table.insert(IsraelPlayersTrait, i)
		end
	end
end

if #IsraelPlayersTrait > 0 then
	include("IsraelLSTraitCode")
	GiveTableOfValidTraitPlayers(IsraelPlayersTrait)
end
if #IsraelPlayersBuilding > 0 then
	include("IsraelLSBuildingCode")
	GiveTableOfValidBuildingPlayers(IsraelPlayersBuilding)
end

