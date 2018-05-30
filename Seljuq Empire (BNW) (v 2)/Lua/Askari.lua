-- Lua Script1
-- Author: Gebruiker
-- DateCreated: 11/7/2014 11:49:33 PM
--------------------------------------------------------------
-- Askari Double Attack
--------------------------------------------------------------
function AskariDoubleAttack(playerID)
	local player = Players[playerID]
	if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_DJSH_SELJUQ"] and player:IsAlive() then
		for unit in player:Units() do
			if unit:IsHasPromotion(GameInfoTypes["PROMOTION_ASKARI_ARCHER"]) and (unit:IsHasPromotion(GameInfoTypes["PROMOTION_ACCURACY_1"]) or unit:IsHasPromotion(GameInfoTypes["PROMOTION_BARRAGE_1"])) and (unit:GetLevel() >= 2) then
				unit:SetHasPromotion(GameInfoTypes["PROMOTION_ASKARI"], true)
			end
			if unit:IsHasPromotion(GameInfoTypes["PROMOTION_ASKARI"]) then
				unit:IsPromotionValid(GameInfoTypes["PROMOTION_TWIN_FURY"])
				unit:CanAcquirePromotion(GameInfoTypes["PROMOTION_TWIN_FURY"])
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(AskariDoubleAttack)