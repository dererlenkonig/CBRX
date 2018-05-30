-- DMS_MasgidProductionInfo
-- Author: DMS
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
include("IconSupport")
--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end
--------------------------------------------------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationSemienGuditID				= GameInfoTypes["CIVILIZATION_DMS_SEMIEN_GUDIT"]
local buildingMasgidProductionID			= GameInfoTypes["BUILDING_DMS_MASGID_PRODUCTION_DUMMY"]
local buildingMasgidID						= GameInfoTypes["BUILDING_DMS_MASGID"]

if not(JFD_IsCivilisationActive(civilisationSemienGuditID)) then return end
--------------------------------------------------------------
-- DMS_IsSemien
--------------------------------------------------------------
function DMS_IsSemien(pCity)
	if Players[pCity:GetOwner()]:GetCivilizationType() ==  civilisationSemienGuditID then
		return true
	end

	return false
end
--------------------------------------------------------------
-- DMS_HasMasgid
--------------------------------------------------------------
function DMS_HasMasgid(pCity)
	if pCity:IsHasBuilding(buildingMasgidID) then
		return true
	end

	return false
end
--------------------------------------------------------------
-- DMS_IsNotCapital
--------------------------------------------------------------
function DMS_IsNotCapital(pCity)
	if (not pCity:IsCapital()) then
		return true
	end

	return false
end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_MasgidProductionCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_MasgidProductionCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSMasgidProduction)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSMasgidProduction)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSMasgidProduction)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSMasgidProductionTipControls = {}
TTManager:GetTypeControlTable("DMSMasgidProductionTooltip", g_DMSMasgidProductionTipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
function ProcessCityScreen(instance)

	if not(instance) then
		instance = Controls
	end

	-- Ensure City Selected
	local activePlayer = Players[Game.GetActivePlayer()]
	local pCity = UI.GetHeadSelectedCity()
	if not(pCity) then
		instance.IconFrame:SetHide(true)
		return
	end
	-- Ensure City is Semien
	local isSemien = DMS_IsSemien(pCity)
	if not (isSemien) then
		instance.IconFrame:SetHide(true)
		return
	end
	local hasMasgid = DMS_HasMasgid(pCity)
	if not (hasMasgid) then
		instance.IconFrame:SetHide(true)
		return
	end
	local isNotCapital = DMS_IsNotCapital(pCity)
	if not (isNotCapital) then
		instance.IconFrame:SetHide(true)
		return
	end
		
	instance.IconFrame:SetToolTipType("DMSMasgidProductionTooltip")
	IconHookup(3, 64, "DMS_SEMIEN_ATLAS", instance.IconImage)

	local iProduction = pCity:GetNumRealBuilding(buildingMasgidProductionID)
	local pCapital = activePlayer:GetCapitalCity()
	local iCapitalFaith = pCapital:GetFaithPerTurn()

	local titleText = "[COLOR_POSITIVE_TEXT]MASGID[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_MCIS_DMS_MASGID_PRODUCTION_HELP", iProduction, iCapitalFaith)
	
	g_DMSMasgidProductionTipControls.Heading:SetText(titleText)
	g_DMSMasgidProductionTipControls.Body:SetText(helpText)
	g_DMSMasgidProductionTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSMasgidProduction()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSMasgidProduction)

function SerialEventCityDirty_DMSMasgidProduction()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSMasgidProduction)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSMasgidProduction)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSMasgidProduction()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSMasgidProduction)
--=======================================================================================================================
--=======================================================================================================================
