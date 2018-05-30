-- JFD_MuscovyEvents
-- Author: JFD
--=======================================================================================================================
print("JFD's Muscovy Events: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
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
-- GLOBALS
--------------------------------------------------------------------------------------------------------------------------
local civilisationID  = GameInfoTypes["CIVILIZATION_JFD_MUSCOVY"]
local eraMedievalID	  = GameInfoTypes["ERA_MEDIEVAL"]	
local mathCeil		  = math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Muscovy: The Printing Press
--------------------------------------------------------------------------------------------------------------------------
local techPrintingPressID = GameInfoTypes["TECH_PRINTING_PRESS"]
local Event_JFD_Muscovy_PrintingPress = {}
	Event_JFD_Muscovy_PrintingPress.Name = "TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS"
	Event_JFD_Muscovy_PrintingPress.Desc = "TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS_DESC"
	Event_JFD_Muscovy_PrintingPress.EventImage = 'Event_Muscovy_PrintingPress.dds'
	Event_JFD_Muscovy_PrintingPress.Weight = 10
	Event_JFD_Muscovy_PrintingPress.CanFunc = (
		function(player)			
			local playerID = player:GetID()
			if player:GetCivilizationType() ~= civilisationID  then return false end
			if player:GetCurrentEra() < eraMedievalID then return false end
			if Teams[player:GetTeam()]:IsHasTech(techPrintingPressID) then return false end
			if load(player, "Event_JFD_Muscovy_PrintingPress") == true 	then return false end
			local goldCost = mathCeil(500*iMod)
			if player:GetGold() < goldCost then return false end
			return true
		end
		)
	Event_JFD_Muscovy_PrintingPress.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_Muscovy_PrintingPress.Outcomes[1] = {}
	Event_JFD_Muscovy_PrintingPress.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS_OUTCOME_1"
	Event_JFD_Muscovy_PrintingPress.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS_OUTCOME_RESULT_1"
	Event_JFD_Muscovy_PrintingPress.Outcomes[1].Weight = 5
	Event_JFD_Muscovy_PrintingPress.Outcomes[1].CanFunc = (
		function(player)	
			Event_JFD_Muscovy_PrintingPress.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_JFD_Muscovy_PrintingPress.Outcomes[1].DoFunc = (
		function(player) 
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_MUSCOVY_PRINTING_PRESS_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS"))
			save(player, "Event_JFD_Muscovy_PrintingPress", true)
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_Muscovy_PrintingPress.Outcomes[2] = {}
	Event_JFD_Muscovy_PrintingPress.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS_OUTCOME_2"
	Event_JFD_Muscovy_PrintingPress.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS_OUTCOME_RESULT_2"
	Event_JFD_Muscovy_PrintingPress.Outcomes[2].Weight = 2
	Event_JFD_Muscovy_PrintingPress.Outcomes[2].CanFunc = (
		function(player)	
			local goldCost = mathCeil(500*iMod)
			Event_JFD_Muscovy_PrintingPress.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS_OUTCOME_RESULT_2", goldCost)
			return true
		end
		)
	Event_JFD_Muscovy_PrintingPress.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local goldCost = mathCeil(500*iMod)
			player:ChangeGold(-goldCost)
			Teams[player:GetTeam()]:GetTeamTechs():SetHasTech(techPrintingPressID, true)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_MUSCOVY_PRINTING_PRESS_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_PRINTING_PRESS"))
			save(player, "Event_JFD_Muscovy_PrintingPress", true)
		end)
	
Events_AddCivilisationSpecific(civilisationID, "Event_JFD_Muscovy_PrintingPress", Event_JFD_Muscovy_PrintingPress)
--------------------------------------------------------------------------------------------------------------------------
--  Muscovy: Conspiring Nobles
--------------------------------------------------------------------------------------------------------------------------
local eventMuscovyNoblesCity = nil
local taskRazeID = TaskTypes["TASK_RAZE"]
local Event_JFD_Muscovy_ConspiringNobles = {}
	Event_JFD_Muscovy_ConspiringNobles.Name = "TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES"
	Event_JFD_Muscovy_ConspiringNobles.Desc = "TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES_DESC"
	Event_JFD_Muscovy_ConspiringNobles.EventImage = 'Event_Muscovy_ConspiringNobles.dds'
	Event_JFD_Muscovy_ConspiringNobles.Weight = 6
	Event_JFD_Muscovy_ConspiringNobles.CanFunc = (
		function(player)	
			if player:GetCivilizationType() ~= civilisationID then return false end
			if player:GetCurrentEra() < eraMedievalID then return false end
			local cities = {}
			local count = 1
			for eventMuscovyNoblesCity in player:Cities() do
				if (not eventMuscovyNoblesCity:IsOriginalCapital() and eventMuscovyNoblesCity:GetOriginalOwner() ~= player:GetID()) then
					cities[count] = eventMuscovyNoblesCity
					count = count + 1
				end
			end
			eventMuscovyNoblesCity = cities[GetRandom(1, #cities)]
			if (not eventMuscovyNoblesCity) then return false end
			Event_JFD_Muscovy_ConspiringNobles.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES_DESC", eventMuscovyNoblesCity:GetName())
			return true
		end
		)
	Event_JFD_Muscovy_ConspiringNobles.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[1] = {}
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES_OUTCOME_1"
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES_OUTCOME_RESULT_1"
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[1].Weight = 5
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[1].CanFunc = (
		function(player)	
			local goldenAgeCost = mathCeil((player:GetGoldenAgeProgressMeter()*25)/100)		
			Event_JFD_Muscovy_ConspiringNobles.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES_OUTCOME_RESULT_1", eventMuscovyNoblesCity:GetName(), goldenAgeCost)
			return true
		end
		)
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local goldenAgeCost = mathCeil((player:GetGoldenAgeProgressMeter()*25)/100)		
			player:ChangeGoldenAgeProgressMeter(-goldenAgeCost)	
			eventMuscovyNoblesCity:DoTask(taskRazeID)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_MUSCOVY_CONSPIRING_NOBLES_OUTCOME_RESULT_1_NOTIFICATION", eventMuscovyNoblesCity:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES", player:GetName(), player:GetCivilizationAdjective(), eventMuscovyNoblesCity:GetName())) 
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[2] = {}
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES_OUTCOME_2"
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES_OUTCOME_RESULT_2"
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[2].Weight = 2
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[2].CanFunc = (
		function(player)			
			Event_JFD_Muscovy_ConspiringNobles.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES_OUTCOME_RESULT_2", eventMuscovyNoblesCity:GetName())
			return true
		end
		)
	Event_JFD_Muscovy_ConspiringNobles.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			if GetRandom(1,10) <= 3 then
				eventMuscovyNoblesCity:ChangeResistanceTurns(1)
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_MUSCOVY_CONSPIRING_NOBLES_OUTCOME_RESULT_2_ALT_NOTIFICATION", eventMuscovyNoblesCity:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES"))
			else
				JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_JFD_MUSCOVY_CONSPIRING_NOBLES_OUTCOME_RESULT_2_NOTIFICATION", eventMuscovyNoblesCity:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_MUSCOVY_CONSPIRING_NOBLES"))
			end
		end)
	
Events_AddCivilisationSpecific(civilisationID, "Event_JFD_Muscovy_ConspiringNobles", Event_JFD_Muscovy_ConspiringNobles)
--=======================================================================================================================
--=======================================================================================================================


