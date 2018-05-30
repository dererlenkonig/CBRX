-- DMS_Ethiopia_Events
-- Author: DMS
--=======================================================================================================================
print("DMS' The Ethiopian Civ Pack's Events: loaded")
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("JFD_RTPUtils.lua")
--==========================================================================================================================
-- USER SETTINGS
--==========================================================================================================================
-- DMS_GetUserSetting (adapted from JFD's JFD_GetUserSetting - credit goes there!)
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetUserSetting(type)
	for row in GameInfo.DMS_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- Debug
----------------------------------------------------------------------------------------------------------------------------
local bPrintForDebug = DMS_GetUserSetting("DMS_ETHIOPIA_EVENTS_DEBUGGING_ON") == 1

function DMS_Print(string)
	if (not bPrintForDebug) then
		return
	else
		return print(string)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
----------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
----------------------------------------------------------------------------------------------------------------------------
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SendNotification
----------------------------------------------------------------------------------------------------------------------------
function JFD_SendNotification(playerID, notificationType, description, descriptionShort, global, iX, iY)
	local player = Players[playerID]
	if global then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
	else
		if player:IsHuman() then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_TableContains
----------------------------------------------------------------------------------------------------------------------------
function DMS_TableContains(table, value)
	for _, v in pairs(table) do
		if v == value then

		return true
		end
	end

	return false
end
----------------------------------------------------------------------------------------------------------------------------
-- GetStrongestMilitaryUnit
----------------------------------------------------------------------------------------------------------------------------
function GetStrongestMilitaryUnit(pPlayer, bIgnoreResources, ...)
    local tUnit = {["ID"] = GameInfoTypes.UNIT_WARRIOR, ["Combat"] = -1}
    for iKey, sCombatType in pairs({...}) do
        for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
            if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
                tUnit = row
            end
        end
    end
    return tUnit.ID
end
----------------------------------------------------------------------------------------------------------------------------
--Player:GetDefaultName
----------------------------------------------------------------------------------------------------------------------------
function Player.GetDefaultName(player)
    local leader = GameInfo.Leaders[player:GetLeaderType()]
    local leaderName = leader.Description
    local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
    for row in GameInfo.Policy_JFD_LeaderName("LeaderType = '" .. leader.Type .. "'") do
        if player:HasPolicy(GameInfoTypes[row.PolicyType]) then
            leaderName = row.Description
        end
    end

    return leaderName
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetEraAdjustedValue
----------------------------------------------------------------------------------------------------------------------------
local mathCeil = math.ceil
function JFD_GetEraAdjustedValue(playerID, num)
	local player = Players[playerID]
	local currentEraID = player:GetCurrentEra()
	local eraMod = GameInfo.Eras[currentEraID].ResearchAgreementCost
	return mathCeil(num * eraMod/100)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_IsUsingEE
----------------------------------------------------------------------------------------------------------------------------
function DMS_IsUsingEE()
	local EEModID = "ce8aa614-7ef7-4a45-a179-5329869e8d6d"
	local isUsingEE = false
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == EEModID) then
			isUsingEE = true
			break
		end
	end
	return isUsingEE
end
----------------------------------------------------------------------------------------------------------------------------
--IsCPDLL
----------------------------------------------------------------------------------------------------------------------------
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()
------------------------------------------------------------------------------------------------------------------------
-- JFD_isUsingRiseToPower
------------------------------------------------------------------------------------------------------------------------
function JFD_isUsingRiseToPower()
	local RtPID = "eea66053-7579-481a-bb8d-2f3959b59974"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == RtPID) then
			return true
		end
	end
	return false
