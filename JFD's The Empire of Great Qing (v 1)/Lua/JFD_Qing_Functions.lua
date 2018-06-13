-- JFD_Qing_Functions
-- Author: JFD
-- DateCreated: 2/21/2014 12:13:46 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("FLuaVector.lua")
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
-- DIPLOMACY
----------------------------------------------------------------------------------------------------------------------------
local civilizationGreatBritainID = GameInfoTypes["CIVILIZATION_JFD_GREAT_BRITAIN"]
--JFD_Qing_SequenceGameInitComplete
function JFD_Qing_SequenceGameInitComplete()
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
        local player = Players[playerID]
		local civilizationID = player:GetCivilizationType()
		if civilizationID == civilizationGreatBritainID then
			ChangeDiplomacyResponse("LEADER_JFD_CIXI", "RESPONSE_FIRST_GREETING",   "TXT_KEY_LEADER_JFD_CIXI_FIRSTGREETING%",	"TXT_KEY_LEADER_JFD_CIXI_VICTORIA_FIRSTGREETING_1",	500)
			ChangeDiplomacyResponse("LEADER_JFD_CIXI", "RESPONSE_DEFEAT",			"TXT_KEY_LEADER_JFD_CIXI_DEFEATED%",		"TXT_KEY_LEADER_JFD_CIXI_VICTORIA_DEFEATED_1",		500)
			break
		end
	end
end
Events.SequenceGameInitComplete.Add(JFD_Qing_SequenceGameInitComplete)
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBAL
----------------------------------------------------------------------------------------------------------------------------
local mathMin     = math.min

local traitQingID 			 = GameInfoTypes["TRAIT_JFD_QING"]
local unitPekingFieldForceID = GameInfoTypes["UNIT_JFD_PEKING_FORCE"]
----------------------------------------------------------------------------------------------------------------------------
-- NEW POLICIES
----------------------------------------------------------------------------------------------------------------------------
--JFD_GreatQing_NewPolicies_PlayerAdoptPolicy
local promotionedPekingForceID = GameInfoTypes["PROMOTION_JFD_PEKING_FORCE"]
function JFD_GreatQing_NewPolicies_PlayerAdoptPolicy(playerID, unitID, promotionID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitQingID)) then return end
	for unit in player:Units() do
		local upgradeUnitID = unit:GetUpgradeUnitType()
		if player:CanTrain(upgradeUnitID, true, true, true, false) then
			local newUnit = player:InitUnit(upgradeUnitID, unit:GetX(), unit:GetY())
			newUnit:Convert(unit)
			if upgradeUnitID == unitPekingFieldForceID then
				newUnit:SetHasPromotion(promotionedPekingForceID, true)
			end
		end
	end
end
GameEvents.PlayerAdoptPolicy.Add(JFD_GreatQing_NewPolicies_PlayerAdoptPolicy)
GameEvents.PlayerAdoptPolicyBranch.Add(JFD_GreatQing_NewPolicies_PlayerAdoptPolicy)

--JFD_GreatQing_NewPolicies_UnitPromoted
function JFD_GreatQing_NewPolicies_UnitPromoted(playerID, unitID, plotX, plotY)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitQingID)) then return end
	local unit = player:GetUnitByID(unitID)
	local rewardCulture = (unit:GetLevel()*6)
	player:ChangeJONSCulture(rewardCulture)
	if player:IsHuman() then
		local hex = ToHexFromGrid(Vector2(plotX, plotY))
		Events.AddPopupTextEvent(HexToWorld(hex), Locale.ConvertTextKey("[COLOR_POSITIVE_TEXT]+{1_Num}[ENDCOLOR] [ICON_CULTURE]", rewardCulture), true)
		Events.GameplayFX(hex.x, hex.y, -1)
	end
end
GameEvents.UnitPromoted.Add(JFD_GreatQing_NewPolicies_UnitPromoted)
----------------------------------------------------------------------------------------------------------------------------
-- NAVAL WAR COLLEGE
----------------------------------------------------------------------------------------------------------------------------	
--JFD_GreatQing_NavalWarCollege_CityTrained
local buildingNavalCollegeID = GameInfoTypes["BUILDING_JFD_NAVAL_COLLEGE"]
local domainSeaID 			 = GameInfoTypes["DOMAIN_SEA"]
function JFD_GreatQing_PekingFieldForce_CityTrained(playerID, cityID, unitID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitQingID)) then return end
	local city = player:GetCityByID(cityID)
	if (not city:IsHasBuilding(buildingNavalCollegeID)) then return end
	local unit = player:GetUnitByID(unitID)
	if (not unit:IsCombatUnit()) then return end
	if unit:GetDomainType() ~= domainSeaID then return end
	local numXP = city:GetDomainFreeExperience(domainSeaID)
	unit:ChangeExperience(numXP)
end 
GameEvents.CityTrained.Add(JFD_GreatQing_NavalWarCollege_CityTrained)
----------------------------------------------------------------------------------------------------------------------------
-- PEKING FIELD FORCE
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GreatQing_PekingFieldForce_PlayerDoTurn
local buildingGreatQingID = GameInfoTypes["BUILDING_JFD_QING"]
function JFD_GreatQing_PekingFieldForce_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitQingID)) then return end
	local capital = player:GetCapitalCity()
	if (not capital:IsHasBuilding(buildingGreatQingID)) then
		capital:SetNumRealBuilding(buildingGreatQingID, 1)
	end
end
GameEvents.PlayerDoTurn.Add(JFD_GreatQing_PekingFieldForce_PlayerDoTurn)
GameEvents.PlayerCityFounded.Add(JFD_GreatQing_PekingFieldForce_PlayerDoTurn)

--JFD_GreatQing_PekingFieldForce_UnitUpgraded
function JFD_GreatQing_PekingFieldForce_UnitUpgraded(playerID, unitID, newUnitID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitQingID)) then return end
	local unit = player:GetUnitByID(unitID)
	local newUnit = player:GetUnitByID(newUnitID)
	if newUnit:GetUnitType() ~= unitPekingFieldForceID then return end
	newUnit:SetHasPromotion(promotionedPekingForceID, true)
end
GameEvents.UnitUpgraded.Add(JFD_GreatQing_PekingFieldForce_UnitUpgraded)
--==========================================================================================================================
--==========================================================================================================================	






