print("Burma - Unit Code")

include( "LSSaveUtils" );

local BurmaCivIDBuilding = {}
local BurmaLeaderIDTrait = {}
local BurmaPlayersBuilding = {}
local BurmaPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_BURMA_LS_MOD" then
		BurmaLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

local impcivID = GameInfoTypes[ GameInfo.Improvements["IMPROVEMENT_LS_BURMA"].CivilizationType]
if impcivID then
	BurmaCivIDBuilding[impcivID] = 1;
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if BurmaCivIDBuilding[player:GetCivilizationType()] then
			table.insert(BurmaPlayersBuilding, i)
		end
		if BurmaLeaderIDTrait[player:GetLeaderType()] then
			table.insert(BurmaPlayersTrait, i)
		end
	end
end

if #BurmaPlayersTrait > 0 then
	include("BurmaLSTraitCode")
	GiveTableOfValidTraitPlayers(BurmaPlayersTrait)
end
if #BurmaPlayersBuilding > 0 then
	include("BurmaLSImprovementCode")
	GiveTableOfValidImproPlayers(BurmaPlayersBuilding)
end

--