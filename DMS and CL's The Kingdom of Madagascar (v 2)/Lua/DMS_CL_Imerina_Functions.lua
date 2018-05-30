-- DMS_CL_Imerina_Functions
-- Author: DMS
--==========================================================================================================================
-- includes
--==========================================================================================================================
include("Sukritact_SaveUtils.lua"); MY_MOD_NAME = "MadagascarUA";
include("PlotIterators.lua")
include("IconSupport")
include("FLuaVector.lua")
--==========================================================================================================================
-- USER SETTINGS
--==========================================================================================================================
-- DMS_GetUserSetting (adapted from JFD's JFD_GetUserSetting - credit goes there!)
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetUserSetting(type)
	for row in GameInfo.DMS_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetUserSetting
----------------------------------------------------------------------------------------------------------------------------
function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end

local bUserSettingPiety = JFD_GetUserSetting("JFD_RTP_PIETY_CORE") == 1
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- Debug
----------------------------------------------------------------------------------------------------------------------------
local bPrintForDebug = DMS_GetUserSetting("DMS_IMERINA_DEBUGGING_ON") == 1

function DMS_Print(string)
	if (not bPrintForDebug) then
		return
	else
		return print(string)
	end
end

----------------------------------------------------------------------------------------------------------------------------
--IsCPDLL
----------------------------------------------------------------------------------------------------------------------------
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()
----------------------------------------------------------------------------------------------------------------------------
--HasTrait
----------------------------------------------------------------------------------------------------------------------------
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
-- JFD_IsCivilisationActive
----------------------------------------------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_SendNotification
------------------------------------------------------------------------------------------------------------------------
function JFD_SendNotification(playerID, notificationType, description, descriptionShort, global, iX, iY)
	local player = Players[playerID]
	if global then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
	else
		if player:IsHuman() then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_GetNearestCity
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetNearestCity(pPlayer, plotX, plotY)
	local iDistance = nil
	local pTargetCity = pPlayer:GetCapitalCity()
	for pCity in pPlayer:Cities() do
		if not(iDistance) or iDistance > Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY()) then
			pTargetCity = pCity
			iDistance = Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY())
		end
	end
	return(pTargetCity)
end
----------------------------------------------------------------------------------------------------------------------------
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID 						= Game.GetActivePlayer()
local activePlayer 							= Players[activePlayerID]
local activePlayerTeam 						= Teams[Game.GetActiveTeam()]
local civilisationImerinaID					= GameInfoTypes["CIVILIZATION_DMS_CL_IMERINA"]
local isImerinaCivActive 					= JFD_IsCivilisationActive(civilisationImerinaID)
local isImerinaActivePlayer 				= activePlayer:GetCivilizationType() == civilisationImerinaID
-- unique components 
local traitTanguenaOrdealID					= GameInfoTypes["TRAIT_DMS_CL_TANGUENA_ORDEAL"]
local improvementRovaID						= GameInfoTypes["IMPROVEMENT_DMS_CL_ROVA"]
local unitTafikaID							= GameInfoTypes["UNIT_DMS_CL_TAFIKA"]
local buildingRovaExpendCounterID			= GameInfoTypes["BUILDING_DMS_ROVA_EXPEND_COUNTER"]
local promotionTafikaID						= GameInfoTypes["PROMOTION_DMS_TAFIKA"]
local promotionAfterRandomID				= GameInfoTypes["PROMOTION_DMS_IMERINA_AFTERRANDOM"]

if isImerinaCivActive then
	print("Queen Ranavalona I joins the game - BEWARE!")
