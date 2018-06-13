-- DMS_Venezuela_Functions
-- Author: DMS
--==========================================================================================================================
-- includes
--==========================================================================================================================
include("FLuaVector.lua")
include("PlotIterators.lua")
include("IconSupport")
--==========================================================================================================================
-- USER SETTINGS
--==========================================================================================================================
-- DMS_GetUserSetting (adapted from JFD's JFD_GetUserSetting - credit goes there!)
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetUserSetting(type)
	for row in GameInfo.DMS_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- Debug
----------------------------------------------------------------------------------------------------------------------------
local bPrintForDebug = DMS_GetUserSetting("DMS_VENEZUELA_DEBUGGING_ON") == 1

function DMS_Print(string)
	if (not bPrintForDebug) then
		return
	else
		return print(string)
	end
end
----------------------------------------------------------------------------------------------------------------------------
--IsCPDLL
----------------------------------------------------------------------------------------------------------------------------
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()
----------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
----------------------------------------------------------------------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
----------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SendNotification
----------------------------------------------------------------------------------------------------------------------------
function JFD_SendNotification(playerID, notificationType, description, descriptionShort, global, iX, iY)
	local player = Players[playerID]
	if global then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
	else
		if player:IsHuman() then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
--HasTrait
----------------------------------------------------------------------------------------------------------------------------
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
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID 									= Game.GetActivePlayer()
local activePlayer 										= Players[activePlayerID]
local activePlayerTeam 									= Teams[Game.GetActiveTeam()]
local civilisationVenezuelaID							= GameInfoTypes["CIVILIZATION_DMS_VENEZUELA"]
local isVenezuelaCivActive 								= JFD_IsCivilisationActive(civilisationVenezuelaID)
local isVenezuelaActivePlayer 							= activePlayer:GetCivilizationType() == civilisationVenezuelaID
-- unique components 
local traitBolivarianSocialismID						= GameInfoTypes["TRAIT_DMS_BOLIVARIAN_SOCIALISM"]
local buildingCommunalCouncilID							= GameInfoTypes["BUILDING_DMS_COMMUNAL_COUNCIL"]
local unitVeNilangalID									= GameInfoTypes["UNIT_DMS_VE_NILANGAL"]
-- dummy buildings
local buildingCommunalCouncilProductionID				= GameInfoTypes["BUILDING_DMS_COMMUNAL_COUNCIL_PRODUCTION"]
local buildingCommunalCouncilCounterID					= GameInfoTypes["BUILDING_DMS_COMMUNAL_COUNCIL_COUNTER"]

local missionRangedAttack								= GameInfoTypes["MISSION_RANGE_ATTACK"]
local mathCeil = math.ceil
local mathFloor = math.floor
local convertTextKey = Locale.ConvertTextKey

if isVenezuelaCivActive then
	print("President Hugo Chávez of Venezuela joins the game!")
end
--==========================================================================================================================
-- MAIN FUNCTIONS	
--==========================================================================================================================
-- DMS_BolivarianSocialism_PlayerDoTurn
----------------------------------------------------------------------------------------------------------------------------
function DMS_BolivarianSocialism_PlayerDoTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitBolivarianSocialismID) then
		local iNumDenouncedCivs = 0
		DMS_Print("DMS_BolivarianSocialism_PlayerDoTurn: iterating foreign civs..")
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i and i ~= iPlayer then
				local pOtherPlayer = Players[i]
				if pOtherPlayer and pOtherPlayer:IsEverAlive() then
					if pPlayer:IsDenouncedPlayer(i) then
						DMS_Print("DMS_BolivarianSocialism_PlayerDoTurn: " .. pPlayer:GetCivilizationShortDescription() .. " is denouncing " .. pOtherPlayer:GetCivilizationShortDescription() .. "..")
						iNumDenouncedCivs = iNumDenouncedCivs + 1
					end
				end
			end
		end
		DMS_Print("DMS_BolivarianSocialism_PlayerDoTurn: iNumDenouncedCivs = " .. iNumDenouncedCivs .. "..")
		if iNumDenouncedCivs > 0 then
			local iMaintenanceCost = pPlayer:CalculateUnitCost()
			DMS_Print("DMS_BolivarianSocialism_PlayerDoTurn: iMaintenanceCost = " .. iMaintenanceCost .. "..")
			local iCultureBonus = mathFloor(iNumDenouncedCivs^(1.5) + 1/(iMaintenanceCost^(-0.6)))
			DMS_Print("DMS_BolivarianSocialism_PlayerDoTurn: iCultureBonus = " .. iCultureBonus .. "..")
			pPlayer:ChangeJONSCulture(iCultureBonus)

			if pPlayer:IsHuman() then
				Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]+" .. iCultureBonus .. " [ICON_CULTURE] Culture[ENDCOLOR] from having denounced " .. iNumDenouncedCivs .. " Civilizations and having a Unit maintenance cost of " .. iMaintenanceCost .. "!");
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(DMS_BolivarianSocialism_PlayerDoTurn)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_VeNilangal_CultureUnderProduction
----------------------------------------------------------------------------------------------------------------------------
function DMS_VeNilangal_CultureUnderProduction(iPlayer)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitBolivarianSocialismID) then
		DMS_Print("DMS_VeNilangal_CultureUnderProduction: initializing. iterate cities..")
		for pCity in pPlayer:Cities() do
			DMS_Print("DMS_VeNilangal_CultureUnderProduction: pCity = " .. pCity:GetName() .. "..")
			if pCity:IsProductionUnit() then
				DMS_Print("DMS_VeNilangal_CultureUnderProduction: " .. pCity:GetName() .. " is producing a unit..")
				--local tUnitInfo = GameInfo.Units{ID=pCity:GetProductionUnit()}()
				local iType = pCity:GetProductionUnit()
				if iType == unitVeNilangalID then
					--local tUnitInfo = GameInfo.Units[iType]
					DMS_Print("DMS_VeNilangal_CultureUnderProduction: unit is UU..")
					local iCultureBonus = 5
					DMS_Print("DMS_VeNilangal_CultureUnderProduction: iCultureBonus = " .. iCultureBonus .. "..")
					pPlayer:ChangeJONSCulture(iCultureBonus)
					Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pCity:GetX(), pCity:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iCultureBonus .. "[ENDCOLOR] [ICON_CULTURE] Culture", 0)
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(DMS_VeNilangal_CultureUnderProduction)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_VeNilangal_DoubleOnFinish
----------------------------------------------------------------------------------------------------------------------------
function DMS_VeNilangal_DoubleOnFinish(iPlayer, iCity, iUnit, bGold, bFaithOrCulture)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitBolivarianSocialismID) then
		local pCity = pPlayer:GetCityByID(iCity)
		if pCity then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit then
				DMS_Print("DMS_VeNilangal_DoubleOnFinish: unit produced in " .. pCity:GetName() .. "..")
				if pUnit:GetUnitType() == unitVeNilangalID then
					DMS_Print("DMS_VeNilangal_DoubleOnFinish: unit is UU..")
					local pNewUnit = pPlayer:InitUnit(unitVeNilangalID, pCity:GetX(), pCity:GetY())
					DMS_Print("DMS_VeNilangal_DoubleOnFinish: init new unit ..")
					pNewUnit:JumpToNearestValidPlot()
				end
			end
		end
	end
