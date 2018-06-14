-- Martial_School
-- Author: EmeraldRange
-- DateCreated: 5/19/2017 4:57:23 PM
--------------------------------------------------------------
print "Martial School lua loaded"
-------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------------------------------------
local iCiv = GameInfoTypes.CIVILIZATION_TAUNGOO
local bIsCivActive = JFD_IsCivilisationActive(iCiv) --defined in Ahmudan.lua
-------------------------------------------------------------------------------------------------------------------------
--       "Provides 2 XP per 2 citizens." 
--				Clarification: 1 citizen does not produce 1 XP.
--       by EmeraldRange
-------------------------------------------------------------------------------------------------------------------------
local iXpBuilding = GameInfoTypes.BUILDING_ER_MARTIAL_DUMMY
local iTaungooUB = GameInfoTypes.BUILDING_ER_MARTIAL_SCHOOL
function ER_XpFromCitizens(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() then   --(The building may be obtained by some other civs)
		for pCity in pPlayer:Cities() do --cycle through cities to look for Martial Schools
			if pCity:IsHasBuilding(iTaungooUB) then
				local iHalfPop = math.floor(pCity:GetPopulation()/2)
				if( pCity:GetNumRealBuilding(iXpBuilding) ~= iHalfPop) then
					pCity:SetNumRealBuilding(iXpBuilding, iHalfPop)
					print("Receiving " .. (iHalfPop * 2) .. " XP.")
				else 
					print("Receiving " .. (iHalfPop * 2) .. " XP.")
				end
			end
		end
	end
end

if bIsCivActive then
	GameEvents.PlayerDoTurn.Add(ER_XpFromCitizens)
end