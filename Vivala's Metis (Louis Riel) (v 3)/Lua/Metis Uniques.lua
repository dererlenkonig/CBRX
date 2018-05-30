local iMetis = GameInfoTypes.CIVILIZATION_VIVALA_METIS
local iCoureur = GameInfoTypes.UNIT_VIVALA_COUREUR_DES_BOIS
local iCoureurOutside = GameInfoTypes.PROMOTION_VIVALA_COUREUR_OUTSIDE_FRIENDLY
local iCoureurRiver = GameInfoTypes.PROMOTION_VIVALA_COUREUR_RIVERSIDE
local iCoureurMove = GameInfoTypes.PROMOTION_VIVALA_COUREUR_RIVERSIDE_MOVE
local iMetisPop = GameInfoTypes.BUILDING_VIVALA_METIS_POP
local iMetisXP = GameInfoTypes.BUILDING_VIVALA_METIS_XP
local iTradeFactory = GameInfoTypes.BUILDING_VIVALA_TRADE_FACTORY

function VivalaCoureur(iPlayer, iUnit, iX, iY)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetUnitType() == iCoureur and (pUnit:GetGameTurnCreated() ~= 0) then
			--print(pUnit:GetGameTurnCreated())
			--print(Game.GetGameTurn())
			local pPlot = Map.GetPlot(iX, iY)
			if iPlayer == pPlot:GetOwner() then
				pUnit:SetHasPromotion(iCoureurOutside, false)
			else
				pUnit:SetHasPromotion(iCoureurOutside, true)
			end
			if pPlot:IsRiver() then
				pUnit:SetHasPromotion(iCoureurRiver, true)
				pUnit:SetHasPromotion(iCoureurMove, true)
			else
				pUnit:SetHasPromotion(iCoureurRiver, false)
				pUnit:SetHasPromotion(iCoureurMove, false)
			end
		end
	end

end


function VivalaMetisPop(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iMetis then
		local tRoutes = pPlayer:GetTradeRoutesToYou()
		for iRouteID, route in ipairs(tRoutes) do
			local sender = route.FromID
			local origin = route.FromCity
			local destination = route.ToCity
			if destination:GetNumRealBuilding(iMetisPop) == 0 then
				if sender ~= iPlayer then
					destination:ChangePopulation(1)
					destination:SetNumRealBuilding(iMetisPop, 1)
				end
			end
		end
		local yourRoutes = pPlayer:GetTradeRoutes()
		for iRouteID, route in ipairs(yourRoutes) do
			local sender = route.FromID
			local origin = route.FromCity
			local destination = route.ToCity
			if destination:GetNumRealBuilding(iMetisPop) == 0 and route.ToID == iPlayer then
				if origin:GetNumRealBuilding(iTradeFactory) > 0 then
					destination:ChangePopulation(1)
					destination:SetNumRealBuilding(iMetisPop, 1)
				end
			end
		end
	end
end

function VivalaMetisXP(iPlayer)
	local iOpenBorders = 0
	local players = Players
	local pPlayer = Players[iPlayer]
	local iTeamA = pPlayer:GetTeam()
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iMetis then
		for playerID, player in ipairs(players) do
			if player:IsAlive() and (not(player:IsMinorCiv())) and (not(player:IsBarbarian())) and (playerID ~= iPlayer) then
				local iTeamB = player:GetTeam()
				--print(playerID)
				if Teams[iTeamA]:IsAllowsOpenBordersToTeam(iTeamB) or Teams[iTeamB]:IsAllowsOpenBordersToTeam(iTeamA) then
					iOpenBorders = iOpenBorders + 1
					--print(iOpenBorders)
				end
			end
		end
		for city in pPlayer:Cities() do
			city:SetNumRealBuilding(iMetisXP, math.min(iOpenBorders, 6))
		end
	end
end

GameEvents.UnitSetXY.Add(VivalaCoureur)

GameEvents.PlayerDoTurn.Add(VivalaMetisPop)
GameEvents.PlayerDoTurn.Add(VivalaMetisXP)

