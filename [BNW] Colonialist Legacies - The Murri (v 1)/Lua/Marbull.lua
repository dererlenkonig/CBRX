local iMarbull = GameInfoTypes.UNIT_CL_MARBULL
local iRoad = GameInfoTypes.ROUTE_ROAD
local iMovementPoints = GameInfo.Routes[iRoad].Movement / 2

function MarbullMovement(iPlayer, iUnit, iX, iY)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitType() == iMarbull then
		local pPlot = Map.GetPlot(iX, iY)
		if pPlot:GetRouteType() == iRoad then
			pUnit:ChangeMoves(iMovementPoints)
		end
	end
end

GameEvents.UnitSetXY.Add(MarbullMovement)