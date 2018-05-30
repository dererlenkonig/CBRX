-- JFD_Prussia_Functions
-- Author: JFD
-- DateCreated: 5/4/2014 12:54:31 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
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
----------------------------------------------------------------------------------------------------------------------------
-- MATHS
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBAL
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID         = Game.GetActivePlayer()
local activePlayer	         = Players[activePlayerID]
local mathCeil		         = math.ceil

local traitPrussiaID         = GameInfoTypes["TRAIT_JFD_PRUSSIA"]
----------------------------------------------------------------------------------------------------------------------------
-- KONIGRATZER MARCH
----------------------------------------------------------------------------------------------------------------------------
--JFD_Prussia_KonigratzerMarch_CityTrained
function JFD_Prussia_KonigratzerMarch_CityTrained(playerID, cityID, unitID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitPrussiaID)) then return end
	local city = player:GetCityByID(cityID)
	local unit = player:GetUnitByID(unitID)
	if (not unit:IsCombatUnit()) then return end
	local unitDomainID = unit:GetDomainType()
	local extraXP = 0
	for row in GameInfo.Building_DomainFreeExperiences() do
		if (city:IsHasBuilding(GameInfoTypes[row.BuildingType]) and unitDomainID == GameInfoTypes[row.DomainType]) then
			extraXP = extraXP + row.Experience
		end 
	end
	extraXP = mathCeil(extraXP*0.5)
	if extraXP > 0 then unit:ChangeExperience(extraXP) end
end
GameEvents.CityTrained.Add(JFD_Prussia_KonigratzerMarch_CityTrained)

--JFD_Prussia_KonigratzerMarch_UnitPromoted
local promotionVeteran = {}
	promotionVeteran[1]		= GameInfoTypes["PROMOTION_JFD_PRUSSIAN_VETERAN_1"]
	promotionVeteran[2]		= GameInfoTypes["PROMOTION_JFD_PRUSSIAN_VETERAN_1"]
	promotionVeteran[3]		= GameInfoTypes["PROMOTION_JFD_PRUSSIAN_VETERAN_2"]
	promotionVeteran[6]		= GameInfoTypes["PROMOTION_JFD_PRUSSIAN_VETERAN_3"]
	promotionVeteran[8]		= GameInfoTypes["PROMOTION_JFD_PRUSSIAN_VETERAN_4"]
	promotionVeteran[10]	= GameInfoTypes["PROMOTION_JFD_PRUSSIAN_VETERAN_5"]
local unitCombatGunID		= GameInfoTypes["UNITCOMBAT_GUN"]
local unitCombatMeleeID		= GameInfoTypes["UNITCOMBAT_MELEE"]
local unitCombatMountedID	= GameInfoTypes["UNITCOMBAT_MOUNTED"]
function JFD_Prussia_KonigratzerMarch_UnitPromoted(playerID, unitID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitPrussiaID)) then return end
	local unit = player:GetUnitByID(unitID)
	local unitCombatType = unit:GetUnitCombatType()
	if (unitCombatType == unitCombatGunID or unitCombatType == unitCombatMeleeID or unitCombatType == unitCombatMountedID) then
		local unitLevel = unit:GetLevel()
		if unitLevel >= 10 then return end
		local promotionVeteranID = promotionVeteran[unitLevel]
		if (not promotionVeteranID) then return end
		if (not unit:IsHasPromotion(promotionVeteranID)) then
			unit:SetHasPromotion(promotionVeteranID, true)
		end
	end
end
GameEvents.UnitPromoted.Add(JFD_Prussia_KonigratzerMarch_UnitPromoted)
----------------------------------------------------------------------------------------------------------------------------
-- LANDWEHR
----------------------------------------------------------------------------------------------------------------------------
--JFD_Prussia_Landwehr_PlayerDoTurn
local unitLandwehrID = GameInfoTypes["UNIT_JFD_LANDWEHR"]
local unitPromotionLandwehrID = GameInfoTypes["PROMOTION_JFD_LANDWEHR"]
local unitPromotionLandwehrAdjID = GameInfoTypes["PROMOTION_JFD_LANDWEHR_DOUBLE"]
function JFD_Prussia_Landwehr_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	if player:IsMinorCiv() then return end
	for unit in player:Units() do
		local isAdjacentLandwehr = false
		if unit:GetUnitType() == unitLandwehrID then
			if isCPDLL then
				isAdjacentLandwehr = unit:IsAdjacentToUnit(unitLandwehrID, true, false)
			else
				local unitPlot = unit:GetPlot()
				for adjacentPlot in PlotAreaSweepIterator(unitPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					isAdjacentLandwehr = (adjacentPlot:GetUnit() and adjacentPlot:GetUnit():GetUnitType() == unitLandwehrID)
					if isAdjacentLandwehr then break end
				end
			end
			if isAdjacentLandwehr then
				if (not unit:IsHasPromotion(unitPromotionLandwehrAdjID)) then
					unit:SetHasPromotion(unitPromotionLandwehrID, false)
					unit:SetHasPromotion(unitPromotionLandwehrAdjID, true)
				end
			else
				if unit:IsHasPromotion(unitPromotionLandwehrAdjID) then
					unit:SetHasPromotion(unitPromotionLandwehrID, true)
					unit:SetHasPromotion(unitPromotionLandwehrAdjID, false)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_Prussia_Landwehr_PlayerDoTurn)
----------------------------------------------------------------------------------------------------------------------------
-- DEATH'S HEAD
----------------------------------------------------------------------------------------------------------------------------
--JFD_Prussia_DeathsHead_UnitSetXY
local direction_types = {
	DirectionTypes["DIRECTION_NORTHEAST"],
	DirectionTypes["DIRECTION_NORTHWEST"],
	DirectionTypes["DIRECTION_EAST"],
	DirectionTypes["DIRECTION_SOUTHEAST"],
	DirectionTypes["DIRECTION_SOUTHWEST"],
	DirectionTypes["DIRECTION_WEST"],}
local unitDeathsHeadHussarID = GameInfoTypes["UNIT_JFD_DEATHS_HEAD"]
function JFD_Prussia_DeathsHead_UnitSetXY(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	local unit = player:GetUnitByID(unitID)
	local unitPlot = unit:GetPlot()
	if (not unitPlot) then return end
	if unit:GetUnitType() ~= unitDeathsHeadHussarID then return end
	local playerTeam = Teams[player:GetTeam()]
	for adjacentPlot in PlotAreaSweepIterator(unitPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		local adjacentUnit = adjacentPlot:GetUnit()
		if (adjacentUnit and adjacentUnit:IsCombatUnit() and adjacentUnit:GetOwner() > -1) then
			if playerTeam:IsAtWar(adjacentUnit:GetOwner()) then	
				if JFD_GetRandom(1,100) <= 50 then
					adjacentUnit:ChangeDamage(5, playerID)
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(JFD_Prussia_DeathsHead_UnitSetXY) 
--=======================================================================================================================
--=======================================================================================================================
