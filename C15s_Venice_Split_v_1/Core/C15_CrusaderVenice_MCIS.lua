-- C15_Venice_Food_MCIS
-- Author: Chrisy15
-- DateCreated: 4/17/2016 7:58:27 AM
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("IconSupport")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILS
-------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
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

-------------------------------------------------------------------------------------------------------------------------
-- GLOBALS
-------------------------------------------------------------------------------------------------------------------------
local activePlayerID		= Game.GetActivePlayer()
local activePlayer			= Players[activePlayerID]
local civilizationID 		= GameInfoTypes["CIVILIZATION_VENICE"]
local isVeniceCivActive	 = JFD_IsCivilisationActive(civilizationID)
local isVeniceActivePlayer = activePlayer:GetCivilizationType() == civilizationID
if isVeniceCivActive then
	print("Venice MCIS is loaded!")
end

function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
   table.insert(tCityInfoAddins, {["Key"] = "C15_Venice_Food_MCIS", ["SortOrder"] = 1})
end
if isVeniceActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
end
 
function CityInfoStackDirty(key, instance)
	if key ~= "C15_Venice_Food_MCIS" then return end
	ProcessCityScreen(instance)
end
if isVeniceActivePlayer then
	LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
end
if not(OptionsManager.GetSmallUIAssets()) then Controls.IconFrame:SetOffsetX(294) end
--=======================================================================================================================
-- CORE FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
g_C15_Venice_Food_MCIS_TipControls = {}
TTManager:GetTypeControlTable("C15_Venice_Food_MCIS_Tooltip", g_C15_Venice_Food_MCIS_TipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
local malaysiaMCISDummy = GameInfoTypes["BUILDING_C15_VENICE_NAVAL_PROD"]
function ProcessCityScreen(instance)
	-- Ensure City Selected
	local city = UI.GetHeadSelectedCity()
	if (not city) then
		instance.IconFrame:SetHide(true)
		return
	end
	instance.IconFrame:SetToolTipType("C15_Venice_Food_MCIS_Tooltip")
	IconHookup(7, 64, "EXPANSION2_CIV_COLOR_ATLAS", instance.IconImage)
	local bonus = city:GetNumRealBuilding(malaysiaMCISDummy) * 3
	if bonus <= 0 then
		instance.IconFrame:SetHide(true)
		return
	end
	local textDescription = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey("TXT_KEY_C15_VENICE_MCIS_DESC")) .. "[ENDCOLOR]"
	local textHelp = Locale.ConvertTextKey("TXT_KEY_C15_VENICE_MCIS_HELP", bonus)
	g_C15_Venice_Food_MCIS_TipControls.Heading:SetText(textDescription)
	g_C15_Venice_Food_MCIS_TipControls.Body:SetText(textHelp)
	g_C15_Venice_Food_MCIS_TipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end
--=======================================================================================================================
--=======================================================================================================================
