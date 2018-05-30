print ("Roof of the World - Nepal Unit code")

local NepalCivIDBuilding = {}
local NepalLeaderIDTrait = {}
local NepalPlayersBuilding = {}
local NepalPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_ROOF_OF_THE_WORLD" then
		NepalLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_RICE_TERRACE" then
		NepalCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if NepalCivIDBuilding[player:GetCivilizationType()] then
			table.insert(NepalPlayersBuilding, i)
		end
		if NepalLeaderIDTrait[player:GetLeaderType()] then
			table.insert(NepalPlayersTrait, i)
		end
	end
end

if #NepalPlayersTrait + #NepalPlayersBuilding> 0 then
	include("NepalLSTraitCode")
	GiveTableOfValidTraitPlayers(NepalPlayersTrait)
	GiveTableOfValidBuildingPlayers(NepalPlayersBuilding)
end

-- Unique unit code

local NepXP = 2.5 - 0.5 * Game.GetGameSpeedType();
local iProm = GameInfoTypes.PROMOTION_GURKHA_MOD;

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:IsHasPromotion(iProm) then
			iUnit:ChangeExperience(NepXP);
		end
	end
end)