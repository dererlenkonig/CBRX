-- DMS_SarawitDiscountInfo
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
local techCivilServiceID					= GameInfoTypes["TECH_CIVIL_SERVICE"]
local unitSarawitID							= GameInfoTypes["UNIT_DMS_SARAWIT"]

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
--------------------------------------------------------------
-- DMS_SarawitNotObsolete
--------------------------------------------------------------
function DMS_SarawitNotObsolete(pCity)
	if (not Teams[Players[pCity:GetOwner()]:GetTeam()]:IsHasTech(techCivilServiceID)) then
		return true
	end

	return false
end
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "DMS_SarawitDiscountCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_SarawitDiscountCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSSarawitDiscount)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSSarawitDiscount)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSSarawitDiscount)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSSarawitDiscountTipControls = {}
TTManager:GetTypeControlTable("DMSSarawitDiscountTooltip", g_DMSSarawitDiscountTipControls)
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
	-- Ensure sarawit is not obsolete
	local sarawitNotObsolete = DMS_SarawitNotObsolete(pCity)
	if not (sarawitNotObsolete) then
		instance.IconFrame:SetHide(true)
		return
	end


	instance.IconFrame:SetToolTipType("DMSSarawitDiscountTooltip")
	IconHookup(10, 64, "DMS_ETHIOPIA_ATLAS", instance.IconImage)
	
	local iNumSarawit = 0
	for pUnit in activePlayer:Units() do
		if pUnit:GetUnitType() == unitSarawitID or pUnit:GetUnitType() == unitSarawitCheap1ID or pUnit:GetUnitType() == unitSarawitCheap2ID or pUnit:GetUnitType() == unitSarawitCheap3ID or pUnit:GetUnitType() == unitSarawitCheap4ID or pUnit:GetUnitType() == unitSarawitCheap5ID or pUnit:GetUnitType() == unitSarawitCheap6ID or pUnit:GetUnitType() == unitSarawitCheap7ID or pUnit:GetUnitType() == unitSarawitCheap8ID then
			iNumSarawit = iNumSarawit + 1
		end
	end
	local iNumDiscount = iNumSarawit * 8

	local titleText = "[COLOR_POSITIVE_TEXT]SARAWIT[ENDCOLOR]"
	local helpText = Locale.ConvertTextKey("TXT_KEY_MCIS_DMS_SARAWIT_HELP", iNumDiscount, iNumSarawit)
	
	g_DMSSarawitDiscountTipControls.Heading:SetText(titleText)
	g_DMSSarawitDiscountTipControls.Body:SetText(helpText)
	g_DMSSarawitDiscountTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSSarawitDiscount()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSSarawitDiscount)

function SerialEventCityDirty_DMSSarawitDiscount()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSSarawitDiscount)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSSarawitDiscount)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSSarawitDiscount()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSSarawitDiscount)
--=======================================================================================================================
--=======================================================================================================================
