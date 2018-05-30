-- DMS_ReligiousPressureInfo
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
local civilisationEthiopiaZaraYaqobID		= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_YAQOB"]
local buildingReligiousPressureWriterID		= GameInfoTypes["BUILDING_DMS_ZY_RELIGIOUS_PRESSURE"]

if not(JFD_IsCivilisationActive(civilisationEthiopiaZaraYaqobID)) then return end
--------------------------------------------------------------
-- DMS_IsEthiopiaZaraYaqob
--------------------------------------------------------------
function DMS_IsEthiopiaZaraYaqob(pCity)
	if Players[pCity:GetOwner()]:GetCivilizationType() ==  civilisationEthiopiaZaraYaqobID then
		return true
	end

	return false
end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_ReligiousPressureCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_ReligiousPressureCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSReligiousPressure)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSReligiousPressure)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSReligiousPressure)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSReligiousPressureTipControls = {}
TTManager:GetTypeControlTable("DMSReligiousPressureTooltip", g_DMSReligiousPressureTipControls)
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
	local isEthiopiaZaraYaqob = DMS_IsEthiopiaZaraYaqob(pCity)
	if not (isEthiopiaZaraYaqob) then
		instance.IconFrame:SetHide(true)
		return
	end

	instance.IconFrame:SetToolTipType("DMSReligiousPressureTooltip")
	IconHookup(2, 64, "DMS_ETHIOPIA_ATLAS", instance.IconImage)

	local iNumGW = pCity:GetNumRealBuilding(buildingReligiousPressureWriterID)
	local iNumReligiousPressure = (5 * iNumGW)
	
	local titleText = "[COLOR_POSITIVE_TEXT]RELIGIOUS PRESSURE[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_MCIS_DMS_RELIGIOUS_PRESSURE_HELP", iNumReligiousPressure, iNumGW)
	
	g_DMSReligiousPressureTipControls.Heading:SetText(titleText)
	g_DMSReligiousPressureTipControls.Body:SetText(helpText)
	g_DMSReligiousPressureTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSReligiousPressure()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSReligiousPressure)

function SerialEventCityDirty_DMSReligiousPressure()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSReligiousPressure)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSReligiousPressure)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSReligiousPressure()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSReligiousPressure)
--=======================================================================================================================
--=======================================================================================================================
