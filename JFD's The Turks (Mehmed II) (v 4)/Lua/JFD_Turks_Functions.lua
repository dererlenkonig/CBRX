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
--IsCPDLL
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()

--HasTrait
function HasTrait(player, traitID)
	if isCPDLL then 
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
--GetStrongestMilitaryUnit (Sukritact)
function GetStrongestMilitaryUnit(pPlayer, bIgnoreResources, ...)
	local tUnit = {["ID"] = GameInfoTypes.UNIT_WARRIOR, ["Combat"] = 0}
	for iKey, sCombatType in pairs(arg) do
		for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
			if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
				tUnit = row
			end
		end
	end
	return tUnit.ID
end

--JFD_GetUniqueUnit (Whoward)
function JFD_GetUniqueUnit(player, unitClass)
	if isCPDLL then 
		return player:GetGetSpecificUnitType(unitClass) 
	else
		local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
		for uniqueUnit in GameInfo.Civilization_UnitClassOverrides{CivilizationType = civType, UnitClassType = unitClass} do
			return uniqueUnit.UnitType
		end
		return GameInfo.UnitClasses[unitClass].DefaultUnit
	end
end
--=======================================================================================================================
-- USER SETTINGS
--=======================================================================================================================
--JFD_GetUserSetting
function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local traitTurksID = GameInfoTypes["TRAIT_JFD_TURKS"]
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- TRIBUTE IN BLOOD
----------------------------------------------------------------------------------------------------------------------------
--JFD_Turks_TributeInBlood_LoadScreenClose
function JFD_Turks_TributeInBlood_LoadScreenClose()
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if player:IsAlive() then
			local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
			for row in GameInfo.Civilization_FreePolicies("CivilizationType = '" .. civType .. "'") do
				local policyID = GameInfoTypes[row.PolicyType]
				if (not player:HasPolicy(policyID)) then
					player:SetNumFreePolicies(1)
					player:SetNumFreePolicies(0)
					player:SetHasPolicy(policyID, true)
				end
			end
		end
	end
end
Events.LoadScreenClose.Add(JFD_Turks_TributeInBlood_LoadScreenClose)

--JFD_Turks_TributeInBlood_CityCaptureComplete
local buildingTurksID = GameInfoTypes["BUILDING_JFD_TURKS"]
function JFD_Turks_TributeInBlood_CityCaptureComplete(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local player = Players[newOwnerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitTurksID)) then return end
	local city = Map.GetPlot(plotX, plotY):GetPlotCity()
	if (not city) then return end
	if city:IsHasBuilding(buildingTurksID) then return end
	local otherPlayer = Players[oldOwnerID]
	local unitID = GetStrongestMilitaryUnit(player, true, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
	if (not unitID) then return end
	local unitType = "UNIT_OTTOMAN_JANISSARY"
	local unitClass = GameInfo.Units[unitID].Class
	if unitClass ~= "UNITCLASS_MUSKETMAN" then unitType = JFD_GetUniqueUnit(otherPlayer, unitClass) end
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
local buildingEnderunAcademyID  = GameInfoTypes["BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY"]
function JFD_Turks_Decisions_CityTrained(playerID, cityID, unitID)
	local player = Players[playerID]
	local city = player:GetCityByID(cityID)
	if city:IsHasBuilding(buildingEnderunAcademyID) then
		local unit = player:GetUnitByID(unitID)
		if unit:GetUnitType() == unitLancerID then
			local newUnit = player:InitUnit(unitSipahiID, unit:GetX(), unit:GetY())
			newUnit:Convert(unit)
		end
	end
end
GameEvents.CityTrained.Add(JFD_Turks_Decisions_CityTrained)
--==========================================================================================================================
--==========================================================================================================================