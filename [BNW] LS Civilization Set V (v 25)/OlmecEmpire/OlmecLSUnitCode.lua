print("Colossal Heads - Olmec Unit Code")

local OlmecCivIDBuilding = {}
local OlmecLeaderIDTrait = {}
local OlmecPlayersBuilding = {}
local OlmecPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_OLMEC_TRAIT" then
		OlmecLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_COLOSSAL_HEADS" then
		OlmecCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if OlmecCivIDBuilding[player:GetCivilizationType()] then
			table.insert(OlmecPlayersBuilding, i)
		end
		if OlmecLeaderIDTrait[player:GetLeaderType()] then
			table.insert(OlmecPlayersTrait, i)
		end
	end
end

if #OlmecPlayersTrait > 0 then
	include("OlmecLSTraitCode")
	GiveTableOfValidTraitPlayers(OlmecPlayersTrait)
end
if #OlmecPlayersBuilding > 0 then
	include("OlmecLSBuildingCode")
	GiveTableOfValidBuildingPlayers(OlmecPlayersBuilding)
end

--

local PromID = GameInfoTypes.PROMOTION_OLMEC_UNWELCOME;
local GoodHut = GameInfoTypes.IMPROVEMENT_GOODY_HUT;
local GoodyHuts = {}
local unitWar = GameInfoTypes.UNIT_WARRIOR;
local unitTl = GameInfoTypes.UNIT_TLAMACAZQUI;

function OBxy(player, unit, x, y)
	if Players[player]:GetUnitByID(unit) ~= nil then
		local cUnit = Players[player]:GetUnitByID(unit);
		if cUnit:IsHasPromotion( PromID ) then
			cPlot = cUnit:GetPlot();
			if cPlot ~= nil then
				AncientMap(x, y, player)
			end
		end
	end
end

function AncientMap(cX, cY, player)
	for plot, bool in pairs(GoodyHuts) do
		if Map.PlotDistance(plot:GetX(), plot:GetY(), cX, cY) < 6 then
			if not plot:IsRevealed(Players[player]:GetTeam()) then
				if plot:GetImprovementType() == GoodHut then
					plot:SetRevealed(Players[player]:GetTeam(), true);
					if player == Game.GetActivePlayer() then
						plot:UpdateFog()
					end
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(OBxy)

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:GetImprovementType() == GoodHut then
			GoodyHuts[fPlot] = true;
		end
	end
	for i, v in pairs(Players) do
		for iUnit in v:Units() do
			if iUnit:IsHasPromotion( PromID ) then
				AncientMap(iUnit:GetX(), iUnit:GetY(), i)
			end
		end
	end
end)

function OBCheck(iPlayer)
	if Players[iPlayer]:IsBarbarian() then
		GHreduction()
	end
end
GameEvents.PlayerDoTurn.Add(OBCheck)

function GHreduction()
	GoodyTrue = true;
	for plot, bool in pairs(GoodyHuts) do
		if plot:GetImprovementType() ~= GoodHut then
			GoodyHuts[plot] = nil;
		else
			GoodyTrue = false;
		end
	end
	if GoodyTrue then
		GameEvents.PlayerDoTurn.Remove(OBCheck)
		GameEvents.UnitSetXY.Remove(OBxy)
	end
end

GameEvents.CityTrained.Add(function(ownerId, cityId, unitId, bGold, bFaithOrCulture)
	if Players[ownerId]:GetUnitByID(unitId):IsHasPromotion( PromID ) then
		AncientMap(Players[ownerId]:GetUnitByID(unitId):GetX(), Players[ownerId]:GetUnitByID(unitId):GetY(), ownerId)
	end
end)

Events.SequenceGameInitComplete.Add(function()
	if Game.GetElapsedGameTurns() == 0 then
		local OlmecUnitCivID = {}
		for row in GameInfo.Civilization_UnitClassOverrides() do
			if row.UnitType == "UNIT_TLAMACAZQUI" then
				OlmecUnitCivID[GameInfoTypes[row.CivilizationType]] = 1;
			end
		end
		for i, player in pairs(Players) do
			if OlmecUnitCivID[player:GetCivilizationType()] then
				if player:IsEverAlive() then
					for iUnit in player:Units() do
						if iUnit:GetUnitType() == unitWar then
							local iX = iUnit:GetX()
							local iY = iUnit:GetY()
							iUnit:Kill();
							player:InitUnit(unitTl,iX, iY);
							AncientMap(iX, iY, i)
							break;
						end
					end
				end
			end
		end
	end
end)