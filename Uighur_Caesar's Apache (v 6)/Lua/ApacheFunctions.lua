-- Lua Script1
-- Author: pedro
-- DateCreated: 08/30/15 12:32:52 PM
--------------------------------------------------------------
local apacheID							= GameInfoTypes["CIVILIZATION_UC_APACHE"]
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

local isApacheActive = JFD_IsCivilisationActive(apacheID)

function ApachePillageMovement(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if player:GetCivilizationType() == apacheID and player:IsAlive() then
	local plot = unit:GetPlot()
	if (not plot) then return end
	if (plot:GetImprovementType() ~= -1) then
	if plot:IsImprovementPillaged() then
	if plot:IsRoughGround() then
	unit:ChangeMoves(120)
	else unit:ChangeMoves(60)
				end
			end
		end
	end
end
if isApacheActive then
GameEvents.UnitSetXY.Add(ApachePillageMovement)
end

function RenegadeSurvivalOne(ownerId, unitId, ePromotion)
local player = Players[ownerId]
	local unit = player:GetUnitByID(unitId)
			if unit:GetUnitType() == GameInfoTypes.UNIT_UC_RENEGADE then
			if ePromotion == (GameInfoTypes.PROMOTION_DRILL_1) or ePromotion == (GameInfoTypes.PROMOTION_SHOCK_1) then
			if not unit:IsHasPromotion(GameInfoTypes.PROMOTION_SURVIVALISM_1) then
			unit:SetHasPromotion(GameInfoTypes.PROMOTION_SURVIVALISM_1, true)
			end
		end
	end
end
GameEvents.UnitPromoted.Add(RenegadeSurvivalOne)

function RenegadeSurvivalTwo(ownerId, unitId, ePromotion)
local player = Players[ownerId]
	local unit = player:GetUnitByID(unitId)
			if unit:GetUnitType() == GameInfoTypes.UNIT_UC_RENEGADE then
			if ePromotion == (GameInfoTypes.PROMOTION_DRILL_2) or ePromotion == (GameInfoTypes.PROMOTION_SHOCK_2) then
			if not unit:IsHasPromotion(GameInfoTypes.PROMOTION_SURVIVALISM_2) then
			unit:SetHasPromotion(GameInfoTypes.PROMOTION_SURVIVALISM_2, true)
			end
		end
	end
end
GameEvents.UnitPromoted.Add(RenegadeSurvivalTwo)

function RenegadeSurvivalThree(ownerId, unitId, ePromotion)
local player = Players[ownerId]
	local unit = player:GetUnitByID(unitId)
			if unit:GetUnitType() == GameInfoTypes.UNIT_UC_RENEGADE then
			if ePromotion == (GameInfoTypes.PROMOTION_DRILL_3) or ePromotion == (GameInfoTypes.PROMOTION_SHOCK_3) then
			if not unit:IsHasPromotion(GameInfoTypes.PROMOTION_SURVIVALISM_3) then
			unit:SetHasPromotion(GameInfoTypes.PROMOTION_SURVIVALISM_3, true)
			end
		end
	end
end
GameEvents.UnitPromoted.Add(RenegadeSurvivalThree)

function ApacheWorker(oldOwnerID, capital, plotX, plotY, newOwnerID)
local player = Players[newOwnerID]
	if (player:IsAlive() and player:GetCivilizationType() == apacheID) then
		local capturedCity = Map.GetPlot(plotX, plotY):GetPlotCity()
		local capturedCityOriginalOwnerID = capturedCity:GetOriginalOwner()
		if capturedCityOriginalOwnerID ~= newOwnerID then
			if (not capturedCity:IsHasBuilding(GameInfoTypes.BUILDING_UC_APACHE_CANCEL)) then
				capturedCity:SetNumRealBuilding(GameInfoTypes.BUILDING_UC_APACHE_CANCEL, 1)
			end
			player:InitUnit(GameInfoTypes.UNIT_WORKER, plotX, plotY)
					end
				end
			end
GameEvents.CityCaptureComplete.Add(ApacheWorker)

function ApacheXPMove(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if player:GetCivilizationType() == apacheID and player:IsAlive() then
	local plot = unit:GetPlot()
	if (not plot) then return end
	if (plot:GetImprovementType() ~= -1) then
	if plot:IsImprovementPillaged() then
	if not unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_APACHE_XP) then
			unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_APACHE_XP, true)
				end
			end
		end
	end
end
if isApacheActive then
GameEvents.UnitSetXY.Add(ApacheXPMove)
end

function ApacheXPMoveCancel(playerID, unitID, unitX, unitY)
	local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	if player:GetCivilizationType() == apacheID and player:IsAlive() then
	local plot = unit:GetPlot()
	if (not plot) then return end
	if (plot:GetImprovementType() == -1) or not (plot:IsImprovementPillaged()) then
	if unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_APACHE_XP) then
			unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_APACHE_XP, false)
				end
			end
		end
	end
if isApacheActive then
GameEvents.UnitSetXY.Add(ApacheXPMoveCancel)
end


function WarbandCivilianKill(playerId, unitId, newDamage, oldDamage)
    if newDamage > oldDamage then --filter out heals
        local pPlayer = Players[playerId]
        for pUnit in pPlayer:Units() do
            if pUnit:GetID() == unitId then
                if not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_WARBAND_FLANK) then -- this is a possible the target
                    if pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND then -- this is a possible target. Fan out for adjacent ships
                        local pPlot = pUnit:GetPlot()
						local iNumUnits = pPlot:GetNumUnits()
						for iVal = 0,(iNumUnits - 1) do
						local cUnit = pPlot:GetUnit(iVal)
						if not (cUnit:IsCombatUnit()) then
                        for i = 0, 5 do
                            local pAdj = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), i);
                            if pAdj ~= nil then
                                if pAdj:GetNumUnits() > 0 then
                                    for i = 0, pAdj:GetNumUnits() - 1 do
                                        local pSH = pAdj:GetUnit(i)
                                        if pSH:IsHasPromotion(GameInfoTypes.PROMOTION_UC_WARBAND_FLANK) then
                                                pSH:SetDamage(pSH:GetDamage() - 15)
												pSH:ChangeExperience(5)
                                                cUnit:Kill()
											if pSH:GetOwner():IsHuman() then
												Events.GameplayAlertMessage('Our Warband killed a stacked civilian unit!')
                                                print('UKIC Worked. You are the player. Hooray!!!')
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
    return --this event expects a return, so it perfoms better if you give it one
end
Events.SerialEventUnitSetDamage.Add(WarbandCivilianKill)

function ApacheXPSet(playerID)
local player = Players[playerID]
	local unit = player:GetUnitByID(unitID)
	for unit in player:Units() do
	if player:GetCivilizationType() == apacheID and player:IsAlive() then
	local plot = unit:GetPlot()
	if (not plot) then return end 
	if (plot:GetImprovementType() ~= -1) then
	if plot:IsImprovementPillaged() then
	if not unit:IsHasPromotion(GameInfoTypes.PROMOTION_UC_APACHE_XP) then
			unit:SetHasPromotion(GameInfoTypes.PROMOTION_UC_APACHE_XP, true)
					end
				end
			end
		end
	end
end
if isApacheActive then
GameEvents.PlayerDoTurn.Add(ApacheXPSet)
end