-- JFD_Turks_Events
-- Author: JFD
--=======================================================================================================================
print("JFD's The Turks Events: loaded")
--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_IsHasConqueredMajorCapital
function JFD_IsHasConqueredMajorCapital(playerID)
	local player = Players[playerID]
	local numConqueredCapitals = 0
	for city in player:Cities() do
		if city:GetOriginalOwner() ~= playerID then
			if city:IsOriginalCapital() then
				return true
			end
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
-- Civ Specific Events
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local civilizationTurksID = GameInfoTypes["CIVILIZATION_JFD_TURKS"]
local mathCeil			  = math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Turks: Re-Population Efforts
--------------------------------------------------------------------------------------------------------------------------
local buildingPalaceID = GameInfoTypes["BUILDING_PALACE"]
local capitalCity = nil	
local Event_JFD_Turks_Repopulation = {}
	Event_JFD_Turks_Repopulation.Name = "TXT_KEY_EVENT_JFD_TURKS_REPOPULATION"
	Event_JFD_Turks_Repopulation.Desc = "TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_DESC"
	Event_JFD_Turks_Repopulation.Weight = 10
	Event_JFD_Turks_Repopulation.CanFunc = (
		function(player)			
			if load(player, "Event_JFD_Turks_Repopulation") == true then return false end
			if player:GetCivilizationType() ~= civilizationTurksID then return false end
			local playerID = player:GetID()
			local goldCost = mathCeil(226*iMod)
			if player:GetGold() < goldCost then return false end
			local playerID = player:GetID()
			if (not JFD_IsHasConqueredMajorCapital(playerID)) then return false end
			if player:GetCapitalCity():GetPopulation() < 4 then return false end
			local cities = {}
			local count = 1
			for city in player:Cities() do
				if city:GetOriginalOwner() ~= playerID then
					cities[count] = city:GetID()
					count = count + 1
				end
			end	
			local cityID = cities[GetRandom(1,#cities)]
			if (not cityID) then return false end
			capitalCity = player:GetCityByID(cityID)
			Event_JFD_Turks_Repopulation.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_DESC", Players[capitalCity:GetOriginalOwner()]:GetCivilizationDescription(), capitalCity:GetName())
			return true
		end
		)
	Event_JFD_Turks_Repopulation.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_Turks_Repopulation.Outcomes[1] = {}
	Event_JFD_Turks_Repopulation.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_1"
	Event_JFD_Turks_Repopulation.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_1"
	Event_JFD_Turks_Repopulation.Outcomes[1].Weight = 5
	Event_JFD_Turks_Repopulation.Outcomes[1].CanFunc = (
		function(player)			
			local goldCost = mathCeil(464*iMod)
			if player:GetGold() < goldCost then return false end
			Event_JFD_Turks_Repopulation.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_1", goldCost, capitalCity:GetName())
			return true
		end
		)
	Event_JFD_Turks_Repopulation.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local goldCost = mathCeil(464*iMod)
			local capital = player:GetCapitalCity()
			player:ChangeGold(-goldCost)
			capital:ChangePopulation(-3, true)
			capitalCity:ChangePopulation(3, true)
			capitalCity:SetNumRealBuilding(buildingPalaceID, 1)
			capital:SetNumRealBuilding(buildingPalaceID, 0)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_1_NOTIFICATION", capitalCity:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION"))
			JFD_SendWorldEvent(playerID, Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_1", player:GetName(), Players[capitalCity:GetOriginalOwner()]:GetCivilizationDescription(), capitalCity:GetName()))
			save(player, "Event_JFD_Turks_Repopulation", true)
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_Turks_Repopulation.Outcomes[2] = {}
	Event_JFD_Turks_Repopulation.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_2"
	Event_JFD_Turks_Repopulation.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_2"
	Event_JFD_Turks_Repopulation.Outcomes[2].Weight = 5
	Event_JFD_Turks_Repopulation.Outcomes[2].CanFunc = (
		function(player)		
			local goldCost = mathCeil(226*iMod)
			Event_JFD_Turks_Repopulation.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_2", goldCost, capitalCity:GetName())
			return true
		end
		)
	Event_JFD_Turks_Repopulation.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local goldCost = mathCeil(226*iMod)
			player:ChangeGold(-goldCost)
			player:GetCapitalCity():ChangePopulation(-2, true)
			capitalCity:ChangePopulation(2, true)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_2_NOTIFICATION", capitalCity:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION"))
		end)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_JFD_Turks_Repopulation.Outcomes[3] = {}
	Event_JFD_Turks_Repopulation.Outcomes[3].Name = "TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_3"
	Event_JFD_Turks_Repopulation.Outcomes[3].Desc = "TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_3"
	Event_JFD_Turks_Repopulation.Outcomes[3].Weight = 5
	Event_JFD_Turks_Repopulation.Outcomes[3].CanFunc = (
		function(player)		
			Event_JFD_Turks_Repopulation.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_3")
			return true
		end
		)
	Event_JFD_Turks_Repopulation.Outcomes[3].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION_OUTCOME_RESULT_3_NOTIFICATION", capitalCity:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_REPOPULATION"))
		end)
