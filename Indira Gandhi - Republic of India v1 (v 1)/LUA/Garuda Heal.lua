include("GetUnitsInAdjacentPlotsWithPromotion.lua")

local unitPromotionGarudaID = GameInfoTypes["PROMOTION_GARUDA_HEAL_PROMOTION"]

function Scissor_Garuda_Heal(playerID)
    local player = Players[playerID]
    for unit in player:Units() do
        if unit:IsHasPromotion(unitPromotionGarudaID) then
            if IsAdjacentToUnitPromotion then
				if (unit:GetCurrHitPoints() < 80) then
					if (unit:GetCurrHitPoints() > 67) then
						unit:SetDamage(0)
					else
						unit:ChangeDamage(-15)
					end
				end
            end
        end
    end
end
GameEvents.PlayerDoTurn.Add(Scissor_Garuda_Heal)