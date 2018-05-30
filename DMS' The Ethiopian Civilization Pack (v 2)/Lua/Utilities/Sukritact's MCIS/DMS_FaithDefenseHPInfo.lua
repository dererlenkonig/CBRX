-- DMS_FaithDefenseHPInfo.lua
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
local buildingDefenseFromFaithID			= GameInfoTypes["BUILDING_DMS_ZY_DEFENSE"]

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
	table.insert(tCityInfoAddins, {["Key"] = "DMS_FaithDefenseHPCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_FaithDefenseHPCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSFaithDefenseHP)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSFaithDefenseHP)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSFaithDefenseHP)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSFaithDefenseHPTipControls = {}
TTManager:GetTypeControlTable("DMSFaithDefenseHPTooltip", g_DMSFaithDefenseHPTipControls)
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

	instance.IconFrame:SetToolTipType("DMSFaithDefenseHPTooltip")
	IconHookup(2, 64, "DMS_ETHIOPIA_ATLAS", instance.IconImage)
	local iNumDefenseBuildings = pCity:GetNumRealBuilding(buildingDefenseFromFaithID)
	local iFaithFromTerrainAndImprovements = math.ceil(pCity:GetFaithPerTurn() - (pCity:GetFaithPerTurnFromBuildings() + pCity:GetFaithPerTurnFromPolicies() + pCity:GetFaithPerTurnFromReligion() + pCity:GetFaithPerTurnFromTraits()))
	local iNumDefense = iNumDefenseBuildings * 2
	local iNumHP = iNumDefenseBuildings * 10

	local titleText = "[COLOR_POSITIVE_TEXT]DEFENSE AND HITPOINTS[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_MCIS_DMS_FAITH_DEFENSE_HP_HELP", iFaithFromTerrainAndImprovements, iNumDefense, iNumHP)
	
	g_DMSFaithDefenseHPTipControls.Heading:SetText(titleText)
	g_DMSFaithDefenseHPTipControls.Body:SetText(helpText)
	g_DMSFaithDefenseHPTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSFaithDefenseHP()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSFaithDefenseHP)

function SerialEventCityDirty_DMSFaithDefenseHP()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSFaithDefenseHP)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSFaithDefenseHP)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSFaithDefenseHP()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSFaithDefenseHP)
--=======================================================================================================================
--=======================================================================================================================
