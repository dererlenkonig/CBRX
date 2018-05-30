local iHumpy = GameInfoTypes.BUILDING_CL_HUMPY
local iFaithDummy = GameInfoTypes.BUILDING_CL_HUMPY_FAITH -- yields 1 faith
local iCaravanClass = GameInfoTypes.UNITCLASS_CARAVAN
local iCargoShipClass = GameInfoTypes.UNITCLASS_CARGO_SHIP
local iClaimChance = 25 -- Percentage chance that a trade unit departing a city with a Humpy will claim a neutral tile

function HumpyFaith(iPlayer)
	local pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
		if pPlayer:IsCapitalConnectedToCity(pCity) and pCity:IsHasBuilding(iHumpy) then
			pCity:SetNumRealBuilding(iFaithDummy, 1)
		else
			pCity:SetNumRealBuilding(iFaithDummy, 0)
		end
	end
end

GameEvents.PlayerDoTurn.Add(HumpyFaith)

function HumpyClaim(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:GetUnitClassType() == iCaravanClass or pUnit:GetUnitClassType() == iCargoShipClass then
			local pPlot = pUnit:GetPlot()
			if pPlot:GetOwner() == -1 then
				local pCity = nil
				for i, sTradeRoute in ipairs(pPlayer:GetInternationalTradeRoutePlotToolTip(pPlot)) do
					sCityName = string.sub(sTradeRoute, 1, string.find(sTradeRoute, " ("))
					for pPossibleCity in pPlayer:Cities() do
						if pPossibleCity:GetName() == sCityName and pPossibleCity:IsHasBuilding(iHumpy) then
							pCity = pPossibleCity
							break
						end
					end
					if pCity then
						break
					end
				end
				if pCity then
					local bPlotIsAdjacent = false
					for iDirection = 0, (DirectionTypes.NUM_DIRECTION_TYPES-1), 1 do
						local pOtherPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), iDirection)
						if pOtherPlot:GetOwner() == iPlayer then
							bPlotIsAdjacent = true
							break
						end
					end
					if bPlotIsAdjacent then
						pPlot:SetOwner(iPlayer, pCity:GetID())
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(HumpyClaim)