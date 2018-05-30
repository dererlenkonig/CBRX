-- C15_Iroquois_TradeDefenceMCIS
-- Author: Chrisy15
-- DateCreated: 12/4/2017 12:30:31 AM
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
   table.insert(tCityInfoAddins, {["Key"] = "C15_Iroquois_TradeDefence_MCIS", ["SortOrder"] = 1})
   table.insert(tEventsToHook, LuaEvents.C15_SKorea_ChaebolMCISUpdate)
end
if isIroquoisActivePlayer then
	LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
	LuaEvents.RequestCityInfoStackDataRefresh()
end
 
function CityInfoStackDirty(key, instance)
	if key ~= "C15_Iroquois_TradeDefence_MCIS" then return end
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
g_C15_Iroquois_TradeDefence_MCIS_TipControls = {}
TTManager:GetTypeControlTable("C15_Iroquois_TradeDefence_MCIS_Tooltip", g_C15_Iroquois_TradeDefence_MCIS_TipControls)
-------------------------------------------------------------------------------------------------------------------------
-- ProcessCityScreen
-------------------------------------------------------------------------------------------------------------------------
local iTradeDummy = GameInfoTypes["BUILDING_C15_IROQUOIS_CAYUGA_TRADE"]
local iDefenceDummy = GameInfoTypes["BUILDING_C15_IROQUOIS_ONEIDA_DEF"]

function ProcessCityScreen(instance)
	-- Ensure City Selected
	local pCity = UI.GetHeadSelectedCity()
	if (not pCity) then
		instance.IconFrame:SetHide(true)
		return
	end
	instance.IconFrame:SetToolTipType("C15_Iroquois_TradeDefence_MCIS_Tooltip")
	IconHookup(pCivilization.PortraitIndex, 64, pCivilization.IconAtlas, instance.IconImage)
	local iBonus = 0
	local sNation = C15_GetCityNation(pCity)
	local sDesc, sHelp
	if sNation == "NATION_C15_CAYUGA" then
		iBonus = pCity:GetNumRealBuilding(iTradeDummy)
		sDesc = "TXT_KEY_C15_IROQUOIS_TRADE_MCIS_DESC" 
		sHelp = "TXT_KEY_C15_IROQUOIS_TRADE_MCIS_HELP" 
	elseif sNation == "NATION_C15_ONEIDA" then
		iBonus = pCity:GetNumRealBuilding(iDefenceDummy)
		sDesc = "TXT_KEY_C15_IROQUOIS_DEFENCE_MCIS_DESC" 
		sHelp = "TXT_KEY_C15_IROQUOIS_DEFENCE_MCIS_HELP" 
	end
	if iBonus <= 0 then
		instance.IconFrame:SetHide(true)
		return
	end
	local textDescription = "[COLOR_POSITIVE_TEXT]" .. string.upper(Locale.ConvertTextKey(sDesc)) .. "[ENDCOLOR]"
	local textHelp = Locale.ConvertTextKey(sHelp, iBonus)
	g_C15_Iroquois_TradeDefence_MCIS_TipControls.Heading:SetText(textDescription)
	g_C15_Iroquois_TradeDefence_MCIS_TipControls.Body:SetText(textHelp)
	g_C15_Iroquois_TradeDefence_MCIS_TipControls.Box:DoAutoSize()
	instance.IconFrame:SetHide(false)
end