end
--==========================================================================================================================
-- MAIN FUNCTIONS	
--==========================================================================================================================
-- DMS_TanguenaOrdeal_UnitXP
----------------------------------------------------------------------------------------------------------------------------
function DMS_TanguenaOrdeal_UnitXP(iPlayer, iCity, iUnit)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() and HasTrait(pPlayer, traitTanguenaOrdealID) then
		local pCity = pPlayer:GetCityByID(iCity)
		if pCity then
			local iOwnPantheon = nil
			local iOwnReligion = nil
			DMS_Print("DMS_TanguenaOrdeal_UnitXP fired on CityTrained..")
			if IsCPDLL and (not bUserSettingPiety) then
				--iOwnReligion = load(pPlayer, "DMS_Imerina_ReligionFounder") -- not used anymore since G added GetOriginalReligionCreatedByPlayer
				if Player.GetOriginalReligionCreatedByPlayer then
					iOwnReligion = pPlayer:GetOriginalReligionCreatedByPlayer()
				else
					iOwnReligion = pPlayer:GetReligionCreatedByPlayer()
				end
			elseif IsCPDLL and bUserSettingPiety then 
				if pPlayer:HasStateReligion() then
					iOwnReligion = pPlayer:GetStateReligion()
				end
			elseif (not IsCPDLL) then
				if pPlayer:HasCreatedReligion() then
					iOwnReligion = pPlayer:GetReligionCreatedByPlayer()
				elseif pPlayer:GetCapitalCity():GetReligiousMajority() ~= -1 then
					iOwnReligion = pPlayer:GetCapitalCity():GetReligiousMajority()
				else
					iOwnReligion = nil
				end
			end
			----
			if iOwnReligion == nil then -- continue even if player isn't following a religion
				DMS_Print("DMS_TanguenaOrdeal_UnitXP: player does not have a religion")
				local iNumPop = pCity:GetPopulation()
				local iNumFollowersTotal = 0
				local iNumPressureTotal = 0
				for row in GameInfo.Religions() do
					local iReligion = row.ID
					if (iReligion ~= -1) and iReligion ~= iOwnReligion then
						local iNumFollowers	= pCity:GetNumFollowers(iReligion) 
						iNumFollowersTotal = iNumFollowersTotal + iNumFollowers -- followers of foreign religion
						local iNumPressure = pCity:GetPressurePerTurn(iReligion)
						iNumPressureTotal = iNumPressureTotal + iNumPressure -- pressure of foreign religion
					end
				end
				if iNumPop > 0 and iNumPressureTotal > 0 then
					local iXP = math.ceil((iNumPop - iNumFollowersTotal) / iNumPop * (1 + iNumPressureTotal / 10))
					DMS_Print("DMS_TanguenaOrdeal_UnitXP: iXP = " .. iXP .. "")
					if iXP > 0 then
						local pUnit = pPlayer:GetUnitByID(iUnit)
						if pUnit and pUnit:IsCombatUnit() then
							pUnit:ChangeExperience(iXP)
							DMS_Print("DMS_TanguenaOrdeal_UnitXP: = granted experience..")

							if pPlayer:IsHuman() then
								Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pUnit:GetX(), pUnit:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iXP .. "[ENDCOLOR] Experience!", 0)
							end
						end
					end
				end
			----
			elseif iOwnReligion ~= nil then
				DMS_Print("DMS_TanguenaOrdeal_UnitXP: player has a (state) religion")
				local iNumPop = pCity:GetPopulation()
				DMS_Print("DMS_TanguenaOrdeal_UnitXP: city population = " .. iNumPop .. "")
				local iNumFollowersTotal = 0
				local iNumNotHeretics = 0
				local iNumPressureTotal = 0
				DMS_Print("DMS_TanguenaOrdeal_UnitXP: iterating foreign religions to count followers and pressure")
				for row in GameInfo.Religions() do
					local iReligion = row.ID
					if (iReligion ~= -1) and iReligion ~= iOwnReligion then
						local iNumFollowers	= pCity:GetNumFollowers(iReligion) 
						iNumFollowersTotal = iNumFollowersTotal + iNumFollowers -- followers of foreign religion
						local iNumPressure = pCity:GetPressurePerTurn(iReligion)
						iNumPressureTotal = iNumPressureTotal + iNumPressure -- pressure of foreign religion
					end
				end
				DMS_Print("DMS_TanguenaOrdeal_UnitXP: pop following foreign religions = " .. iNumFollowersTotal .. "")
				DMS_Print("DMS_TanguenaOrdeal_UnitXP: foreign religion pressure = " .. iNumPressureTotal .. "")
				if iNumPop > 0 and iNumPressureTotal > 0 then
					local iXP = math.ceil((iNumPop - iNumFollowersTotal) / iNumPop * (iNumPressureTotal / 10))
					DMS_Print("DMS_TanguenaOrdeal_UnitXP: iXP = " .. iXP .. "")
					if iXP > 0 then
						local pUnit = pPlayer:GetUnitByID(iUnit)
						if pUnit and pUnit:IsCombatUnit() then
							pUnit:ChangeExperience(iXP)
							DMS_Print("DMS_TanguenaOrdeal_UnitXP: = granted experience..")

							if pPlayer:IsHuman() then
								Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pUnit:GetX(), pUnit:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iXP .. "[ENDCOLOR] Experience!", 0)
							end
						end
					end
				end
			end
		end
	end
