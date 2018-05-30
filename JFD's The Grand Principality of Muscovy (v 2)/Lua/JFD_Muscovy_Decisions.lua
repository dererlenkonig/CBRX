-- JFD_Muscovy_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Muscovy Decisions: loaded")
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("JFD_CID_HappinessUtils.lua")
include("JFD_RTP_SovereigntyUtils.lua")
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
------------------------------------------------------------------------------------------------------------------------
-- UNIQUE UTILS
------------------------------------------------------------------------------------------------------------------------
--JFD_GetNumConqueredCapitals
function JFD_GetNumConqueredCapitals(playerID)
	local numCapitals = 0
	for city in Players[playerID]:Cities() do
		if (city:GetOriginalOwner() ~= playerID and city:IsOriginalCapital()) then
			numCapitals = numCapitals + 1
		end
	end
	return numCapitals
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
local userSettingHappinessCore   = JFD_GetUserSetting("JFD_CID_HAPPINESS_CORE") == 1
local userSettingSovereigntyCore = JFD_GetUserSetting("JFD_RTP_SOVEREIGNTY_CORE") == 1
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local activePlayerTeam 	= Teams[Game.GetActiveTeam()]
local civilizationID 	= GameInfoTypes["CIVILIZATION_JFD_MUSCOVY"]
local eraMedievalID		= GameInfoTypes["ERA_MEDIEVAL"]
local mathCeil 			= math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Muscovy: Found the Russian Tsardom
-------------------------------------------------------------------------------------------------------------------------
local buildingStBasilsID		= GameInfoTypes["BUILDING_DECISIONS_JFD_ST_BASILS"]
local policyRussiaID			= GameInfoTypes["POLICY_DECISIONS_JFD_MUSCOVY_RUSSIA"]
local reformExecutiveAbsoluteID = GameInfoTypes["REFORM_JFD_EXECUTIVE_ABSOLUTE"]
local Decisions_JFD_Muscovy_Russia = {}
	Decisions_JFD_Muscovy_Russia.Name = "TXT_KEY_DECISIONS_JFD_MUSCOVY_RUSSIA"
	Decisions_JFD_Muscovy_Russia.Desc = "TXT_KEY_DECISIONS_JFD_MUSCOVY_RUSSIA_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_Muscovy_Russia, "CIVILIZATION_JFD_MUSCOVY")
	Decisions_JFD_Muscovy_Russia.Pedia = "TXT_KEY_DECISIONS_BUILDING_JFD_ST_BASILS"
	Decisions_JFD_Muscovy_Russia.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if player:HasPolicy(policyRussiaID) then
			if userSettingSovereigntyCore then
				Decisions_JFD_Muscovy_Russia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_MUSCOVY_RUSSIA_ENACTED_DESC_SOVEREIGNTY")
			else
				Decisions_JFD_Muscovy_Russia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_MUSCOVY_RUSSIA_ENACTED_DESC")
			end
			return false, false, true
		end
		local costCulture = mathCeil(400*iMod)
		local costFaith = mathCeil(500*iMod)
		if userSettingSovereigntyCore then
			Decisions_JFD_Muscovy_Russia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_MUSCOVY_RUSSIA_DESC_SOVEREIGNTY", costCulture, costFaith)
			if (not player:HasGovernment()) then return true, false end
			if player:GetSovereignty() < 50 then return true, false end
		else
			Decisions_JFD_Muscovy_Russia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_MUSCOVY_RUSSIA_DESC", costCulture, costFaith)
		end
		local playerID = player:GetID()
		if JFD_GetNumConqueredCapitals(playerID) < 3 then return true, false end
		if player:GetCurrentEra() < eraMedievalID then return true, false end
		if player:GetJONSCulture() < costCulture then return true, false end
		if player:GetFaith() < costFaith then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Muscovy_Russia.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local costCulture = mathCeil(400*iMod)
		local costFaith = mathCeil(500*iMod)
		player:ChangeJONSCulture(-costCulture)
		player:ChangeFaith(-costFaith)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:ChangeGoldenAgeTurns(12)
		player:GetCapitalCity():SetNumRealBuilding(buildingStBasilsID, 1)
		PreGame.SetCivilizationDescription(playerID, "TXT_KEY_CIV_RUSSIA_DESC")
		PreGame.SetCivilizationShortDescription(playerID, "TXT_KEY_CIV_RUSSIA_SHORT_DESC")
		PreGame.SetCivilizationAdjective(playerID, "TXT_KEY_CIV_RUSSIA_ADJECTIVE")
		if userSettingSovereigntyCore then
			JFD_SetHasReform(player:GetID(), reformExecutiveAbsoluteID, true, true)
		end
		if isCPDLL then
			player:GrantPolicy(policyRussiaID, true)
		else
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(policyRussiaID, true)
		end
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_MUSCOVY_RUSSIA", player:GetName()))
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Muscovy_Russia", Decisions_JFD_Muscovy_Russia)
--------------------------------------------------------------------------------------------------------------------------
-- Muscovy: Unleash the Oprichniki
--------------------------------------------------------------------------------------------------------------------------
tDecisions.Decisions_RussiaOprichnina = nil
local Decisions_JFD_Muscovy_Oprichnik = {}
	Decisions_JFD_Muscovy_Oprichnik.Name = "TXT_KEY_DECISIONS_JFD_MUSCOVY_OPRICHNIK"
	Decisions_JFD_Muscovy_Oprichnik.Desc = "TXT_KEY_DECISIONS_JFD_MUSCOVY_OPRICHNIK_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_Muscovy_Oprichnik, "CIVILIZATION_JFD_MUSCOVY")
	Decisions_JFD_Muscovy_Oprichnik.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		local era = load(player, "Decisions_JFD_Muscovy_Oprichnik")
		if (era and era < player:GetCurrentEra()) then
			save(player, "Decisions_JFD_Muscovy_Oprichnik", nil)
		elseif era then
			if userSettingHappinessCore then
				Decisions_JFD_Muscovy_Oprichnik.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_MUSCOVY_OPRICHNIK_ENACTED_DESC_HAPPINESS")
			else
				Decisions_JFD_Muscovy_Oprichnik.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_MUSCOVY_OPRICHNIK_ENACTED_DESC")
			end
			return false, false, true
		end
		local costGoldenAgePoints = mathCeil((player:GetNumCities()*60)*iMod)
		if userSettingHappinessCore then
			costGoldenAgePoints = mathCeil((player:GetNumCities()*100)*iMod)
			Decisions_JFD_Muscovy_Oprichnik.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_MUSCOVY_OPRICHNIK_DESC_HAPPINESS", costGoldenAgePoints)
		else
			Decisions_JFD_Muscovy_Oprichnik.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_MUSCOVY_OPRICHNIK_DESC", costGoldenAgePoints)
		end
		if player:GetCurrentEra() < eraMedievalID then return true, false end
		if player:GetGoldenAgeProgressMeter() < costGoldenAgePoints then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Muscovy_Oprichnik.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local costGoldenAgePoints = mathCeil((player:GetNumCities()*60)*iMod)
		if userSettingHappinessCore then
			costGoldenAgePoints = mathCeil((player:GetNumCities()*100)*iMod)
		end
		player:ChangeGoldenAgeProgressMeter(-costGoldenAgePoints)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		for city in player:Cities() do
			city:ChangeResistanceTurns(-city:GetResistanceTurns())
			if userSettingHappinessCore then
				JFD_SetResistanceCounter(playerID, city, 0)
			end
		end
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_MUSCOVY_OPRICHNIK", player:GetName(), player:GetCivilizationShortDescription()))
		save(player, "Decisions_JFD_Muscovy_Oprichnik", player:GetCurrentEra())
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Muscovy_Oprichnik", Decisions_JFD_Muscovy_Oprichnik)
--=======================================================================================================================
--=======================================================================================================================