end

GameEvents.CityTrained.Add(DMS_VeNilangal_DoubleOnFinish)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_VeNilangal_AutoRangedAttack
----------------------------------------------------------------------------------------------------------------------------
function DMS_VeNilangal_AutoRangedAttack(iPlayer, iUnit, iX, iY)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitType() == unitVeNilangalID then
		DMS_Print("DMS_VeNilangal_AutoRangedAttack: initializing..")
		if (not pUnit:IsEmbarked()) then
			if pUnit:GetMoves() <= 0 then
			DMS_Print("DMS_VeNilangal_AutoRangedAttack: Unit depleted moves..")
				local pPlot = Map.GetPlot(iX, iY)
				if pPlot then
					DMS_Print("DMS_VeNilangal_AutoRangedAttack: on plot (" .. pPlot:GetX() .. "," .. pPlot:GetY() .. ")..")
					local tPossibleTargets = {}
					DMS_Print("DMS_VeNilangal_AutoRangedAttack: scan for targets..")
					for nearbyPlot in PlotAreaSweepIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						local pEnemy = nearbyPlot:GetUnit()
						DMS_Print("DMS_VeNilangal_AutoRangedAttack: found unit on plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ")..")
						if pEnemy and Teams[pPlayer:GetTeam()]:IsAtWar(pEnemy:GetTeam()) then
							DMS_Print("DMS_VeNilangal_AutoRangedAttack: unit is a target..")
							--if pUnit:CanStartMission(missionRangedAttack, nearbyPlot:GetX(), nearbyPlot:GetY()) then
								--DMS_Print("DMS_VeNilangal_AutoRangedAttack: Can Start Range Attack..")
								table.insert(tPossibleTargets, nearbyPlot)
								DMS_Print("DMS_VeNilangal_AutoRangedAttack: add to table..")
							--end
						else
							DMS_Print("DMS_VeNilangal_AutoRangedAttack: unit is not a target..")
						end
					end
					if #tPossibleTargets > 0 then
						DMS_Print("DMS_VeNilangal_AutoRangedAttack: num targets > 0..")
						local pChosenPlot = tPossibleTargets[JFD_GetRandom(1, #tPossibleTargets)]
						DMS_Print("DMS_VeNilangal_AutoRangedAttack: target on plot (" .. pChosenPlot:GetX() .. "," .. pChosenPlot:GetY() .. ") chosen..")
						--pUnit:PushMission(missionRangedAttack, pChosenPlot:GetX(), pChosenPlot:GetY())
						--DMS_Print("DMS_VeNilangal_AutoRangedAttack: ranged attack pushed..")
						local iNumTileUnits = pPlot:GetNumUnits()
						for i = 0, iNumTileUnits do
							local ChosenUnit = pChosenPlot:GetUnit(i)
							if ChosenUnit and ChosenUnit > 0 then
								ChosenUnit:ChangeDamage(20)

								if pPlayer:IsHuman() then
									Events.GameplayAlertMessage("Your Tortuga Unit performed a ranged attack on an enemy Unit!");
								end
							end
						end
					end
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(DMS_VeNilangal_AutoRangedAttack)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_CommunalCouncil_PlayerAdoptPolicy
----------------------------------------------------------------------------------------------------------------------------
function DMS_CommunalCouncil_PlayerAdoptPolicy(iPlayer, ePolicy)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitBolivarianSocialismID) then
		for pCity in pPlayer:Cities() do
			DMS_Print("DMS_CommunalCouncil_PlayerAdoptPolicy: checking city " .. pCity:GetName() .. "..")
			if pCity:IsHasBuilding(buildingCommunalCouncilID) then
				DMS_Print("DMS_CommunalCouncil_PlayerAdoptPolicy: " .. pCity:GetName() .. " has UB..")
				local iNumCurrentCounter = pCity:GetNumRealBuilding(buildingCommunalCouncilCounterID)
				DMS_Print("DMS_CommunalCouncil_PlayerAdoptPolicy: adding 10 counter buildings to existent number (" .. iNumCurrentCounter .. "); total = " .. iNumCurrentCounter + 10 .. "..")
				pCity:SetNumRealBuilding(buildingCommunalCouncilCounterID, iNumCurrentCounter + 10)
			end
		end
	end
end

GameEvents.PlayerAdoptPolicy.Add(DMS_CommunalCouncil_PlayerAdoptPolicy)
GameEvents.PlayerAdoptPolicyBranch.Add(DMS_CommunalCouncil_PlayerAdoptPolicy)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_CommunalCouncil_PlayerDoTurn
----------------------------------------------------------------------------------------------------------------------------
function DMS_CommunalCouncil_PlayerDoTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitBolivarianSocialismID) then
		for pCity in pPlayer:Cities() do
			DMS_Print("DMS_CommunalCouncil_PlayerDoTurn: checking city " .. pCity:GetName() .. "..")
			if pCity:IsHasBuilding(buildingCommunalCouncilID) then
				DMS_Print("DMS_CommunalCouncil_PlayerDoTurn: " .. pCity:GetName() .. " has UB..")
				local iNumCurrentCounter = pCity:GetNumRealBuilding(buildingCommunalCouncilCounterID)
				if iNumCurrentCounter > 0 then
					local iCityCulture = pCity:GetJONSCulturePerTurn()
					if iCityCulture > 0 then
						DMS_Print("DMS_CommunalCouncil_PlayerDoTurn: iCityCulture = " .. iCityCulture .. "..")
						if iCityCulture > 20 then
							iCityCulture = 20 + math.ceil(iCityCulture/8)
						end
						pCity:ChangeProduction(iCityCulture)
						DMS_Print("DMS_CommunalCouncil_PlayerDoTurn: production added..")
						Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pCity:GetX(), pCity:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iCityCulture .. "[ENDCOLOR] [ICON_PRODUCTION] Production", 0)
					end
					pCity:SetNumRealBuilding(buildingCommunalCouncilCounterID, iNumCurrentCounter - 1)
				else
					pCity:SetNumRealBuilding(buildingCommunalCouncilProductionID, 0)
					pCity:SetNumRealBuilding(buildingCommunalCouncilCounterID, 0)
				end
			else
				if pCity:IsHasBuilding(buildingCommunalCouncilCounterID) then
					pCity:SetNumRealBuilding(buildingCommunalCouncilCounterID, 0)
					DMS_Print("DMS_CommunalCouncil_PlayerDoTurn: rogue counter building, removed..")
				end
				if pCity:IsHasBuilding(buildingCommunalCouncilProductionID) then
					pCity:SetNumRealBuilding(buildingCommunalCouncilProductionID, 0)
					DMS_Print("DMS_CommunalCouncil_PlayerDoTurn: rogue dummy building, removed..")
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(DMS_CommunalCouncil_PlayerDoTurn)
--==========================================================================================================================
--==========================================================================================================================