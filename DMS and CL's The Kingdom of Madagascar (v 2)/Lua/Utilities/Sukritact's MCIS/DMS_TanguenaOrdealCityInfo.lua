-- DMS_TanguenaOrdealInfo
-- Author: DMS
--=======================================================================================================================
-- UTILITY FUNCTIONS	
--=======================================================================================================================
include("IconSupport")
--include("Sukritact_SaveUtils.lua")
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
--------------------------------------------------------------
-- JFD_GetUserSetting
--------------------------------------------------------------
function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
--------------------------------------------------------------
--IsCPDLL
--------------------------------------------------------------
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()
--------------------------------------------------------------------------------------------------------------------------
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilisationImerinaID					= GameInfoTypes["CIVILIZATION_DMS_CL_IMERINA"]
local traitTanguenaOrdealID					= GameInfoTypes["TRAIT_DMS_CL_TANGUENA_ORDEAL"]

local bUserSettingPiety = JFD_GetUserSetting("JFD_RTP_PIETY_CORE") == 1

if not(JFD_IsCivilisationActive(civilisationImerinaID)) then return end
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
	table.insert(tCityInfoAddins, {["Key"] = "DMS_TanguenaOrdealCityInfo", ["SortOrder"] = 1})

	table.insert(tEventsToHook, Events.SerialEventCityHexHighlightDirty)
	table.insert(tEventsToHook, Events.SpecificCityInfoDirty)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function CityInfoStackDirty(key, instance)
	if key ~= "DMS_TanguenaOrdealCityInfo" then return end
	
	Events.SerialEventEnterCityScreen.Remove(EventEnterCityScreen_DMSTanguenaOrdeal)
	Events.SerialEventCityHexHighlightDirty.Remove(SerialEventCityDirty_DMSTanguenaOrdeal)
	Events.SpecificCityInfoDirty.Remove(SerialEventCityDirty_DMSTanguenaOrdeal)
	
	Controls.IconFrame:SetHide(true)
	ProcessCityScreen(instance)
end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)

if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
isCityScreenOpen = false
g_DMSTanguenaOrdealTipControls = {}
TTManager:GetTypeControlTable("DMSTanguenaOrdealTooltip", g_DMSTanguenaOrdealTipControls)
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
	instance.IconFrame:SetToolTipType("DMSTanguenaOrdealTooltip")
	IconHookup(0, 64, "DMS_CL_IMERINA_ATLAS", instance.IconImage)
	
	local iNumPressureTotal = 0
	local iNumFollowersTotal = 0
	local iNumPop = pCity:GetPopulation()
	
	local iOwnReligion = nil
	if IsCPDLL and (not bUserSettingPiety) then
		--iOwnReligion = load(pPlayer, "DMS_Imerina_ReligionFounder") -- not used anymore since G added GetOriginalReligionCreatedByPlayer
		if Player.GetOriginalReligionCreatedByPlayer then
			iOwnReligion = pPlayer:GetOriginalReligionCreatedByPlayer()
		else
			iOwnReligion = pPlayer:GetReligionCreatedByPlayer()
		end
	elseif IsCPDLL and bUserSettingPiety then 
		if activePlayer:HasStateReligion() then
			iOwnReligion = activePlayer:GetStateReligion()
		end
	elseif (not IsCPDLL) then
		if activePlayer:HasCreatedReligion() then
			iOwnReligion = activePlayer:GetReligionCreatedByPlayer()
		elseif activePlayer:GetCapitalCity():GetReligiousMajority() ~= -1 then
			iOwnReligion = activePlayer:GetCapitalCity():GetReligiousMajority()
		else
			iOwnReligion = nil
		end
	end
	for row in GameInfo.Religions() do
		local iReligion = row.ID
		if (iReligion ~= nil) and iReligion ~= iOwnReligion then
			local iNumFollowers	= pCity:GetNumFollowers(iReligion) 
			iNumFollowersTotal = iNumFollowersTotal + iNumFollowers -- followers of foreign religion
			local iNumPressure = pCity:GetPressurePerTurn(iReligion)
			iNumPressureTotal = iNumPressureTotal + iNumPressure -- pressure of foreign religion
		end
	end
	local iNumPressureShown = math.ceil(iNumPressureTotal / 10)
	--local iXP = math.ceil((iNumPop - iNumFollowersTotal) / iNumPop * 0.3 * iNumPressureTotal)
	local iXP = math.ceil((iNumPop - iNumFollowersTotal) / iNumPop * (iNumPressureTotal / 10))
			
	local titleText = Locale.ConvertTextKey("TXT_KEY_DMS_CL_TANGUENA_ORDEAL_CITY_VIEW")
	local helpText = Locale.ConvertTextKey("TXT_KEY_DMS_CL_TANGUENA_ORDEAL_CITY_VIEW_HELP", iNumPressureShown, iNumFollowersTotal, iNumPop, iXP)
	
	g_DMSTanguenaOrdealTipControls.Heading:SetText(titleText)
	g_DMSTanguenaOrdealTipControls.Body:SetText(helpText)
	g_DMSTanguenaOrdealTipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end

function EventEnterCityScreen_DMSTanguenaOrdeal()
	isCityScreenOpen = true
	ProcessCityScreen()
end
Events.SerialEventEnterCityScreen.Add(EventEnterCityScreen_DMSTanguenaOrdeal)

function SerialEventCityDirty_DMSTanguenaOrdeal()
	if isCityScreenOpen then
		ProcessCityScreen()
	end
end
Events.SerialEventCityHexHighlightDirty.Add(SerialEventCityDirty_DMSTanguenaOrdeal)
Events.SpecificCityInfoDirty.Add(SerialEventCityDirty_DMSTanguenaOrdeal)
-------------------------------------------------------------------------------------------------------------------------
-- EventExitCityScreen
-------------------------------------------------------------------------------------------------------------------------
function EventExitCityScreen_DMSTanguenaOrdeal()
	isCityScreenOpen = false
	Controls.IconFrame:SetHide(true)
end
Events.SerialEventExitCityScreen.Add(EventExitCityScreen_DMSTanguenaOrdeal)
--=======================================================================================================================
--=======================================================================================================================
