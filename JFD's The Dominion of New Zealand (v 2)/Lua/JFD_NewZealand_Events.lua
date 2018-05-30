-- JFD_NewZealand_Events
-- Author: JFD
--=======================================================================================================================
print("JFD's New Zealand Events: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
function JFD_IsCommunityPatchDLL()
	local communityPatchDLLID = "d1b6328c-ff44-4b0d-aad7-c657f83610cd"
	local isUsingCPDLL = false
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == communityPatchDLLID) then
			return true
		end
	end
	return false
end
local isUsingCPDLL = JFD_IsCommunityPatchDLL()
--------------------------------------------------------------------------------------------------------------------------
-- UTILS
--------------------------------------------------------------------------------------------------------------------------
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
-- Civ Specific Events
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilizationID	= GameInfoTypes["CIVILIZATION_JFD_NEW_ZEALAND"]
local eraRenaissanceID  = GameInfoTypes["ERA_RENAISSANCE"]
local mathCeil 			= math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- New Zealand: World Heritage Site
--------------------------------------------------------------------------------------------------------------------------
local buildingWorldHeritageSiteCultureID = GameInfoTypes["BUILDING_EVENTS_JFD_WORLD_HERITAGE_CULTURE"]
local buildingWorldHeritageSiteGoldID = GameInfoTypes["BUILDING_EVENTS_JFD_WORLD_HERITAGE_GOLD"]
local eventHeritageCity	= nil				 
local plotMountainID = GameInfoTypes["PLOT_MOUNTAIN"]
local Event_JFD_NewZealand_HeritageSite = {}
	Event_JFD_NewZealand_HeritageSite.Name = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE"
	Event_JFD_NewZealand_HeritageSite.Desc = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_DESC"
	Event_JFD_NewZealand_HeritageSite.EventImage = 'Event_NewZealand_HeritageSite.dds'
	Event_JFD_NewZealand_HeritageSite.Weight = 10
	Event_JFD_NewZealand_HeritageSite.CanFunc = (
		function(player)			
			if player:GetCivilizationType() ~= civilizationID then return false end
			if (not player:GetCapitaleventHeritageCity()) then return false end
			if player:GetCurrentEra() < eraRenaissanceID then return false end
			local cities = {}
			local count = 1
			for eventHeritageCity in player:Cities() do
				if ((not eventHeritageCity:IsHasBuilding(buildingWorldHeritageSiteCultureID)) and (not eventHeritageCity:IsHasBuilding(buildingWorldHeritageSiteGoldID))) then
					if isUsingCPDLL then
						if eventHeritageCity:IsWithinDistanceOfPlotType(plotMountainID, 2) then
							cities[count] = eventHeritageCity:GetID()
							count = count + 1
						elseif eventHeritageCity:Plot():IsFeatureRiver() then
							cities[count] = eventHeritageCity:GetID()
							count = count + 1
						end
					else
						local eventHeritageCityPlot = eventHeritageCity:Plot()
						for loopPlot in PlotAreaSpiralIterator(eventHeritageCityPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
							if loopPlot:IsMountain() or loopPlot:IsRiver() then
								cities[count] = eventHeritageCity:GetID()
								count = count + 1
								break
							end
						end 
					end
				end
			end	
			local eventHeritageCityID = cities[GetRandom(1,#cities)]
			if (not eventHeritageCityID) then return false end
			eventHeritageCity = player:GeteventHeritageCityByID(eventHeritageCityID)
			Event_JFD_NewZealand_HeritageSite.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_DESC", eventHeritageCity:GetName())
			return true
		end
		)
	Event_JFD_NewZealand_HeritageSite.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_NewZealand_HeritageSite.Outcomes[1] = {}
	Event_JFD_NewZealand_HeritageSite.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_OUTCOME_1"
	Event_JFD_NewZealand_HeritageSite.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_OUTCOME_RESULT_1"
	Event_JFD_NewZealand_HeritageSite.Outcomes[1].Weight = 5
	Event_JFD_NewZealand_HeritageSite.Outcomes[1].CanFunc = (
		function(player)			
			Event_JFD_NewZealand_HeritageSite.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_OUTCOME_RESULT_1", eventHeritageCity:GetName())
			return true
		end
		)
	Event_JFD_NewZealand_HeritageSite.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			eventHeritageCity:SetNumRealBuilding(buildingWorldHeritageSiteGoldID, 1)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE", eventHeritageCity:GetName()))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_NewZealand_HeritageSite.Outcomes[2] = {}
	Event_JFD_NewZealand_HeritageSite.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_OUTCOME_2"
	Event_JFD_NewZealand_HeritageSite.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_OUTCOME_RESULT_2"
	Event_JFD_NewZealand_HeritageSite.Outcomes[2].Weight = 5
	Event_JFD_NewZealand_HeritageSite.Outcomes[2].CanFunc = (
		function(player)			
			Event_JFD_NewZealand_HeritageSite.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_OUTCOME_RESULT_2", eventHeritageCity:GetName())
			return true
		end
		)
	Event_JFD_NewZealand_HeritageSite.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			eventHeritageCity:SetNumRealBuilding(buildingWorldHeritageSiteCultureID, 1)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_NEW_ZEALAND_WORLD_HERITAGE_SITE", eventHeritageCity:GetName()))
		end)
Events_AddCivilisationSpecific(civilizationID, "Event_JFD_NewZealand_HeritageSite", Event_JFD_NewZealand_HeritageSite)
--------------------------------------------------------------------------------------------------------------------------
--  New Zealand: Naval Invasion
--------------------------------------------------------------------------------------------------------------------------
local Event_JFD_NewZealand_NavalInvasion = {}
	Event_JFD_NewZealand_NavalInvasion.Name = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION"
	Event_JFD_NewZealand_NavalInvasion.Desc = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_DESC"
	Event_JFD_NewZealand_NavalInvasion.EventImage = 'Event_NewZealand_NavalInvasion.dds'
	Event_JFD_NewZealand_NavalInvasion.Weight = 10
	Event_JFD_NewZealand_NavalInvasion.CanFunc = (
		function(player)			
			if load(player, "Event_JFD_NewZealand_NavalInvasion") == true then return false end
			if player:GetCivilizationType() ~= civilizationID then return false end
			if player:GetCurrentEra() < eraRenaissanceID then return false end
			local playerTeam = Teams[player:GetTeam()]
			local goldCost = mathCeil(1000*iMod)
			if player:GetGold() < goldCost then return false end
			local alliedCivs = {}
			local alliedCivsCount = 1
			for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
				local otherPlayer = Players[otherPlayerID]
				if (otherPlayer:IsAlive() and otherPlayerID ~= playerID) then
					local otherTeamID = otherPlayer:GetTeam()
					if (playerTeam:IsHasMet(otherTeamID) and playerTeam:IsDefensivePact(otherTeamID) and (not playerTeam:IsAtWar(otherTeamID))) then
						alliedCivs[alliedCivsCount] = otherPlayerID
					end
				end
			end
			local civ1ID = alliedCivs[GetRandom(1,#alliedCivs)]
			if (not civ1ID) then return false end
			local civ1Player = Players[civ1ID]
			local civ1Description = civ1Player:GetCivilizationDescription()
			local civ1ShortDescription = civ1Player:GetCivilizationShortDescription()
			local neutralCivs = {}
			local neutralCivsCount = 1
			for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
				local otherPlayer = Players[otherPlayerID]
				if (otherPlayer:IsAlive() and otherPlayerID ~= playerID and otherPlayerID ~= civ1ID) then
					local otherTeamID = otherPlayer:GetTeam()
					if (playerTeam:IsHasMet(otherTeamID) and (not playerTeam:IsAtWar(otherTeamID)) and (not Teams[civ1Player:GetTeam()]:IsAtWar(otherTeamID))) then
						neutralCivs[neutralCivsCount] = otherPlayerID
					end
				end
			end
			local civ2ID = neutralCivs[GetRandom(1,#neutralCivs)]
			if (not civ2ID) then return false end
			local civ2Description = Players[civ2ID]:GetCivilizationDescription()
			local civ2ShortDescription = Players[civ2ID]:GetCivilizationShortDescription()
			Event_JFD_NewZealand_NavalInvasion.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_DESC", civ1Description, civ2Description, civ1ShortDescription, civ2ShortDescription)			
			return true
		end
		)
	Event_JFD_NewZealand_NavalInvasion.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_NewZealand_NavalInvasion.Outcomes[1] = {}
	Event_JFD_NewZealand_NavalInvasion.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_OUTCOME_1"
	Event_JFD_NewZealand_NavalInvasion.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_OUTCOME_RESULT_1"
	Event_JFD_NewZealand_NavalInvasion.Outcomes[1].Weight = 5
	Event_JFD_NewZealand_NavalInvasion.Outcomes[1].CanFunc = (
		function(player)			
			local goldCost = mathCeil((50*player:GetCurrentEra())*iMod)
			local numCoastalCities = 1
			for city in player:Cities() do
				if city:IsCoastal() then
					numCoastalCities = numCoastalCities + 1
				end
			end
			goldCost = (goldCost*numCoastalCities)
			if player:GetGold() < goldCost then return false end
			local navalUnitToSpawnID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_NAVALMELEE", "UNITCOMBAT_NAVALRANGED")
			if navalUnitToSpawnID then
				local navalUnitToSpawnClass = GameInfo.Units[navalUnitToSpawnID].Class
				local navalUnitToSpawnType = GameInfoTypes[JFD_GetUniqueUnit(player, navalUnitToSpawnClass)]
				local navalUnitToSpawnName = GameInfo.Units[navalUnitToSpawnID].Description
				Event_JFD_NewZealand_NavalInvasion.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_OUTCOME_RESULT_1", goldCost, navalUnitToSpawnName)
			else
				return false
			end
			return true
		end
		)
	Event_JFD_NewZealand_NavalInvasion.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local goldCost = mathCeil((50*player:GetCurrentEra())*iMod)
			local navalUnitToSpawnID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_NAVALMELEE", "UNITCOMBAT_NAVALRANGED")
			local navalUnitToSpawnClass = GameInfo.Units[navalUnitToSpawnID].Class
			local navalUnitToSpawnType = GameInfoTypes[JFD_GetUniqueUnit(player, navalUnitToSpawnClass)]
			local numCoastalCities = 0
			for city in player:Cities() do
				if city:IsCoastal() then
					numCoastalCities = numCoastalCities + 1
					player:InitUnit(navalUnitToSpawnType, city:GetX(), city:GetY())
				end
			end
			goldCost = (goldCost*numCoastalCities)
			player:ChangeGold(-goldCost)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_NewZealand_NavalInvasion.Outcomes[2] = {}
	Event_JFD_NewZealand_NavalInvasion.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_OUTCOME_2"
	Event_JFD_NewZealand_NavalInvasion.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_OUTCOME_RESULT_2"
	Event_JFD_NewZealand_NavalInvasion.Outcomes[2].Weight = 2
	Event_JFD_NewZealand_NavalInvasion.Outcomes[2].CanFunc = (
		function(player)			
			Event_JFD_NewZealand_NavalInvasion.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_OUTCOME_RESULT_2")
			return true
		end
		)
	Event_JFD_NewZealand_NavalInvasion.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_NEW_ZEALAND_NAVAL_INVASION"))
		end)	
Events_AddCivilisationSpecific(civilizationID, "Event_JFD_NewZealand_NavalInvasion", Event_JFD_NewZealand_NavalInvasion)	
--=======================================================================================================================
--=======================================================================================================================


