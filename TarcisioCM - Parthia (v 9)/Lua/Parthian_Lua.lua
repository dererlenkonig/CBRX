include("PlotIterators")

local civilizationID = GameInfoTypes["CIVILIZATION_PARTHIA"]

function CBR_PersianHorses(playerID, x, y)
	local player = Players[playerID]
	if (not player:GetCivilizationType() == civilizationID or not player:IsAlive()) then return end
	local pCity = Map.GetPlotXY(x, y, 0, 0):GetPlotCity()
	if not pCity == player:GetCapitalCity() then 
		pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_PARTHIA_FREEHORSES_1"], 1) 
	end
	
end
GameEvents.PlayerCityFounded.Add(CBR_PersianHorses)

function TCM_Persian_Horses(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == civilizationID and player:IsAlive() then
		for city in player:Cities() do
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_PARTHIA_FREEHORSES_1"], 0)
			if not city:IsCapital() then
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_PARTHIA_FREEHORSES_1"], 1)
			end
		end
	end
end
--GameEvents.PlayerDoTurn.Add(TCM_Persian_Horses)

function TCM_CataphractAbility(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() and player:GetCivilizationType() == civilizationID then
		for city in player:Cities() do
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_PARTHIANDUMMY"], 0)	
			local plot = city:Plot()
			for i = 0, plot:GetNumUnits() - 1, 1 do  
				local unit = plot:GetUnit(i)
				if unit:IsHasPromotion(GameInfoTypes["PROMOTION_TCM_LOCAL_NOBILITY"]) then
					if city:IsOccupied() or city:IsPuppet() then
						city:SetNumRealBuilding(GameInfoTypes["BUILDING_TCM_PARTHIANDUMMY"], 1)	
					end
				end
			end
		end
		for unitB in player:Units() do
			if unitB:GetUnitType() == GameInfoTypes["UNIT_PARTHIA_HORSE_ARCHER"] then
				local plotB = unitB:GetPlot()
				local enemyNum = 0
				local friendlyNum = 0
				for loopPlot in PlotAreaSweepIterator(plotB, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
					local otherUnit = loopPlot:GetUnit()
					if otherUnit then
						if otherUnit:GetOwner() == playerID then
							friendlyNum = friendlyNum + 1
						else
							enemyNum = enemyNum + 1
						end
					end
				end
				if enemyNum > friendlyNum then
					unitB:SetHasPromotion(GameInfoTypes["PROMOTION_PARTHIA_RETREAT"], true)
				else
					if unitB:IsHasPromotion(GameInfoTypes["PROMOTION_PARTHIA_RETREAT"]) then
						unitB:SetHasPromotion(GameInfoTypes["PROMOTION_PARTHIA_RETREAT"], false)
					end
				end
			end
		end
	end
	-- if unitID then
		-- local oldunit = player:GetUnitByID(unitID)
		-- local oldplot = oldunit:GetPlot()
		-- if oldplot then
			-- for firstloop in PlotAreaSweepIterator(oldplot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				-- local unit = firstloop:GetUnit()
				-- if unit and unit:GetUnitType() == GameInfoTypes["UNIT_PARTHIA_HORSE_ARCHER"] then
					-- local enemyNum = 0
					-- local friendlyNum = 0
					-- for loopPlot in PlotAreaSweepIterator(firstloop, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
						-- local otherUnit = loopPlot:GetUnit()
						-- if otherUnit then
							-- if otherUnit:GetOwner() == playerID then
								-- friendlyNum = friendlyNum + 1
							-- else
								-- enemyNum = enemyNum + 1
							-- end
						-- end
					-- end
					-- if enemyNum > friendlyNum then
						-- unit:SetHasPromotion(GameInfoTypes["PROMOTION_PARTHIA_RETREAT"], true)
					-- else
						-- if unit:IsHasPromotion(GameInfoTypes["PROMOTION_PARTHIA_RETREAT"]) then
							-- unit:SetHasPromotion(GameInfoTypes["PROMOTION_PARTHIA_RETREAT"], false)
						-- end
					-- end
				-- end
			-- end
		-- end
	-- else
		-- for unit in player:Units() do
			-- if unit:GetUnitType() == GameInfoTypes["UNIT_PARTHIA_HORSE_ARCHER"] then
				-- local plot = unit:GetPlot()
				-- local enemyNum = 0
				-- local friendlyNum = 0
				-- for loopPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
					-- local otherUnit = loopPlot:GetUnit()
					-- if otherUnit then
						-- if otherUnit:GetOwner() == playerID then
							-- friendlyNum = friendlyNum + 1
						-- else
							-- enemyNum = enemyNum + 1
						-- end
					-- end
				-- end
				-- if enemyNum > friendlyNum then
					-- unit:SetHasPromotion(GameInfoTypes["PROMOTION_PARTHIA_RETREAT"], true)
				-- else
					-- if unit:IsHasPromotion(GameInfoTypes["PROMOTION_PARTHIA_RETREAT"]) then
						-- unit:SetHasPromotion(GameInfoTypes["PROMOTION_PARTHIA_RETREAT"], false)
					-- end
				-- end
			-- end
		-- end
	-- end
end
GameEvents.PlayerDoTurn.Add(TCM_CataphractAbility)
--GameEvents.UnitSetXY.Add(TCM_CataphractAbility)

