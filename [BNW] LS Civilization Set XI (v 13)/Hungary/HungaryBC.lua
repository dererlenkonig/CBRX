print ("Last Bastion - Hungary Code")

local HungaryCivIDBuilding = {}
local HungaryLeaderIDTrait = {}
local HungaryPlayersBuilding = {}
local HungaryPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_HUNGARY_LS" then
		HungaryLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_VEGVAR" then
		HungaryCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if HungaryCivIDBuilding[player:GetCivilizationType()] then
			table.insert(HungaryPlayersBuilding, i)
		end
		if HungaryLeaderIDTrait[player:GetLeaderType()] then
			table.insert(HungaryPlayersTrait, i)
		end
	end
end

if #HungaryPlayersTrait > 0 then
	include("HungaryLSTraitCode")
	GiveTableOfValidTraitPlayers(HungaryPlayersTrait, HungaryPlayersBuilding)
end