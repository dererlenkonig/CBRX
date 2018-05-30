--Game_IsCPActive
function Game_IsCPActive()
    for _, mod in pairs(Modding.GetActivatedMods()) do
        if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
            return true
        end
    end
    return false
end
local isCPActive = Game_IsCPActive()

--HasTrait
function HasTrait(player, traitID)
    if isCPActive then 
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

include( "SaveUtils" ); MY_MOD_NAME = "Scissor_Indira"; WARN_NOT_SHARED = false

local indiraTrait = GameInfoTypes["TRAIT_THE_EMERGENCY"]
local outputDouble = GameInfoTypes.BUILDING_DUMMY_OUTPUT_DOUBLE
local tourismDouble = GameInfoTypes.BUILDING_DUMMY_TOURISM_DOUBLE

function Emergency(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, indiraTrait)) then return end
	
	for pCity in player:Cities() do
		if not pCity:IsCapital() then
			local effectTurnsRemaining = load(player, pCity:GetName()) or 0
			if not effectTurnsRemaining == 0 then
				effectTurnsRemaining = effectTurnsRemaining - 1
				save(player, pCity:GetName(), effectTurnsRemaining)
				print('Effect Turns Remaining: ' .. effectTurnsRemaining)
			
				if effectTurnsRemaining == 5 then
					pCity:SetNumRealBuilding(outputDouble, 1)
					pCity:SetNumRealBuilding(tourismDouble, 1)
					print('Sent ' .. pCity:GetName() .. ' into Double Production mode')
				elseif effectTurnsRemaining == 1 then
					pCity:SetNumRealBuilding(outputDouble, 0)
					pCity:SetNumRealBuilding(tourismDouble, 0)
				end	
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(Emergency)

function EmergencyStart(ownerID, cityID, buildingType, bGold, bFaithOrCulture)
	local player = Players[ownerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, indiraTrait)) then return end
	if not player:GetCityByID(cityID):IsCapital() then return end
	
	for pCity in player:Cities() do
		local effectTurnsRemaining = load(player, pCity:GetName()) or 0
		if not pCity:IsCapital() then
			if player:IsCapitalConnectedToCity(pCity) and effectTurnsRemaining == 0 then
				pCity:ChangeResistanceTurns(3)
				save(player, pCity:GetName(), 8)
				print('Sent ' .. pCity:GetName() .. ' into Resistance')
			end
		end
	end
	
end

GameEvents.CityConstructed.Add(EmergencyStart)


include("GetUnitsInAdjacentPlotsWithPromotion")
include("PlotIterators")

local unitPromotionGarudaID = GameInfoTypes["PROMOTION_GARUDA_HEAL_PROMOTION"]
local unitPromotionUraniumID = GameInfoTypes["PROMOTION_FREE_URANIUM"]

function Scissor_Functions(playerID)
    local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, indiraTrait)) then return end

	local iNumber = 0

	-- Garuda
    for unit in player:Units() do
        if unit:IsHasPromotion(unitPromotionGarudaID) then
            if IsAdjacentToUnitPromotion then
				if (unit:GetCurrHitPoints() < 80) then
					if (unit:GetCurrHitPoints() > 67) then
						unit:SetDamage(0)
						print("Ran Garuda function, set Damage to 0")
					else
						unit:ChangeDamage(-15)
						print("Ran Garuda function, set Damage to -15")
					end
				end
            end
        end
    end
	for city in player:Cities() do
		-- Garrisoned Uranium
		city:SetNumRealBuilding(GameInfoTypes["BUILDING_SCISSOR_INDIRA"], 0)

		if (city:GetGarrisonedUnit() and player:IsCapitalConnectedToCity(city)) then
			if city:GetGarrisonedUnit():IsHasPromotion(unitPromotionUraniumID) then
				city:SetNumRealBuilding(GameInfoTypes["BUILDING_SCISSOR_INDIRA"], 1)
				print("Found a garrisoned unit, added one uranium.")
			end
		end

		-- Pokhran Lab
		local pCityPlot = city:Plot()
		if (city:GetNumRealBuilding(GameInfoTypes["BUILDING_POKHRAN_LAB"]) == 1) then
			for pAreaPlot in PlotAreaSpiralIterator(pCityPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
				if (pAreaPlot:GetTerrainType() == TerrainTypes.TERRAIN_DESERT and pAreaPlot:GetPlotType() == PlotTypes.PLOT_HILLS) then
					iNumber = iNumber + 1
				end
			end
			city:SetNumRealBuilding(GameInfoTypes["BUILDING_POKHRAN_URANIUM"], iNumber)
		end
	end
end
GameEvents.PlayerDoTurn.Add(Scissor_Functions)


print("Indira Gandhi is in the game. YOU HAVE BEEN WARNED.")