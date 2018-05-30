-- JFD_IsCivilisationActive
function JFD_IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilizationID then
				return true
			end
		end
	end
	return false
end

include( "SaveUtils" ); MY_MOD_NAME = "Scissor_Indira";

local civilizationID = GameInfoTypes["CIVILIZATION_INDIRA_GANDHI"]
local isIndiraCivActive  = JFD_IsCivilisationActive(civilizationID)
local numBuildings = 0
local buildingCount = 0
local outputDouble = GameInfoTypes.BUILDING_DUMMY_OUTPUT_DOUBLE
local tourismDouble = GameInfoTypes.BUILDING_DUMMY_TOURISM_DOUBLE
local effectTurnsRemaining = 0

if isIndiraCivActive then print("Indira is in the game. YOU HAVE BEEN WARNED.") end

function Emergency(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civilizationID then
		local newBuilding = false
		local cCity = pPlayer:GetCapitalCity()
		buildingCount = cCity:GetNumBuildings()
			if buildingCount > numBuildings then
				numBuildings = buildingCount
				newBuilding = true
				print('A building was built in the capital.')
			end

		for pCity in pPlayer:Cities() do
			if type(load(pPlayer, pCity) == "number" then effectTurnsRemaining = load(pPlayer, pCity:GetName()) else save(pPlayer, pCity:GetName(), 0)

			if effectTurnsRemaining > 0 then 
				effectTurnsRemaining -= 1
				save(pPlayer, pCity:GetName(), effectTurnsRemaining)
			end
			print('Effect Turns Remaining: ' .. effectTurnsRemaining)
			
			elseif pPlayer:IsCapitalConnectedToCity(pCity) and newBuilding and effectTurnsRemaining == 0 then
				pCity:ChangeResistanceTurns(3)
				save(pPlayer, pCity:GetName(), 8)
				print('Sent ' .. pCity:GetName() .. ' into Resistance')
			end
			
			if effectTurnsRemaining == 6 then
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

if isIndiraCivActive then GameEvents.PlayerDoTurn.Add(Emergency) end