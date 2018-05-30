-- JFD_NewZealand_Functions
-- Author: JFD
-- DateCreated: 4/13/2014 4:19:30 PM
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
-- UNIQUE
----------------------------------------------------------------------------------------------------------------------------
--JFD_GetNumInternationalTradeRoutes
function JFD_GetNumTradeRoutesToDifferentCivilizaitons(playerID)
	local player = Players[playerID]
	local numTradeRoutes = 0 
	local tradeRoutes = player:GetTradeRoutes()
	for _, tradeRoute in ipairs(tradeRoutes) do
		if (tradeRoute.FromCivilizationType ~= tradeRoute.ToCivilizationType) then
			numTradeRoutes = numTradeRoutes + 1
			if numTradeRoutes >= 3 then
				break
			end
		end
	end
	return numTradeRoutes
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
local mathMin			= math.min
local traitNewZealandID = GameInfoTypes["TRAIT_JFD_NEW_ZEALAND"]
----------------------------------------------------------------------------------------------------------------------------
-- BRITIAN OF THE SOUTH SEAS
----------------------------------------------------------------------------------------------------------------------------
--JFD_NewZealand_BritianOfTheSouthSeas_PlayerDoTurn
local buildingNewZealandGrowthID = GameInfoTypes["BUILDING_JFD_NEW_ZEALAND_GROWTH"]
local buildingNewZealandTrade1ID = GameInfoTypes["BUILDING_JFD_NEW_ZEALAND_TRADE_1"]
local buildingNewZealandTrade2ID = GameInfoTypes["BUILDING_JFD_NEW_ZEALAND_TRADE_2"]
function JFD_NewZealand_BritianOfTheSouthSeas_PlayerDoTurn(playerID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitNewZealandID)) then return end
	local capital = player:GetCapitalCity()
	if (not capital) then return end
	for city in player:Cities() do
		city:SetNumRealBuilding(buildingNewZealandGrowthID, 0)
	end
	local tradeRoutes = player:GetTradeRoutes()
	for _, tradeRoute in ipairs(tradeRoutes) do
		if (tradeRoute.FromCivilizationType ~= tradeRoute.ToCivilizationType) then
			local city = player:GetCityByID(tradeRoute.ToCityID) 
			local numExisting = city:GetNumRealBuilding(buildingNewZealandGrowthID)
			city:SetNumRealBuilding(buildingNewZealandGrowthID, numExisting+1)
		end
	end	
	if capital:IsHasBuilding(buildingNewZealandTrade1ID) then
		capital:SetNumRealBuilding(buildingNewZealandTrade1ID, 0)
		capital:SetNumRealBuilding(buildingNewZealandTrade2ID, 0)
	end
	for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local otherPlayer = Players[otherPlayerID]
		if (otherPlayer:IsAlive() and otherPlayerID ~= playerID) then
			local otherTeam = Teams[otherPlayer:GetTeam()]
			local otherCapital = otherPlayer:GetCapitalCity()
			if otherPlayer:IsDoF(player:GetTeam()) then
				capital:SetNumRealBuilding(buildingNewZealandTrade1ID, 1)
				capital:SetNumRealBuilding(buildingNewZealandTrade2ID, 1)
				otherCapital:SetNumRealBuilding(buildingNewZealandTrade1ID, 1)
				break
			elseif otherCapital:IsHasBuilding(buildingNewZealandTrade1ID) then
				capital:SetNumRealBuilding(buildingNewZealandTrade1ID, 0)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_NewZealand_BritianOfTheSouthSeas_PlayerDoTurn)
----------------------------------------------------------------------------------------------------------------------------
-- ANZAC
----------------------------------------------------------------------------------------------------------------------------
--JFD_NewZealand_ANZAC_PlayerDoTurn
local unitPromotionANZACID = GameInfoTypes["PROMOTION_JFD_ANZAC"]
function JFD_NewZealand_ANZAC_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	local capital = player:GetCapitalCity()
	if (not capital) then return end
	local capitalX = capital:GetX()
	local capitalY = capital:GetY()
	for unit in player:Units() do
		if unit:GetDamage() > 0 then
			if (unit:IsHasPromotion(unitPromotionANZACID) and unit:GetPlot():GetOwner() ~= playerID) then
				local healFromDistance = mathMin(Map.PlotDistance(capitalX, capitalY, unit:GetX(), unit:GetY()), 30)
				unit:ChangeDamage(-healFromDistance)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_NewZealand_ANZAC_PlayerDoTurn)
----------------------------------------------------------------------------------------------------------------------------
-- DEFENDER
----------------------------------------------------------------------------------------------------------------------------
local unitPromotionDefenderActiveID	= GameInfoTypes["PROMOTION_JFD_DEFENDER_ACTIVE"]
local unitPromotionDefenderID		= GameInfoTypes["PROMOTION_JFD_DEFENDER"]
function JFD_NewZealand_Defender_PlayerDoTurn(playerID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	if (not player:IsAlive()) then return end
	if player:IsBarbarian() then return end
	for unit in player:Units() do
		local isPromotionValid = false
		if (unit and (unit:IsHasPromotion(unitPromotionDefenderActiveID) or unit:IsHasPromotion(unitPromotionDefenderID))) then
			local plot = unit:GetPlot()
			if (plot and plot:IsPlayerCityRadius(playerID)) then 
				isPromotionValid = true
			else
				for otherPlayerID = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
					local otherPlayer = Players[otherPlayerID]
					if (otherPlayer:IsAlive() and otherPlayerID ~= playerID) then	
						local otherTeamID = otherPlayer:GetTeam()
						if otherPlayer:IsDoF(player:GetTeam()) then
							if plot:IsPlayerCityRadius(otherPlayerID) then 
								isPromotionValid = true
								break
							end
						end
					end
				end
			end
		end
		if isPromotionValid then
			if (not unit:IsHasPromotion(unitPromotionDefenderActiveID)) then
				unit:SetHasPromotion(unitPromotionDefenderActiveID, true)
				unit:SetHasPromotion(unitPromotionDefenderID, false)
			end
		else
			if unit:IsHasPromotion(unitPromotionDefenderActiveID) then
				unit:SetHasPromotion(unitPromotionDefenderActiveID, false)
				unit:SetHasPromotion(unitPromotionDefenderID, true)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_NewZealand_Defender_PlayerDoTurn)
--==========================================================================================================================
--==========================================================================================================================