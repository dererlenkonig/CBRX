-- C15_Iroquois_Lua
-- Author: Chrisy15
-- DateCreated: 12/3/2017 2:47:00 PM
--------------------------------------------------------------

include("C15_Iroquois_Utils.lua")
include("EventsAndDecisions_Utilities.lua")

local iPeaceCombat = GameInfoTypes["PROMOTION_C15_IROQUOIS_GREAT_LAW_PEACE_COMBAT"]
local iSenecaPromotion = GameInfoTypes["PROMOTION_C15_IROQUOIS_NATION_SENECA_COMBAT"]
local iMohawkXP = GameInfoTypes["BUILDING_C15_IROQUOIS_MOHAWK_XP"]
local iOneidaDef = GameInfoTypes["BUILDING_C15_IROQUOIS_ONEIDA_DEF"]
local iCayugaTrade = GameInfoTypes["BUILDING_C15_IROQUOIS_CAYUGA_TRADE"]

local iLonghouse = GameInfoTypes["BUILDING_LONGHOUSE"]
local iGreatPeaceTrait = GameInfoTypes["TRAIT_C15_IROQUOIS"]
local iCamp = GameInfoTypes["IMPROVEMENT_CAMP"]
local iFurs = GameInfoTypes["RESOURCE_FUR"]
local iDummyPolicy = GameInfoTypes["POLICY_C15_IROQUOIS_MOHAWK_BLOCK"]

local tNations = C15_GetNations()

local sMohawk 	= "NATION_C15_MOHAWK"
local sOnondaga = "NATION_C15_ONONDAGA"
local sOneida	= "NATION_C15_ONEIDA"
local sCayuga	= "NATION_C15_CAYUGA"
local sSeneca 	= "NATION_C15_SENECA"
local sTusco  	= "NATION_C15_TUSCO"

local iWLTKDTurns = math.ceil(GameDefines.CITY_RESOURCE_WLTKD_TURNS / 4)

local tDefensiveBuildings = {}
for row in DB.Query("SELECT ID FROM Buildings WHERE Defense > 0 AND ExtraCityHitPoints > 0") do
	tDefensiveBuildings[row.ID] = true
end

local bSov = JFD_GetUserSetting("JFD_RTP_SOVEREIGNTY_CORE") == 1
local bLoyalty = JFD_GetUserSetting("JFD_CID_LOYALTY_CORE") == 1

function C15_Iroquois_DummyPolicy(playerID)	
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if (HasTrait(player, iGreatPeaceTrait) and player:IsEverAlive()) then
			if not player:HasPolicy(iDummyPolicy) then
				if Player.GrantPolicy then
					player:GrantPolicy(iDummyPolicy, true)
				else
					player:SetNumFreePolicies(1)
					player:SetNumFreePolicies(0)
					player:SetHasPolicy(iDummyPolicy, true)
				end
			end
		end
	end
end

Events.LoadScreenClose.Add(C15_Iroquois_DummyPolicy)

function C15_Iroquois_CityFounded(playerID, iX, iY)
	local pPlayer = Players[playerID]
	if HasTrait(pPlayer, iGreatPeaceTrait) then
		local pPlot = Map.GetPlot(iX, iY)
		local pCity = pPlot:GetPlotCity()
		local sName
		if pCity:IsCapital() then
			sName = Locale.ConvertTextKey("TXT_KEY_IROQ_CITY_NAME_ONONDAGA")
			for pUnit in pPlayer:Units() do
				if pUnit:IsCombatUnit() then
					pUnit:SetHasPromotion(tNations[sOnondaga].PromotionType, true)
				end
			end
		else
			sName = C15_GetRandomCityName(pCity)
		end
		if sName then
			pCity:SetName(sName)
		else
			sName = pCity:GetName()
		end
		local sNation = C15_GetCityNation(pCity, true, sName)
		if sNation then
			C15_SetCityNation(pCity, sNation)
		end
	end
end

GameEvents.PlayerCityFounded.Add(C15_Iroquois_CityFounded)