Events_AddCivilisationSpecific(civilizationTurksID, "Event_JFD_Turks_Repopulation", Event_JFD_Turks_Repopulation)
--------------------------------------------------------------------------------------------------------------------------
--  Turks: Merchant's Patronage
--------------------------------------------------------------------------------------------------------------------------
local cityState = nil
local techCompassID = GameInfoTypes["TECH_COMPASS"]
local Event_JFD_Turks_Patronage = {}
	Event_JFD_Turks_Patronage.Name = "TXT_KEY_EVENT_JFD_TURKS_PATRONAGE"
	Event_JFD_Turks_Patronage.Desc = "TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_DESC"
	Event_JFD_Turks_Patronage.Weight = 10
	Event_JFD_Turks_Patronage.CanFunc = (
		function(player)			
			if player:GetCivilizationType() ~= civilizationTurksID then return false end
			if (not Teams[player:GetTeam()]:IsHasTech(techCompassID)) then return false end
			local playerTeam = Teams[player:GetTeam()]
			local cityStates = {}
			local count = 1
			for minorID = 0, GameDefines.MAX_MINOR_CIVS - 1 do
				local minorCiv = Players[minorID]
				if (Teams[player:GetTeam()]:IsHasMet(minorCiv:GetTeam()) and minorCiv:IsMinorCiv() and minorCiv:GetCapitalCity()) then
					cityStates[count] = minorCiv
					count = count + 1
				end
			end
			cityState = cityStates[GetRandom(1,#cityStates)]
			if (not cityState) then return false end
			Event_JFD_Turks_Patronage.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_DESC", cityState:GetName())			
			return true
		end
		)
	Event_JFD_Turks_Patronage.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JFD_Turks_Patronage.Outcomes[1] = {}
	Event_JFD_Turks_Patronage.Outcomes[1].Name = "TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_OUTCOME_1"
	Event_JFD_Turks_Patronage.Outcomes[1].Desc = "TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_OUTCOME_RESULT_1"
	Event_JFD_Turks_Patronage.Outcomes[1].Weight = 5
	Event_JFD_Turks_Patronage.Outcomes[1].CanFunc = (
		function(player)			
			local playerID = player:GetID()
			Event_JFD_Turks_Patronage.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_JFD_Turks_Patronage.Outcomes[1].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local unitToSpawnID = GetStrongestMilitaryUnit(player, false, "UNITCOMBAT_NAVALMELEE", "UNITCOMBAT_NAVALRANGED")
			if unitToSpawnID then
				local capital = player:GetCapitalCity()
				local capitalX = capital:GetX()
				local capitalY = capital:GetY()
				local unitOne = player:InitUnit(unitToSpawnID, capitalX, capitalY)
				local unitTwo = player:InitUnit(unitToSpawnID, capitalX, capitalY)
				local unitThree = player:InitUnit(unitToSpawnID, capitalX, capitalY)
				local civilizationAdj = cityState:GetCivilizationAdjective()
				local unitName = civilizationAdj .. " " .. unitOne:GetName()
				unitOne:JumpToNearestValidPlot()
				unitTwo:JumpToNearestValidPlot()
				unitThree:JumpToNearestValidPlot()
				unitOne:SetName(unitName)
				unitTwo:SetName(unitName)
				unitThree:SetName(unitName)
			end
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_PATRONAGE"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JFD_Turks_Patronage.Outcomes[2] = {}
	Event_JFD_Turks_Patronage.Outcomes[2].Name = "TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_OUTCOME_2"
	Event_JFD_Turks_Patronage.Outcomes[2].Desc = "TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_OUTCOME_RESULT_2"
	Event_JFD_Turks_Patronage.Outcomes[2].Weight = 2
	Event_JFD_Turks_Patronage.Outcomes[2].CanFunc = (
		function(player)			
			local cultureReward = mathCeil(133*iMod)
			Event_JFD_Turks_Patronage.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_OUTCOME_RESULT_2", cultureReward)
			return true
		end
		)
	Event_JFD_Turks_Patronage.Outcomes[2].DoFunc = (
		function(player) 
			local playerID = player:GetID()
			local cultureReward = mathCeil(133*iMod)
			player:ChangeJONSCulture(cultureReward)
			JFD_SendNotification(playerID, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_PATRONAGE_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_JFD_TURKS_PATRONAGE"))
		end)	
Events_AddCivilisationSpecific(civilizationTurksID, "Event_JFD_Turks_Patronage", Event_JFD_Turks_Patronage)	
--=======================================================================================================================
--=======================================================================================================================