end
local isUsingRtP = JFD_isUsingRiseToPower()
--========================================================================================================================
-- Civ Specific Events
--========================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationAksumID					= GameInfoTypes["CIVILIZATION_DMS_AKSUM_KALEB"]
local civilisationEthiopiaAmdaSeyonIID		= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_SEYON_I"]
local civilisationEthiopiaZaraYaqobID		= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_YAQOB"]
local civilisationEthiopiaMenelikIIID		= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_MENELIK_II"]
local civilisationEthiopiaHaileSelassieID	= GameInfoTypes["CIVILIZATION_ETHIOPIA"]
local eraAncientID							= GameInfoTypes["ERA_ANCIENT"]
local eraClassicalID						= GameInfoTypes["ERA_CLASSICAL"]
local eraMedievalID							= GameInfoTypes["ERA_MEDIEVAL"]
local eraRenaissanceID						= GameInfoTypes["ERA_RENAISSANCE"]
local eraEnlightenmentID					= GameInfoTypes["ERA_ENLIGHTENMENT"]
local eraIndustrialID						= GameInfoTypes["ERA_INDUSTRIAL"]
local eraAtomicID							= GameInfoTypes["ERA_ATMOIC"]
local eraModernID							= GameInfoTypes["ERA_MODERN"]
local buildingOromoCityID					= GameInfoTypes["BUILDING_EVENT_DMS_ETHIOPIA_THE_OROMO"]
--------------------------------------------------------------------------------------------------------------------------
-- The Monastic Orders
--------------------------------------------------------------------------------------------------------------------------
local Event_EthiopiaTheMonasticOrders = {}
	Event_EthiopiaTheMonasticOrders.Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER"
	Event_EthiopiaTheMonasticOrders.Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_DESC"
	Event_EthiopiaTheMonasticOrders.EventImage = "Event_TheMonasticOrders.dds"
	Event_EthiopiaTheMonasticOrders.Weight = 10
	Event_EthiopiaTheMonasticOrders.tValidCivs = {
		["CIVILIZATION_DMS_AKSUM_KALEB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_SEYON_I"]		= true,
		["CIVILIZATION_DMS_ETHIOPIA_YAQOB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_MENELIK_II"]	= true,
		["CIVILIZATION_ETHIOPIA"]					= true,
		}
	Event_EthiopiaTheMonasticOrders.CanFunc = (
		function(pPlayer)			
			local iPlayer = pPlayer:GetID()
			if load(pPlayer, "Event_EthiopiaTheMonasticOrders") == true			then return false end

			local sCivAdj = pPlayer:GetCivilizationAdjective()
			local sCivShort = pPlayer:GetCivilizationShortDescription()	
			Event_EthiopiaTheMonasticOrders.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_DESC", sCivAdj, sCivShort, sCivAdj, sCivAdj)

			local iGold = JFD_GetEraAdjustedValue(pPlayer:GetID(), 85)
			local iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 20)

			local iReligion = nil
			if isUsingRtP then
				if pPlayer:HasStateReligion() then
					iReligion = pPlayer:GetStateReligion()

					iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 5)
				end
			elseif (not isUsingRtP) then
				if pPlayer:HasCreatedReligion() then
					iReligion = pPlayer:GetReligionCreatedByPlayer()
				else
					iReligion = pPlayer:GetCapitalCity():GetReligiousMajority()
				end
			end

			if (not iReligion)												then return false end
			if pPlayer:GetCurrentEra() < eraMedievalID						then return false end
			if pPlayer:GetCurrentEra() > eraIndustrialID					then return false end
			if pPlayer:GetGold() < iGold									then return false end
			if isUsingRtP then
				if pPlayer:GetPiety() < iFaithOrPiety						then return false end	
			elseif (not isUsingRtP) then
				if pPlayer:GetFaith() < iFaithOrPiety						then return false end	
			end
							
			return true
		end
		)
	Event_EthiopiaTheMonasticOrders.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_EthiopiaTheMonasticOrders.Outcomes[1] = {}
	Event_EthiopiaTheMonasticOrders.Outcomes[1].Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_OUTCOME_1"
	Event_EthiopiaTheMonasticOrders.Outcomes[1].Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_OUTCOME_RESULT_1"
	Event_EthiopiaTheMonasticOrders.Outcomes[1].Weight = 5
	Event_EthiopiaTheMonasticOrders.Outcomes[1].CanFunc = (
		function(pPlayer)	
			local iPlayer = pPlayer:GetID()
			local iGold = JFD_GetEraAdjustedValue(iPlayer, 85)
			local iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 20)
			local iconFaithOrPiety = "[ICON_PEACE]"
			local sFaithOrPiety = "Faith"
			if isUsingRtP then
				iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 5)
				iconFaithOrPiety = "[ICON_JFD_PIETY]"
				sFaithOrPiety = "Piety"
			end
			
			Event_EthiopiaTheMonasticOrders.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_OUTCOME_RESULT_1", iGold, iFaithOrPiety, iconFaithOrPiety, sFaithOrPiety)
			return true
		end
		)
	Event_EthiopiaTheMonasticOrders.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()
			local iGold = JFD_GetEraAdjustedValue(iPlayer, 85)
			local iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 20)
			if isUsingRtP then
				iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 5)
				pPlayer:ChangePiety(-iFaithOrPiety)
			elseif (not isUsingRtP) then
				pPlayer:ChangeFaith(-iFaithOrPiety)
			end
			pPlayer:ChangeGold(iGold)
			
			local sCivShort = pPlayer:GetCivilizationShortDescription()	
			local sCivAdjective = pPlayer:GetCivilizationAdjective()	
			local sLeader = pPlayer.GetDefaultName()

			JFD_SendNotification(iPlayer, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER"))
			JFD_SendWorldEvent(iPlayer, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_DMS_ETHIOPIA_THE_MONASTIC_ORDER_1", sCivShort, sLeader, sCivAdjective))

			save(pPlayer, "Event_EthiopiaTheMonasticOrders", true)
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_EthiopiaTheMonasticOrders.Outcomes[2] = {}
	Event_EthiopiaTheMonasticOrders.Outcomes[2].Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_OUTCOME_2"
	Event_EthiopiaTheMonasticOrders.Outcomes[2].Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_OUTCOME_RESULT_2"
	Event_EthiopiaTheMonasticOrders.Outcomes[2].Weight = 2
	Event_EthiopiaTheMonasticOrders.Outcomes[2].CanFunc = (
		function(pPlayer)			
			local iPlayer = pPlayer:GetID()
			local iGold = JFD_GetEraAdjustedValue(iPlayer, 85)
			local iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 20)
			local iconFaithOrPiety = "[ICON_PEACE]"
			local sFaithOrPiety = "Faith"
			if isUsingRtP then
				iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 5)
				iconFaithOrPiety = "[ICON_JFD_PIETY]"
				sFaithOrPiety = "Piety"
			end
			Event_EthiopiaTheMonasticOrders.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_OUTCOME_RESULT_2", iFaithOrPiety, iconFaithOrPiety, sFaithOrPiety, iGold)
			return true
		end
		)
	Event_EthiopiaTheMonasticOrders.Outcomes[2].DoFunc = (
		function(pPlayer) 
			local iPlayer = pPlayer:GetID()
			local iGold = JFD_GetEraAdjustedValue(iPlayer, 85)
			local iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 20)
			if isUsingRtP then
				iFaithOrPiety = JFD_GetEraAdjustedValue(iPlayer, 5)
				pPlayer:ChangePiety(iFaithOrPiety)
			elseif (not isUsingRtP) then
				pPlayer:ChangeFaith(iFaithOrPiety)
			end
			pPlayer:ChangeGold(-iGold)
			
			local sCivShort = pPlayer:GetCivilizationShortDescription()	
			local sCivAdjective = pPlayer:GetCivilizationAdjective()	
			local sLeader = pPlayer.GetDefaultName()

			JFD_SendNotification(iPlayer, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_MONASTIC_ORDER"))
			JFD_SendWorldEvent(iPlayer, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_DMS_ETHIOPIA_THE_MONASTIC_ORDER_2", sCivShort, sLeader))

			save(pPlayer, "Event_EthiopiaTheMonasticOrders", true)
		end)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_EthiopiaTheMonasticOrders.tValidCivs[sCiv] then
			tEvents.Event_EthiopiaTheMonasticOrders = Event_EthiopiaTheMonasticOrders
			break
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- The Oromo
--------------------------------------------------------------------------------------------------------------------------
local Event_EthiopiaTheOromo = {}
	Event_EthiopiaTheOromo.Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_OROMO"
	Event_EthiopiaTheOromo.Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_OROMO_DESC"
	Event_EthiopiaTheOromo.Data1 = {}	
	Event_EthiopiaTheOromo.Data2 = nil
	Event_EthiopiaTheOromo.Weight = 5
	Event_EthiopiaTheOromo.tValidCivs = {
		["CIVILIZATION_DMS_AKSUM_KALEB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_SEYON_I"]		= true,
		["CIVILIZATION_DMS_ETHIOPIA_YAQOB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_MENELIK_II"]	= true,
		["CIVILIZATION_ETHIOPIA"]					= true,
		}
	Event_EthiopiaTheOromo.CanFunc = (
		function(pPlayer)			
			local iPlayer = pPlayer:GetID()
			if load(pPlayer, "Event_EthiopiaTheOromo") == true			then return false end

			local iReligion = nil
			if isUsingRtP then
				if pPlayer:HasStateReligion() then
					iReligion = pPlayer:GetStateReligion()
				end
			elseif (not isUsingRtP) then
				if pPlayer:HasCreatedReligion() then
					iReligion = pPlayer:GetReligionCreatedByPlayer()
				else
					iReligion = pPlayer:GetReligiousMajority()
				end
			end
			
			Event_EthiopiaTheOromo.Data1 = {}
			for pCity in pPlayer:Cities() do
				if (not pCity:IsCapital()) and (pCity:GetPopulation() > 6) and pCity:GetNumFollowers(iReligion) >= mathCeil(pCity:GetPopulation()/2) then
					table.insert(Event_EthiopiaTheOromo.Data1, pCity)
				end
			end
			if #Event_EthiopiaTheOromo.Data1 < 1							then return false end

			Event_EthiopiaTheOromo.Data2 = Event_EthiopiaTheOromo.Data1[JFD_GetRandom(1, #Event_EthiopiaTheOromo.Data1)]
			Event_EthiopiaTheOromo.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_OROMO_DESC", Event_EthiopiaTheOromo.Data2:GetName())

			if (not iReligion)												then return false end
			if pPlayer:GetCurrentEra() > eraAtomicID						then return false end
										
			return true
		end
		)
	Event_EthiopiaTheOromo.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_EthiopiaTheOromo.Outcomes[1] = {}
	Event_EthiopiaTheOromo.Outcomes[1].Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_OROMO_OUTCOME_1"
	Event_EthiopiaTheOromo.Outcomes[1].Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_THE_OROMO_OUTCOME_RESULT_1"
	Event_EthiopiaTheOromo.Outcomes[1].Weight = 5
	Event_EthiopiaTheOromo.Outcomes[1].CanFunc = (
		function(pPlayer)	
			local iPlayer = pPlayer:GetID()
			
			local iNumPop = Event_EthiopiaTheOromo.Data2:GetPopulation()
			local iNumConvert = mathCeil(iNumPop/2)

			Event_EthiopiaTheOromo.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_OROMO_OUTCOME_RESULT_1", Event_EthiopiaTheOromo.Data2:GetName(), iNumConvert, Event_EthiopiaTheOromo.Data2:GetName())
			return true
		end
		)
	Event_EthiopiaTheOromo.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()
			local iReligion = nil
			if isUsingRtP then
				if pPlayer:HasStateReligion() then
					iReligion = pPlayer:GetStateReligion()
				end
			elseif (not isUsingRtP) then
				if pPlayer:HasCreatedReligion() then
					iReligion = pPlayer:GetReligionCreatedByPlayer()
				else
					iReligion = pPlayer:GetReligiousMajority()
				end
			end
			local iNumPop = Event_EthiopiaTheOromo.Data2:GetPopulation()
			local iNumConvert = mathCeil(iNumPop/2)
			local iNumConvertPercent = mathCeil(iNumConvert/iNumPop * 100)

			Event_EthiopiaTheOromo.Data2:ConvertPercentFollowers(-1, iReligion, iNumConvertPercent)
		
			Event_EthiopiaTheOromo.Data2:SetNumRealBuilding(buildingOromoCityID, 1)

			local sCivAdjective = pPlayer:GetCivilizationAdjective()

			JFD_SendNotification(iPlayer, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_OROMO_OUTCOME_RESULT_1_NOTIFICATION", Event_EthiopiaTheOromo.Data2:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_THE_OROMO"))
			JFD_SendWorldEvent(iPlayer, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_DMS_ETHIOPIA_THE_OROMO_1", sCivAdjective, Event_EthiopiaTheOromo.Data2:GetName()))

			save(pPlayer, "Event_EthiopiaTheOromo", true)
		end)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_EthiopiaTheOromo.tValidCivs[sCiv] then
			tEvents.Event_EthiopiaTheOromo = Event_EthiopiaTheOromo
			break
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- Oromo Settlers
--------------------------------------------------------------------------------------------------------------------------
local Event_EthiopiaOromoSettlers = {}
	Event_EthiopiaOromoSettlers.Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_OROMO_SETTLERS"
	Event_EthiopiaOromoSettlers.Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_OROMO_SETTLERS_DESC"
	Event_EthiopiaOromoSettlers.Data1 = {}	
	Event_EthiopiaOromoSettlers.Data2 = nil
	Event_EthiopiaOromoSettlers.Weight = 5
	Event_EthiopiaOromoSettlers.tValidCivs = {
		["CIVILIZATION_DMS_AKSUM_KALEB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_SEYON_I"]		= true,
		["CIVILIZATION_DMS_ETHIOPIA_YAQOB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_MENELIK_II"]	= true,
		["CIVILIZATION_ETHIOPIA"]					= true,
		}
	Event_EthiopiaOromoSettlers.CanFunc = (
		function(pPlayer)			
			local iPlayer = pPlayer:GetID()
			if load(pPlayer, "Event_EthiopiaTheOromo") == false				then return false end
			if load(pPlayer, "Event_EthiopiaOromoSettlers") == true			then return false end
			if pPlayer:GetCurrentEra() > eraAtomicID						then return false end

			local iReligion = nil
			if isUsingRtP then
				if pPlayer:HasStateReligion() then
					iReligion = pPlayer:GetStateReligion()
				end
			elseif (not isUsingRtP) then
				if pPlayer:HasCreatedReligion() then
					iReligion = pPlayer:GetReligionCreatedByPlayer()
				else
					iReligion = pPlayer:GetReligiousMajority()
				end
			end
			if (not iReligion)												then return false end
			-- find city from 'The Oromo' event
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(buildingOromoCityID) then
					if (pCity:GetPopulation() > 6) and pCity:GetNumFollowers(iReligion) >= mathCeil(pCity:GetPopulation()/2) then
						Event_EthiopiaOromoSettlers.Data2 = pCity
					end
				end
			end
			-- if this city is no longer in the player's control, find a new one
			Event_EthiopiaOromoSettlers.Data1 = {}
			if Event_EthiopiaOromoSettlers.Data2 == -1 then
				for pCity in pPlayer:Cities() do
					if (not pCity:IsCapital()) and (pCity:GetPopulation() > 6) and pCity:GetNumFollowers(iReligion) >= mathCeil(pCity:GetPopulation()/2) then
						table.insert(Event_EthiopiaOromoSettlers.Data1, pCity)
					end
				end
			end
			if Event_EthiopiaOromoSettlers.Data2 == -1 then
				if #Event_EthiopiaOromoSettlers.Data1 < 1					then return false end
				Event_EthiopiaOromoSettlers.Data2 = Event_EthiopiaOromoSettlers.Data1[JFD_GetRandom(1, #Event_EthiopiaOromoSettlers.Data1)]
			end

			Event_EthiopiaOromoSettlers.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_OROMO_SETTLERS_DESC", Event_EthiopiaOromoSettlers.Data2:GetName())

			return true
		end
		)
	Event_EthiopiaOromoSettlers.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_EthiopiaOromoSettlers.Outcomes[1] = {}
	Event_EthiopiaOromoSettlers.Outcomes[1].Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_OROMO_SETTLERS_OUTCOME_1"
	Event_EthiopiaOromoSettlers.Outcomes[1].Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_OROMO_SETTLERS_OUTCOME_RESULT_1"
	Event_EthiopiaOromoSettlers.Outcomes[1].Weight = 5
	Event_EthiopiaOromoSettlers.Outcomes[1].CanFunc = (
		function(pPlayer)	
			local iPlayer = pPlayer:GetID()
			
			local iNumPop = Event_EthiopiaOromoSettlers.Data2:GetPopulation()
			local iNumConvert = mathCeil(iNumPop/2)

			Event_EthiopiaOromoSettlers.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_OROMO_SETTLERS_OUTCOME_RESULT_1", Event_EthiopiaOromoSettlers.Data2:GetName(), iNumConvert, Event_EthiopiaOromoSettlers.Data2:GetName())
			return true
		end
		)
	Event_EthiopiaOromoSettlers.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()
			local iReligion = nil
			if isUsingRtP then
				if pPlayer:HasStateReligion() then
					iReligion = pPlayer:GetStateReligion()
				end
			elseif (not isUsingRtP) then
				if pPlayer:HasCreatedReligion() then
					iReligion = pPlayer:GetReligionCreatedByPlayer()
				else
					iReligion = pPlayer:GetReligiousMajority()
				end
			end
			local iNumPop = Event_EthiopiaOromoSettlers.Data2:GetPopulation()
			local iNumConvert = mathCeil(iNumPop/2)
			local iNumConvertPercent = mathCeil(iNumConvert/iNumPop * 100)

			Event_EthiopiaOromoSettlers.Data2:ConvertPercentFollowers(-1, iReligion, iNumConvertPercent)
		
			Event_EthiopiaOromoSettlers.Data2:SetNumRealBuilding(buildingOromoCityID, 1)

			local sCivAdjective = pPlayer:GetCivilizationAdjective()

			JFD_SendNotification(iPlayer, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_OROMO_SETTLERS_OUTCOME_RESULT_1_NOTIFICATION", Event_EthiopiaOromoSettlers.Data2:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_OROMO_SETTLERS"))
			JFD_SendWorldEvent(iPlayer, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_DMS_ETHIOPIA_OROMO_SETTLERS_1", sCivAdjective, Event_EthiopiaOromoSettlers.Data2:GetName()))

			save(pPlayer, "Event_EthiopiaOromoSettlers", true)
		end)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_EthiopiaOromoSettlers.tValidCivs[sCiv] then
			tEvents.Event_EthiopiaOromoSettlers = Event_EthiopiaOromoSettlers
			break
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- Integration of the Oromo
--------------------------------------------------------------------------------------------------------------------------
local Event_EthiopiaIntegrationOfTheOromo = {}
	Event_EthiopiaIntegrationOfTheOromo.Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_INTEGRATION_OF_THE_OROMO"
	Event_EthiopiaIntegrationOfTheOromo.Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_INTEGRATION_OF_THE_OROMO_DESC"
	Event_EthiopiaIntegrationOfTheOromo.Data1 = {}	
	Event_EthiopiaIntegrationOfTheOromo.Data2 = nil
	Event_EthiopiaIntegrationOfTheOromo.Weight = 10
	Event_EthiopiaIntegrationOfTheOromo.tValidCivs = {
		["CIVILIZATION_DMS_AKSUM_KALEB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_SEYON_I"]		= true,
		["CIVILIZATION_DMS_ETHIOPIA_YAQOB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_MENELIK_II"]	= true,
		["CIVILIZATION_ETHIOPIA"]					= true,
		}
	Event_EthiopiaIntegrationOfTheOromo.CanFunc = (
		function(pPlayer)			
			local iPlayer = pPlayer:GetID()
			if load(pPlayer, "Event_EthiopiaOromoSettlers") == false		then return false end
			if load(pPlayer, "Event_EthiopiaIntegrationOfTheOromo") == true	then return false end
			if pPlayer:GetCurrentEra() > eraAtomicID						then return false end

			-- find city from 'Oromo Settlers' event (DO NOT FIND NEW ONE IF THIS ONE IS LOST)
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(buildingOromoCityID) then
					if (pCity:GetPopulation() > 10) then
						Event_EthiopiaIntegrationOfTheOromo.Data2 = pCity
					end
				end
			end

			Event_EthiopiaIntegrationOfTheOromo.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_INTEGRATION_OF_THE_OROMO_DESC")

			return true
		end
		)
	Event_EthiopiaIntegrationOfTheOromo.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_EthiopiaIntegrationOfTheOromo.Outcomes[1] = {}
	Event_EthiopiaIntegrationOfTheOromo.Outcomes[1].Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_INTEGRATION_OF_THE_OROMO_OUTCOME_1"
	Event_EthiopiaIntegrationOfTheOromo.Outcomes[1].Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_INTEGRATION_OF_THE_OROMO_OUTCOME_RESULT_1"
	Event_EthiopiaIntegrationOfTheOromo.Outcomes[1].Weight = 5
	Event_EthiopiaIntegrationOfTheOromo.Outcomes[1].CanFunc = (
		function(pPlayer)	
			local iPlayer = pPlayer:GetID()
			
			local iNumPop = Event_EthiopiaIntegrationOfTheOromo.Data2:GetPopulation()
			local iNumCulture = JFD_GetEraAdjustedValue(iPlayer, iNumPop * 15)

			Event_EthiopiaIntegrationOfTheOromo.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_INTEGRATION_OF_THE_OROMO_OUTCOME_RESULT_1", iNumCulture)
			return true
		end
		)
	Event_EthiopiaIntegrationOfTheOromo.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()
			local iNumPop = Event_EthiopiaIntegrationOfTheOromo.Data2:GetPopulation()
			local iNumCulture = JFD_GetEraAdjustedValue(iPlayer, iNumPop * 15)

			pPlayer:ChangeJONSCulture(iNumCulture)
						
			local sCivAdjective = pPlayer:GetCivilizationAdjective()

			JFD_SendNotification(iPlayer, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_INTEGRATION_OF_THE_OROMO_OUTCOME_RESULT_1_NOTIFICATION", Event_EthiopiaIntegrationOfTheOromo.Data2:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_INTEGRATION_OF_THE_OROMO"))
			JFD_SendWorldEvent(iPlayer, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_DMS_ETHIOPIA_INTEGRATION_OF_THE_OROMO_1", sCivAdjective, Event_EthiopiaIntegrationOfTheOromo.Data2:GetName()))

			save(pPlayer, "Event_EthiopiaIntegrationOfTheOromo", true)
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_EthiopiaIntegrationOfTheOromo.tValidCivs[sCiv] then
			tEvents.Event_EthiopiaIntegrationOfTheOromo = Event_EthiopiaIntegrationOfTheOromo
			break
		end
	end
end
--------------------------------------------------------------------------------------------------------------------------
-- Amba Geshen - The Mountain of Kings
--------------------------------------------------------------------------------------------------------------------------
local Event_EthiopiaAmbaGeshenTheMountainOfKings = {}
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS"
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_DESC"
	Event_EthiopiaAmbaGeshenTheMountainOfKings.EventImage = "Event_AmbaGeshenTheMountainOfKings.dds"
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Data2 = nil
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Weight = 5
	Event_EthiopiaAmbaGeshenTheMountainOfKings.tValidCivs = {
		["CIVILIZATION_DMS_AKSUM_KALEB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_SEYON_I"]		= true,
		["CIVILIZATION_DMS_ETHIOPIA_YAQOB"]			= true,
		["CIVILIZATION_DMS_ETHIOPIA_MENELIK_II"]	= true,
		["CIVILIZATION_ETHIOPIA"]					= true,
		}
	Event_EthiopiaAmbaGeshenTheMountainOfKings.CanFunc = (
		function(pPlayer)			
			local iPlayer = pPlayer:GetID()
			if load(pPlayer, "Event_EthiopiaAmbaGeshenTheMountainOfKings") == true	then return false end
			
			local iNumGold		= JFD_GetEraAdjustedValue(iPlayer, 115)
			local iNumCulture	= JFD_GetEraAdjustedValue(iPlayer, 25)

			if pPlayer:GetGold() < iNumGold											then return false end
			if pPlayer:GetJONSCulture() < iNumCulture								then return false end

			Event_EthiopiaAmbaGeshenTheMountainOfKings.Data2 = JFD_GetRandom(2,5)

			Event_EthiopiaAmbaGeshenTheMountainOfKings.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_DESC")

			return true
		end
		)

	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[1] = {}
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[1].Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_OUTCOME_1"
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[1].Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_OUTCOME_RESULT_1"
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[1].Weight = 10
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[1].CanFunc = (
		function(pPlayer)	
			local iPlayer = pPlayer:GetID()
			
			local iNumGold			= JFD_GetEraAdjustedValue(iPlayer, 115)
			local iNumCulture		= JFD_GetEraAdjustedValue(iPlayer, 75)

			Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_OUTCOME_RESULT_1", iNumCulture, iNumGold)
			return true
		end
		)
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()
			local iNumGold			= JFD_GetEraAdjustedValue(iPlayer, 115)
			local iNumCulture		= JFD_GetEraAdjustedValue(iPlayer, 75)

			pPlayer:ChangeJONSCulture(iNumCulture)
			pPlayer:ChangeGold(-iNumGold)
						
			local sCivShort = pPlayer:GetCivilizationShortDescription()

			JFD_SendNotification(iPlayer, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS"))
			JFD_SendWorldEvent(iPlayer, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_1", sCivShort))

			save(pPlayer, "Event_EthiopiaAmbaGeshenTheMountainOfKings", true)
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[2] = {}
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[2].Name = "TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_OUTCOME_2"
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[2].Desc = "TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_OUTCOME_RESULT_2"
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[2].Weight = 5
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[2].CanFunc = (
		function(pPlayer)	
			local iPlayer = pPlayer:GetID()
			
			local iNumGold			= JFD_GetEraAdjustedValue(iPlayer, 150)
			local iNumCulture		= JFD_GetEraAdjustedValue(iPlayer, 25)
			local iTurnResistance	= JFD_GetRandom()

			Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_OUTCOME_RESULT_2", iNumGold, Event_EthiopiaAmbaGeshenTheMountainOfKings.Data2, iNumCulture)
			return true
		end
		)
	Event_EthiopiaAmbaGeshenTheMountainOfKings.Outcomes[2].DoFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()
			local iNumGold			= JFD_GetEraAdjustedValue(iPlayer, 150)
			local iNumCulture		= JFD_GetEraAdjustedValue(iPlayer, 25)

			pPlayer:ChangeJONSCulture(-iNumCulture)
			pPlayer:ChangeGold(iNumGold)
			
			local pCapital = pPlayer:GetCapitalCity()
			pCapital:ChangeResistanceTurns(Event_EthiopiaAmbaGeshenTheMountainOfKings.Data2)
						
			local sCivShort = pPlayer:GetCivilizationShortDescription()

			JFD_SendNotification(iPlayer, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS"))
			JFD_SendWorldEvent(iPlayer, Locale.ConvertTextKey("TXT_KEY_JFD_WORLD_EVENTS_DMS_ETHIOPIA_AMBA_GESHEN_THE_MOUNTAIN_OF_KINGS_2", sCivShort))

			save(pPlayer, "Event_EthiopiaAmbaGeshenTheMountainOfKings", true)
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_EthiopiaAmbaGeshenTheMountainOfKings.tValidCivs[sCiv] then
			tEvents.Event_EthiopiaAmbaGeshenTheMountainOfKings = Event_EthiopiaAmbaGeshenTheMountainOfKings
			break
		end
	end
end
--========================================================================================================================
--========================================================================================================================