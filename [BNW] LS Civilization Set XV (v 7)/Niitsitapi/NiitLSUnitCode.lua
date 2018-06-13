print("Lord of the Rings - Niit UU code ")

include("LSSaveUtils")
local NiitCivIDBuilding = {}
local NiitLeaderIDTrait = {}
local NiitPlayersBuilding = {}
local NiitPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_NIIT" then
		NiitLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

local impcivID = GameInfoTypes[ GameInfo.Improvements["IMPROVEMENT_LS_NIIT_TIPI"].CivilizationType]
if impcivID then
	NiitCivIDBuilding[impcivID] = 1;
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if NiitCivIDBuilding[player:GetCivilizationType()] then
			table.insert(NiitPlayersBuilding, i)
		end
		if NiitLeaderIDTrait[player:GetLeaderType()] then
			table.insert(NiitPlayersTrait, i)
		end
	end
end

if #NiitPlayersTrait then
	include("NiitLSTraitCode")
	GiveTableOfValidTraitPlayers(NiitPlayersTrait)
end

if #NiitPlayersBuilding > 0 then
	include("NiitLSImproCode")
	GiveTableOfValidBuildingPlayers(NiitPlayersBuilding)
end
-- Unique unit code 

local UUID = GameInfoTypes.UNIT_LS_WAR_PARTY;
local WorkerID = GameInfoTypes.UNIT_WORKER;
local isValidT = {}

function PreKillFunction(unitOwnerId, unitId, unitType, unitX, unitY, bDelay, eKillingPlayer)
	if bDelay then
		if math.random(1,4) == 3 then
			if eKillingPlayer ~= -1 then
				local kUnit = Players[unitOwnerId]:GetUnitByID(unitId);
				if kUnit:IsCombatUnit() then
					local gID = unitId .. "x" .. unitOwnerId .. "x" .. Game.GetGameTurn();
					isValidT[gID] = eKillingPlayer;
				end
			end
		end
	else
		local gID = unitId .. "x" .. unitOwnerId .. "x" .. Game.GetGameTurn();
		if isValidT[gID] then
			local dPlot = Map.GetPlot(unitX, unitY);
			if dPlot:GetNumUnits() == 2 then
				for i = 0, 1 do
					local dUnit = dPlot:GetUnit(i);
					if dUnit:GetUnitType() == UUID then
						if dUnit:GetOwner() == isValidT[gID] then
							local jUnit = Players[isValidT[gID]]:InitUnit(WorkerID, unitX, unitY)
							jUnit:SetMoves(0)
							return;
						end
					end
				end
			end
		end
	end
end
GameEvents.UnitPrekill.Add(PreKillFunction)