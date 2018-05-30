-- DMS_VenezuelaDynamicTopPanelSupport.lua
-- Author: DMS
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
--==========================================================================================================================
-- MAIN FUNCTIONS	
--==========================================================================================================================
-- DMS_GetCultureFromCivsDenounced
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetCultureFromCivsDenounced(iPlayer)
	local pPlayer = Players[iPlayer]
	local iCultureBonus = 0
	local iNumDenouncedCivs = 0
	if pPlayer then
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i and i ~= iPlayer then
				local pOtherPlayer = Players[i]
				if pOtherPlayer and pOtherPlayer:IsEverAlive() then
					if pPlayer:IsDenouncedPlayer(i) then
						iNumDenouncedCivs = iNumDenouncedCivs + 1
					end
				end
			end
		end
		if iNumDenouncedCivs > 0 then
			local iMaintenanceCost = pPlayer:CalculateUnitCost()
			iCultureBonus = mathFloor(iNumDenouncedCivs^(2.6) + 1/(iMaintenanceCost^(-0.6)))
		end
	end
	return iCultureBonus
end
--=======================================================================================================================
--=======================================================================================================================