end

GameEvents.CityTrained.Add(DMS_TanguenaOrdeal_UnitXP)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Imerina_CPReligionFound (Thanks for this Chrisy)
----------------------------------------------------------------------------------------------------------------------------
function DMS_Imerina_CPReligionFound(iPlayer, iCity, eReligion)
    save(Players[iPlayer], "DMS_Imerina_ReligionFounder", eReligion)
end

if IsCPDLL and (not bUserSettingPiety) then
    GameEvents.ReligionFounded.Add(DMS_Imerina_CPReligionFound)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_VoromaheryXPSiphon
----------------------------------------------------------------------------------------------------------------------------
function DMS_VoromaheryXPSiphon(iPlayer, iUnit, iNewDamage, iOldDamage)
    if iNewDamage > iOldDamage then
        local pPlayer = Players[iPlayer]
		if pPlayer then
			for pUnit in pPlayer:Units() do
				if pUnit:GetID() == iUnit then
					if pUnit and (not pUnit:IsHasPromotion(promotionAfterRandomID)) then
						local pPlot = pUnit:GetPlot()
						if pPlot then
							local iRange = 2
							for dX = -iRange, iRange do
								for dY = -iRange, iRange do
									local pSpecificPlot = Map.PlotXYWithRangeCheck(pPlot:GetX(), pPlot:GetY(), dX, dY, iRange)
									if pSpecificPlot ~= nil then
										if pSpecificPlot:GetNumUnits() > 0 then
											for i = 0, pSpecificPlot:GetNumUnits() - 1 do
												local pSH = pSpecificPlot:GetUnit(i)
												if pSH and pSH:IsHasPromotion(promotionAfterRandomID) then
													DMS_Print("DMS_VoromaheryXPSiphon: found attacker..")
													-- attacker found
													local iUnitXP = pUnit:GetExperience()
													if iUnitXP == 0 then -- may include barbs this way (I don't think they generate XP)
														local iUnitHP = math.floor(100 - pUnit:GetDamage())
														local iSiphonXP = math.min(iUnitXP, math.floor((100 - iUnitHP) / 10))
														pSH:ChangeExperience(iSiphonXP)
														DMS_Print("DMS_VoromaheryXPSiphon: granted XP (couldn't siphon XP as attacked unit didn't have any..")
														if Players[pSH:GetOwner()]:IsHuman() then
															Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pSH:GetX(), pSH:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iSiphonXP .. "[ENDCOLOR] Experience!", 2)
															Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pUnit:GetX(), pUnit:GetY()))), "[COLOR_NEGATIVE_TEXT]-" .. iSiphonXP .. "[ENDCOLOR] Experience!", 2)
														end
													elseif iUnitXP > 0 then
														local iUnitHP = math.floor(100 - pUnit:GetDamage())
														--local iUnitLevel = pUnit:GetLevel()
														--local iAttackerLevel = pSH:GetLevel()
														local iSiphonXP = math.min(iUnitXP, math.floor((100 - iUnitHP) / 10))
														local iRemoveXP = math.min(iUnitXP, math.floor((100 - iUnitHP) / 10))
														pSH:ChangeExperience(iSiphonXP)
														pUnit:ChangeExperience(-iRemoveXP)
														DMS_Print("DMS_VoromaheryXPSiphon: Siphoned XP..")
														if pPlayer:IsHuman() or Players[pSH:GetOwner()]:IsHuman() then
															Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pSH:GetX(), pSH:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iSiphonXP .. "[ENDCOLOR] Experience!", 2)
															Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pUnit:GetX(), pUnit:GetY()))), "[COLOR_NEGATIVE_TEXT]-" .. iRemoveXP .. "[ENDCOLOR] Experience!", 2)
														end
														if iUnitHP < 60 and iUnitXP < 25 then
															DMS_Print("DMS_VoromaheryXPSiphon: unit has less than 60 HP and less than 25 XP - steal promotion..")
															local tPromotionsToSteal = {}
															for UnitPromotion in GameInfo.UnitPromotions() do
																local iPromotion = UnitPromotion.ID
																if pUnit:IsHasPromotion(iPromotion) then
																	if pSH:IsPromotionValid(iPromotion) then
																		if (not pSH:IsHasPromotion(iPromotion)) then
																			local bCannotBeChosen = UnitPromotion.CannotBeChosen
																			if bCannotBeChosen == 0 or bCannotBeChosen == false or bCannotBeChosen == "false" then
																				local bIsFreePromotion = false
																				for FreePromotion in GameInfo.Unit_FreePromotions() do
																					local iFreePromotionUnit = FreePromotion.UnitType
																					if (iUnit == iFreePromotionUnit) then
																						local iFreePromotion = FreePromotion.PromotionType
																						if (iPromotion == iFreePromotion) then
																							bIsFreePromotion = true
																						end
																					end
																				end
																				if bIsFreePromotion == false then
																					tPromotionsToSteal[iPromotion] = iPromotion
																				end
																			end
																		end
																	end
																end
															end
															if #tPromotionsToSteal > 0 then
																DMS_Print("DMS_VoromaheryXPSiphon: unit has one or more promotion to steal..")
																pSH:SetHasPromotion(iPromotion, true)
																pUnit:SetHasPromotion(iPromotion, false)
																if pPlayer:IsHuman() or Players[pSH:GetOwner()]:IsHuman() then
																	Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pSH:GetX(), pSH:GetY()))), "Stole [COLOR_POSITIVE_TEXT]" .. GameInfo.UnitPromotion[iPromotion].Description .. "[ENDCOLOR] Promotion!", 2)
																	Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pUnit:GetX(), pUnit:GetY()))), "Lost [COLOR_NEGATIVE_TEXT]" .. GameInfo.UnitPromotion[iPromotion].Description .. "[ENDCOLOR] Promotion!", 2)
																end
															else
																DMS_Print("DMS_VoromaheryXPSiphon: unit doesn't have any promotions that can be stolen..")
															end
														end
														pSH:SetHasPromotion(promotionAfterRandomID, false)
														pSH:SetHasPromotion(promotionTafikaID, true)
														DMS_Print("DMS_VoromaheryXPSiphon: promotions resat..")
														return
													end
													pSH:SetHasPromotion(promotionAfterRandomID, false)
													pSH:SetHasPromotion(promotionTafikaID, true)
													DMS_Print("DMS_VoromaheryXPSiphon: promotions resat..")
													return
												end
											end  
										end
									end
								end
							end
						end
					end 
				end
			end
		end
    end
