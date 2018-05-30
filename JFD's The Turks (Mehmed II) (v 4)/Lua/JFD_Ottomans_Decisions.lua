-- JFD_Ottomans_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Ottoman Decisions: loaded")
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationOttomanID = GameInfoTypes["CIVILIZATION_OTTOMAN"]
local mathCeil 				= math.ceil
-------------------------------------------------------------------------------------------------------------------------
-- Ottomans: Commission Decorated Tughra
-------------------------------------------------------------------------------------------------------------------------
local eraRenaissanceID		   = GameInfoTypes["ERA_RENAISSANCE"]
local unitOttomanCaligrapherID = GameInfoTypes["UNIT_DECISIONS_JFD_OTTOMAN_CALLIGRAPHER"]
local Decisions_JFD_Ottomans_DecoratedTughra = {}
	Decisions_JFD_Ottomans_DecoratedTughra.Name = "TXT_KEY_DECISIONS_JFD_OTTOMAN_COMMISSION_DECORATED_TUGHRA"
	Decisions_JFD_Ottomans_DecoratedTughra.Desc = "TXT_KEY_DECISIONS_JFD_OTTOMAN_COMMISSION_DECORATED_TUGHRA_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_Ottomans_DecoratedTughra, "CIVILIZATION_OTTOMAN")
	Decisions_JFD_Ottomans_DecoratedTughra.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationOttomanID then return false, false end
		if load(player, "Decisions_JFD_Ottomans_DecoratedTughra") == true then
			Decisions_JFD_Ottomans_DecoratedTughra.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_OTTOMAN_COMMISSION_DECORATED_TUGHRA_ENACTED_DESC")
			return false, false, true
		end
		local costGold = mathCeil(500*iMod)
		Decisions_JFD_Ottomans_DecoratedTughra.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_OTTOMAN_COMMISSION_DECORATED_TUGHRA_DESC", costGold)
		if player:GetGold() < costGold then return true, false end
		if player:GetCurrentEra() < eraRenaissanceID then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Ottomans_DecoratedTughra.DoFunc = (
	function(player)
		local costGold = mathCeil(500*iMod)
		local capital = player:GetCapitalCity()
		player:ChangeNumResourceTotal(iMagistrate, 1)
		player:ChangeGold(-costGold)
		player:InitUnit(unitOttomanCaligrapherID, capital:GetX(), capital:GetY())
		save(player, "Decisions_JFD_Ottomans_DecoratedTughra", true)
	end
	)

Decisions_AddCivilisationSpecific(civilizationOttomanID, "Decisions_JFD_Ottomans_DecoratedTughra", Decisions_JFD_Ottomans_DecoratedTughra)
--=======================================================================================================================
--=======================================================================================================================
