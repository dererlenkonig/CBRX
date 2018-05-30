-- JFD_IsCivilisationActive
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

local civilizationNubiaID = GameInfoTypes["CIVILIZATION_MC_LITE_NUBIA"]
local isCivNubiaActive	  = JFD_IsCivilisationActive(civilizationNubiaID)

function NubiaTaSeti(oldOwnerID, capital, plotX, plotY, newOwnerID)
	local player = Players[newOwnerID]
	if (player:IsAlive() and player:GetCivilizationType() == civilizationNubiaID) then
		local city = Map.GetPlot(plotX, plotY):GetPlotCity()
		for buildingClass in GameInfo.BuildingClasses("MaxGlobalInstances == 1") do
			if city:IsHasBuilding(GameInfoTypes[buildingClass.DefaultBuilding]) then
				player:ChangeGoldenAgeTurns(12)
				break
			end
		end
	end
end
if isCivNubiaActive then
	GameEvents.CityCaptureComplete.Add(NubiaTaSeti)
end	

local buildingRangedProductionID = GameInfoTypes["BUILDING_MC_LITE_NUBIA_PRODUCTION"]
local buildingWonderExtensionID  = GameInfoTypes["BUILDING_MC_LITE_NUBIA_WONDERS"]
local unitCombatRangedID 		 = GameInfoTypes["UNITCOMBAT_ARCHER"]
function NubiaTaSetiRangedProduction(playerID)
	local player = Players[playerID]
	if (player:IsAlive() and player:GetCivilizationType() == civilizationNubiaID) then
		for city in player:Cities() do
			if city:GetGarrisonedUnit() then
				if city:GetGarrisonedUnit():GetUnitCombatType() == unitCombatRangedID then
					if (not city:IsHasBuilding(buildingRangedProductionID)) then
						city:SetNumRealBuilding(buildingRangedProductionID,1)
					end
				else
					if city:IsHasBuilding(buildingRangedProductionID) then
						city:SetNumRealBuilding(buildingRangedProductionID,0)
					end
				end
			else
				if city:IsHasBuilding(buildingRangedProductionID) then
					city:SetNumRealBuilding(buildingRangedProductionID,0)
				end
			end
			
			local numWorldWonders = 0
			for buildingClass in GameInfo.BuildingClasses("MaxPlayerInstances == 1") do
				if player:CountNumBuildings(GameInfoTypes[buildingClass.DefaultBuilding]) then
					numWorldWonders = numWorldWonders + 1
					if numWorldWonders == 5 then break end
				end
			end
			player:GetCapitalCity():SetNumRealBuilding(buildingWonderExtensionID, numWorldWonders)
		end
	end
end
if isCivNubiaActive then
	GameEvents.PlayerDoTurn.Add(NubiaTaSetiRangedProduction)
end
local promotionID = GameInfoTypes["PROMOTION_MC_APEDEMAK_RIVER"]
function JFD_NubiaUU(playerID)
	local player = Players[playerID]
	if (player:IsAlive() and (not player:IsBarbarian()) and (not player:IsMinorCiv())) then
		for unit in player:Units() do
			if unit:IsHasPromotion(promotionID) then
				local plot = Map.GetPlot(unit:GetX(), unit:GetY())
				if (plot and plot:IsRiver()) then
					unit:ChangeMoves(60)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(JFD_NubiaUU)