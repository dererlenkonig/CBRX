-- JFD_NewZealand_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's New Zealand Decisions: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
--JFD_GetEraAdjustedValue
local mathCeil = math.ceil
function JFD_GetEraAdjustedValue(playerID, num)
	local player = Players[playerID]
	local currentEraID = player:GetCurrentEra()
	local eraMod = GameInfo.Eras[currentEraID].ResearchAgreementCost
	return mathCeil(num * eraMod/100)
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
--IsCPDLL
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()
--=======================================================================================================================
-- USER SETTINGS
--=======================================================================================================================
-- JFD_GetUserSetting
function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID 		= GameInfoTypes["CIVILIZATION_JFD_NEW_ZEALAND"]
local resourceDignitariesID = GameInfoTypes["RESOURCE_JFD_DIGNITARIES"]
-------------------------------------------------------------------------------------------------------------------------
-- New Zealand: Commemorate the ANZACs
-------------------------------------------------------------------------------------------------------------------------
local eraModernID			= GameInfoTypes["ERA_MODERN"]
local policyANZACID			= GameInfoTypes["POLICY_DECISIONS_JFD_NEW_ZEALAND_ANZACS"]
local unitPromotionANZACID	= GameInfoTypes["PROMOTION_JFD_ANZAC"]
local Decisions_JFD_NewZealand_ANZACS = {}
	Decisions_JFD_NewZealand_ANZACS.Name = "TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_ANZACS"
	Decisions_JFD_NewZealand_ANZACS.Desc = "TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_ANZACS_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_NewZealand_ANZACS, "CIVILIZATION_JFD_NEW_ZEALAND")
	Decisions_JFD_NewZealand_ANZACS.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if player:HasPolicy(policyANZACID) then
			Decisions_JFD_NewZealand_ANZACS.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_ANZACS_ENACTED_DESC")
			return false, false, true
		end
		local resourceID = iMagistrate
		local resourceType = "[ICON_MAGISTRATES] Magistrates"
		if resourceDignitariesID then
			resourceID = resourceDignitariesID
			resourceType = "[ICON_JFD_DIGNITARY] Dignitaries"
		end
		Decisions_JFD_NewZealand_ANZACS.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_ANZACS_DESC", resourceType)
		if player:GetCurrentEra() < eraModernID then return true, false	end
		if player:GetNumResourceAvailable(resourceID, false) < 2 then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_NewZealand_ANZACS.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local resourceID = iMagistrate
		if resourceDignitariesID then
			resourceID = resourceDignitariesID
		end
		player:ChangeNumResourceTotal(resourceID, -2)
		for unit in player:Units() do
			if unit:IsHasPromotion(unitPromotionANZACID) then
				unit:ChangeExperience(10)
			end
		end
		if isCPDLL then
			player:GrantPolicy(policyANZACID, true)
		else
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(policyANZACID, true)
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_NewZealand_ANZACS", Decisions_JFD_NewZealand_ANZACS)
-------------------------------------------------------------------------------------------------------------------------
-- New Zealand: Promulgate Imperial Plans
-------------------------------------------------------------------------------------------------------------------------
local eraIndustrialID 		= GameInfoTypes["ERA_INDUSTRIAL"]
local policyImperialPlansID = GameInfoTypes["POLICY_DECISIONS_JFD_NEW_ZEALAND_IMPERIUM"]
local Decisions_JFD_NewZealand_Imperium = {}
	Decisions_JFD_NewZealand_Imperium.Name = "TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_IMPERIUM"
	Decisions_JFD_NewZealand_Imperium.Desc = "TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_IMPERIUM_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_NewZealand_Imperium, "CIVILIZATION_JFD_NEW_ZEALAND")
	Decisions_JFD_NewZealand_Imperium.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if player:HasPolicy(policyImperialPlansID) then
			Decisions_JFD_NewZealand_Imperium.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_IMPERIUM_ENACTED_DESC")
			return false, false, true
		end
		local costCulture = player:GetNextPolicyCost()
		Decisions_JFD_NewZealand_Imperium.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_IMPERIUM_DESC", costCulture)
		if player:GetCurrentEra() < eraIndustrialID then return true, false	end
		if player:GetJONSCulture() < costCulture then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_NewZealand_Imperium.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local costCulture = player:GetNextPolicyCost()
		player:ChangeJONSCulture(-costCulture)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		if isCPDLL then
			player:GrantPolicy(policyImperialPlansID, true)
		else
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(policyImperialPlansID, true)
		end
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_NEW_ZEALAND_EMPIRE", player:GetName(), player:GetCivilizationShortDescription()))
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_NewZealand_Imperium", Decisions_JFD_NewZealand_Imperium)
--=======================================================================================================================
--=======================================================================================================================
