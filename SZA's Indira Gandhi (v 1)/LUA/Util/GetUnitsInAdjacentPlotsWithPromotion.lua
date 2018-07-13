


-------------------------------------------------------------------------------------------------------
-- GetUnitsInAdjacentPlotsWithPromotion

--[[

1)	Data sent for sFrienEmies can be:
	a)	"SamePlayer"	unit owner has to be same as iPlayer
	b)	"Enemies"	unit owner has to be at war with iPlayer
	c)	"Friends"	unit owner cannot be at war with iPlayer
	d)	nil (ie, nothing specified)
		this defaults to same as "SamePlayer"
2)	Data sent for sFrienEmies can be:
	a)	"boolean"	routine returns "true" on encountering 1st qualifying unit
	b)	"table"		all qualifying unit objects are stored in an lua-table and this table is the 'return' value
	c)	"integer"	an integer count is kept of all qualifying units and this integer count is the 'return' value
	d)	nil (ie, nothing specified)
		this defaults to same as "boolean"

]]--

-------------------------------------------------------------------------------------------------------

function GetUnitsInAdjacentPlotsWithPromotion(pPlot, iPromotion, iPlayer, sFrienEmies, sReturnType)
	local tUnitsFound = {}
	local iNumUnitsFound = 0
	local pPlayer = Players[iPlayer]
	local iPlayersTeamID = pPlayer:GetTeam()
	local pPlayerTeam = Teams[iPlayersTeamID]
	for direction = 0, DirectionTypes.NUM_DIRECTION_TYPES - 1, 1 do
		local pAdjacentPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)
		if pAdjacentPlot and pAdjacentPlot:IsUnit() then
			for i = 0, pAdjacentPlot:GetNumUnits() do
				local pAdjacentUnit = pAdjacentPlot:GetUnit(i)
				if pAdjacentUnit and pAdjacentUnit:IsHasPromotion(iPromotion) then
					local bCountUnit = false
					if pAdjacentUnit:GetOwner() == iPlayer then
						if (sFrienEmies == "SamePlayer") or (sFrienEmies == nil) then
							if (sReturnType == "boolean") or (sReturnType == nil) then
								return true
							else
								bCountUnit = true
							end
						end
					else
						if pPlayerTeam:IsAtWar(Players[pAdjacentUnit:GetOwner()]:GetTeam()) then
							if sFrienEmies == "Enemies" then
								if (sReturnType == "boolean") or (sReturnType == nil) then
									return true
								else
									bCountUnit = true
								end
							end
						else
							if sFrienEmies == "Friends" then
								if (sReturnType == "boolean") or (sReturnType == nil) then
									return true
								else
									bCountUnit = true
								end
							end
						end
					end
					if  bCountUnit then
						if (sReturnType == "table") then
							table.insert(tUnitsFound, pAdjacentUnit)
						else	--defaulters get counted as integers
							iNumUnitsFound = iNumUnitsFound + 1
						end
					end
				end
			end
		end
	end
	if (sReturnType == "boolean") or (sReturnType == nil) then
		return false
	elseif (sReturnType == "table") then
		return tUnitsFound
	else
		return iNumUnitsFound
	end
end