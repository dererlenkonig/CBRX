-- DMS_FaithFromPillageTilesInfo
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
local buildingPillageImprovementFaithID		= GameInfoTypes["BUILDING_DMS_PILLAGE_IMPROVEMENT_FAITH"]

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
-- DMS_IsCapital
--------------------------------------------------------------
function DMS_IsCapital(pCity)
	if Players[pCity:GetOwner()]:GetCapitalCity() ==  pCity then
		return true
	end

	return false
end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_FaithFromPillageTilesCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_FaithFromPillageTilesCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSFaithFromPillageTiles)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSFaithFromPillageTiles)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSFaithFromPillageTiles)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSFaithFromPillageTilesTipControls = {}
TTManager:GetTypeControlTable("DMSFaithFromPillageTilesTooltip", g_DMSFaithFromPillageTilesTipControls)
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
	-- Ensure City is Capital
	local isCapital = DMS_IsCapital(pCity)
	if not (isCapital) then
		instance.IconFrame:SetHide(true)
		return
	end

	instance.IconFrame:SetToolTipType("DMSFaithFromPillageTilesTooltip")
	IconHookup(0, 64, "DMS_SEMIEN_ATLAS", instance.IconImage)
	
	local iFaith = pCity:GetNumRealBuilding(buildingPillageImprovementFaithID)

	local titleText = "[COLOR_POSITIVE_TEXT]FIELDS OF JUDITH[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_MCIS_DMS_FIELD_OF_JUDITH_HELP", iFaith)
	
	g_DMSFaithFromPillageTilesTipControls.Heading:SetText(titleText)
	g_DMSFaithFromPillageTilesTipControls.Body:SetText(helpText)
	g_DMSFaithFromPillageTilesTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSFaithFromPillageTiles()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSFaithFromPillageTiles)

function SerialEventCityDirty_DMSFaithFromPillageTiles()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSFaithFromPillageTiles)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSFaithFromPillageTiles)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSFaithFromPillageTiles()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSFaithFromPillageTiles)
--=======================================================================================================================
--=======================================================================================================================
