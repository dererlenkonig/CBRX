-- C15_Iroquois_Utils
-- Author: Chrisy15
-- DateCreated: 12/3/2017 3:52:47 PM
--------------------------------------------------------------

--=================================================================
-- Defines
-------------------------------------------------------------------

local tNations = {}
for row in GameInfo.C15_Iroquois_Nations() do
	tNations[row.Type] = {Description = Locale.ConvertTextKey(row.Description), Help = Locale.ConvertTextKey(row.Help), BuildingType = GameInfoTypes[row.BuildingType], LonghouseDummyType = GameInfoTypes[row.LonghouseDummyType], PromotionType = GameInfoTypes[row.PromotionType]}
end

local tCityNations = {}
for row in GameInfo.C15_Iroquois_Nation_Cities() do
	table.insert(tCityNations, {CityName = Locale.ConvertTextKey(row.CityName), Nation = row.NationType})
end

local iLonghouse = GameInfoTypes["BUILDING_LONGHOUSE"]

--=================================================================
--=================================================================
-- General
-------------------------------------------------------------------

function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end

function HasTrait(player, traitID) -- Jifford
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

function C15_GetNationTable(sNation)
	return tNations[sNation]
end

function C15_GetNations()
	return tNations
end

function C15_PlaceStuffAroundCity(pCity, iResource, iNumtoPlace) -- Modified from Secret
	local tPlots = {}
	for i = 0, pCity:GetNumCityPlots() - 1 do
		local pPlot = pCity:GetCityIndexPlot(i)
		if pPlot then
			table.insert(tPlots, pPlot)
		end
	end
    for iVal = 1, iNumtoPlace do
        local bPlaced = false
        while (not(bPlaced)) and tPlots[1] do
            local iRandom = JFD_GetRandom(1, #tPlots)
            local pPlot =  tPlots[iRandom]
			if pPlot then
				if (pPlot:GetTerrainType() ~= iSnow) and (not pPlot:IsWater()) and (not pPlot:IsImpassable()) and (pPlot:GetResourceType() == -1) and (not pPlot:IsCity()) then 
					pPlot:SetResourceType(iResource, 1)
					bPlaced = true
					table.remove(tPlots, iRandom)
				end
			end
        end
    end
end

function C15_GetFriendlyCitiesWithinRadius(pPlayer, iX, iY, iRad)
	local tCities = {}
	for pCity in pPlayer:Cities() do
		if Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY()) <= iRad then
			table.insert(tCities, pCity)
		end
	end
	return tCities
end

function C15_GetNearestCityWithLonghouseDummy(pPlayer, pCity)
	local iX, iY = pCity:GetX(), pCity:GetY()
	local pClosest, iClosestDistance = nil, math.huge
	for pIterCity in pPlayer:Cities() do
		local sNation = C15_GetCityNation(pIterCity)
		if pCity ~= pIterCity and sNation then
			if tNations[sNation].LonghouseDummyType then
				local iDistance = Map.PlotDistance(iX, iY, pIterCity:GetX(), pIterCity:GetY())
				if iDistance < iClosestDistance then
					pClosest, iClosestDistance = pIterCity, iDistance
				end
			end
		end
	end
	return pClosest
end

--=================================================================
--=================================================================
-- City
-------------------------------------------------------------------

function C15_CheckCityNameExists(sName, pCity)
	for i = 0, GameDefines.MAX_CIV_PLAYERS - 1 do
		local pPlayer = Players[i]
		if pPlayer then
			for pIterCity in pPlayer:Cities() do
				if pIterCity ~= pCity and pIterCity:GetName() == sName then
					return true
				end
			end
		end
	end
	return false
end

function C15_GetCityNation(pCity, bByName, sName)
	if not bByName then
		for k, v in pairs(tNations) do
			if pCity:IsHasBuilding(v.BuildingType) then
				return k
			end
		end
	end
	sName = sName or pCity:GetName()
	for k, v in ipairs(tCityNations) do
		if v.CityName == sName then
			return v.Nation
		end
	end
	return nil
end

function C15_SetCityNation(pCity, sNation)
	sNation = sNation or C15_GetCityNation(pCity)
	if sNation then
		local tNation = tNations[sNation]
		if tNation then
			pCity:SetNumRealBuilding(tNation.BuildingType, 1)
			C15_MaintainLonghouse(pCity)
			LuaEvents.C15_Iroquois_NationSet(pCity, sNation)
		end
	end
end

function C15_GetRandomCityName(pCity)
	local sName
	local tNames = tCityNations
	while not sName and #tNames > 0 do
		local iRand = JFD_GetRandom(1, #tNames)
		if C15_CheckCityNameExists(tNames[iRand].CityName, pCity) then
			table.remove(tNames, iRand)
		else
			sName = tNames[iRand].CityName
		end
	end
	return sName
end

function C15_IsHasLonghouseDummy(pCity, bAny)
	if bAny then
		for k, v in pairs(tNations) do
			if pCity:IsHasBuilding(v.LonghouseDummyType) then
				return true
			end
		end
		return false
	else
		local iLonghouseDummy = tNations[C15_GetCityNation(pCity)].LonghouseDummyType
		if iLonghouseDummy then
			return pCity:IsHasBuilding(iLonghouseDummy)
		end
	end
	
	return false
end

function C15_GetLonghouseDummyType(pCity)
	for k, v in pairs(tNations) do
		if v.LonghouseDummyType and pCity:IsHasBuilding(v.LonghouseDummyType) then
			return v.LonghouseDummyType
		end
	end
	return nil
end

function C15_MaintainLonghouse(pCity)
	local sNation = C15_GetCityNation(pCity)
	if sNation and pCity:IsHasBuilding(iLonghouse) then
		local tNation = tNations[sNation]
		if tNation.LonghouseDummyType then
			pCity:SetNumRealBuilding(tNation.LonghouseDummyType, 1)
		else
			local iCurrentDummy = C15_GetLonghouseDummyType(pCity)
			if iCurrentDummy then
				pCity:SetNumRealBuilding(iCurrentDummy, 0)
			end
			local pClosest = C15_GetNearestCityWithLonghouseDummy(Players[pCity:GetOwner()], pCity)
			if pClosest then
				pCity:SetNumRealBuilding(tNations[C15_GetCityNation(pClosest)].LonghouseDummyType, 1)
			end
		end
	elseif C15_IsHasLonghouseDummy(pCity, true) then
		for k, v in pairs(tNations) do
			if v.LonghouseDummyType then
				pCity:SetNumRealBuilding(v.LonghouseDummyType, 0)
			end
		end
	end
end

--=================================================================
--=================================================================
-- Unit
-------------------------------------------------------------------

function C15_GetUnitNation(pUnit)
	for k, v in pairs(tNations) do
		if pUnit:IsHasPromotion(v.PromotionType) then
			return k
		end
	end
	return nil
end




