-- DMS_RovaPolicyInfo
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
local civilisationImerinaID					= GameInfoTypes["CIVILIZATION_DMS_CL_IMERINA"]
local buildingRovaExpendCounterID			= GameInfoTypes["BUILDING_DMS_ROVA_EXPEND_COUNTER"]

if not(JFD_IsCivilisationActive(civilisationImerinaID)) then return end
-------------------------------------------------------------------------------------------------------------------------
-- DMS_bIsCapital
-------------------------------------------------------------------------------------------------------------------------
function DMS_bIsCapital(pCity)
	if pCity and pCity == Players[pCity:GetOwner()]:GetCapitalCity() then

	return true
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- DMS_bIsImerina
-------------------------------------------------------------------------------------------------------------------------
function DMS_bIsImerina(pCity)
	local pPlayer = Players[pCity:GetOwner()]
	if pPlayer and pPlayer:GetCivilizationType() == civilisationImerinaID then

		return true
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_RovaPolicyCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_RovaPolicyCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSRovaPolicy)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSRovaPolicy)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSRovaPolicy)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSRovaPolicyTipControls = {}
TTManager:GetTypeControlTable("DMSRovaPolicyTooltip", g_DMSRovaPolicyTipControls)
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
	-- Ensure Civ is Imerina
	local bIsImerina = DMS_bIsImerina(pCity)
	if not (bIsImerina) then
		instance.IconFrame:SetHide(true)
		return
	end
	-- Ensure City is Capital
	local bIsCapital = DMS_bIsCapital(pCity)
	if not (bIsCapital) then
		instance.IconFrame:SetHide(true)
		return
	end
	
	instance.IconFrame:SetToolTipType("DMSRovaPolicyTooltip")
	IconHookup(0, 64, "DMS_CL_IMERINA_ATLAS", instance.IconImage)
	
	local pCapital = Players[pCity:GetOwner()]:GetCapitalCity()
	local iNumRovaExpend = pCapital:GetNumRealBuilding(buildingRovaExpendCounterID)
			
	local titleText = Locale.ConvertTextKey("TXT_KEY_DMS_CL_ROVA_POLICY_CITY_VIEW")
	local helpText = Locale.ConvertTextKey("TXT_KEY_DMS_CL_ROVA_POLICY_CITY_VIEW_HELP", iNumRovaExpend, 12 - iNumRovaExpend)
	
	g_DMSRovaPolicyTipControls.Heading:SetText(titleText)
	g_DMSRovaPolicyTipControls.Body:SetText(helpText)
	g_DMSRovaPolicyTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSRovaPolicy()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSRovaPolicy)

function SerialEventCityDirty_DMSRovaPolicy()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSRovaPolicy)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSRovaPolicy)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSRovaPolicy()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSRovaPolicy)
--=======================================================================================================================
--=======================================================================================================================
