print("Flower of Enlightenment - Scotland Unit Code")

local ScotlandCivIDBuilding = {}
local ScotlandLeaderIDTrait = {}
local ScotlandPlayersBuilding = {}
local ScotlandPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_SCOTLAND_TRAIT" then
		ScotlandLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_SCOTS" then
		ScotlandCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if ScotlandCivIDBuilding[player:GetCivilizationType()] then
			table.insert(ScotlandPlayersBuilding, i)
		end
		if ScotlandLeaderIDTrait[player:GetLeaderType()] then
			table.insert(ScotlandPlayersTrait, i)
		end
	end
end

if #ScotlandPlayersTrait > 0 then
	include("ScotlandLSTraitCode")
	GiveTableOfValidTraitPlayers(ScotlandPlayersTrait)
end
if #ScotlandPlayersBuilding > 0 then
	include("ScotlandLSBuildingCode")
	GiveTableOfValidBuildingPlayers(ScotlandPlayersBuilding)
end

--

local HighlandP = GameInfoTypes.PROMOTION_HIGHLANDER_LS_MOD;
local SecondP = GameInfoTypes.PROMOTION_HIGHLANDER_AB_LS_MOD;

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	local cPlot = Map.GetPlot(x,y);
	if cPlot then
		local cUnit = Players[player]:GetUnitByID(unit);
		if cUnit:IsHasPromotion(HighlandP) or cUnit:IsHasPromotion(SecondP) then
			if cPlot:IsHills() then
				cUnit:SetHasPromotion( SecondP ,true);
				cUnit:SetHasPromotion( HighlandP ,false);
			else
				cUnit:SetHasPromotion( SecondP ,false);
				cUnit:SetHasPromotion( HighlandP ,true);
			end
		end
	end
end)