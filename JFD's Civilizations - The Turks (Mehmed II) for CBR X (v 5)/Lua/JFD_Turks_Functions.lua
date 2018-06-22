-- JFD_Turks_Functions
-- Author: JFD
-- DateCreated: 4/13/2014 4:19:30 PM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
--Game_IsCPActive
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPActive = Game_IsCPActive()

--HasTrait
function HasTrait(player, traitID)
	if isCPActive then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
	return false
end
--------------------------------------------------------------------------------------------------------------------------
-- UNIT
--------------------------------------------------------------------------------------------------------------------------
--Player_GetStrongestMilitaryUnit (adapted from Sukritact)
function Player_GetStrongestMilitaryUnit(player, ignoreResources, unitCombatTypes)
	local unit = {["ID"] = GameInfoTypes.UNIT_WARRIOR, ["Combat"] = 0}
	for _, combatType in pairs(unitCombatTypes) do
		for row in GameInfo.Units("CombatClass = '" .. combatType .. "'") do
			if player:CanTrain(row.ID, ignoreResources) and row.Combat > unit.Combat then
				unit = row
			end
		end
	end
	return unit.ID
end

--Player_GetUniqueUnit (Whoward)
function Player_GetUniqueUnit(player, unitClass)
	if isCPActive then 
		return player:GetSpecificUnitType(unitClass) 
	else
		local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
		for uniqueUnit in GameInfo.Civilization_UnitClassOverrides{CivilizationType = civType, UnitClassType = unitClass} do
			return uniqueUnit.UnitType
		end
		return GameInfo.UnitClasses[unitClass].DefaultUnit
	end
end
--=======================================================================================================================
-- GAME DEFINES
--=======================================================================================================================
------------------------------------------------------------------------------------------------------------------------
local defineMaxMajorCivs = GameDefines["MAX_MAJOR_CIVS"]
--=======================================================================================================================
-- CORE FUNCTIONS
--=======================================================================================================================
-- INIT
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--g_Civilization_FreePolicies_Table
local g_Civilization_FreePolicies_Table = {}
local g_Civilization_FreePolicies_Count = 1
for row in DB.Query("SELECT * FROM Civilization_FreePolicies;") do 	
	g_Civilization_FreePolicies_Table[g_Civilization_FreePolicies_Count] = row
	g_Civilization_FreePolicies_Count = g_Civilization_FreePolicies_Count + 1
end

--JFD_LoadScreenClose
local function JFD_LoadScreenClose()
	for playerID = 0, defineMaxMajorCivs - 1 do
		local player = Players[playerID]
	
		--g_Civilization_FreePolicies_Table
		local policiesTable = g_Civilization_FreePolicies_Table
		local numPolicies = #policiesTable
		for index = 1, numPolicies do
			local row = policiesTable[index]
			local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
			if civType == row.CivilizationType then
				local policyID = GameInfoTypes[row.PolicyType]
				if isCPActive then 
					player:GrantPolicy(policyID, true)
				else
					player:SetNumFreePolicies(1)
					player:SetHasPolicy(policyID, true)
				end
			end
		end
	end
end
Events.LoadScreenClose.Add(JFD_LoadScreenClose)
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- TRIBUTE IN BLOOD
----------------------------------------------------------------------------------------------------------------------------
local traitTurksID = GameInfoTypes["TRAIT_JFD_TURKS"]

--JFD_Turks_TributeInBlood_CityCaptureComplete
local buildingTurksID = GameInfoTypes["BUILDING_JFD_TURKS"]
function JFD_Turks_TributeInBlood_CityCaptureComplete(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local player = Players[newOwnerID]
	local otherPlayer = Players[oldOwnerID]
	if otherPlayer:IsMinorCiv() then
		otherPlayer = player
	end
	if (not player:IsAlive()) then return end
	
	if (not HasTrait(player, traitTurksID)) then return end
	local city = Map.GetPlot(plotX, plotY):GetPlotCity()
	if (not city) then return end
	if city:IsHasBuilding(buildingTurksID) then return end
	
	local unitID = Player_GetStrongestMilitaryUnit(player, true, {"UNITCOMBAT_MELEE", "UNITCOMBAT_GUN"})
	if (not unitID) then return end
	local unitType = "UNIT_OTTOMAN_JANISSARY"
	local unitClass = GameInfo.Units[unitID].Class
	if unitClass ~= "UNITCLASS_MUSKETMAN" then 
		unitType = Player_GetUniqueUnit(otherPlayer, unitClass) 
	end
	if (not unitType) then return end
	
	unitID = GameInfoTypes[unitType]
	player:InitUnit(unitID, plotX, plotY)
	city:SetNumRealBuilding(buildingTurksID, 1)
end
GameEvents.CityCaptureComplete.Add(JFD_Turks_TributeInBlood_CityCaptureComplete)
------------------------------------------------------------------------------------------------------------------------
-- DECISIONS
------------------------------------------------------------------------------------------------------------------------
--JFD_Turks_Decisions_CityTrained
local buildingEnderunAcademyID = GameInfoTypes["BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY"]
local unitLancerID			   = GameInfoTypes["UNIT_LANCER"]
local unitSipahiID			   = GameInfoTypes["UNIT_OTTOMAN_SIPAHI"]
function JFD_Turks_Decisions_CityTrained(playerID, cityID, unitID)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if unit:GetUnitType() ~= unitLancerID then return end
	
	local city = player:GetCityByID(cityID)
	if (not city:IsHasBuilding(buildingEnderunAcademyID)) then return end
	
	local newUnit = player:InitUnit(unitSipahiID, unit:GetX(), unit:GetY())
	newUnit:Convert(unit)
end
GameEvents.CityTrained.Add(JFD_Turks_Decisions_CityTrained)
--==========================================================================================================================
--==========================================================================================================================