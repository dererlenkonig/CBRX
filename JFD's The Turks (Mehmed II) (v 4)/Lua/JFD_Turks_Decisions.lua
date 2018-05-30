-- JFD_Turks_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Turks Decisions: loaded")
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
--JFD_GetUserSetting
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
local civilizationID   = GameInfoTypes["CIVILIZATION_JFD_TURKS"]
-------------------------------------------------------------------------------------------------------------------------
-- Turks: Become a Gunpowder Empire
-------------------------------------------------------------------------------------------------------------------------
local techGunpowderID  = GameInfoTypes["TECH_GUNPOWDER"]
local techPhysicsID	   = GameInfoTypes["TECH_PHYSICS"]
local unitBombardID    = GameInfoTypes["UNIT_JFD_BOMBARD"] 
local unitMusketmanID  = GameInfoTypes["UNIT_MUSKETMAN"]
tDecisions.Decisions_OttomanGunpowder = nil
local Decisions_JFD_Turks_GunpowderEmpire = {}
    Decisions_JFD_Turks_GunpowderEmpire.Name = "TXT_KEY_DECISIONS_OTTOMANGUNPOWDER"
	Decisions_JFD_Turks_GunpowderEmpire.Desc = "TXT_KEY_DECISIONS_OTTOMANGUNPOWDER_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_Turks_GunpowderEmpire, "CIVILIZATION_JFD_TURKS")
	Decisions_JFD_Turks_GunpowderEmpire.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_JFD_Turks_GunpowderEmpire") == true then
			Decisions_JFD_Turks_GunpowderEmpire.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OTTOMANGUNPOWDER_ENACTED_DESC")
			return false, false, true
		end
		local costGold = mathCeil(500*iMod)
		Decisions_JFD_Turks_GunpowderEmpire.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_OTTOMANGUNPOWDER_DESC", costGold)
		if (not Teams[player:GetTeam()]:IsHasTech(techPhysicsID)) then return true, false end
		if player:GetGold() < costGold then	return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Turks_GunpowderEmpire.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local costGold = mathCeil(500*iMod)
		local capital = player:GetCapitalCity()
		player:ChangeGold(-costGold)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		Teams[player:GetTeam()]:GetTeamTechs():SetHasTech(techGunpowderID, true)
		player:InitUnit(unitMusketmanID, capital:GetX(), capital:GetY())
		player:InitUnit(unitMusketmanID, capital:GetX(), capital:GetY())
		player:InitUnit(unitBombardID, capital:GetX(), capital:GetY())
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_TURKS_OTTOMAN_GUNPOWDER", player:GetName(), player:GetCivilizationShortDescription()))
		save(player, "Decisions_JFD_Turks_GunpowderEmpire", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Turks_GunpowderEmpire", Decisions_JFD_Turks_GunpowderEmpire)
-------------------------------------------------------------------------------------------------------------------------
-- Turks: Found the Enderun Academy
-------------------------------------------------------------------------------------------------------------------------
local buildingEnderunAcademyID  = GameInfoTypes["BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY"]
local eraRenaissanceID			= GameInfoTypes["ERA_RENAISSANCE"]
local unitLancerID				= GameInfoTypes["UNIT_LANCER"]
local unitSipahiID				= GameInfoTypes["UNIT_OTTOMAN_SIPAHI"]
local Decisions_JFD_Turks_EnderunAcademy = {}
	Decisions_JFD_Turks_EnderunAcademy.Name = "TXT_KEY_DECISIONS_JFD_TURKS_ENDERUN_ACADEMY"
	Decisions_JFD_Turks_EnderunAcademy.Desc = "TXT_KEY_DECISIONS_JFD_TURKS_ENDERUN_ACADEMY_DESC"
	Decisions_JFD_Turks_EnderunAcademy.Pedia = "TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY"
	HookDecisionCivilizationIcon(Decisions_JFD_Turks_EnderunAcademy, "CIVILIZATION_JFD_TURKS")
	Decisions_JFD_Turks_EnderunAcademy.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_JFD_Turks_EnderunAcademy") == true then
			Decisions_JFD_Turks_EnderunAcademy.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_TURKS_ENDERUN_ACADEMY_ENACTED_DESC")
			return false, false, true 
		end
		local playerID = player:GetID()
		local costGold = mathCeil(700*iMod)
		Decisions_JFD_Turks_EnderunAcademy.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_TURKS_ENDERUN_ACADEMY_DESC", costGold)
		if (not player:GetCapitalCity()) then return true, false end
		if player:GetCurrentEra() < eraRenaissanceID then return true, false end
		local capitalGarrison = player:GetCapitalCity():GetGarrisonedUnit()
		if (not capitalGarrison) then return true, false end
		if capitalGarrison:GetLevel() < 3 then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		if player:GetGold() < costGold then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Turks_EnderunAcademy.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local costGold = mathCeil(700*iMod)
		player:ChangeNumResourceTotal(iMagistrate, -2)
		player:ChangeGold(-costGold)
		player:GetCapitalCity():SetNumRealBuilding(buildingEnderunAcademyID, 1)
		JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_TURKS_ENDERUN_ACADEMY", player:GetName(), player:GetCivilizationShortDescription()))
		save(player, "Decisions_JFD_Turks_EnderunAcademy", true)
	end
	)

Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Turks_EnderunAcademy", Decisions_JFD_Turks_EnderunAcademy)
--=======================================================================================================================
--=======================================================================================================================
