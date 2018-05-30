-- JFD_RussiaCatherine_Decisions
-- Author: JFD
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- UTILS
------------------------------------------------------------------------------------------------------------------------
-- Sukritact_PlaceResource
function Sukritact_PlaceResource(cityPlot, resourceID)
    local plots = {}
    for loopPlot in PlotAreaSweepIterator(cityPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
        table.insert(plots, loopPlot)
    end
    for iVal = 1, 1 do
		local isPlaced = false
		while (not isPlaced) and #plots > 0 do
			local randomNumber = GetRandom(1, #plots)
			local plot = plots[randomNumber]
			if (not plot:IsHills() and not plot:IsMountain() and not plot:IsWater() and plot:GetResourceType() == -1) then
				plot:SetResourceType(resourceID, 1)
				isPlaced = true
			end
			table.remove(plots, randomNumber)
		end
	end
end

-- JFD_SendWorldEvent
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
-- DECISIONS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local activePlayerTeam 		= Teams[Game.GetActiveTeam()]
local civilisationID 		= GameInfoTypes["CIVILIZATION_JFD_MUSCOVY"]
local civilisationRussiaID 	= GameInfoTypes["CIVILIZATION_RUSSIA"]
local eraRenaissanceID  	= GameInfoTypes["ERA_RENAISSANCE"]
local mathCeil 				= math.ceil
-------------------------------------------------------------------------------------------------------------------------
-- Russia (Catherine): Decree the Establishment of the Smolny Institute
-------------------------------------------------------------------------------------------------------------------------
local buildingSmolnyInstituteID = GameInfoTypes["BUILDING_DECISIONS_JFD_SMOLNY"]
local eraEnlightenmentID		= GameInfoTypes["ERA_ENLIGHTENMENT"]
local techEducationID 			= GameInfoTypes["TECH_EDUCATION"]
tDecisions.Decisions_RussianStreltsy = nil
local Decisions_JFD_RussiaCatherine_SmolnyInstitute = {}
	Decisions_JFD_RussiaCatherine_SmolnyInstitute.Name = "TXT_KEY_DECISIONS_JFD_RUSSIA_CATHERINE_SMOLNY_INSTITUTE"
	Decisions_JFD_RussiaCatherine_SmolnyInstitute.Desc = "TXT_KEY_DECISIONS_JFD_RUSSIA_CATHERINE_SMOLNY_INSTITUTE_DESC"
	Decisions_JFD_RussiaCatherine_SmolnyInstitute.Pedia = "TXT_KEY_BUILDING_DECISIONS_JFD_SMOLNY"
	HookDecisionCivilizationIcon(Decisions_JFD_RussiaCatherine_SmolnyInstitute, "CIVILIZATION_RUSSIA")
	Decisions_JFD_RussiaCatherine_SmolnyInstitute.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilisationRussiaID then return false, false end
		if load(player, "Decisions_JFD_RussiaCatherine_SmolnyInstitute") then
			Decisions_JFD_RussiaCatherine_SmolnyInstitute.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_RUSSIA_CATHERINE_SMOLNY_INSTITUTE_ENACTED_DESC")
			return false, false, true
		end
		local costGold = mathCeil(570*iMod)
		local eraDesc = "Renaissance Era"
		local eraID = eraRenaissanceID
		if eraEnlightenmentID then
			eraDesc = "Enlightenment Era"
			eraID = eraEnlightenmentID
		end
		Decisions_JFD_RussiaCatherine_SmolnyInstitute.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_RUSSIA_CATHERINE_SMOLNY_INSTITUTE_DESC", eraDesc, costGold)
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		if player:GetGold() < costGold then return true, false end
		if player:GetCurrentEra() < eraRenaissanceID then return true, false end
		if (not Teams[player:GetTeam()]:IsHasTech(techEducationID)) then return true, false end
		return true, true
	end
	)
	
	Decisions_JFD_RussiaCatherine_SmolnyInstitute.DoFunc = (
	function(player)
		local costGold = mathCeil(570*iMod)
		player:ChangeGold(-costGold)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:GetCapitalCity():SetNumRealBuilding(buildingSmolnyInstituteID, 1)
		JFD_SendWorldEvent(player:GetID(), Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_RUSSIA_CATHERINE_SMOLNY_INTITUTE", player:GetName(), player:GetCivilizationShortDescription())) 
		save(player, "Decisions_JFD_RussiaCatherine_SmolnyInstitute", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationRussiaID, "Decisions_JFD_RussiaCatherine_SmolnyInstitute", Decisions_JFD_RussiaCatherine_SmolnyInstitute)
-------------------------------------------------------------------------------------------------------------------------
-- Russia (Catherine): Patronise the Fur Trade
-------------------------------------------------------------------------------------------------------------------------
local resourceFurID = GameInfoTypes["RESOURCE_FUR"]
local terrainTundraID = GameInfoTypes["TERRAIN_TUNDRA"]
local unitSettlerID = GameInfoTypes["UNIT_SETTLER"]
local Decisions_RussiaCatherineFurTrade = {}
	Decisions_RussiaCatherineFurTrade.Name = "TXT_KEY_DECISIONS_JFD_RUSSIA_CATHERINE_FUR_TRADE"
	Decisions_RussiaCatherineFurTrade.Desc = "TXT_KEY_DECISIONS_JFD_RUSSIA_CATHERINE_FUR_TRADE_DESC"
	HookDecisionCivilizationIcon(Decisions_RussiaCatherineFurTrade, "CIVILIZATION_RUSSIA")
	Decisions_RussiaCatherineFurTrade.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilisationRussiaID then return false, false end
		if load(player, "Decisions_RussiaCatherineFurTrade") then
			Decisions_RussiaCatherineFurTrade.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_RUSSIA_CATHERINE_FUR_TRADE_ENACTED_DESC")
			return false, false, true
		end
		local costGold = mathCeil(1200*iMod)
		Decisions_RussiaCatherineFurTrade.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_RUSSIA_CATHERINE_FUR_TRADE_DESC", costGold)
		if player:GetNumResourceAvailable(iMagistrate, false) < 1 then return true, false end
		if player:GetNumResourceAvailable(resourceFurID, false) < 1 then return true, false end
		if player:GetGold() < costGold then return true, false end
		if player:GetCurrentEra() < eraRenaissanceID then return true, false end
		return true, true
	end
	)
	
	Decisions_RussiaCatherineFurTrade.DoFunc = (
	function(player)
		local costGold = mathCeil(1200*iMod)
		local capital = player:GetCapitalCity()
		player:ChangeGold(-costGold)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		player:InitUnit(unitSettlerID, capital:GetX(), capital:GetY())
		player:InitUnit(unitSettlerID, capital:GetX(), capital:GetY())
		JFD_SendWorldEvent(player:GetID(), Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_RUSSIA_CATHERINE_FUR_TRADE", player:GetName(), player:GetCivilizationShortDescription())) 
		save(player, "Decisions_RussiaCatherineFurTrade", true)
	end
	)
	
	Decisions_RussiaCatherineFurTrade.Monitors = {}
	Decisions_RussiaCatherineFurTrade.Monitors[GameEvents.PlayerCityFounded] =  (
	function(playerID, cityX, cityY)
		local player = Players[playerID]
		if player:GetCivilizationType() ~= civilisationRussiaID then return end
		if load(player, "Decisions_RussiaCatherineFurTrade") then
			local plot = Map.GetPlot(cityX, cityY)
			if plot:GetTerrainType() == terrainTundraID then
				Sukritact_PlaceResource(plot, resourceFurID)
			end		
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationRussiaID, "Decisions_RussiaCatherineFurTrade", Decisions_RussiaCatherineFurTrade)
--=======================================================================================================================
--=======================================================================================================================
