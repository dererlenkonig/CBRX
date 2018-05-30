-- DMS_GrowthFromTRsInfo
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
local civilisationAksumKalebID				= GameInfoTypes["CIVILIZATION_DMS_AKSUM_KALEB"]
local buildingTradeRouteGrowthDummyID		= GameInfoTypes["BUILDING_DMS_TRADE_ROUTE_GROWTH_DUMMY"]

if not(JFD_IsCivilisationActive(civilisationAksumKalebID)) then return end
--------------------------------------------------------------
-- DMS_IsAksum
--------------------------------------------------------------
function DMS_IsAksum(pCity)
	if Players[pCity:GetOwner()]:GetCivilizationType() ==  civilisationAksumKalebID then
		return true
	end

	return false
end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_GrowthFromTRsCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_GrowthFromTRsCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSGrowthFromTRs)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSGrowthFromTRs)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSGrowthFromTRs)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSGrowthFromTRsTipControls = {}
TTManager:GetTypeControlTable("DMSGrowthFromTRsTooltip", g_DMSGrowthFromTRsTipControls)
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
	-- Ensure City is Aksum
	local isAksum = DMS_IsAksum(pCity)
	if not (isAksum) then
		instance.IconFrame:SetHide(true)
		return
	end
	--local buildingGrowthFromTRs = GameInfo.Buildings[buildingGrowthFromTRsID]
	instance.IconFrame:SetToolTipType("DMSGrowthFromTRsTooltip")
	IconHookup(0, 64, "DMS_ETHIOPIA_ATLAS", instance.IconImage)
	
	local iNumTR = pCity:GetNumRealBuilding(buildingTradeRouteGrowthDummyID)
	local iNumGrowthFromTR = iNumTR * 5

	local titleText = "[COLOR_POSITIVE_TEXT]SAINT ELESBAAN[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_MCIS_DMS_SAINT_ELESBAAN_HELP", iNumGrowthFromTR, iNumTR)
	
	g_DMSGrowthFromTRsTipControls.Heading:SetText(titleText)
	g_DMSGrowthFromTRsTipControls.Body:SetText(helpText)
	g_DMSGrowthFromTRsTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSGrowthFromTRs()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSGrowthFromTRs)

function SerialEventCityDirty_DMSGrowthFromTRs()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSGrowthFromTRs)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSGrowthFromTRs)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSGrowthFromTRs()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSGrowthFromTRs)
--=======================================================================================================================
--=======================================================================================================================
