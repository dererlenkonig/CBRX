-- DMS_Venezuela_Decisions
-- Author: DMS
--==========================================================================================================================
print("DMS's Venezuela (Chavez) Decisions: loaded")
include("PlotIterators.lua")
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
local bPrintForDebug = DMS_GetUserSetting("DMS_VENEZUELA_DEBUGGING_ON") == 1

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
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetUserSetting
----------------------------------------------------------------------------------------------------------------------------
function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end

local bUserSettingInventors = JFD_GetUserSetting("SUK_DECISIONS_SD_TALENTS_RESOURCE_ADDITIONS_INVENTORS") == 1
--==========================================================================================================================
-- Civ Specific Decisions
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local civilisationVenezuelaID							= GameInfoTypes["CIVILIZATION_DMS_VENEZUELA"]
local traitBolivarianSocialismID						= GameInfoTypes["TRAIT_DMS_BOLIVARIAN_SOCIALISM"]
local buildingCommunalCouncilID							= GameInfoTypes["BUILDING_DMS_COMMUNAL_COUNCIL"]
local unitVeNilangalID									= GameInfoTypes["UNIT_DMS_VE_NILANGAL"]
local resourceOil										= GameInfoTypes["RESOURCE_OIL"]
local promotionALBAStrength								= GameInfoTypes["PROMOTION_DMS_ALBA_STRENGTH"]
local buildingBroadcastTower							= GameInfoTypes["BUILDING_BROADCAST_TOWER"]
local buildingAloPresidente								= GameInfoTypes["BUILDING_DMS_DECISIONS_ALO_PRESIDENTE"]

local iInventors
if bUserSettingClaims then
	iInventors											= GameInfoTypes["RESOURCE_JFD_INVENTOR"]
end
----------------------------------------------------------------------------------------------------------------------------
-- Venezuela (Chavez): Alo Presidente
----------------------------------------------------------------------------------------------------------------------------
local Decisions_AloPresidente = {}
	Decisions_AloPresidente.Name = "TXT_KEY_DECISIONS_DMS_ALO_PRESIDENTE"
	Decisions_AloPresidente.Desc = "TXT_KEY_DECISIONS_DMS_ALO_PRESIDENTE_DESC"
	HookDecisionCivilizationIcon(Decisions_AloPresidente, "CIVILIZATION_DMS_VENEZUELA")
	Decisions_AloPresidente.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilisationVenezuelaID then return false, false end
		if load(pPlayer, "Decisions_AloPresidente") == true then
			Decisions_AloPresidente.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_ALO_PRESIDENTE_ENACTED_DESC")
			return false, false, true
		end

		local iNumCulture = 300
		local sJFDLCDependedCost = "[NEWLINE][ICON_BULLET]1 [ICON_MAGISTRATE] Magistrate"
		if bUserSettingInventors then
			sJFDLCDependedCost = "[NEWLINE][ICON_BULLET]1 [ICON_JFD_INVENTORS] Inventor."
		end
		Decisions_AloPresidente.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_ALO_PRESIDENTE_DESC", sJFDLCDependedCost, iNumCulture)
		if (pPlayer:GetJONSCulture() < iNumCulture) 							then return true, false end
		if bUserSettingInventors then
			if (pPlayer:GetNumResourceAvailable(iInventors, false) < 1)			then return true, false end
		else
			if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1)		then return true, false end
		end

		if (pPlayer:GetLateGamePolicyTree() == -1) or 
		(pPlayer:GetLateGamePolicyTree() == nil) or 
		(pPlayer:GetLateGamePolicyTree() == 0)									then return true, false end

		return true, true
	end
	)
	
	Decisions_AloPresidente.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iNumCulture = 300
		if bUserSettingInventors then
			pPlayer:ChangeNumResourceTotal(iInventors, -1)
		else
			pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		end
		pPlayer:ChangeJONSCulture(-iNumCulture)

		for pCity in pPlayer:Cities() do
			if (not pCity:IsHasBuilding(buildingBroadcastTower)) then
				pCity:SetNumRealBuilding(buildingBroadcastTower, 1)
			end
		end		

		pPlayer:GetCapitalCity():SetNumRealBuilding(buildingAloPresidente, 1)

		JFD_SendWorldEvent(pPlayer:GetID(), Locale.ConvertTextKey("TXT_KEY_DMS_WORLD_EVENTS_ALO_PRESIDENTE"))
		save(pPlayer, "Decisions_AloPresidente", true)
	end
	)
		
