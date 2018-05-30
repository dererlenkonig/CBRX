-- JFD_FlandersFunctions
-- Author: JFD
-- DateCreated: 3/12/2014 9:35:16 PM
--=======================================================================================================================
-- INCLUDES
--=======================================================================================================================
include("FLuaVector.lua")
include("JFD_Muscovy_DTP.lua")
include("PlotIterators")
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
local mathMin		 = math.min
local traitMuscovyID = GameInfoTypes["TRAIT_JFD_MUSCOVY"]
--------------------------------------------------------------------------------------------------------------------------
-- TSAR OF ALL THE RUSSIAS
--------------------------------------------------------------------------------------------------------------------------
--JFD_Moscovy_TsarOfAllTheRussias_CityCaptureComplete
local buildingMuscovyID = GameInfoTypes["BUILDING_JFD_MUSCOVY"]
function JFD_Moscovy_TsarOfAllTheRussias_CityCaptureComplete(oldOwnerID, isCapital, plotX, plotY, newOwnerID, isConquest, isConquest)
	if (not isConquest) then return end
	local player = Players[newOwnerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitMuscovyID)) then return end
	local plot = Map.GetPlot(plotX, plotY)
	local city = plot:GetPlotCity()
	if (not city) then return end
	if city:IsHasBuilding(buildingMuscovyID) then return end
	for unit in player:Units() do
		unit:ChangeDamage(-20)
	end
	local otherPlayer = Players[oldOwnerID]
	for city in otherPlayer:Cities() do
		local damage = ((city:GetMaxHitPoints()*25)/100)
		city:ChangeDamage(damage)
    end
	city:SetNumRealBuilding(buildingMuscovyID, 1)
end
GameEvents.CityCaptureComplete.Add(JFD_Moscovy_TsarOfAllTheRussias_CityCaptureComplete)

--JFD_Moscovy_TsarOfAllTheRussias_PlayerDoTurn
function JFD_Moscovy_TsarOfAllTheRussias_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitMuscovyID)) then return end
	local rewardGoldenAgePoints = JFD_Muscovy_GetGoldenAgePointsFromRazing(playerID)
	player:ChangeGoldenAgeProgressMeter(rewardGoldenAgePoints)
end
GameEvents.PlayerDoTurn.Add(JFD_Moscovy_TsarOfAllTheRussias_PlayerDoTurn)
--------------------------------------------------------------------------------------------------------------------------
-- SOBOR
--------------------------------------------------------------------------------------------------------------------------
--JFD_Moscovy_Sobor_PlayerDoTurn
local buildingSoborID			= GameInfoTypes["BUILDING_JFD_SOBOR"]
local buildingSoborCourthouseID	= GameInfoTypes["BUILDING_JFD_SOBOR_COURTHOUSE"]
local buildingSoborExpansionID	= GameInfoTypes["BUILDING_JFD_SOBOR_FAITH"]
function JFD_Moscovy_Sobor_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitMuscovyID)) then return end
	for city in player:Cities() do
		if city:IsHasBuilding(buildingSoborID) then
			city:SetNumRealBuilding(buildingSoborExpansionID, mathMin(city:GetFaithPerTurn(),30)) 
			if city:IsOccupied() then
				if (not city:IsHasBuilding(buildingSoborCourthouseID)) then
					city:SetNumRealBuilding(buildingSoborCourthouseID, 1)
				end
			else
				if city:IsHasBuilding(buildingSoborCourthouseID) then
					city:SetNumRealBuilding(buildingSoborCourthouseID, 0)
				end
			end
		else
			if city:IsHasBuilding(buildingSoborExpansionID) then
				city:SetNumRealBuilding(buildingSoborExpansionID, 0)
			end
			if city:IsHasBuilding(buildingSoborCourthouseID) then
				city:SetNumRealBuilding(buildingSoborCourthouseID, 0)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_Moscovy_Sobor_PlayerDoTurn)
--------------------------------------------------------------------------------------------------------------------------
-- STRELTSY
--------------------------------------------------------------------------------------------------------------------------
--JFD_Muscovy_Streltsy_PlayerDoTurn
local unitPromotionStreltsyID		= GameInfoTypes["PROMOTION_JFD_STRELTSY"]
local unitPromotionStreltsyActiveID	= GameInfoTypes["PROMOTION_JFD_STRELTSY_ACTIVE"]
function JFD_Muscovy_Streltsy_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	for unit in player:Units() do
		if (unit:IsHasPromotion(unitPromotionStreltsyID) or unit:IsHasPromotion(unitPromotionStreltsyActiveID)) then
			local isValidPromotion = false
			local unitPlot = unit:GetPlot()
			if isUsingCPDLL then
				isValidPromotion = (unit:IsAdjacentToUnitPromotion(unitPromotionStreltsyActiveID, true, false) or unit:IsAdjacentToUnitPromotion(unitPromotionStreltsyID, true, false))
			else
				for adjacentPlot in PlotAreaSweepIterator(unitPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					isValidPromotion = (adjacentPlot:GetUnit() and (adjacentPlot:GetUnit():IsHasPromotion(unitPromotionStreltsyActiveID) or adjacentPlot:GetUnit():IsHasPromotion(unitPromotionStreltsyID)))
					if isValidPromotion then break end
				end
			end
			if isValidPromotion then
				if (not unit:IsHasPromotion(unitPromotionStreltsyActiveID)) then
					unit:SetHasPromotion(unitPromotionStreltsyActiveID, true)
					unit:SetHasPromotion(unitPromotionStreltsyID, false)
				end
			else
				if unit:IsHasPromotion(unitPromotionStreltsyActiveID) then
					unit:SetHasPromotion(unitPromotionStreltsyActiveID, false)
					unit:SetHasPromotion(unitPromotionStreltsyID, true)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_Muscovy_Streltsy_PlayerDoTurn)
--==========================================================================================================================
--==========================================================================================================================