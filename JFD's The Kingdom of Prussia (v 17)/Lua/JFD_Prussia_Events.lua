-- JFD_Prussia_Events
-- Author: JFD
--=======================================================================================================================
print("JFD's Prussia Events: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- MOD CHECKS
--------------------------------------------------------------------------------------------------------------------------
-- JFD_IsUsingEnlightenmentEra
function JFD_IsUsingEnlightenmentEra()
	local enlightenmentEraID = "ce8aa614-7ef7-4a45-a179-5329869e8d6d"
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if (mod.ID == enlightenmentEraID) then
			return true
		end
	end
	return false
end
local isUsingEnlightenmentEra = JFD_IsUsingEnlightenmentEra()
--------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
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
-- EVENTS
--=======================================================================================================================
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilizationID = GameInfoTypes["CIVILIZATION_JFD_PRUSSIA"]
local eraEnlightenmentID = GameInfoTypes["ERA_ENLIGHTENMENT"]
local eraRenaissanceID = GameInfoTypes["ERA_RENAISSANCE"]
local mathCeil = math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Prussia: Potato War
--------------------------------------------------------------------------------------------------------------------------
local civID = nil
local Event_JFD_Prussia_PotatoWar = {}
	Event_JFD_Prussia_PotatoWar.Name = "TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR"
	Event_JFD_Prussia_PotatoWar.Desc = "TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR_DESC"
	Event_JFD_Prussia_PotatoWar.EventImage = 'Event_Prussia_PotatoWar.dds'
	Event_JFD_Prussia_PotatoWar.Weight = 5
	Event_JFD_Prussia_PotatoWar.CanFunc = (
		function(player)			
			if player:GetCivilizationType() ~= civilizationID then return false end
			if player:GetCurrentEra() < eraRenaissanceID then return false end
			if player:GetNumUnits() < 10 then return false end
			local civilizations = {}
			local count = 1
			for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
				if (player:GetID() ~= otherPlayerID and (not player:IsBarbarian())) then 
					local otherPlayer = Players[otherPlayerID]
					local playerTeam = Teams[player:GetTeam()]
					local otherTeamID = otherPlayer:GetTeam()
					if (playerTeam:IsHasMet(otherTeamID) and playerTeam:IsAtWar(otherTeamID)) then
						civilizations[count] = otherPlayerID
						count = count + 1
					end
				end
			end
			civID = civilizations[GetRandom(1, #civilizations)]	
			if civID == nil then return false end
			local civDesc = Players[civID]:GetCivilizationShortDescription()
			Event_JFD_Prussia_PotatoWar.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR_DESC", civDesc)
			return true
		end
		)
	Event_JFD_Prussia_PotatoWar.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_Prussia_PotatoWar.Outcomes[1] = {}
	Event_JFD_Prussia_PotatoWar.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR_OUTCOME_1"
	Event_JFD_Prussia_PotatoWar.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR_OUTCOME_RESULT_1"
	Event_JFD_Prussia_PotatoWar.Outcomes[1].CanFunc = (
		function(player)			
			Event_JFD_Prussia_PotatoWar.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_JFD_Prussia_PotatoWar.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local civDesc = Players[civID]:GetCivilizationShortDescription()
			local numUnitsKilled = 0
			for unit in player:Units() do
				if numUnitsKilled < 2 then
					if unit:GetLevel() < 3 then
						unit:Kill(-1)
						numUnitsKilled = numUnitsKilled + 1
					end
				end
			end
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_PRUSSIA_POTATO_WAR_OUTCOME_RESULT_1_NOTIFICATION", civDesc), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_Prussia_PotatoWar.Outcomes[2] = {}
	Event_JFD_Prussia_PotatoWar.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR_OUTCOME_2"
	Event_JFD_Prussia_PotatoWar.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR_OUTCOME_RESULT_2"
	Event_JFD_Prussia_PotatoWar.Outcomes[2].CanFunc = (
		function(player)			
			local civDesc = Players[civID]:GetCivilizationShortDescription()
			Event_JFD_Prussia_PotatoWar.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR_OUTCOME_RESULT_2", civDesc)
			return true
		end
		)
	Event_JFD_Prussia_PotatoWar.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local civ = Players[civID]
			local civDesc = civ:GetCivilizationShortDescription()
			if GetRandom(1,10) <= 6 then
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_PRUSSIA_POTATO_WAR_OUTCOME_RESULT_2_NOTIFICATION", civDesc), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR"))
				Teams[player:GetTeam()]:MakePeace(civ:GetTeam())
			else
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_PRUSSIA_POTATO_WAR_OUTCOME_RESULT_2_ALT_NOTIFICATION", civDesc), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_PRUSSIA_POTATO_WAR"))
			end
		end)
Events_AddCivilisationSpecific(civilizationID, "Event_JFD_Prussia_PotatoWar", Event_JFD_Prussia_PotatoWar)
--------------------------------------------------------------------------------------------------------------------------
-- Prussia: Compilation of Clausewitz' 'On War'
--------------------------------------------------------------------------------------------------------------------------
local unitDomainLandID = GameInfoTypes["DOMAIN_LAND"]
local Event_JFD_Prussia_Clausewitz = {}
	Event_JFD_Prussia_Clausewitz.Name = "TXT_KEY_EVENT_JFD_PRUSSIA_CLAUSEWITZ"
	Event_JFD_Prussia_Clausewitz.Desc = "TXT_KEY_EVENT_JFD_PRUSSIA_CLAUSEWITZ_DESC"
	Event_JFD_Prussia_Clausewitz.EventImage = 'Event_Prussia_Clausewitz.dds'
	Event_JFD_Prussia_Clausewitz.Weight = 5
	Event_JFD_Prussia_Clausewitz.CanFunc = (
		function(player)		
			if load(player, "Event_JFD_Prussia_Clausewitz") == true	then return false end
			if player:GetCivilizationType() ~= civilizationID then return false end
			return true
		end
		)
	Event_JFD_Prussia_Clausewitz.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_Prussia_Clausewitz.Outcomes[1] = {}
	Event_JFD_Prussia_Clausewitz.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_PRUSSIA_CLAUSEWITZ_OUTCOME_1"
	Event_JFD_Prussia_Clausewitz.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_PRUSSIA_CLAUSEWITZ_OUTCOME_RESULT_1"
	Event_JFD_Prussia_Clausewitz.Outcomes[1].CanFunc = (
		function(player)	
			Event_JFD_Prussia_Clausewitz.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_PRUSSIA_CLAUSEWITZ_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_JFD_Prussia_Clausewitz.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			for unit in player:Units() do
				if (unit:GetDomainType() == unitDomainLandID and unit:IsCombatUnit()) then
					unit:ChangeExperience(10)
				end
			end
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_PRUSSIA_CLAUSEWITZ_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_PRUSSIA_CLAUSEWITZ"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_PRUSSIA_CLAUSEWITZ", player:GetCivilizationDescription())) 
			save(player, "Event_JFD_Prussia_Clausewitz", true)
		end)
Events_AddCivilisationSpecific(civilizationID, "Event_JFD_Prussia_Clausewitz", Event_JFD_Prussia_Clausewitz)
--=======================================================================================================================
--=======================================================================================================================


