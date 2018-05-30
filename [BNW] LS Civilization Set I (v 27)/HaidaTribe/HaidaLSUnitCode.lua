print ("Scalping - Haida UU code")

local HaidaCivIDBuilding = {}
local HaidaLeaderIDTrait = {}
local HaidaPlayersBuilding = {}
local HaidaPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_SCALPING" then
		HaidaLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_TOTEM_POLE" then
		HaidaCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if HaidaCivIDBuilding[player:GetCivilizationType()] then
			table.insert(HaidaPlayersBuilding, i)
		end
		if HaidaLeaderIDTrait[player:GetLeaderType()] then
			table.insert(HaidaPlayersTrait, i)
		end
	end
end

if #HaidaPlayersTrait > 0 then
	include("HaidaLSTraitCode")
	GiveTableOfValidTraitPlayers(HaidaPlayersTrait)
end
if #HaidaPlayersBuilding > 0 then
	include("HaidaLSBuildingCode")
	GiveTableOfValidBuildingPlayers(HaidaPlayersBuilding)
end

--Unique Unit Code

local TriremeC = GameInfoTypes.UNITCLASS_TRIREME;
local WarCanoe = GameInfoTypes.UNIT_LS_WAR_CANOE;
local Forest = GameInfoTypes.FEATURE_FOREST;

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	if Players[iPlayer]:GetUnitClassCount(TriremeC) > 0 then
		for iUnit in Players[iPlayer]:Units() do
			if iUnit:GetUnitType() == WarCanoe then
				ExtraHeal(iUnit)
			end
		end
	end
end)

function ExtraHeal(cUnit)
	local cPlot = cUnit:GetPlot();
	for i = 0, 5 do
		local iPlot = Map.PlotDirection(cPlot:GetX(), cPlot:GetY(), i)
		if iPlot then
			if iPlot:GetFeatureType() == Forest then
				cUnit:ChangeDamage(-10);
				return;
			end
		end
	end
end