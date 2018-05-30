-- JFD_Qing_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Qing Decisions: loaded")
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("FLuaVector.lua")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
--Player:GetEraAdjustedValue
local mathCeil = math.ceil
function Player.GetEraAdjustedValue(player, num)
	local modEra = GameInfo.Eras[player:GetCurrentEra()].ResearchAgreementCost
	return mathCeil(num*modEra/100)
end

--JFD_SendWorldEvent
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
-- MOD USE
--=======================================================================================================================
-- MODS
-------------------------------------------------------------------------------------------------------------------------
--Game.IsCPActive
function Game.IsCPActive()
	return Game.IsModActive("d1b6328c-ff44-4b0d-aad7-c657f83610cd")
end
--=======================================================================================================================
-- USER SETTINGS
--=======================================================================================================================
-- Game.GetUserSetting
function Game.GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
local userSettingRTPSovereigntyCore = (Game.GetUserSetting("JFD_RTP_SOVEREIGNTY_CORE") == 1)
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID 		= GameInfoTypes["CIVILIZATION_JFD_QING"]
local resourceDignitariesID	= GameInfoTypes["RESOURCE_JFD_DIGNITARIES"]
-------------------------------------------------------------------------------------------------------------------------
-- Great Qing: Abolish the Imperial Exams
-------------------------------------------------------------------------------------------------------------------------
local eraIndustrialID		   = GameInfoTypes["ERA_INDUSTRIAL"]
local policyImperialExamsID    = GameInfoTypes["POLICY_DECISIONS_JFD_QING_IMPERIAL_EXAMS"]
local Decisions_JFD_Qing_ImperialExams = {}
	Decisions_JFD_Qing_ImperialExams.Name = "TXT_KEY_DECISIONS_JFD_QING_IMPERIAL_EXAMS"
	Decisions_JFD_Qing_ImperialExams.Desc = "TXT_KEY_DECISIONS_JFD_QING_IMPERIAL_EXAMS_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_Qing_ImperialExams, "CIVILIZATION_JFD_QING")
	Decisions_JFD_Qing_ImperialExams.CanFunc = (
	function(player)
		local playerID = player:GetID()
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if player:HasPolicy(policyImperialExamsID) then
			if userSettingRTPSovereigntyCore then
				Decisions_JFD_Qing_ImperialExams.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_QING_IMPERIAL_EXAMS_ENACTED_DESC_SOVEREIGNTY")
			else
				Decisions_JFD_Qing_ImperialExams.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_QING_IMPERIAL_EXAMS_ENACTED_DESC")
			end
			return false, false, true 
		end
		local costGold = mathCeil(500*iMod)
		local costMagistrates = player:GetNumPolicyBranchesFinished()+1
		if userSettingRTPSovereigntyCore then
			Decisions_JFD_Qing_ImperialExams.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_QING_IMPERIAL_EXAMS_DESC_SOVEREIGNTY", costGold, costMagistrates)
		else
			Decisions_JFD_Qing_ImperialExams.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_QING_IMPERIAL_EXAMS_DESC", costGold, costMagistrates)
		end
		if player:GetCurrentEra() < eraIndustrialID then return true, false end
		if player:GetGold() < costGold then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < costMagistrates then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Qing_ImperialExams.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local costGold = mathCeil(500*iMod)
		local costMagistrates = player:GetNumPolicyBranchesFinished()+1
		player:ChangeNumResourceTotal(iMagistrate, -costMagistrates)
		if Game.IsCPActive() then
			player:GrantPolicy(policyImperialExamsID, true)
		else
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(policyImperialExamsID, true)
		end
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_QING_IMPERIAL_EXAMS", player:GetName(), player:GetCivilizationShortDescription())) 
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Qing_ImperialExams", Decisions_JFD_Qing_ImperialExams)
-------------------------------------------------------------------------------------------------------------------------
-- Great Qing: Support the Self-Strenghtening Movement
-------------------------------------------------------------------------------------------------------------------------
local eraRenaissanceID		    = GameInfoTypes["ERA_RENAISSANCE"]
local policySelfStrengtheningID = GameInfoTypes["POLICY_DECISIONS_JFD_SELF_STRENGTHENING"]
local Decisions_JFD_Qing_SelfStrengthening = {}
	Decisions_JFD_Qing_SelfStrengthening.Name = "TXT_KEY_DECISIONS_JFD_QING_SELF_STRENGTHENING"
	Decisions_JFD_Qing_SelfStrengthening.Desc = "TXT_KEY_DECISIONS_JFD_QING_SELF_STRENGTHENING_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_Qing_SelfStrengthening, "CIVILIZATION_JFD_QING")
	Decisions_JFD_Qing_SelfStrengthening.CanFunc = (
	function(player)
		local playerID = player:GetID()
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if player:HasPolicy(policySelfStrengtheningID) then
			Decisions_JFD_Qing_SelfStrengthening.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_QING_SELF_STRENGTHENING_ENACTED_DESC")
			return false, false, true 
		end
		local costGold = mathCeil(300*iMod)
		if resourceDignitariesID then
			Decisions_JFD_Qing_SelfStrengthening.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_QING_SELF_STRENGTHENING_DESC_CLAIMS", costGold)
		else
			Decisions_JFD_Qing_SelfStrengthening.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_QING_SELF_STRENGTHENING_DESC", costGold)
		end
		if player:GetCurrentEra() < eraRenaissanceID then return true, false end
		if player:GetGold() < costGold then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		if (resourceDignitariesID and player:GetNumResourceAvailable(resourceDignitariesID, false) < 1) then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Qing_SelfStrengthening.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local costGold = mathCeil(300*iMod)
		player:ChangeGold(-costGold)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		if resourceDignitariesID then
			player:ChangeNumResourceTotal(resourceDignitariesID, -1)
		end
		if Game.IsCPActive() then
			player:GrantPolicy(policySelfStrengtheningID, true)
		else
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(policySelfStrengtheningID, true)
		end
	end
	)
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Qing_SelfStrengthening", Decisions_JFD_Qing_SelfStrengthening)
--=======================================================================================================================
--=======================================================================================================================
