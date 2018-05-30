local iNumber = 0;
include("PlotIterators")

function Scissor_Get_Hill_Uranium(playerID)
    local player = Players[playerID]
    for pCity in player:Cities() do
		local id = TerrainTypes.TERRAIN_DESERT
		local type = PlotTypes.PLOT_HILLS
		local pCityPlot = pCity:Plot()
		if (pCity:GetNumRealBuilding(GameInfoTypes["BUILDING_POKHRAN_LAB"]) = 1)then
			for pAreaPlot in PlotAreaSpiralIterator(pCityPlot, 3,SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				local pPlot = print(pAreaPlot:GetX(), pAreaPlot:GetY())
				if(pPlot:GetTerrainType() = id)then
					if(pPlot:GetPlotType() = type)then
						iNumber++;
					end
				end
			end
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_POKHRAN_URANIUM"], iNumber);
			iNumber = 0;
		end
	end
end
GameEvents.PlayerDoTurn.Add(Scissor_Get_Hill_Uranium)