end

if isImerinaCivActive then
	Events.SerialEventUnitSetDamage.Add(DMS_VoromaheryXPSiphon)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_RovaExpend
----------------------------------------------------------------------------------------------------------------------------
function DMS_RovaExpend_Init()
	Controls.RovaExpendButton:SetHide(true)
end
DMS_RovaExpend_Init()

function DMS_RovaExpend_UnitSelectionCleared()
	Controls.RovaExpendButton:SetHide(true)
end
Events.UnitSelectionCleared.Add(DMS_RovaExpend_UnitSelectionCleared)

function DMS_RovaExpend_CityScreen()
	Controls.RovaExpendButton:SetHide(true)
end
Events.SerialEventEnterCityScreen.Add(DMS_RovaExpend_CityScreen)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_OnRovaExpend
----------------------------------------------------------------------------------------------------------------------------
function DMS_OnRovaExpend()
	Controls.RovaExpendButton:SetHide(true)
	local pUnit = UI.GetHeadSelectedUnit()
	if pUnit then

		local iPlayer = pUnit:GetOwner()
		local pPlayer = Players[iPlayer]
		if pPlayer then
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				local iNumRovaExpendCounter = pCapital:GetNumRealBuilding(buildingRovaExpendCounterID) + 1
				pCapital:SetNumRealBuilding(buildingRovaExpendCounterID, iNumRovaExpendCounter)		
				DMS_Print("DMS_OnRovaExpend: " .. iNumRovaExpendCounter .. "'th unit expended on Rova..")
				if iNumRovaExpendCounter == 12 then
					pPlayer:ChangeNumFreePolicies(1)
					DMS_Print("DMS_OnRovaExpend: Free policy granted..")
					pCapital:SetNumRealBuilding(buildingRovaExpendCounterID, 0)
					if pPlayer:IsHuman() then
						Events.GameplayAlertMessage("Unit expended on a Rova - receive a free Social Policy!")
					end
				else
					if pPlayer:IsHuman() then
						Events.GameplayAlertMessage("Unit expended on a Rova - expend [COLOR_POSITIVE_TEXT]" .. 12 - iNumRovaExpendCounter .. "[ENDCOLOR] more Units to receive a free Social Policy!")
					end			
				end
				local iX = pUnit:GetX()
				local iY = pUnit:GetY()
				if iX and iY then
					local nearestCity = DMS_GetNearestCity(pPlayer, iX, iY)
					if nearestCity then
						local iUnitType = pUnit:GetUnitType()
						local iUnitCost = GameInfo.Units[iUnitType].Cost
						if iUnitCost > 0 then
							nearestCity:ChangeProduction(iUnitCost)
					
							if pPlayer:IsHuman() then
								Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(nearestCity:Plot():GetX(), nearestCity:Plot():GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iUnitCost .. "[ENDCOLOR] [ICON_PRODUCTION] Production in " .. nearestCity:GetName() .. "!", 0)
							end
						end
					end
				end

				local iNumUnitPromotions = 0
				for row in GameInfo.UnitPromotions() do
					local iPromotion = row.ID
					if iPromotion and pUnit:IsHasPromotion(iPromotion) then
						iNumUnitPromotions = iNumUnitPromotions + 1
					end
				end
				if iNumUnitPromotions > 0 then
					local iFaithBonus = math.ceil(iNumUnitPromotions * 6)
					if iFaithBonus > 50 then
						iFaithBonus = 50
					end
					pPlayer:ChangeFaith(iFaithBonus)

					if pPlayer:IsHuman() then
						Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pUnit:GetX(), pUnit:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iFaithBonus .. "[ENDCOLOR] [ICON_PEACE] Faith!", 0)
					end
				end

				if nearestCity then
					local iOwnReligion = -1
					if IsCPDLL and (not bUserSettingPiety) then
						--iOwnReligion = load(pPlayer, "DMS_Imerina_ReligionFounder") -- not used anymore since G added GetOriginalReligionCreatedByPlayer
						if Player.GetOriginalReligionCreatedByPlayer then
							iOwnReligion = pPlayer:GetOriginalReligionCreatedByPlayer()
						else
							iOwnReligion = pPlayer:GetReligionCreatedByPlayer()
						end
					elseif IsCPDLL and bUserSettingPiety then 
						if pPlayer:HasStateReligion() then
							iOwnReligion = pPlayer:GetStateReligion()
						end
					elseif (not IsCPDLL) then
						if pPlayer:HasCreatedReligion() then
							iOwnReligion = pPlayer:GetReligionCreatedByPlayer()
						elseif pPlayer:GetCapitalCity():GetReligiousMajority() ~= -1 then
							iOwnReligion = pPlayer:GetCapitalCity():GetReligiousMajority()
						else
							iOwnReligion = -1
						end
					end
					if nearestCity and iOwnReligion ~= -1 then
						local iNumPop = nearestCity:GetPopulation()
						local iNumFollowersTotal = 0
						for row in GameInfo.Religions() do
							local iReligion = row.ID
							if (iReligion ~= -1) and iReligion ~= iOwnReligion then
								local iNumFollowers	= nearestCity:GetNumFollowers(iReligion) 
								iNumFollowersTotal = iNumFollowersTotal + iNumFollowers -- followers of foreign religion
								local iPercent = math.floor((iNumFollowersTotal / iNumPop) * 100)
								nearestCity:ConvertPercentFollowers(iOwnReligion, iReligion, iPercent)
							end
						end
					end
				end

				pUnit:Kill(true, -1)

			end
		end
		--Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pUnit:GetX(), pUnit:GetY()))), "Unit expended on Rova!")
	end