Decisions_AddCivilisationSpecific(civilisationVenezuelaID, "Decisions_AloPresidente", Decisions_AloPresidente)
----------------------------------------------------------------------------------------------------------------------------
-- Venezuela (Chavez): Establish ALBA
----------------------------------------------------------------------------------------------------------------------------
local Decisions_EstablishALBA = {}
	Decisions_EstablishALBA.Name = "TXT_KEY_DECISIONS_DMS_ESTABLISH_ALBA"
	Decisions_EstablishALBA.Desc = "TXT_KEY_DECISIONS_DMS_ESTABLISH_ALBA_DESC"
	HookDecisionCivilizationIcon(Decisions_EstablishALBA, "CIVILIZATION_DMS_VENEZUELA")
	Decisions_EstablishALBA.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilisationVenezuelaID then return false, false end
		if load(pPlayer, "Decisions_EstablishALBA") == true then
			Decisions_EstablishALBA.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_ESTABLISH_ALBA_ENACTED_DESC")
			return false, false, true
		end

		local iGold = math.ceil(125 * iMod)
		local iCulture = math.ceil(50 * iMod)
		Decisions_EstablishALBA.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_ESTABLISH_ALBA_DESC")
		
		if (pPlayer:GetNumResourceAvailable(resourceOil) < 1)				then return true, false end

		local iNumDoF = 0
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i and i ~= iPlayer then
				local pOtherPlayer = Players[i]
				if pOtherPlayer:IsDoF(iPlayer) then
					iNumDoF = iNumDoF + 1
				end
			end
		end

		if (not pCapital)													then return true, false end
		if (iNumDoF < 1)													then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1)		then return true, false end
				
		return true, true
	end
	)
	
	Decisions_EstablishALBA.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:ChangeNumResourceTotal(resourceOil, -1)
		DMS_Print("Decisions_EstablishALBA.DoFunc: enacted, iterate units..")
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				DMS_Print("Decisions_EstablishALBA.DoFunc: combat unit..")
				local pPlot = pUnit:GetPlot()
				if pPlot then
					local iOwner = pPlot:GetOwner()
					if iOwner then
						DMS_Print("Decisions_EstablishALBA.DoFunc: on owned plot..")
						local pOwner = Players[iOwner]
						if pOwner and pOwner:IsMinorCiv() then
							DMS_Print("Decisions_EstablishALBA.DoFunc: owned by city-state..")
							if pOwner:GetMinorCivFriendshipLevelWithMajor(pPlayer) >= 30 then
								DMS_Print("Decisions_EstablishALBA.DoFunc: is friendly/allied..")
								if (not pUnit:IsHasPromotion(promotionALBAStrength)) then
									pUnit:SetHasPromotion(promotionALBAStrength, true)
									DMS_Print("Decisions_EstablishALBA.DoFunc: granted promotion..")
								end
							else
								if pUnit:IsHasPromotion(promotionALBAStrength) then
									pUnit:SetHasPromotion(promotionALBAStrength, false)
									DMS_Print("Decisions_EstablishALBA.DoFunc: removed promotion..")
								end
							end
						else
							if pUnit:IsHasPromotion(promotionALBAStrength) then
								pUnit:SetHasPromotion(promotionALBAStrength, false)
								DMS_Print("Decisions_EstablishALBA.DoFunc: removed promotion..")
							end
						end
					else
						if pUnit:IsHasPromotion(promotionALBAStrength) then
							pUnit:SetHasPromotion(promotionALBAStrength, false)
							DMS_Print("Decisions_EstablishALBA.DoFunc: removed promotion..")
						end
					end
				end
			end
		end

		save(pPlayer, "Decisions_EstablishALBA", true)
	end
	)

	Decisions_EstablishALBA.Monitors = {}
	Decisions_EstablishALBA.Monitors[GameEvents.PlayerDoTurn] = (
	function(playerID)
		if load(pPlayer, "Decisions_EstablishALBA") == true then
			for pUnit in pPlayer:Units() do
				if pUnit:IsCombatUnit() then
					DMS_Print("Decisions_EstablishALBA.Monitors: combat unit..")
					local pPlot = pUnit:GetPlot()
					if pPlot then
						local iOwner = pPlot:GetOwner()
						if iOwner then
							DMS_Print("Decisions_EstablishALBA.Monitors: on owned plot..")
							local pOwner = Players[iOwner]
							if pOwner and pOwner:IsMinorCiv() then
								DMS_Print("Decisions_EstablishALBA.Monitors: owned by city-state..")
								if pOwner:GetMinorCivFriendshipLevelWithMajor(pPlayer) >= 30 then
									DMS_Print("Decisions_EstablishALBA.Monitors: is friendly/allied..")
									if (not pUnit:IsHasPromotion(promotionALBAStrength)) then
										pUnit:SetHasPromotion(promotionALBAStrength, true)
										DMS_Print("Decisions_EstablishALBA.Monitors: granted promotion..")
									end
								else
									if pUnit:IsHasPromotion(promotionALBAStrength) then
										pUnit:SetHasPromotion(promotionALBAStrength, false)
										DMS_Print("Decisions_EstablishALBA.Monitors: removed promotion..")
									end
								end
							else
								if pUnit:IsHasPromotion(promotionALBAStrength) then
									pUnit:SetHasPromotion(promotionALBAStrength, false)
									DMS_Print("Decisions_EstablishALBA.Monitors: removed promotion..")
								end
							end
						else
							if pUnit:IsHasPromotion(promotionALBAStrength) then
								pUnit:SetHasPromotion(promotionALBAStrength, false)
								DMS_Print("Decisions_EstablishALBA.Monitors: removed promotion..")
							end
						end
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationVenezuelaID, "Decisions_EstablishALBA", Decisions_EstablishALBA)
--==========================================================================================================================
--==========================================================================================================================
