-- JFD_Turks_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Turks Decisions: loaded")
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
--Player_SendWorldEvent
local notificationWorldEventID = NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"]
function Player_SendWorldEvent(player, description, includeHuman)
	local playerTeam = Teams[player:GetTeam()]
	if (not includeHuman) and player:IsHuman() then return end
	if (not playerTeam:IsHasMet(activeTeamID)) then return end
	print("Sending World Event: ", description)
	activePlayer:AddNotification(notificationWorldEventID, description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
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
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID   	  = GameInfoTypes["CIVILIZATION_JFD_TURKS"]
local eraRenaissanceID	  = GameInfoTypes["ERA_RENAISSANCE"]
local resourceCaptainsID  = GameInfoTypes["RESOURCE_JFD_CAPTAINS"]
-------------------------------------------------------------------------------------------------------------------------
-- Turks: Become a Gunpowder Empire
-------------------------------------------------------------------------------------------------------------------------
local policyDecisionsGunpowderEmpireID = GameInfoTypes["POLICY_DECISIONS_TURKSGUNPOWDER"]
local techGunpowderID  	  = GameInfoTypes["TECH_GUNPOWDER"]
local techPhysicsID	   	  = GameInfoTypes["TECH_PHYSICS"]
tDecisions.Decisions_OttomanGunpowder = nil
local Decisions_JFD_Turks_GunpowderEmpire = {}
    Decisions_JFD_Turks_GunpowderEmpire.Name = "TXT_KEY_DECISIONS_JFD_TURKS_GUNPOWDER"
	Decisions_JFD_Turks_GunpowderEmpire.Desc = "TXT_KEY_DECISIONS_JFD_TURKS_GUNPOWDER_DESC"
	Decisions_JFD_Turks_GunpowderEmpire.Type = "Civilization"
	HookDecisionCivilizationIcon(Decisions_JFD_Turks_GunpowderEmpire, "CIVILIZATION_JFD_TURKS")
	Decisions_JFD_Turks_GunpowderEmpire.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if player:HasPolicy(policyDecisionsGunpowderEmpireID) then
			Decisions_JFD_Turks_GunpowderEmpire.Desc = g_ConvertTextKey("TXT_KEY_DECISIONS_JFD_TURKS_GUNPOWDER_ENACTED_DESC")
			return false, false, true
		end
		local costGold = Game_GetRound(500*iMod)
		local resourceID = iMagistrate
		local strResource = "[ICON_MAGISTRATES] Magistrates"
		if resourceCaptainsID then
			resourceID = resourceCaptainsID
			strResource = "[ICON_JFD_CAPTAINS] Captains"
		end
		Decisions_JFD_Turks_GunpowderEmpire.Desc = g_ConvertTextKey("TXT_KEY_DECISIONS_JFD_TURKS_GUNPOWDER_DESC", costGold, strResource)
		if player:GetGold() < costGold then return true, false end
		if player:GetNumResourceAvailable(resourceID, false) < 2 then return true, false end
		if (not player:HasTech(techGunpowderID)) then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Turks_GunpowderEmpire.DoFunc = (
	function(player)
		local costGold = Game_GetRound(500*iMod)
		player:ChangeGold(-costGold)
		local resourceID = iMagistrate
		if resourceCaptainsID then
			resourceID = resourceCaptainsID
		end
		player:ChangeNumResourceTotal(resourceID, -2)
		if isCPActive then
			player:GrantPolicy(policyDecisionsGunpowderEmpireID, true)
		else
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(policyDecisionsGunpowderEmpireID, true)
		end
		Player_SendWorldEvent(player, g_ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_TURKS_GUNPOWDER", player:GetName(), player:GetCivilizationShortDescription()))
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Turks_GunpowderEmpire", Decisions_JFD_Turks_GunpowderEmpire)
-------------------------------------------------------------------------------------------------------------------------
-- Turks: Found the Enderun Academy
-------------------------------------------------------------------------------------------------------------------------
local buildingEnderunAcademyID  = GameInfoTypes["BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY"]
local Decisions_JFD_Turks_EnderunAcademy = {}
	Decisions_JFD_Turks_EnderunAcademy.Name = "TXT_KEY_DECISIONS_JFD_TURKS_ENDERUN_ACADEMY"
	Decisions_JFD_Turks_EnderunAcademy.Desc = "TXT_KEY_DECISIONS_JFD_TURKS_ENDERUN_ACADEMY_DESC"
	Decisions_JFD_Turks_EnderunAcademy.Pedia = "TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY"
	HookDecisionCivilizationIcon(Decisions_JFD_Turks_EnderunAcademy, "CIVILIZATION_JFD_TURKS")
	Decisions_JFD_Turks_EnderunAcademy.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_JFD_Turks_EnderunAcademy") == true then
			Decisions_JFD_Turks_EnderunAcademy.Desc = g_ConvertTextKey("TXT_KEY_DECISIONS_JFD_TURKS_ENDERUN_ACADEMY_ENACTED_DESC")
			return false, false, true 
		end
		local costGold = Game_GetRound(700*iMod)
		local resourceID = iMagistrate
		local strResource = "[ICON_MAGISTRATES] Magistrates"
		if resourceCaptainsID then
			resourceID = resourceCaptainsID
			strResource = "[ICON_JFD_CAPTAINS] Captains"
		end
		Decisions_JFD_Turks_EnderunAcademy.Desc = g_ConvertTextKey("TXT_KEY_DECISIONS_JFD_TURKS_ENDERUN_ACADEMY_DESC", costGold, strResource)
		if (not player:GetCapitalCity()) then return true, false end
		if player:GetCurrentEra() < eraRenaissanceID then return true, false end
		local unitGarrison = player:GetCapitalCity():GetGarrisonedUnit()
		if (not unitGarrison) then return true, false end
		if unitGarrison:GetLevel() < 3 then return true, false end
		if player:GetNumResourceAvailable(resourceID, false) < 2 then return true, false end
		if player:GetGold() < costGold then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Turks_EnderunAcademy.DoFunc = (
	function(player)
		local costGold = Game_GetRound(700*iMod)
		player:ChangeGold(-costGold)
		local resourceID = iMagistrate
		if resourceCaptainsID then
			resourceID = resourceCaptainsID
		end
		player:ChangeNumResourceTotal(resourceID, -2)
		player:GetCapitalCity():SetNumRealBuilding(buildingEnderunAcademyID, 1)
		Player_SendWorldEvent(player, g_ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_TURKS_ENDERUN_ACADEMY", player:GetName(), player:GetCivilizationShortDescription()))
		save(player, "Decisions_JFD_Turks_EnderunAcademy", true)
	end
	)

Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Turks_EnderunAcademy", Decisions_JFD_Turks_EnderunAcademy)
--=======================================================================================================================
--=======================================================================================================================
