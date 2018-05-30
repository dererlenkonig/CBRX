-- JFD_Prussia_Decisions
-- Author: JFD
--=======================================================================================================================
print("JFD's Prussia Decisions: loaded")
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
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
local userSettingSovereigntyCore = JFD_GetUserSetting("JFD_RTP_SOVEREIGNTY_CORE") == 1
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID			= GameInfoTypes["CIVILIZATION_JFD_PRUSSIA"]
local mathCeil					= math.ceil
local resourceDignitaryID		= GameInfoTypes["RESOURCE_JFD_DIGNITARIES"]
--------------------------------------------------------------------------------------------------------------------------
-- Prussia: Empower the Junker Nobility
-------------------------------------------------------------------------------------------------------------------------
local policyEmpowerJunkersID    = GameInfoTypes["POLICY_DECISIONS_JFD_PRUSSIA_JUNKERS"]
local reformPeeragePrivilegedID = GameInfoTypes["REFORM_JFD_PEERAGE_PRIVILEGED"]
local techFlintlockID		    = GameInfoTypes["TECH_EE_FLINTLOCK"]
local techRiflingID			    = GameInfoTypes["TECH_RIFLING"]
local yieldProductionID		    = GameInfoTypes["YIELD_PRODUCTION"]
local unitLandwehrID		    = GameInfoTypes["UNIT_JFD_LANDWEHR"]
local Decisions_JFD_Prussia_Junkers = {}
	Decisions_JFD_Prussia_Junkers.Name = "TXT_KEY_DECISIONS_JFD_PRUSSIA_JUNKERS"
	Decisions_JFD_Prussia_Junkers.Desc = "TXT_KEY_DECISIONS_JFD_PRUSSIA_JUNKERS_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_Prussia_Junkers, "CIVILIZATION_JFD_PRUSSIA")
	Decisions_JFD_Prussia_Junkers.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if player:HasPolicy(policyEmpowerJunkersID) then
			if userSettingSovereigntyCore then
				Decisions_JFD_Prussia_Junkers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_PRUSSIA_JUNKERS_ENACTED_DESC_SOVEREIGNTY")		
			else
				Decisions_JFD_Prussia_Junkers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_PRUSSIA_JUNKERS_ENACTED_DESC")
			end
			return false, false, true 
		end
		local costGold = mathCeil(730*iMod)
		local techID = techRiflingID
		local techDesc = "Rifling"
		if techFlintlockID then
			techID = techFlintlockID
			techDesc = "Flintlock"
		end
		if userSettingSovereigntyCore then
			Decisions_JFD_Prussia_Junkers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_PRUSSIA_JUNKERS_DESC_SOVEREIGNTY", techDesc, costGold)
			if (not player:HasGovernment()) then return true, false end
			if JFD_HasReform(playerID, reformPeeragePrivilegedID) then return true, false end
			if player:GetNumResourceAvailable(iMagistrate, false) < 2 then return true, false end
		else
			Decisions_JFD_Prussia_Junkers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_PRUSSIA_JUNKERS_DESC", techDesc, costGold)
			if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		end	
		if (not Teams[player:GetTeam()]:IsHasTech(techID)) then return true, false end
		if player:GetGold() < costGold then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Prussia_Junkers.DoFunc = (
	function(player)
		local playerID = player:GetID()
		local costGold = mathCeil(730*iMod)
		player:ChangeGold(-costGold)
		if userSettingSovereigntyCore then
			player:ChangeNumResourceTotal(iMagistrate, -2)
		else
			player:ChangeNumResourceTotal(iMagistrate, -1)
		end
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policyEmpowerJunkersID, true)
		if (not JFD_HasReform(playerID, reformPeeragePrivilegedID)) then
			JFD_SetHasReform(playerID, reformPeeragePrivilegedID, true, true)
		end	
	end
	)

	Decisions_JFD_Prussia_Junkers.Monitors = {}
	Decisions_JFD_Prussia_Junkers.Monitors[GameEvents.SetPopulation] =  (
	function(cityX, cityY, oldPopulation, newPopulation)
		local city = Map.GetPlot(cityX, cityY):GetPlotCity()
		local player = Players[city:GetOwner()]
		if player:HasPolicy(policyEmpowerJunkersID) then
			if oldPopulation < newPopulation then
				if player:CanTrain(unitLandwehrID) then
					city:ChangeUnitProduction(unitLandwehrID, city:GetYieldRate(yieldProductionID)*3)
				end
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Prussia_Junkers", Decisions_JFD_Prussia_Junkers)
-------------------------------------------------------------------------------------------------------------------------
-- Prussia: Award the Pour le Merite
-------------------------------------------------------------------------------------------------------------------------
local eraRenaissanceID	 = GameInfoTypes["ERA_RENAISSANCE"]
local eraModernID		 = GameInfoTypes["ERA_MODERN"]
local resourceHorseID	 = GameInfoTypes["RESOURCE_HORSE"]
local unitGreatGeneralID = GameInfoTypes["UNIT_GREAT_GENERAL"]
local Decisions_JFD_Prussia_Merit = {}
	Decisions_JFD_Prussia_Merit.Name = "TXT_KEY_DECISIONS_JFD_PRUSSIA_POUR_LE_MERITE"
	Decisions_JFD_Prussia_Merit.Desc = "TXT_KEY_DECISIONS_JFD_PRUSSIA_POUR_LE_MERITE_DESC"
	HookDecisionCivilizationIcon(Decisions_JFD_Prussia_Merit, "CIVILIZATION_JFD_PRUSSIA")
	Decisions_JFD_Prussia_Merit.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		local era = load(player, "Decisions_JFD_Prussia_Merit")
		local currentEra = player:GetCurrentEra()
		if currentEra >= eraModernID then
			Decisions_JFD_Prussia_Merit.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_PRUSSIA_POUR_LE_MERITE_ENACTED_DESC")
			return false, false, true 
		else
			if era ~= nil then
				if era < currentEra then
					save(player, "Decisions_JFD_Prussia_Merit", nil)
				else
					Decisions_JFD_Prussia_Merit.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_PRUSSIA_POUR_LE_MERITE_ENACTED_DESC")
					return false, false, true
				end
			end
		end
		local costCulture = mathCeil(370*iMod)
		local resourceType = "[ICON_MAGISTRATES] Magistrates"
		local resourceID = iMagistrate
		if userSettingSovereigntyCore then
			resourceType = "[ICON_JFD_DIGNITARY] Dignitaries"
			resourceID = resourceDignitaryID
		end
		Decisions_JFD_Prussia_Merit.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_PRUSSIA_POUR_LE_MERITE_DESC", costCulture, resourceType)	
		if player:GetNumResourceAvailable(resourceID, false) < 1 then return true, false end
		if player:GetJONSCulture() < costCulture then return true, false end
		if player:GetCurrentEra() < eraRenaissanceID then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_Prussia_Merit.DoFunc = (
	function(player)
		local costCulture = mathCeil(370*iMod)
		local resourceID = iMagistrate
		if userSettingSovereigntyCore then
			resourceID = resourceDignitaryID
		end
		player:ChangeJONSCulture(-costCulture)
		player:ChangeNumResourceTotal(resourceID, -1)
		local numHorses = player:GetNumResourceAvailable(resourceHorseID, true)
		local unitToSpawnID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_GUN")
		if unitToSpawnID then
			for unit in player:Units() do
				if numHorses > 0 then
					unitToSpawnID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_MOUNTED")
					numHorses = numHorses - 1
				end
				if unit:GetUnitType() == unitGreatGeneralID then
					local newUnit = player:InitUnit(unitToSpawnID, unit:GetX(), unit:GetY())
					newUnit:Convert(unit, false)
					newUnit:ChangeExperience(30)
				end
			end
		end
		save(player, "Decisions_JFD_Prussia_Merit", player:GetCurrentEra())
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_JFD_Prussia_Merit", Decisions_JFD_Prussia_Merit)
--=======================================================================================================================
--=======================================================================================================================
