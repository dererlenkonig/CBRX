GameEvents.PlayerDoTurn.Add(function(iPlayer)
	for pUnit in Players[iPlayer]:Units() do
		if not pUnit:IsCombatUnit() then
			local pPlot = pUnit:GetPlot()
			local bStackedWithReindeer = false
			for i = 0, pPlot:GetNumUnits()-1 do
				if pPlot:GetUnit(i):GetUnitType() == GameInfoTypes.UNIT_SENSHI_REINDEER_ARCHER then
					bStackedWithReindeer = true
					break
				end
			end
			if bStackedWithReindeer then
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_WOODSMAN, true)
			else
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_WOODSMAN, false)
			end
		end
	end
end)