function C15_Iroquois_AdjUnitCombat(playerID)
	local pPlayer = Players[playerID]
	if HasTrait(pPlayer, iGreatPeaceTrait) then
		for pUnit in pPlayer:Units() do
			local sNation = C15_GetUnitNation(pUnit)
			if sNation then
				local bGive = false
				if Unit.IsAdjacentToUnitPromotion then
					for k, v in pairs(tNations) do
						if pUnit:IsAdjacentToUnitPromotion(v.PromotionType) and k ~= sNation then
							bGive = true
							pUnit:SetHasPromotion(iPeaceCombat, true)
							break
						end
					end
				else
					for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
						local pAdjacentPlot = Map.PlotDirection(pUnit:GetX(), pUnit:GetY(), direction)
						if pAdjacentPlot and pAdjacentPlot:IsUnit() then
							for i = 0, pAdjacentPlot:GetNumUnits() - 1 do
								local pAdjUnit = pAdjacentPlot:GetUnit(i)
								if pAdjUnit:IsCombatUnit() and pAdjUnit:GetOwner() == playerID then
									local sAdjNation = C15_GetUnitNation(pAdjUnit)
									if sAdjNation and sNation ~= sAdjNation then
										if not bGive then
											bGive = true
											pUnit:SetHasPromotion(iPeaceCombat, true)
										end
									end
								end
							end
						end
					end
				end
				if not bGive then
					pUnit:SetHasPromotion(iPeaceCombat, false)
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(C15_Iroquois_AdjUnitCombat)

function C15_Iroquois_DoOnondaga(playerID)
	local pPlayer = Players[playerID]
	if HasTrait(pPlayer, iGreatPeaceTrait) then
		for pCity in pPlayer:Cities() do
			if C15_GetCityNation(pCity) == sOnondaga then
				if bLoyalty then
					LuaEvents.JFD_WLTKDBegins(playerID, pCity, pCity:GetX(), pCity:GetY(), iWLTKDTurns)
				else
					pCity:ChangeWeLoveTheKingDayCounter(iWLTKDTurns)
				end
				if pPlayer:IsHuman() then
					local sMessage = Locale.ConvertTextKey("TXT_KEY_C15_IROQUOIS_ONONDAGA_WLTKD", pCity:GetName())
					Events.GameplayAlertMessage(sMessage)
				end
			end
		end
	end
end

function C15_Iroquois_DoOnondagaSov(playerID, reformID)
	C15_Iroquois_DoOnondaga(playerID)
end

GameEvents.PlayerAdoptPolicy.Add(C15_Iroquois_DoOnondaga)
GameEvents.PlayerAdoptPolicyBranch.Add(C15_Iroquois_DoOnondaga)
if bSov then
	LuaEvents.JFD_ReformPassed.Add(C15_Iroquois_DoOnondagaSov)
end		

function C15_Iroquois_DoCayuga(pCity)
	local iCount = 0
	for i = 0, pCity:GetNumCityPlots() -1 do
		local pPlot = pCity:GetCityIndexPlot(i)
		if pPlot:GetImprovementType() == iCamp and pPlot:IsBeingWorked() then
			iCount = iCount + 1
		end
	end
	pCity:SetNumRealBuilding(iCayugaTrade, iCount)
end

function C15_Iroquois_DoSenecaUnit(playerID, unitID, iX, iY)
	local pPlayer = Players[playerID]
	if HasTrait(pPlayer, iGreatPeaceTrait) then
		local tCities = C15_GetFriendlyCitiesWithinRadius(pPlayer, iX, iY, 3)
		if #tCities > 0 then
			local bGive = false
			for k, v in ipairs(tCities) do
				if C15_GetCityNation(v) == sSeneca then
					bGive = true
					break
				end
			end
			local pUnit = pPlayer:GetUnitByID(unitID)
			pUnit:SetHasPromotion(iSenecaPromotion, bGive)
		end
	end
end

GameEvents.UnitSetXY.Add(C15_Iroquois_DoSenecaUnit)

function C15_Iroquois_DoSenecaConstruct(playerID, cityID, buildingID)
	if tDefensiveBuildings[buildingID] then
		local pPlayer = Players[playerID]
		if HasTrait(pPlayer, iGreatPeaceTrait) then
			local pCity = pPlayer:GetCityByID(cityID)
			if C15_GetCityNation(pCity) == sSeneca then
				local iCult = pPlayer:GetJONSCulture() * 3
				if iCult > 0 then
					pPlayer:ChangeJONSCulture(iCult)
					if pPlayer:IsHuman() then
						local sMessage = Locale.ConvertTextKey("TXT_KEY_C15_IROQUOIS_SENECA_CULTURE", iCult, pCity:GetName())
						Events.GameplayAlertMessage(sMessage)
					end
				end
			end
		end
	end
