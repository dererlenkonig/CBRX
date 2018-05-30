GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if Players[iPlayer].type == GameInfoTypes.CIVILIZATION_SENSHI_EVENKS then
		for pUnit in Players[iPlayer]:Units() do
			if (pUnit:GetUnitType() == GameInfoTypes.UNIT_MISSIONARY or pUnit:GetUnitType() == GameInfoTypes.UNIT_INQUISITOR) and (pUnit:GetPlot():GetImprovementType() == GameInfoTypes.IMPROVEMENT_SENSHI_SHEVENCHEDEK_FOREST or pUnit:GetPlot():GetImprovementType() == GameInfoTypes.IMPROVEMENT_SENSHI_SHEVENCHEDEK_TUNDRA) then
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_MEDIC, true)
			end
		end
	end
end)