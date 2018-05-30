-- C15_Iroquois_NationMCIS
-- Author: Chrisy15
-- DateCreated: 12/4/2017 12:52:51 AM
--------------------------------------------------------------
include("IconSupport")
include("C15_Iroquois_Utils.lua")

function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end

local activePlayerID		= Game.GetActivePlayer()
local activePlayer			= Players[activePlayerID]
local pCivilization = GameInfo.Civilizations["CIVILIZATION_IROQUOIS"]
local civilizationID 		= pCivilization.ID
local isIroquoisCivActive	 = JFD_IsCivilisationActive(civilizationID)
local isIroquoisActivePlayer = activePlayer:GetCivilizationType() == civilizationID
if isIroquoisCivActive then
	print("Iroquois MCIS is loaded!")
end

function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "C15_Iroquois_Nation_MCIS", ["SortOrder"] = 1})
   table.insert(tEventsToHook, LuaEvents.C15_Iroquois_NationSet)
   table.insert(tEventsToHook, Events.SerialEventCityScreenDirty)
end
if isIroquoisActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
end
 
function CityInfoStackDirty(key, instance)
	if key ~= "C15_Iroquois_Nation_MCIS" then return end
	ProcessCityScreen(instance)
end
if isIroquoisActivePlayer then
	LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
end
if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
g_C15_Iroquois_Nation_MCIS_TipControls = {}
TTManager:GetTypeControlTable("C15_Iroquois_Nation_MCIS_Tooltip", g_C15_Iroquois_Nation_MCIS_TipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------

function ProcessCityScreen(instance)
	-- Ensure City Selected
	local pCity = UI.GetHeadSelectedCity()
	if (not pCity) then
		instance.IconFrame:SetHide(true)
		return
	end
	instance.IconFrame:SetToolTipType("C15_Iroquois_Nation_MCIS_Tooltip")
	IconHookup(pCivilization.PortraitIndex, 64, pCivilization.IconAtlas, instance.IconImage)
	local sNation = C15_GetCityNation(pCity)
	if not sNation then
		instance.IconFrame:SetHide(true)
		return
	end
	local tNation = C15_GetNationTable(sNation)
	local textDescription = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey(tNation.Description)) .. "[ENDCOLOR]"
	local textHelp = Locale.ConvertTextKey(tNation.Help)
	g_C15_Iroquois_Nation_MCIS_TipControls.Heading:SetText(textDescription)
	g_C15_Iroquois_Nation_MCIS_TipControls.Body:SetText(textHelp)
	g_C15_Iroquois_Nation_MCIS_TipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end