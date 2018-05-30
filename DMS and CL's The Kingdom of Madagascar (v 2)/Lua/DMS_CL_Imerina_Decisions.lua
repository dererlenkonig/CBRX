-- DMS_CL_Imerina_Decisions
-- Author: DMS
--=======================================================================================================================--==========================================================================================================================
-- includes
--==========================================================================================================================
include("PlotIterators.lua")
--==========================================================================================================================
print("DMS and CL's The Kingdom of Imerina's Decisions: loaded")
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
local bPrintForDebug = DMS_GetUserSetting("DMS_IMERINA_DEBUGGING_ON") == 1

function DMS_Print(string)
	if (not bPrintForDebug) then
		return
	else
		return print(string)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
------------------------------------------------------------------------------------------------------------------------
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
------------------------------------------------------------------------------------------------------------------------
-- GetNearestCity (adapted from Sukritact's Sami civ)
------------------------------------------------------------------------------------------------------------------------
function GetNearestCity(pPlayer, plotX, plotY)
	local iDistance = nil
	local pTargetCity = nil
	for pCity in pPlayer:Cities() do
		if not(iDistance) or iDistance > Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY()) then
			pTargetCity = pCity
			iDistance = Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY())
		end
	end
	return(pTargetCity)
end
--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationImerinaID					= GameInfoTypes["CIVILIZATION_DMS_CL_IMERINA"]
local eraRenaissanceID						= GameInfoTypes["ERA_RENAISSANCE"]
local policyRovanIManjakamiadanaID			= GameInfoTypes["POLICY_DMS_CL_ROVAN_I_MANJAKAMIADANA"]
local buildingRovanIManjakamiadanaID		= GameInfoTypes["BUILDING_DMS_CL_ROVAN_I_MANJAKAMIADANA"]
local UnitGreatWriterFiboniaID				= GameInfoTypes["UNIT_DMS_CL_FIBONIA_WRITER"]
local unitWriterID							= GameInfoTypes["UNIT_WRITER"]
local slotGreatWritingID					= GameInfoTypes["GREAT_WORK_SLOT_LITERATURE"]
local improvementRovaID						= GameInfoTypes["IMPROVEMENT_DMS_CL_ROVA"]
-------------------------------------------------------------------------------------------------------------------------
-- Imerina: Compose the Fibonia
-------------------------------------------------------------------------------------------------------------------------
local Decisions_ComposeTheFibonia = {}
	Decisions_ComposeTheFibonia.Name = "TXT_KEY_DECISIONS_DMS_CL_COMPOSE_THE_IBONIA"
	Decisions_ComposeTheFibonia.Desc = "TXT_KEY_DECISIONS_DMS_CL_COMPOSE_THE_IBONIA_DESC"
	HookDecisionCivilizationIcon(Decisions_ComposeTheFibonia, "CIVILIZATION_DMS_CL_IMERINA")
	Decisions_ComposeTheFibonia.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationImerinaID) then return false, false end
		if load(pPlayer, "Decisions_ComposeTheFibonia") == true then
			Decisions_ComposeTheFibonia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CL_COMPOSE_THE_IBONIA_ENACTED_DESC")
			return false, false, true 
		end
			
		local iCultureCost = math.ceil(200 * iMod)
		Decisions_ComposeTheFibonia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CL_COMPOSE_THE_IBONIA_DESC", iCultureCost)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1)	then return true, false end
		if (pPlayer:GetJONSCulture() < iCultureCost)					then return true, false end
		if (not pPlayer:HasAvailableGreatWorkSlot(slotGreatWritingID))	then return true, false end


		return true, true
	end
	)
	
	Decisions_ComposeTheFibonia.DoFunc = (
	function(pPlayer)
		local iCultureCost = math.ceil(200 * iMod)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		pPlayer:InitUnit(UnitGreatWriterFiboniaID, pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY()):PushMission(GameInfoTypes["MISSION_CREATE_GREAT_WORK"])

		save(pPlayer, "Decisions_ComposeTheFibonia", true)
	end
	)

	Decisions_ComposeTheFibonia.Monitors = {}
	Decisions_ComposeTheFibonia.Monitors[GameEvents.GreatPersonExpended] =  (
	function(playerID, eGreatPersonType)
		print("Decisions_ComposeTheFibonia: Called (GreatPersonExpended)..")
		local pPlayer = Players[playerID]		
		if (pPlayer:GetCivilizationType() ~= civilisationImerinaID) then return end
		if load(pPlayer, "Decisions_ComposeTheFibonia") == true then
			if eGreatPersonType == unitWriterID or eGreatPersonType == UnitGreatWriterFiboniaID then
				local iNumRovas = 0
				for pCity in pPlayer:Cities() do
					for adjPlot in PlotAreaSweepIterator(pCity:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						if adjPlot and adjPlot:GetImprovementType() == improvementRovaID then
							iNumRovas = iNumRovas + 1
						end
					end
				end
				if iNumRovas > 0 then
					iBonusCulture = math.ceil(iNumRovas * 4.5)
					iBonusFaith = math.ceil(iNumRovas * 3.5)
					pPlayer:ChangeJONSCulture(iBonusCulture)
					pPlayer:ChangeFaith(iBonusFaith)
					
					Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]+" .. iBonusCulture .. "[ENDCOLOR] [ICON_CULTURE] Culture and [COLOR_POSITIVE_TEXT]+" .. iBonusFaith .. "[ENDCOLOR] [ICON_PEACE] Faith!")
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationImerinaID, "Decisions_ComposeTheFibonia", Decisions_ComposeTheFibonia)
-------------------------------------------------------------------------------------------------------------------------
-- Imerina: Construct the Rovan’i Manjakamiadana
-------------------------------------------------------------------------------------------------------------------------
local Decisions_ConstructTheRovaniManjakamiadana = {}
	Decisions_ConstructTheRovaniManjakamiadana.Name = "TXT_KEY_DECISIONS_DMS_CL_CONSTRUCT_THE_ROVAN_I_MANJAKAMIADANA"
	Decisions_ConstructTheRovaniManjakamiadana.Desc = "TXT_KEY_DECISIONS_DMS_CL_CONSTRUCT_THE_ROVAN_I_MANJAKAMIADANA_DESC"
	Decisions_ConstructTheRovaniManjakamiadana.Data1 = {}
	HookDecisionCivilizationIcon(Decisions_ConstructTheRovaniManjakamiadana, "CIVILIZATION_DMS_CL_IMERINA")
	Decisions_ConstructTheRovaniManjakamiadana.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationImerinaID) then return false, false end
		if load(pPlayer, "Decisions_ConstructTheRovaniManjakamiadana") == true then
			Decisions_ConstructTheRovaniManjakamiadana.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CL_CONSTRUCT_THE_ROVAN_I_MANJAKAMIADANA_ENACTED_DESC")
			return false, false, true 
		end
		
		local iGoldCost = math.ceil(350 * iMod)
		Decisions_ConstructTheRovaniManjakamiadana.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CL_CONSTRUCT_THE_ROVAN_I_MANJAKAMIADANA_DESC", iGoldCost)
		
		if (pPlayer:GetCurrentEra() < eraRenaissanceID)					then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2)	then return true, false end
		if (pPlayer:GetGold() < iGoldCost) 								then return true, false end
		local iNumRovas = 0
		for pCity in pPlayer:Cities() do
			local pPlot = pCity:Plot()
			for nearbyPlot in PlotAreaSweepIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if nearbyPlot then
					if nearbyPlot:GetImprovementType() == improvementRovaID then
						iNumRovas = iNumRovas + 1
					end
				end
			end
		end
		if (iNumRovas < 3) 												then return true, false end
		
		return true, true
	end
	)
	
	Decisions_ConstructTheRovaniManjakamiadana.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iGoldCost = math.ceil(350 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(policyRovanIManjakamiadanaID, true)
		local iNumRovas = 0
		for pCity in pPlayer:Cities() do
			for adjPlot in PlotAreaSweepIterator(pCity:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if adjPlot and adjPlot:GetImprovementType() == improvementRovaID then
					iNumRovas = iNumRovas + 1
				end
			end
		end
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			pCapital:SetNumRealBuilding(buildingRovanIManjakamiadanaID, iNumRovas)
		end

		save(pPlayer, "Decisions_ConstructTheRovaniManjakamiadana", true)
	end
	)

	Decisions_ConstructTheRovaniManjakamiadana.Monitors = {}
	Decisions_ConstructTheRovaniManjakamiadana.Monitors[GameEvents.PlayerDoTurn] =  (
	function(playerID)
		local pPlayer = Players[playerID]		
		if (pPlayer:GetCivilizationType() ~= civilisationImerinaID) then return end
		if load(pPlayer, "Decisions_ConstructTheRovaniManjakamiadana") == true then
			local iNumRovas = 0
			local pCapital = pPlayer:GetCapitalCity()
			for pCity in pPlayer:Cities() do
				for adjPlot in PlotAreaSweepIterator(pCity:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if adjPlot and adjPlot:GetImprovementType() == improvementRovaID then
						iNumRovas = iNumRovas + 1
					end
				end
			end
			if iNumRovas > 0 then
				--local iNumMilitaryProdBuildings = pCapital:GetNumRealBuilding(buildingRovanIManjakamiadanaID)
				pCapital:SetNumRealBuilding(buildingRovanIManjakamiadanaID, iNumRovas)
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationImerinaID, "Decisions_ConstructTheRovaniManjakamiadana", Decisions_ConstructTheRovaniManjakamiadana)
--=======================================================================================================================
--=======================================================================================================================