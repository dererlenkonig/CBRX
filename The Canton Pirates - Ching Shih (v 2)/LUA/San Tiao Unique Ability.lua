local iDomainSea = DomainTypes.DOMAIN_SEA
local iPromotion = GameInfoTypes["PROMOTION_SAN_TIAO"]
local civilizationID = GameInfoTypes.CIVILIZATION_CANTON_PIRATES

local tClasses = {}
tClasses[GameInfoTypes.UNITCLASS_CARGO_SHIP] = GameInfoTypes.UNITCLASS_CARGO_SHIP
tClasses[GameInfoTypes.UNITCLASS_CARAVAN] = GameInfoTypes.UNITCLASS_CARAVAN

function GoldAgePointsFromTradeRoutePillage(iPlayer, pUnit)
	local pPlayer = Players[iPlayer]
	if pUnit:GetDomainType() == iDomainSea then
		pPlayer:ChangeGoldenAgeProgressMeter(200)
	else
		pPlayer:ChangeGoldenAgeProgressMeter(100)
	end
end

function DetectPlunder(iPlayer, iUnit)
    local pPlayer = Players[iPlayer]
    local pUnit = pPlayer:GetUnitByID(iUnit)
    local iUnitClass = pUnit:GetUnitClassType()
    if tClasses[iUnitClass] ~= nil then
        local pTeam = Teams[pPlayer:GetTeam()]
        local pPlot = pUnit:GetPlot()
        local iNumUnits = pPlot:GetNumUnits()
        for iVal = 0,(iNumUnits - 1) do
            local pLUnit = pPlot:GetUnit(iVal)
            local pOwnerID = pLUnit:GetOwner()
             if pOwnerID > -1 then
                local pOwner = Players[pOwnerID]
                if pLUnit:GetCombatLimit() > 0 and pTeam:IsAtWar(pOwner:GetTeam()) then
                    -- Being plundered, run function
                    GoldAgePointsFromTradeRoutePillage(pOwnerID, pLUnit)
                    break
                end
            end
        end
    end
    
    return false
end
GameEvents.CanSaveUnit.Add(DetectPlunder)

function GoldAgePointsFromPopulation(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() == civilizationID) then
		for pCity in pPlayer:Cities() do
			if pCity:IsCoastal(10) then
				pPlayer:ChangeGoldenAgeProgressMeter(math.floor(pCity:GetPopulation() * 0.25))
			end
                end

		local iGoldAgeProg = pPlayer:GetGoldenAgeProgressMeter()
                local iGoldenAgeThreshold = pPlayer:GetGoldenAgeProgressThreshold()
                if iGoldAgeProg >= iGoldenAgeThreshold then
			pPlayer:ChangeGoldenAgeProgressMeter(-iGoldenAgeThreshold)
			pPlayer:ChangeGoldenAgeTurns(pPlayer:GetGoldenAgeLength())
		end
	end
end
GameEvents.PlayerDoTurn.Add(GoldAgePointsFromPopulation)

local seadomain = GameInfoTypes.DOMAIN_SEA
function ShamelessJFDCopy(playerID, cityID, unitID)
    local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == civilizationID) then
        if player:IsGoldenAge() then
            local unit = player:GetUnitByID(unitID)
            if (unit:IsCombatUnit() and unit:GetDomainType() == seadomain) then
                unit:SetHasPromotion(iPromotion, true)
            end
        end
    end
end
GameEvents.CityTrained.Add(ShamelessJFDCopy)