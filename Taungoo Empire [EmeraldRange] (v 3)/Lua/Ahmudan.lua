-- Ahmudan Conscript UA
-- Author: EmeraldRange, Chrisy15
-- DateCreated: 4/27/2017 6:27:14 PM
-------------------------------------------------------------------------------------------------------------------------
print "Taungoo Mod Loaded"
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
--       MC's Sparta's method
-------------------------------------------------------------------------------------------------------------------------
function GetStrongestMilitaryUnit(pPlayer, bIgnoreResources, ...)
	local tUnit = {["ID"] = GameInfoTypes.UNIT_WARRIOR, ["Combat"] = -1}
	for iKey, sCombatType in pairs({...}) do
		for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
			if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
				tUnit = row
			end
		end
	end
	return tUnit.ID
end
-------------------------------------------------------------------------------------------------------------------------
local iCiv = GameInfoTypes.CIVILIZATION_TAUNGOO
local iUAfrequency = 5 --the frequency of the UA based on GameSpeed 
local bIsCivActive = JFD_IsCivilisationActive(iCiv)

-------------------------------------------------------------------------------------------------------------------------
--       "Spawns units every 5 turns (on Standard Speed) in puppet cities during Golden Ages." 
--       by Chrisy15
-------------------------------------------------------------------------------------------------------------------------
local tSpeeds = {}
for row in DB.Query("SELECT ID, GoldenAgePercent FROM GameSpeeds") do -- Not most efficient way but I'm never sure how to use direct GameInfo queries
	tSpeeds[row.ID] = row.GoldenAgePercent
end

iUAfrequency = math.floor(iUAfrequency * (tSpeeds[Game.GetGameSpeedType()] / 100))

print("Taungoo UA to be activated every " .. iUAfrequency .. " turns")

local iCounterBuilding = GameInfoTypes[""] -- Blank dummy building for counting GA turns on a city-by-city basis

function ER_GoldenAgeUnitSpawn(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iCiv then -- Need to check that the player is the civ
		if pPlayer:IsGoldenAge() then
			local iUnit = GetStrongestMilitaryUnit(pPlayer, false, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
			local iCount = 0
			for pCity in pPlayer:Cities() do
				if pCity:IsPuppet() then -- Count city-wise to catch cities puppeted during golden ages, and use dummies to make the value consistent between sessions
					pCity:SetNumRealBuilding(iCounterBuilding, pCity:GetNumRealBuilding(iCounterBuilding) + 1)
					if pCity:GetNumRealBuilding(iCounterBuilding) == iUAfrequency then
						pCity:SetNumRealBuilding(iCounterBuilding, 0)
						local pUnit = pPlayer:InitUnit(iUnit, pCity:GetX(), pCity:GetY())
						pUnit:JumpToNearestValidPlot()
						iCount = iCount + 1
					end
				end
			end
			if iCount > 0 then
				local sNotifyText = Locale.ConvertTextKey("TXT_KEY_ER_TAUNGOO_CONSCRIPTION_TEXT", iCount)
				local sNotifyHeading = Locale.ConvertTextKey("TXT_KEY_ER_TAUNGOO_CONSCRIPTION_HEAD")
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sNotifyText, sNotifyHeading)
			end
		end
	end
end

if bIsCivActive then
	GameEvents.PlayerDoTurn.Add(ER_GoldenAgeUnitSpawn)
end
-------------------------------------------------------------------------------------------------------------------------
--       "Provides Golden Age Points upon City Capture" 
--       by EmeraldRange
-------------------------------------------------------------------------------------------------------------------------
function ER_GainGoldenPoints(iOldOwner, bIsCapital, iCityX, iCityY, iNewOwner, iPop, bConquest)
	print "Attempting to give GA points"
	local pPlayer = Players[iNewOwner]
	local pCity = (Map.GetPlot(iCityX, iCityY):GetPlotCity())
	local iGoldenAgeBonus = math.floor(pCity:GetStrengthValue() / 800) * 100 --equivalent to eighth of the city strength

	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iCiv  and bConquest then
		pPlayer:ChangeGoldenAgeProgressMeter( iGoldenAgeBonus )
		print ("Got " .. iGoldenAgeBonus .. "Golden Age Points")
		local sNotifyText = ("Gained " .. iGoldenAgeBonus .. " [ICON_GOLDEN_AGE] Golden Age Points from your conquest")
		local sNotifyHeading = Locale.ConvertTextKey("TXT_KEY_ER_TAUNGOO_GA_BONUS_HEAD")
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sNotifyText, sNotifyHeading)
	end
end
if bIsCivActive then
	GameEvents.CityCaptureComplete.Add(ER_GainGoldenPoints)
end