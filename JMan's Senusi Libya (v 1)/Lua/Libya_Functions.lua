-- Lua Script1
-- Author: JMAngelo & Chrisy15
-- DateCreated: 1/13/2018 2:38:22 PM
--------------------------------------------------------------

print("Omar Mukhtar is in the game.")

function C15_ProdTextOnPlot(iX, iY, sString)
    local pHexPos = ToHexFromGrid{x=iX, y=iY}
    local pWorldPos = HexToWorld(pHexPos)
    Events.AddPopupTextEvent(pWorldPos, sString)
end

local gwiID = GameInfoTypes["UNIT_GREAT_WAR_INFANTRY"]
local civilizationID = GameInfoTypes["CIVILIZATION_JMANGELO_SENUSI_LIBYA"]
local uuID = GameInfo.Units.UNIT_JMANGELO_AKHDARI_CAVALRY.ID
local iDesert = GameInfoTypes["TERRAIN_DESERT"]
local iFood = YieldTypes.YIELD_FOOD

function C15_FaithProdUUDude(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilizationID then
		for pCity in pPlayer:Cities() do
			local iFaith = pCity:GetFaithPerTurn()
			if pCity:GetProductionUnit() == uuID and iFaith > 0 then
				pCity:ChangeProduction(iFaith)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(C15_FaithProdUUDude)

function C15_UUSwitchOnKill(playerID, unitID, unitType, iX, iY, bDelay, killerID)
	if unitType == uuID and not bDelay then
		local pPlayer = Players[playerID]
		local pUnit = pPlayer:GetUnitByID(unitID)
		pPlayer:InitUnit(gwiID, iX, iY)
		print("LIBYA: Replaced Akhdari Cavalry with a Great War Infantry.")
	end
end

GameEvents.UnitPrekill.Add(C15_UUSwitchOnKill)

function C15_GGPFaithFromDesertFood(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilizationID then
		for pCity in pPlayer:Cities() do
			for i = 0, pCity:GetNumCityPlots() - 1, 1 do
				local pPlot = pCity:GetCityIndexPlot(i)
				if pPlot and (pPlot:GetWorkingCity() == pCity and pPlot:IsBeingWorked()) and (pPlot:GetTerrainType() == iDesert and pPlot:GetYield(iFood) > 0) then
					local iFoodOutput = pPlot:GetYield(iFood)
					pPlayer:ChangeFaith(iFoodOutput)
					pPlayer:ChangeCombatExperience(iFoodOutput)
					print("LIBYA: Got faith from desert food.")
					if pPlayer:IsHuman() then
						C15_ProdTextOnPlot(pPlot:GetX(), pPlot:GetY(), Locale.ConvertTextKey("TXT_KEY_JMANGELO_GP_FOOD", iFoodOutput))
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(C15_GGPFaithFromDesertFood)
					