end

GameEvents.CityConstructed.Add(C15_Iroquois_DoSenecaConstruct)

function C15_Iroquois_DoSeneca(pCity)
	for i = 0, pCity:GetNumCityPlots() -1 do
		local pPlot = pCity:GetCityIndexPlot(i)
		if pPlot:IsUnit() then
			for j = 0, pPlot:GetNumUnits() -1 do
				local pUnit = pPlot:GetUnit(j)
				if pUnit:GetOwner() == pCity:GetOwner() then
					pUnit:SetHasPromotion(iSenecaPromotion, true)
				end
			end
		end
	end
end

function C15_Iroquois_OnNation(pCity, sNation)	
	if sNation == sCayuga then
		C15_PlaceStuffAroundCity(pCity, iFurs, 1)
	end
	C15_Iroquois_MaintainCity(pCity)
end

LuaEvents.C15_Iroquois_NationSet.Add(C15_Iroquois_OnNation)

function C15_Iroquois_MaintainCity(pCity)
	local sNation = C15_GetCityNation(pCity)
	if sNation then
		if sNation == sMohawk then
			pCity:SetNumRealBuilding(iMohawkXP, 1)
		elseif sNation == sCayuga then
			C15_Iroquois_DoCayuga(pCity)
		elseif sNation == sOneida then
			pCity:SetNumRealBuilding(iOneidaDef, pCity:GetFaithPerTurn())
		elseif sNation == sSeneca then
			C15_Iroquois_DoSeneca(pCity)
		end
		C15_MaintainLonghouse(pCity)
	end
end

function C15_Iroquois_LonghouseBuilt(playerID, cityID, buildingID)
	if buildingID == iLonghouse then
		local pPlayer = Players[playerID]
		local pCity = pPlayer:GetCityByID(cityID)
		C15_Iroquois_MaintainCity(pCity)
	end
end

GameEvents.CityConstructed.Add(C15_Iroquois_LonghouseBuilt)

function C15_Iroquois_MaintainCities(playerID)
	local pPlayer = Players[playerID]
	if HasTrait(pPlayer, iGreatPeaceTrait) then
		for pCity in pPlayer:Cities() do
			C15_Iroquois_MaintainCity(pCity)
		end
	end
end

GameEvents.PlayerDoTurn.Add(C15_Iroquois_MaintainCities)

function C15_Iroquois_MaintainConquer(oldID, bCap, iX, iY, newID)
	local pPlayer = Players[newID]
	if HasTrait(pPlayer, iGreatPeaceTrait) then
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		if pCity then
			C15_Iroquois_MaintainCity(pCity)
		end
	end
end

GameEvents.CityCaptureComplete.Add(C15_Iroquois_MaintainConquer)

-- Event
local iEvent = GameInfoTypes["CITY_EVENT_C15_IROQUOIS_TUSCARORA_MIGRATION"]

function C15_Iroquois_EventListener(oldID, bCapital, iX, iY, newID, iOldPop, bConquest)
	if not bConquest then return end
	for i = 0, GameDefines.MAX_MAJOR_CIVS -1 do
		if i ~= oldID and i ~= newID then
			local pPlayer = Players[i]
			if HasTrait(pPlayer, iGreatPeaceTrait) and Teams[pPlayer:GetTeam()]:IsHasMet(Players[oldID]:GetTeam()) and JFD_GetRandom(1, 10) <= 4 then
				for pCity in pPlayer:Cities() do
					if not C15_GetCityNation(pCity) then
						if City.DoCityStartEvent then
							pCity:DoCityStartEvent(iEvent)
							C15_SetCityNation(pCity, sTusco)
						elseif g_CoreEvents_Enabled then
							LuaEvents.C15_Iroquois_TryingToGetEventToWork(pPlayer)
							C15_SetCityNation(pCity, sTusco)
						end
						break
					end
				end
			end
		end
	end
end

GameEvents.CityCaptureComplete.Add(C15_Iroquois_EventListener)