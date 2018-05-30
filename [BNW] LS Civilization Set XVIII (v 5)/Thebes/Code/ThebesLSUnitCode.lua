print("Thebes - Unit Code")

ContextPtr:SetHide(true)

local ThebesCivIDBuilding = {}
local ThebesLeaderIDTrait = {}
local ThebesPlayersBuilding = {}
local ThebesPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_THEBES_LS_MOD" then
		ThebesLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_THEBES" then
		ThebesCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if ThebesCivIDBuilding[player:GetCivilizationType()] then
			table.insert(ThebesPlayersBuilding, i)
		end
		if ThebesLeaderIDTrait[player:GetLeaderType()] then
			table.insert(ThebesPlayersTrait, i)
		end
	end
end

if #ThebesPlayersTrait > 0 then
	include("ThebesLSTraitCode")
	GiveTableOfValidTraitPlayers(ThebesPlayersTrait)
end
if #ThebesPlayersBuilding > 0 then
	include("ThebesLSBuildingCode")
	GiveTableOfValidBuildingPlayers(ThebesPlayersBuilding)
end

--unit 
local uUnit = GameInfoTypes.UNIT_LS_THEBES;
local HTHP = {}
local HPT = {}

GameEvents.UnitPrekill.Add(function(unitOwnerId, unitId, unitType, unitX, unitY, bDelay, eKillingPlayer)
	if bDelay then
		if eKillingPlayer ~= -1 then
			local kUnit = Players[unitOwnerId]:GetUnitByID(unitId);
			if kUnit:IsCombatUnit() then
				local gID = unitId .. "x" .. unitOwnerId .. "x" .. Game.GetGameTurn();
				HTHP[gID] = {}
				HPT[gID] = Map.GetPlot(unitX, unitY);
				for iUnit in Players[eKillingPlayer]:Units() do
					if iUnit:GetUnitType() == uUnit then
						HTHP[gID][iUnit] = {iUnit:GetDamage(), iUnit:IsOutOfAttacks(), iUnit:GetExperience()};
					end
				end
			end
		end
	else
		local gID = unitId .. "x" .. unitOwnerId .. "x" .. Game.GetGameTurn();
		if HTHP[gID] then
			for iUnit, data in pairs(HTHP[gID]) do
				if (data[1] < iUnit:GetDamage()) or (iUnit:GetPlot() == HPT[gID]) or (iUnit:GetExperience() > data[3]) or (iUnit:IsOutOfAttacks() ~= data[2]) then
					iUnit:SetMoves(iUnit:MaxMoves())
					break;
				end
			end
			HTHP[gID] = {}
		end
	end
end)