end

Controls.RovaExpendButton:RegisterCallback(Mouse.eLClick, DMS_OnRovaExpend)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_RoveExpend_Show_USC
----------------------------------------------------------------------------------------------------------------------------
function DMS_RoveExpend_Show_USC(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() and HasTrait(pPlayer, traitTanguenaOrdealID) then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		DMS_Print("DMS_RoveExpend_Show_USC initializing..")
		if pUnit and pUnit:IsCombatUnit() then
			local pPlot = pUnit:GetPlot()
			if pPlot and pPlot:GetImprovementType() == improvementRovaID then
				DMS_Print("DMS_RoveExpend_Show_USC: unit is on a rova tile..")
				Controls.RovaExpendButton:SetHide(false)
				local iNumPromotions = 0
				for UnitPromotion in GameInfo.UnitPromotions() do
					local iPromotion = UnitPromotion.ID
					if pUnit:IsHasPromotion(iPromotion) then
						local bCannotBeChosen = UnitPromotion.CannotBeChosen
						if bCannotBeChosen == 0 or bCannotBeChosen == false or bCannotBeChosen == "false" then
							local bIsFreePromotion = false
							for FreePromotion in GameInfo.Unit_FreePromotions() do
								local iFreePromotionUnit = FreePromotion.UnitType
								if (iUnit == iFreePromotionUnit) then
									local iFreePromotion = FreePromotion.PromotionType
									if (iPromotion == iFreePromotion) then
										bIsFreePromotion = true
										DMS_Print("DMS_RoveExpend_Show_USC: bIsFreePromotion = true - terminate..")
									end
								end
							end
							if bIsFreePromotion == false then
								iNumPromotions = iNumPromotions + 1
								DMS_Print("DMS_RoveExpend_Show_USC: iNumPromotions = " .. iNumPromotions .. "..")
							end
						end
					end
				end
				if iNumPromotions >= 3 then
					local pCapital = pPlayer:GetCapitalCity()
					if not pCapital then 
						local buttonToolTipEnabled = Locale.ConvertTextKey("TXT_KEY_UNIT_DMS_CL_ROVA_EXPEND_TT_DISABLED_NO_CAPITAL")
					end
					local iNumUnitsToExpend = 12 - pCapital:GetNumRealBuilding(buildingRovaExpendCounterID)
					local nearestCity = DMS_GetNearestCity(pPlayer, pPlot:GetX(), pPlot:GetY())
					local iFaithBonus = math.ceil(iNumPromotions * 6)
					local buttonToolTipEnabled = Locale.ConvertTextKey("TXT_KEY_UNIT_DMS_CL_ROVA_EXPEND_TT_ENABLED", iNumUnitsToExpend, nearestCity:GetName(), iNumPromotions, iFaithBonus)
					Controls.RovaExpendButton:SetDisabled(false)
					Controls.RovaExpendButton:LocalizeAndSetToolTip(buttonToolTipEnabled)
				elseif iNumPromotions < 3 then
					local pCapital = pPlayer:GetCapitalCity()
					if not pCapital then 
						local buttonToolTipEnabled = Locale.ConvertTextKey("TXT_KEY_UNIT_DMS_CL_ROVA_EXPEND_TT_DISABLED_NO_CAPITAL")
					end
					local iNumUnitsToExpend = 12 - pCapital:GetNumRealBuilding(buildingRovaExpendCounterID)
					local buttonToolTipDisabled = Locale.ConvertTextKey("TXT_KEY_UNIT_DMS_CL_ROVA_EXPEND_TT_DISABLED", iNumUnitsToExpend)
					Controls.RovaExpendButton:SetDisabled(true)
					Controls.RovaExpendButton:LocalizeAndSetToolTip(buttonToolTipDisabled)
				end
			else
				Controls.RovaExpendButton:SetHide(true) -- plot nil or not rova
			end
		else
			Controls.RovaExpendButton:SetHide(true) -- not combat unit
		end
	else
		Controls.RovaExpendButton:SetHide(true) -- not madagascar
	end
end

Events.UnitSelectionChanged.Add(DMS_RoveExpend_Show_USC)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_RoveExpend_Show_USXY
----------------------------------------------------------------------------------------------------------------------------
function DMS_RoveExpend_Show_USXY(iPlayer, iUnit, iX, iY)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() and HasTrait(pPlayer, traitTanguenaOrdealID) then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit and pUnit:IsCombatUnit() then
			local pPlot = pUnit:GetPlot()
			if pPlot and pPlot:GetImprovementType() == improvementRovaID then
				DMS_Print("DMS_RoveExpend_Show_USXY: unit is on a rova tile..")
				Controls.RovaExpendButton:SetHide(false)
				local iNumPromotions = 0
				for UnitPromotion in GameInfo.UnitPromotions() do
					local iPromotion = UnitPromotion.ID
					if pUnit:IsHasPromotion(iPromotion) then
						local bCannotBeChosen = UnitPromotion.CannotBeChosen
						if bCannotBeChosen == 0 or bCannotBeChosen == false or bCannotBeChosen == "false" then
							local bIsFreePromotion = false
							for FreePromotion in GameInfo.Unit_FreePromotions() do
								local iFreePromotionUnit = FreePromotion.UnitType
								if (iUnit == iFreePromotionUnit) then
									local iFreePromotion = FreePromotion.PromotionType
									if (iPromotion == iFreePromotion) then
										bIsFreePromotion = true
										DMS_Print("DMS_RoveExpend_Show_USXY: bIsFreePromotion = true - terminate..")
									end
								end
							end
							if bIsFreePromotion == false then
								iNumPromotions = iNumPromotions + 1
								DMS_Print("DMS_RoveExpend_Show_USXY: iNumPromotions = " .. iNumPromotions .. "..")
							end
						end
					end
				end
				if iNumPromotions >= 3 then
					local pCapital = pPlayer:GetCapitalCity()
					if not pCapital then 
						local buttonToolTipEnabled = Locale.ConvertTextKey("TXT_KEY_UNIT_DMS_CL_ROVA_EXPEND_TT_DISABLED_NO_CAPITAL")
					end
					local iNumUnitsToExpend = 12 - pCapital:GetNumRealBuilding(buildingRovaExpendCounterID)
					local nearestCity = DMS_GetNearestCity(pPlayer, pPlot:GetX(), pPlot:GetY())
					local iFaithBonus = math.ceil(iNumPromotions * 8)
					local buttonToolTipEnabled = Locale.ConvertTextKey("TXT_KEY_UNIT_DMS_CL_ROVA_EXPEND_TT_ENABLED", iNumUnitsToExpend, nearestCity:GetName(), iNumPromotions, iFaithBonus)
					Controls.RovaExpendButton:SetDisabled(false)
					Controls.RovaExpendButton:LocalizeAndSetToolTip(buttonToolTipEnabled)
				elseif iNumPromotions < 3 then
					local pCapital = pPlayer:GetCapitalCity()
					if not pCapital then 
						local buttonToolTipEnabled = Locale.ConvertTextKey("TXT_KEY_UNIT_DMS_CL_ROVA_EXPEND_TT_DISABLED_NO_CAPITAL")
					end
					local iNumUnitsToExpend = 12 - pCapital:GetNumRealBuilding(buildingRovaExpendCounterID)
					local buttonToolTipDisabled = Locale.ConvertTextKey("TXT_KEY_UNIT_DMS_CL_ROVA_EXPEND_TT_DISABLED", iNumUnitsToExpend)
					Controls.RovaExpendButton:SetDisabled(true)
					Controls.RovaExpendButton:LocalizeAndSetToolTip(buttonToolTipDisabled)
				end
			else
				Controls.RovaExpendButton:SetHide(true) -- plot nil or not rova
			end
		else
			Controls.RovaExpendButton:SetHide(true) -- not combat unit
		end
	else
		Controls.RovaExpendButton:SetHide(true) -- not madagascar
	end
end

GameEvents.UnitSetXY.Add(DMS_RoveExpend_Show_USXY)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_RoveExpend_AI
----------------------------------------------------------------------------------------------------------------------------
function DMS_RoveExpend_AI(iPlayer, iUnit, iX, iY)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() and HasTrait(pPlayer, traitTanguenaOrdealID) then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if (pUnit == nil or pUnit:IsDelayedDeath()) then 
			do DMS_Print("DMS_RoveExpend_AI: unit nil or IsDelayedDeath") return end 
		end
		if pUnit and pUnit:IsCombatUnit() then
			local pPlot = pUnit:GetPlot()
			if pPlot and pPlot:GetImprovementType() == improvementRovaID then
				local iRand = JFD_GetRandom(1,3)
				if iRand <= 2 then
					local iNumPromotions = 0
					for UnitPromotion in GameInfo.UnitPromotions() do
						local iPromotion = UnitPromotion.ID
						if pUnit:IsHasPromotion(iPromotion) then
							local bCannotBeChosen = UnitPromotion.CannotBeChosen
							if bCannotBeChosen == 0 or bCannotBeChosen == false or bCannotBeChosen == "false" then
								local bIsFreePromotion = false
								for FreePromotion in GameInfo.Unit_FreePromotions() do
									local iFreePromotionUnit = FreePromotion.UnitType
									if (iUnit == iFreePromotionUnit) then
										local iFreePromotion = FreePromotion.PromotionType
										if (iPromotion == iFreePromotion) then
											bIsFreePromotion = true
											DMS_Print("DMS_RoveExpend_AI: bIsFreePromotion = true - terminate..")
										end
									end
								end
								if bIsFreePromotion == false then
									iNumPromotions = iNumPromotions + 1
									DMS_Print("DMS_RoveExpend_AI: iNumPromotions = " .. iNumPromotions .. "..")
								end
							end
						end
					end
					if iNumPromotions >= 3 then
						local pCapital = pPlayer:GetCapitalCity()
						if pCapital then
							local iNumRovaExpendCounter = pCapital:GetNumRealBuilding(buildingRovaExpendCounterID) + 1
							pCapital:SetNumRealBuilding(buildingRovaExpendCounterID, iNumRovaExpendCounter)		
							DMS_Print("DMS_RoveExpend_AI: " .. iNumRovaExpendCounter .. "'th unit expended on Rova..")
							if iNumRovaExpendCounter == 12 then
								pPlayer:ChangeNumFreePolicies(1)
								DMS_Print("DMS_RoveExpend_AI: Free policy granted..")
								pCapital:SetNumRealBuilding(buildingRovaExpendCounterID, 0)
							end
							if (iX == pUnit:GetX()) and (iY == pUnit:GetY()) and (iX ~= nil) and (iY~= nil) then
								local nearestCity = DMS_GetNearestCity(pPlayer, pUnit:GetX(), pUnit:GetY())
								if nearestCity then
									local iUnitType = pUnit:GetUnitType()
									local iUnitCost = GameInfo.Units[iUnitType].Cost
									if iUnitCost > 0 then
										nearestCity:ChangeProduction(iUnitCost)
									end
								end
							else
								DMS_Print("DMS_RoveExpend_AI: unit coordinates are nil - terminate")
								do return end
							end
							if iNumPromotions > 0 then
								local iFaithBonus = math.ceil(iNumPromotions * 6)
								if iFaithBonus > 50 then
									iFaithBonus = 50
								end
								pPlayer:ChangeFaith(iFaithBonus)
							end

							if nearestCity then
								local iOwnReligion = -1
								if IsCPDLL and (not bUserSettingPiety) then
									--iOwnReligion = load(pPlayer, "DMS_Imerina_ReligionFounder") -- not used anymore since G added GetOriginalReligionCreatedByPlayer
									if Player.GetOriginalReligionCreatedByPlayer then
										iOwnReligion = pPlayer:GetOriginalReligionCreatedByPlayer()
									else
										iOwnReligion = pPlayer:GetReligionCreatedByPlayer()
									end
								elseif IsCPDLL and bUserSettingPiety then 
									if pPlayer:HasStateReligion() then
										iOwnReligion = pPlayer:GetStateReligion()
									end
								elseif (not IsCPDLL) then
									if pPlayer:HasCreatedReligion() then
										iOwnReligion = pPlayer:GetReligionCreatedByPlayer()
									elseif pPlayer:GetCapitalCity():GetReligiousMajority() ~= -1 then
										iOwnReligion = pPlayer:GetCapitalCity():GetReligiousMajority()
									else
										iOwnReligion = -1
									end
								end
								if iOwnReligion ~= -1 then
									local iNumPop = nearestCity:GetPopulation()
									local iNumFollowersTotal = 0
									for row in GameInfo.Religions() do
										local iReligion = row.ID
										if (iReligion ~= -1) and iReligion ~= iOwnReligion then
											local iNumFollowers	= nearestCity:GetNumFollowers(iReligion) 
											iNumFollowersTotal = iNumFollowersTotal + iNumFollowers -- followers of foreign religion
											if iNumPop > 0 then
												local iPercent = math.floor((iNumFollowersTotal / iNumPop) * 100)
												nearestCity:ConvertPercentFollowers(iOwnReligion, iReligion, iPercent)
											end
										end
									end
								end
							end

							pUnit:Kill(true, -1)

						end
					end
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(DMS_RoveExpend_AI)
--==========================================================================================================================
--==========================================================================================================================