-- DMS_WCDelegatesInfo
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
local civilisationEthiopiaHaileSelassieID	= GameInfoTypes["CIVILIZATION_ETHIOPIA"]
local buildingDelegateIdeologicalTenetID	= GameInfoTypes["BUILDING_DMS_HS_DELEGATE_TENET"]

if not(JFD_IsCivilisationActive(civilisationEthiopiaHaileSelassieID)) then return end
--------------------------------------------------------------
-- DMS_IsEthiopiaHaileSelassie
--------------------------------------------------------------
function DMS_IsEthiopiaHaileSelassie(pCity)
	if Players[pCity:GetOwner()]:GetCivilizationType() ==  civilisationEthiopiaHaileSelassieID then
		return true
	end

	return false
end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_WCDelegatesCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_WCDelegatesCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSWCDelegates)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSWCDelegates)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSWCDelegates)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSWCDelegatesTipControls = {}
TTManager:GetTypeControlTable("DMSWCDelegatesTooltip", g_DMSWCDelegatesTipControls)
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
	-- Ensure City is Ethiopia
	local isEthiopiaHaileSelassie = DMS_IsEthiopiaHaileSelassie(pCity)
	if not (isEthiopiaHaileSelassie) then
		instance.IconFrame:SetHide(true)
		return
	end

	instance.IconFrame:SetToolTipType("DMSWCDelegatesTooltip")
	IconHookup(4, 64, "EXPANSION_CIV_COLOR_ATLAS", instance.IconImage)
	
	local iNumWCDelegates = pCity:GetNumRealBuilding(buildingDelegateIdeologicalTenetID)

	local titleText = "[COLOR_POSITIVE_TEXT]LION OF JUDAH[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_MCIS_DMS_WC_DELEGATE_HELP", iNumWCDelegates, iNumWCDelegates)
	
	g_DMSWCDelegatesTipControls.Heading:SetText(titleText)
	g_DMSWCDelegatesTipControls.Body:SetText(helpText)
	g_DMSWCDelegatesTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSWCDelegates()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSWCDelegates)

function SerialEventCityDirty_DMSWCDelegates()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSWCDelegates)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSWCDelegates)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSWCDelegates()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSWCDelegates)
--=======================================================================================================================
--=======================================================================================================================
