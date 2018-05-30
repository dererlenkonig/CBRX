-- MaroonScripts
-- Author: Leugi
--==========================================================================================================================	
--==========================================================================================================================	
-- Variables
--==========================================================================================================================	
print ("Haiti Maroon Script: Loaded")
local iMaroonPromo = GameInfoTypes.PROMOTION_LEUGI_FREEDOM_CRY
local iMaroonPromoON = GameInfoTypes.PROMOTION_LEUGI_FREEDOM_CRY_ACTIVE

 local direction_types = {
	DirectionTypes.DIRECTION_NORTHEAST,
	DirectionTypes.DIRECTION_NORTHWEST,
	DirectionTypes.DIRECTION_EAST,
	DirectionTypes.DIRECTION_SOUTHEAST,
	DirectionTypes.DIRECTION_SOUTHWEST,
	DirectionTypes.DIRECTION_WEST,
	}

--==========================================================================================================================	
-- function itself
--==========================================================================================================================	

function LeugiMaroonScript(playerID)
	local player = Players[playerID]
	if player:IsEverAlive() then
		for unit in player:Units() do
		local plot = unit:GetPlot()
		if plot then
			for loop, direction in ipairs(direction_types) do
				local adjPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction)
				if adjPlot then
					if (adjPlot:IsCity()) then
						local pCity = adjPlot:GetPlotCity();
						if pCity:IsOccupied() then
							if (unit:IsHasPromotion(iMaroonPromo)) then
								unit:SetHasPromotion(iMaroonPromoON, true)
								unit:SetHasPromotion(iMaroonPromo, false)
							end
						elseif (unit:IsHasPromotion(iMaroonPromoON)) then
							unit:SetHasPromotion(iMaroonPromoON, false)
							unit:SetHasPromotion(iMaroonPromo, true)
						end
					elseif (unit:IsHasPromotion(iMaroonPromoON)) then
						unit:SetHasPromotion(iMaroonPromoON, false)
						unit:SetHasPromotion(iMaroonPromo, true)
					end
				end
			end
		end
		end
	end
end

GameEvents.UnitSetXY.Add(LeugiMaroonScript)
GameEvents.PlayerDoTurn.Add(LeugiMaroonScript)