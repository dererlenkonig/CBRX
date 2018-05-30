local unitPromotionUraniumID = GameInfoTypes["PROMOTION_FREE_URANIUM"]

function Scissor_Get_Free_Uranium(playerID)
    local player = Players[playerID]
    for city in player:Cities() do
        if (city:GetGarrisonedUnit()):IsHasPromotion(unitPromotionUraniumID) then
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_SCISSOR_INDIRA"], 1);
		else
			pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_SCISSOR_INDIRA"], 0);
		end
	end
end
GameEvents.PlayerDoTurn.Add(Scissor_Get_Free_Uranium)
