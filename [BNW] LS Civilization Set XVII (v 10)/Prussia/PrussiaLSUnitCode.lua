print ("Army with the Army - PRussia UU code ")

local PrussiaCivIDBuilding = {}
local PrussiaLeaderIDTrait = {}
local PrussiaPlayersBuilding = {}
local PrussiaPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_PRUSSIA" then
		PrussiaLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_KRIEGSSCHULE" then
		PrussiaCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if PrussiaCivIDBuilding[player:GetCivilizationType()] then
			table.insert(PrussiaPlayersBuilding, i)
		end
		if PrussiaLeaderIDTrait[player:GetLeaderType()] then
			table.insert(PrussiaPlayersTrait, i)
		end
	end
end

if #PrussiaPlayersTrait > 0 then
	include("PrussiaLSTraitCode")
	GiveTableOfValidTraitPlayers(PrussiaPlayersTrait)
end
if #PrussiaPlayersBuilding > 0 then
	include("PrussiaLSBuildingCode")
	GiveTableOfValidBuildingPlayers(PrussiaPlayersBuilding)
end

-- Unique unit code 

local promON = GameInfoTypes.PROMOTION_LS_PRUSSIA_SIEGE_ON;
local promOFF = GameInfoTypes.PROMOTION_LS_PRUSSIA_SIEGE_OFF

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	if Map.GetPlot(x,y) then
		local cUnit = Players[player]:GetUnitByID(unit);
		if cUnit then
			if cUnit:IsHasPromotion(promON) or cUnit:IsHasPromotion(promOFF) then
				CheckCityPenalty(cUnit)
			end
		end
	end
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:IsHasPromotion(promON) or iUnit:IsHasPromotion(promOFF) then
			CheckCityPenalty(iUnit)
		end
	end
end)

function CheckCityPenalty(iUnit)
	local citystate = false;
	for i = 0, 5 do
		local iPlot = Map.PlotDirection(iUnit:GetX(), iUnit:GetY(), i);
		if iPlot then
			if iPlot:IsCity() then
				if Players[iPlot:GetPlotCity():GetOwner()]:IsMinorCiv() then
					citystate = true;
					break;
				end
			end
		end
	end
	iUnit:SetHasPromotion(promON, citystate)
	iUnit:SetHasPromotion(promOFF, not citystate)
end