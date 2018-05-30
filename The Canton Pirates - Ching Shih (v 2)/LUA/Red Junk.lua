include("GetUnitsInAdjacentPlotsWithPromotion.lua")

local domainSeaID = GameInfoTypes["DOMAIN_SEA"]
local unitPromotionWarJunkID = GameInfoTypes["PROMOTION_WAR_JUNK_PROMOTION"]
local unitPromotionAttackTwiceID = GameInfoTypes["PROMOTION_WAR_JUNK_ATTACK_TWICE"]

function C15_Pirate_WarJunk(playerID)
    local player = Players[playerID]
    for unit in player:Units() do
        if unit:IsHasPromotion(unitPromotionWarJunkID) then
            if IsAdjacentToUnitPromotion then
            unit:SetHasPromotion(unitPromotionAttackTwiceID, unit:IsAdjacentToUnitPromotion(unitPromotionWarJunkID, true, false))
            else
            unit:SetHasPromotion(unitPromotionAttackTwiceID, GetUnitsInAdjacentPlotsWithPromotion(unit:GetPlot(), unitPromotionWarJunkID, playerID, "SamePlayer"))
            end
        end
    end
end
GameEvents.PlayerDoTurn.Add(C15_Pirate_WarJunk)