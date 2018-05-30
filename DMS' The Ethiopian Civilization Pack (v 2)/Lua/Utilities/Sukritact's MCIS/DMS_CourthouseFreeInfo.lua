-- DMS_CourthouseFreeInfo
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
local civilisationEthiopiaAmdaSeyonID		= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_SEYON_I"]
local buildingAmdaSeyonFreeCourthouseID		= GameInfoTypes["BUILDING_DMS_AS_FREE_COURTHOUSE"]

if not(JFD_IsCivilisationActive(civilisationEthiopiaAmdaSeyonID)) then return end
--------------------------------------------------------------
-- DMS_IsEthiopiaAmdaSeyon
--------------------------------------------------------------
function DMS_IsEthiopiaAmdaSeyon(pCity)
	if Players[pCity:GetOwner()]:GetCivilizationType() ==  civilisationEthiopiaAmdaSeyonID then
		return true
	end

	return false
end
--------------------------------------------------------------
-- DMS_HasFreeCourthouse
--------------------------------------------------------------
function DMS_HasFreeCourthouse(pCity)
	if pCity:IsHasBuilding(buildingAmdaSeyonFreeCourthouseID) then
		return true
	end

	return false
end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_CourthouseFreeCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_CourthouseFreeCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSCourthouseFree)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSCourthouseFree)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSCourthouseFree)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSCourthouseFreeTipControls = {}
TTManager:GetTypeControlTable("DMSCourthouseFreeTooltip", g_DMSCourthouseFreeTipControls)
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
	-- Ensure City is Ethiopian
	local isEthiopiaAmdaSeyon = DMS_IsEthiopiaAmdaSeyon(pCity)
	if not (isEthiopiaAmdaSeyon) then
		instance.IconFrame:SetHide(true)
		return
	end
	-- Ensure City has free Courthouse
	local hasFreeCourthouse = DMS_HasFreeCourthouse(pCity)
	if not (hasFreeCourthouse) then
		instance.IconFrame:SetHide(true)
		return
	end
	
	instance.IconFrame:SetToolTipType("DMSCourthouseFreeTooltip")
	IconHookup(63, 64, "BW_ATLAS_1", instance.IconImage)
	
	local titleText = "[COLOR_POSITIVE_TEXT]PILLAR OF ZION[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_MCIS_DMS_FREE_COURTHOUSE_HELP")
	
	g_DMSCourthouseFreeTipControls.Heading:SetText(titleText)
	g_DMSCourthouseFreeTipControls.Body:SetText(helpText)
	g_DMSCourthouseFreeTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSCourthouseFree()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSCourthouseFree)

function SerialEventCityDirty_DMSCourthouseFree()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSCourthouseFree)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSCourthouseFree)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSCourthouseFree()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSCourthouseFree)
--=======================================================================================================================
--=======================================================================================================================
