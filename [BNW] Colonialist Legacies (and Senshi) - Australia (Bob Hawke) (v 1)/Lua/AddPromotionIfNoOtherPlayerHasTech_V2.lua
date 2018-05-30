

local iRequiredCivilization = GameInfoTypes.CIVILIZATION_SENSHI_HAWKE
local iNoPlayerHasResearchedPromo = GameInfoTypes.PROMOTION_SENSHI_SASR_BONUS
local iRequiredUnit = GameInfoTypes.UNIT_SENSHI_SASR
local iRequiredBuilding = GameInfoTypes.BUILDING_SENSHI_CSIRO
local iCityGoldenAgePercentage = 33

function HasAnyPlayerResearchedTech(iPlayer, iTech, bCountTheDead)
	for iScanPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		if iScanPlayer ~= iPlayer then
			local pPlayer = Players[iScanPlayer]
			if pPlayer:IsEverAlive() then
				local pTeam = Teams[pPlayer:GetTeam()]
				if bCountTheDead then
					if pTeam:IsHasTech(iTech) then
						return true
					end
				else
					if pPlayer:IsAlive() then
						if pTeam:IsHasTech(iTech) then
							return true
						end
					end
				end
			end
		end
	end
	return false
end
function SetPromotionToUnitType(iPlayer, iPromotion, iUnit, bBoolean)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:GetUnitType() == iUnit then
			pUnit:SetHasPromotion(iPromotion, bBoolean)
		end
	end
end
function MonitorPlayerResearch(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() ~= iRequiredCivilization then return end
	if (pPlayer:GetCurrentResearch() ~= -1) and (pPlayer:GetCurrentResearch() ~= nil) then
		local bAddPromotion = (not HasAnyPlayerResearchedTech(iPlayer, pPlayer:GetCurrentResearch(), false))
		SetPromotionToUnitType(iPlayer, iNoPlayerHasResearchedPromo, iRequiredUnit, bAddPromotion)
	end
end
function TeamResearchedATech(iTeam, iTech, iChange)
	local pOurPlayer, iPlayerNum = "NONE", -1
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		if (Players[iPlayer]:IsAlive()) then
			if Players[iPlayer]:GetCivilizationType() == iRequiredCivilization then
				pOurPlayer, iPlayerNum = Players[iPlayer], iPlayer
				if (pOurPlayer:GetTeam() == iTeam) then
					SetPromotionToUnitType(iPlayer, iNoPlayerHasResearchedPromo, iRequiredUnit, false)
					if pOurPlayer:CountNumBuildings(iRequiredBuilding) > 0 then
						for pCity in pOurPlayer:Cities() do
							if pCity:IsHasBuilding(iRequiredBuilding) then
								local iCityPop = pCity:GetPopulation()
								local iGoldenAgePoints = math.floor(iCityPop * (iCityGoldenAgePercentage/100))
								pOurPlayer:ChangeGoldenAgeProgressMeter(iGoldenAgePoints)
								if pOurPlayer:IsHuman() then
									Events.GameplayAlertMessage(iGoldenAgePoints .. " [ICON_GOLDEN_AGE] Golden Age Points added from the city of " .. pCity:GetName())
								end
							end
						end
					end
					return
				end
			end
		end
	end
	if iPlayerNum ~= -1 then
		if (pOurPlayer:GetCurrentResearch() ~= -1) and (pOurPlayer:GetCurrentResearch() ~= nil) and (pOurPlayer:GetCurrentResearch() == iTech) then
			SetPromotionToUnitType(iPlayerNum, iNoPlayerHasResearchedPromo, iRequiredUnit, false)
		end
	end
end
function IsCivInPlay(iCivType)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local iSlotStatus = PreGame.GetSlotStatus(iSlot)
		if (iSlotStatus == SlotStatus.SS_TAKEN or iSlotStatus == SlotStatus.SS_COMPUTER) then
			if (PreGame.GetCivilization(iSlot) == iCivType) then
				return true
			end
		end
	end
	return false
end
if IsCivInPlay(iRequiredCivilization) then
	GameEvents.PlayerDoTurn.Add(MonitorPlayerResearch)
	GameEvents.TeamTechResearched.Add(TeamResearchedATech)
end
























