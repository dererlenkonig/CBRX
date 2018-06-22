-- JFD_Ottomans_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Ottoman Decisions: loaded")
--=======================================================================================================================
-- GLOBALS
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local g_ConvertTextKey  		= Locale.ConvertTextKey
local g_MathCeil				= math.ceil
local g_MathFloor				= math.floor
local g_MathMax					= math.max
local g_MathMin					= math.min
				
local Players 					= Players
local Teams 					= Teams

local activePlayerID			= Game.GetActivePlayer()
local activePlayer				= Players[activePlayerID]
local activeTeamID				= activePlayer:GetTeam()
local activeTeam				= Teams[activeTeamID]
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
--Game_GetRound
function Game_GetRound(num, idp)
	local mult = 10^(idp or 0)
	return g_MathFloor(num * mult + 0.5) / mult
end
local g_GetRound = Game_GetRound
------------------------------------------------------------------------------------------------------------------------
--Player:SendWorldEvent
local notificationWorldEventID = NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"]
function Player.SendWorldEvent(player, description, includeHuman)
	print("Sending World Event: ", description)
	local playerTeam = Teams[player:GetTeam()]
	if (not includeHuman) and player:IsHuman() then return end
	if (not playerTeam:IsHasMet(activeTeamID)) then return end
	activePlayer:AddNotification(notificationWorldEventID, description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
end 
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID		= GameInfoTypes["CIVILIZATION_OTTOMAN"]
local eraRenaissanceID		= GameInfoTypes["ERA_RENAISSANCE"]
local resourceDignitariesID = GameInfoTypes["RESOURCE_JFD_DIGNITARIES"]
-------------------------------------------------------------------------------------------------------------------------
-- Ottomans: Commission Decorated Tughra
-------------------------------------------------------------------------------------------------------------------------
local unitDecisionsOttomansCaligrapherID = GameInfoTypes["UNIT_DECISIONS_JFD_OTTOMAN_CALLIGRAPHER"]
if (not resourceDignitariesID) then
local Decisions_JFD_Ottomans_DecoratedTughra = {}
	Decisions_JFD_Ottomans_DecoratedTughra.Name = "TXT_KEY_DECISIONS_JFD_OTTOMAN_COMMISSION_DECORATED_TUGHRA"
	Decisions_JFD_Ottomans_DecoratedTughra.Desc = "TXT_KEY_DECISIONS_JFD_OTTOMAN_COMMISSION_DECORATED_TUGHRA_DESC"
	Decisions_JFD_Ottomans_DecoratedTughra.Type = "Civilization"
	HookDecisionCivilizationIcon(Decisions_JFD_Ottomans_DecoratedTughra, "CIVILIZATION_OTTOMAN")
	Decisions_JFD_Ottomans_DecoratedTughra.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_JFD_Ottomans_DecoratedTughra") == true then
			Decisions_JFD_Ottomans_DecoratedTughra.Desc = g_ConvertTextKey("TXT_KEY_DECISIONS_JFD_OTTOMAN_COMMISSION_DECORATED_TUGHRA_ENACTED")
			return false, false, true
		end
		local costGold = g_GetRound(500*iMod)
		Decisions_JFD_Ottomans_DecoratedTughra.Desc = g_ConvertTextKey("TXT_KEY_DECISIONS_JFD_OTTOMAN_COMMISSION_DECORATED_TUGHRA_DESC", costGold)
		if player:GetGold() < costGold then return true, false end
		if player:GetCurrentEra() < eraRenaissanceID then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Ottomans_DecoratedTughra.DoFunc = (
	function(player)
		local costGold = g_GetRound(500*iMod)
		player:ChangeNumResourceTotal(iMagistrate, 1)
		player:ChangeGold(-costGold)
		
		local capital = player:GetCapitalCity()
		local plotX, plotY = capital:GetX(), capital:GetY()
		player:InitUnit(unitDecisionsOttomansCaligrapherID, plotX, plotY)
		save(player, "Decisions_JFD_Ottomans_DecoratedTughra", true)
	end
	)

Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Ottomans_DecoratedTughra", Decisions_JFD_Ottomans_DecoratedTughra)
end
--=======================================================================================================================
--=======================================================================================================================
