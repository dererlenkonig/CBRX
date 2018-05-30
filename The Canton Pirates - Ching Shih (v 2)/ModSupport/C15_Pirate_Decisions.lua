
local civilizationID = GameInfoTypes["CIVILIZATION_CANTON_PIRATES"]
local AdmiralDecisionPromotion = GameInfoTypes["PROMOTION_C15_ADMIRAL_DECISION_PROMOTION"]
local DummySupplyPromotion = GameInfoTypes["PROMOTION_C15_SUPPLY_DUMMY_PROMOTION"]
local pDomainSea = DomainTypes.DOMAIN_SEA

include("PlotIterators.lua")

function JFD_GetUserSettingAlt(type)
	if isUsingCID == true then
		for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
			return row.Value
		end
	end
end

local bUserSettingsAdmiralLuxes = JFD_GetUserSettingAlt("JFD_EXCE_EXPLORATION_UNIT_CHANGES_ADMIRAL") == 1

function ModEnabledCheck(sModID) -- LeeS from Jifford or WH
	for i,v in pairs(Modding.GetActivatedMods()) do
		if sModID == v.ID then
			return true
		end
	end
	return false
end
local bEnlightenmentEraIsActive = ModEnabledCheck("ce8aa614-7ef7-4a45-a179-5329869e8d6d")

function C15_GetNumNavalUnits(pPlayer)
	local iNumUnits = 0
	for pUnit in pPlayer:Units() do
		if pUnit:GetDomainType() == pDomainSea and pUnit:IsCombatUnit() then
			iNumUnits = iNumUnits + 1
		end
	end
	return iNumUnits
end

--[[local tWonders = {};
for pBuilding in GameInfo.Buildings() do
	print("pBuilding = ", pBuilding.Type)
	local sBuildingClass = pBuilding.BuildingClass
	print("sBuildingClass = ", sBuildingClass)
	if GameInfo.BuildingClasses[sBuildingClass].MaxGlobalInstances == 1 then
		print("pBuilding is a wonder")
		tWonders[pBuilding.ID] = pBuilding.Type
	end
end]]

local tWonders = {}
for BuildingClass in DB.Query("SELECT ID, Type, DefaultBuilding FROM BuildingClasses WHERE MaxGlobalInstances = '1'") do
    local iBuildingClass = BuildingClass.ID
    local sBuildingClassType = BuildingClass.Type
    for Building in GameInfo.Buildings("BuildingClass='" .. sBuildingClassType .. "'") do
        tWonders[Building.ID] = {BuildingType=Building.Type, BuildingDescription = Building.Description}
    end
end
	
--------------------------------------------------------------------------------------------------------------

local Decisions_C15_Pirate_Captains = {}
	Decisions_C15_Pirate_Captains.Name = "TXT_KEY_DECISIONS_C15_PIRATE_CAPTAINS"
	Decisions_C15_Pirate_Captains.Desc = "TXT_KEY_DECISIONS_C15_PIRATE_CAPTAINS_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_Pirate_Captains, "CIVILIZATION_CANTON_PIRATES")
	Decisions_C15_Pirate_Captains.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load (player, "Decisions_C15_Pirate_Captains") == true then
			Decisions_C15_Pirate_Captains.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_PIRATE_CAPTAINS_ENACTED_DESC")
			return false, false, true
		end
		local pEra = GameInfoTypes["ERA_RENAISSANCE"]
		if bEnlightenmentEraIsActive then
			pEra = GameInfoTypes["ERA_ENLIGHTENMENT"]
		end
		local iEra = player:GetCurrentEra()
		local iCostMod = 300 * iMod
		if bUserSettingsAdmiralLuxes then
			iCostMod = 500 * iMod
		end
		local iCost = math.floor((C15_GetNumNavalUnits(player) / 4) * iCostMod)
		Decisions_C15_Pirate_Captains.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_PIRATE_CAPTAINS_DESC", iCost)
		if bEnlightenmentEraIsActive then
			Decisions_C15_Pirate_Captains.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_PIRATE_CAPTAINS_DESC_EE")
		end
		if player:GetGold() < iCost then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1       then return true, false end 
		if iEra < pEra then return true, false end
		if C15_GetNumNavalUnits(player) < 4 then return true, false end
		
		return true, true
	end
	)
	
	Decisions_C15_Pirate_Captains.DoFunc = (
	function(player)
		local iCostMod = 300 * iMod
		if bUserSettingsAdmiralLuxes then
			iCostMod = 500 * iMod
		end
		local iCost = math.floor((C15_GetNumNavalUnits(player) / 4) * iCostMod)
		local pCapital = player:GetCapitalCity()
		local admiralID = GameInfoTypes["UNIT_GREAT_ADMIRAL"]
		player:ChangeGold(-iCost)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		for i = 0, math.floor(C15_GetNumNavalUnits(player) / 4) -1 do
			local unit = player:InitUnit(admiralID, pCapital:GetX(), pCapital:GetY())
			unit:JumpToNearestValidPlot()
			unit:SetHasPromotion(AdmiralDecisionPromotion, true)
		end
		save(player, "Decisions_C15_Pirate_Captains", true)
	end
	)
	
	Decisions_C15_Pirate_Captains.Monitors = {}
	Decisions_C15_Pirate_Captains.Monitors[GameEvents.UnitSetXY] = (
	function(playerID, unitID, iX, iY)
		local pPlayer = Players[playerID]
		local bAdmiral = false
		local bAdmiral2 = false
		if pPlayer:GetCivilizationType() == civilizationID then
			local pUnit = pPlayer:GetUnitByID(unitID)
			if pUnit:GetDomainType() == pDomainSea then
				--print("Is boat")
				local pPlot = Map.GetPlot(iX, iY)
				for pEdgePlot in PlotAreaSpiralIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if pEdgePlot and pEdgePlot:IsUnit() then
						--print("Unit found")
						for i = 0, pEdgePlot:GetNumUnits()-1, 1 do
							local oUnit = pEdgePlot:GetUnit(i)
							--print("oUnit")
							--print(oUnit:GetOwner())
							if oUnit and oUnit:GetOwner() == playerID then
								--print("Good Unit")
								if oUnit:IsHasPromotion(AdmiralDecisionPromotion) and not pUnit:IsHasPromotion(AdmiralDecisionPromotion) then
									--print("Is admiral")
									bAdmiral = true
									break
								elseif not oUnit:IsHasPromotion(AdmiralDecisionPromotion) and pUnit:IsHasPromotion(AdmiralDecisionPromotion) then
									oUnit:SetHasPromotion(DummySupplyPromotion, true)
								end
							end
						end
					end
				end
				if bAdmiral then
					if not pUnit:IsHasPromotion(DummySupplyPromotion) then
						pUnit:SetHasPromotion(DummySupplyPromotion, true)
					end
				else
					if pUnit:IsHasPromotion(DummySupplyPromotion) then
						pUnit:SetHasPromotion(DummySupplyPromotion, false)
					end
				end
			end
		end
	end
	)
		
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_C15_Pirate_Captains", Decisions_C15_Pirate_Captains)

