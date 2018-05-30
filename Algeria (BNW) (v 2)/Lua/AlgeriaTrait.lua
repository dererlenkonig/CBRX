-- Lua Script1
-- Author: Davey
-- DateCreated: 7/1/2014 1:31:42 PM
--------------------------------------------------------------
--Defense from Faith
--------------------------------------------------------------
local bALGFAITH1 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_1
local bALGFAITH2 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_2
local bALGFAITH3 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_3
local bALGFAITH4 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_4
local bALGFAITH5 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_5
local bALGFAITH6 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_6
local bALGFAITH7 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_7
local bALGFAITH8 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_8
local bALGFAITH9 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_9
local bALGFAITH10 = GameInfoTypes.BUILDING_ALGERIA_FAITH_DEFENSE_10

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_DJSH_ALGERIA) then
			for pCity in pPlayer:Cities() do
				if (pCity:GetNumBuilding(bALGFAITH1) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH1, 0);
				end
				if (pCity:GetNumBuilding(bALGFAITH2) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH2, 0);
				end
				if (pCity:GetNumBuilding(bALGFAITH3) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH3, 0);
				end
				if (pCity:GetNumBuilding(bALGFAITH4) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH4, 0);
				end
				if (pCity:GetNumBuilding(bALGFAITH5) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH5, 0);
				end
				if (pCity:GetNumBuilding(bALGFAITH6) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH6, 0);
				end
				if (pCity:GetNumBuilding(bALGFAITH7) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH7, 0);
				end
				if (pCity:GetNumBuilding(bALGFAITH8) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH8, 0);
				end
				if (pCity:GetNumBuilding(bALGFAITH9) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH9, 0);
				end
				if (pCity:GetNumBuilding(bALGFAITH10) > 0) then
					pCity:SetNumRealBuilding(bALGFAITH10, 0);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 10) then
					pCity:SetNumRealBuilding(bALGFAITH1, 1);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 20) then
					pCity:SetNumRealBuilding(bALGFAITH2, 1);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 30) then
					pCity:SetNumRealBuilding(bALGFAITH3, 1);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 40) then
					pCity:SetNumRealBuilding(bALGFAITH4, 1);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 50) then
					pCity:SetNumRealBuilding(bALGFAITH5, 1);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 60) then
					pCity:SetNumRealBuilding(bALGFAITH6, 1);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 70) then
					pCity:SetNumRealBuilding(bALGFAITH7, 1);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 80) then
					pCity:SetNumRealBuilding(bALGFAITH8, 1);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 90) then
					pCity:SetNumRealBuilding(bALGFAITH9, 1);
				end
				if (pPlayer:GetTotalFaithPerTurn() >= 100) then
					pCity:SetNumRealBuilding(bALGFAITH10, 1);
				end
			end
		end
	end
end)
--------------------------------------------------------------
--Faith and Generation from Terrain Types
--------------------------------------------------------------
local bZAWI = GameInfoTypes.BUILDING_ZAWIYA
local bALGYIELD1 = GameInfoTypes.BUILDING_ZAWIYA_TERRAIN_1
local bALGYIELD2 = GameInfoTypes.BUILDING_ZAWIYA_TERRAIN_2
local bALGYIELD3 = GameInfoTypes.BUILDING_ZAWIYA_TERRAIN_3
local bALGYIELD4 = GameInfoTypes.BUILDING_ZAWIYA_TERRAIN_4
local bALGYIELD5 = GameInfoTypes.BUILDING_ZAWIYA_TERRAIN_5
local bALGYIELD6 = GameInfoTypes.BUILDING_ZAWIYA_TERRAIN_6
local bALGYIELD7 = GameInfoTypes.BUILDING_ZAWIYA_TERRAIN_7

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_DJSH_ALGERIA) then
			for pCity in pPlayer:Cities() do
				if (pCity:GetNumBuilding(bALGYIELD1) > 0) then
					pCity:SetNumRealBuilding(bALGYIELD1, 0);
				end
				if (pCity:GetNumBuilding(bALGYIELD2) > 0) then
					pCity:SetNumRealBuilding(bALGYIELD2, 0);
				end
				if (pCity:GetNumBuilding(bALGYIELD3) > 0) then
					pCity:SetNumRealBuilding(bALGYIELD3, 0);
				end
				if (pCity:GetNumBuilding(bALGYIELD4) > 0) then
					pCity:SetNumRealBuilding(bALGYIELD4, 0);
				end
				if (pCity:GetNumBuilding(bALGYIELD5) > 0) then
					pCity:SetNumRealBuilding(bALGYIELD5, 0);
				end
				if (pCity:GetNumBuilding(bALGYIELD6) > 0) then
					pCity:SetNumRealBuilding(bALGYIELD6, 0);
				end
				if (pCity:GetNumBuilding(bALGYIELD7) > 0) then
					pCity:SetNumRealBuilding(bALGYIELD7, 0);
				end
				if (pCity:GetNumBuilding(bZAWI) > 0) then
					local pCityPlot = Players[iPlayer]:GetCityByID(iCity):Plot()
					local iOwner = pCityPlot:GetOwner()
					local directions = {DirectionTypes.DIRECTION_NORTHEAST, DirectionTypes.DIRECTION_EAST, DirectionTypes.DIRECTION_SOUTHEAST, DirectionTypes.DIRECTION_SOUTHWEST, DirectionTypes.DIRECTION_WEST, DirectionTypes.DIRECTION_NORTHWEST}
					for loop, direction in ipairs(directions) do
						local pPlot = Map.PlotDirection(pCityPlot:GetX(), pCityPlot:GetY(), direction)
						if (pPlot ~= nil and iOwner == pPlot:GetOwner()) then
							if pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_COAST then
								pCity:SetNumRealBuilding(bALGYIELD1, 1);
							end
							if pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_GRASS then
								pCity:SetNumRealBuilding(bALGYIELD2, 1);
							end
							if pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_PLAINS then
								pCity:SetNumRealBuilding(bALGYIELD3, 1);
							end
							if pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_DESERT then
								pCity:SetNumRealBuilding(bALGYIELD4, 1);
							end
							if pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_SNOW then
								pCity:SetNumRealBuilding(bALGYIELD5, 1);
							end
							if pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_TUNDRA then
								pCity:SetNumRealBuilding(bALGYIELD6, 1);
							end
							if pPlot:IsMountain() then
								pCity:SetNumRealBuilding(bALGYIELD7, 1);
							end
						end
					end
				end
			end
		end
	end
end)