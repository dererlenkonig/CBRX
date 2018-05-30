-- Lua Script1
-- Author: User
-- DateCreated: 6/26/2014 9:44:09 PM
--==========================================================================================================================
-- UTILITY FUNCTIONS (Taken from JFD's Carthage)
--==========================================================================================================================
include("PlotIterators")
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationAblaiID = GameInfoTypes["CIVILIZATION_DJSH_KAZAKH"]

function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end
--------------------------------------------------------------------------------------------------------------------------
-- GetRandom
--------------------------------------------------------------------------------------------------------------------------
function GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_AblaiLandClaims
----------------------------------------------------------------------------------------------------------------------------
function JFD_AblaiLandClaims(playerID, iX, iY)
	local player = Players[playerID]
	if player:GetCivilizationType() == civilisationAblaiID then
		local playerTeam = player:GetTeam()
		local plot = Map.GetPlot(iX, iY)
		local city = plot:GetPlotCity()
		local cityID = city:GetID()
		for adjacentPlot in PlotAreaSweepIterator(plot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
			x = adjacentPlot:GetX()
			y = adjacentPlot:GetY()
			if adjacentPlot:GetOwner() == -1 and (adjacentPlot:GetTerrainType() == GameInfoTypes["TERRAIN_PLAINS"] or adjacentPlot:GetTerrainType() == GameInfoTypes["TERRAIN_GRASS"]) and adjacentPlot:IsFlatlands() and adjacentPlot:GetFeatureType() == FeatureTypes.NO_FEATURE then
				adjacentPlot:SetOwner(playerID, cityID, true, true)
				adjacentPlot:SetRevealed(playerTeam, true)
			end
		end

		Sukritact_PlaceKazakhResource(city)
	end 	
end

if JFD_IsCivilisationActive(civilisationAblaiID) then 
	GameEvents.PlayerCityFounded.Add(JFD_AblaiLandClaims)
end
--------------------------------------------------------------
-- Sukritact_PlaceKazakhResource
--------------------------------------------------------------
iResourceSheep = GameInfoTypes.RESOURCE_SHEEP
iResourceCow = GameInfoTypes.RESOURCE_COW
iResourceHorse = GameInfoTypes.RESOURCE_HORSE
iRadius = 2

function Sukritact_PlaceKazakhResource(pCity)
    local pPlot = pCity:Plot()
    local tPlots = {}
    local iNumtoPlace = 1
    for pLoopPlot in PlotAreaSweepIterator(pPlot, iRadius, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
        table.insert(tPlots, pLoopPlot)
    end
	
    for iVal = 1, iNumtoPlace do
		local bPlaced = false
		while (not(bPlaced)) and #tPlots > 0 do
			local iRandom = GetRandom(1, #tPlots)
			local pPlot = tPlots[iRandom]
			if (pPlot:GetTerrainType() == GameInfoTypes["TERRAIN_GRASS"] or pPlot:GetTerrainType() == GameInfoTypes["TERRAIN_PLAINS"]) and pPlot:IsFlatlands() and pPlot:GetFeatureType() == FeatureTypes.NO_FEATURE and pPlot:GetResourceType() == -1 then
				local random = Map.Rand(3, "Random Kazakh Pasture Resource")
				if random == 0 then
					pPlot:SetResourceType(GameInfoTypes["RESOURCE_SHEEP"], 1)
					bPlaced = true
				end
				if random == 1 then
					pPlot:SetResourceType(GameInfoTypes["RESOURCE_COW"], 1)
					bPlaced = true
				end
				if random == 2 then
					pPlot:SetResourceType(GameInfoTypes["RESOURCE_HORSE"], 2)
					bPlaced = true
				end
			end
			
			table.remove(tPlots, iRandom)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- AblaiAutoImprove
----------------------------------------------------------------------------------------------------------------------------
function AblaiFoundAutoImprove(playerID, iX, iY)
	local player = Players[playerID]
	if player:GetCivilizationType() == civilisationAblaiID then
		local playerTeam = player:GetTeam()
		local plot = Map.GetPlot(iX, iY)
		local city = plot:GetPlotCity()
		local cityID = city:GetID()
		for adjacentPlot in PlotAreaSweepIterator(plot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
			x = adjacentPlot:GetX()
			y = adjacentPlot:GetY()
			if adjacentPlot:GetOwner() == Game.GetActivePlayer() and (adjacentPlot:GetResourceType() == GameInfoTypes["RESOURCE_COW"] or adjacentPlot:GetResourceType() == GameInfoTypes["RESOURCE_HORSE"] or adjacentPlot:GetResourceType() == GameInfoTypes["RESOURCE_SHEEP"]) then
				adjacentPlot:SetImprovementType(8);
			end
		end
	end
end

if JFD_IsCivilisationActive(civilisationAblaiID) then 
	GameEvents.PlayerCityFounded.Add(AblaiFoundAutoImprove)
end

function AblaiAutoImprove(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_DJSH_KAZAKH"] and player:IsAlive() then
		for city in player:Cities() do
			local pTeam = Teams[player:GetTeam()]
			for cityPlot = 0, city:GetNumCityPlots() - 1, 1 do
				local adjacentPlot = city:GetCityIndexPlot(cityPlot)
				if adjacentPlot ~= nil then
					if adjacentPlot:GetOwner() == city:GetOwner() then
						if (adjacentPlot:GetResourceType() == GameInfoTypes["RESOURCE_COW"] or adjacentPlot:GetResourceType() == GameInfoTypes["RESOURCE_HORSE"] or adjacentPlot:GetResourceType() == GameInfoTypes["RESOURCE_SHEEP"]) then
							adjacentPlot:SetImprovementType(8);
						end
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(AblaiAutoImprove)