--========================================================================================================================================

Decisions_C15_Pirate_Code = {}
	Decisions_C15_Pirate_Code.Name = "TXT_KEY_DECISIONS_C15_PIRATE_CODE"
	Decisions_C15_Pirate_Code.Desc = "TXT_KEY_DECISIONS_C15_PIRATE_CODE_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_Pirate_Code, "CIVILIZATION_CANTON_PIRATES")
	Decisions_C15_Pirate_Code.CanFunc = (
	function(player)
		if player:GetCivilizationType() ~= civilizationID then return false, false end
		if load(player, "Decisions_C15_Pirate_Code") == true then
			Decisions_C15_Pirate_Code.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_PIRATE_CODE_DESC_ENACTED")
			return false, false, true
		end
		local iNumNavalUnits = C15_GetNumNavalUnits(player)
		local iCost = math.floor(iNumNavalUnits * 100 * iMod)
		Decisions_C15_Pirate_Code.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_PIRATE_CODE_DESC", iCost)
		if player:GetJONSCulture() < iCost then return true, false end
		if player:GetNumResourceAvailable(iMagistrate, false) < 1       then return true, false end 
		if iNumNavalUnits < 3 then return true, false end
		if not Teams[player:GetTeam()]:IsHasTech(GameInfoTypes["TECH_NAVIGATION"]) then return true, false end
		
		return true, true
	end
	)
	
	Decisions_C15_Pirate_Code.DoFunc = (
	function(player)
		local iCost = math.floor(C15_GetNumNavalUnits(player) * 100 * iMod)
		player:ChangeNumResourceTotal(iMagistrate, -1)
		--[[if GrantPolicy then
			player:GrantPolicy(policyCodeDecision, true)
		else
			player:SetNumFreePolicies(1)
			player:SetNumFreePolicies(0)
			player:SetHasPolicy(policyCodeDecision, true)
		end]]
		save(player, "Decisions_C15_Pirate_Code", true)
	end
	)
	
	Decisions_C15_Pirate_Code.Monitors = {}
	Decisions_C15_Pirate_Code.Monitors[GameEvents.CityCaptureComplete] = (
	function (oldOwnerID, bCapital, iX, iY, newOwnerID, iOldPop, bConquest)
		local pPlayer = Players[newOwnerID]
		if pPlayer:GetCivilizationType() == civilizationID and load(pPlayer, "Decisions_C15_Pirate_Code") == true then
			if bConquest then
				local pPlot = Map.GetPlot(iX, iY)
				local pCity = pPlot:GetPlotCity()
				if pCity then
					if pCity:GetNumWorldWonders() > 0 then
						pCity:SetPopulation(iOldPop)
						for ID, DataTable in pairs(tWonders) do
							if pCity:IsHasBuilding(ID) then
								local iProdCost = pCity:GetBuildingProductionNeeded(ID)
								local sWonderName = GameInfo.Buildings[ID]
								pPlayer:ChangeGold(iProdCost)
								if pPlayer:IsHuman() then
									local sAlertMessage = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_PIRATE_CODE_WONDER_GOLD", iProdCost, DataTable.BuildingDescription, pCity:GetName())
									Events.GameplayAlertMessage(sAlertMessage)
								end
							end
						end
					end
				end
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_C15_Pirate_Code", Decisions_C15_Pirate_Code)

		