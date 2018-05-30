-- C15_Iroquois_Events
-- Author: Chrisy15
-- DateCreated: 12/31/2017 5:28:13 PM
--------------------------------------------------------------

local civilizationID = GameInfoTypes["CIVILIZATION_IROQUOIS"]

local Event_C15_Iroquois_Tuscarora = {}
	Event_C15_Iroquois_Tuscarora.Name = "TXT_KEY_CITY_EVENT_C15_IROQUIOS_TUSCARORA_MIGRATION"
	Event_C15_Iroquois_Tuscarora.Desc = "TXT_KEY_CITY_EVENT_C15_IROQUIOS_TUSCARORA_MIGRATION_HELP_ED"
	
	Event_C15_Iroquois_Tuscarora.Outcomes = {}
	
	Event_C15_Iroquois_Tuscarora.Outcomes[1] = {}
	Event_C15_Iroquois_Tuscarora.Outcomes[1].Name = "TXT_KEY_CITY_EVENT_C15_IROQUIOS_TUSCARORA_MIGRATION_CHOICE_1"
	Event_C15_Iroquois_Tuscarora.Outcomes[1].Weight = 100
	Event_C15_Iroquois_Tuscarora.Outcomes[1].DoFunc = (function (pPlayer) end)
	
Events_AddCivilisationSpecific(civilizationID, "Event_C15_Iroquois_Tuscarora", Event_C15_Iroquois_Tuscarora)

function C15_IroquoisEvent(pPlayer)
	LuaEvents.PushRandomEventPopup(pPlayer, tEvents.Event_C15_Iroquois_Tuscarora)
end

LuaEvents.C15_Iroquois_TryingToGetEventToWork.Add(C15_IroquoisEvent)