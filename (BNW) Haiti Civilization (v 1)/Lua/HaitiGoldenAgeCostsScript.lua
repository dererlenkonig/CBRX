-- OccupiedScripts
-- Author: Leugi
--==========================================================================================================================	
--==========================================================================================================================	
-- Variables
--==========================================================================================================================	
HaitiBonusBld = "BUILDING_HAITI_BONUS"

--------------------------------------------------------------
-- JFD_IsCivilisationActive
--------------------------------------------------------------
local civilisationID = GameInfoTypes["CIVILIZATION_LEUGI_HAITI"]

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

if JFD_IsCivilisationActive(civilisationID) then
	print("Touissaint Louverture is in this game")
end
-----------------------------------------------------------------
-- Leugi_CleanUpBuilding
-----------------------------------------------------------------

function Leugi_CleanUpBuilding(Player, BuildingType)
	for pCity in Player:Cities() do
		if pCity:IsHasBuilding(GameInfoTypes["" .. BuildingType .. ""]) then
			pCity:SetNumRealBuilding(GameInfoTypes["" .. BuildingType .. ""], 0)
		end
	end
end
-----------------------------------------------------------------
-- Leugi_CapitalSetNumBuilding
-----------------------------------------------------------------

function Leugi_CapitalSetNumBuilding(Player, BuildingType, num)
	for pCity in Player:Cities() do
		if (pCity:IsCapital()) then
			pCity:SetNumRealBuilding(GameInfoTypes["" .. BuildingType .. ""], num)
		end
	end
end

--==========================================================================================================================	
-- function itself
--==========================================================================================================================	

function Leugi_HaitiGABonus(playerID)
	local player = Players[playerID]
	if ( player:IsAlive() ) then
    if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_LEUGI_HAITI"] then
		 if (player:GetGoldenAgeTurns() > 0) then
			Leugi_CapitalSetNumBuilding(player, HaitiBonusBld, 1)
		else
			Leugi_CleanUpBuilding(player, HaitiBonusBld)
		end
	else
		Leugi_CleanUpBuilding(player, HaitiBonusBld)
	end
	end
end
   
   
if JFD_IsCivilisationActive(civilisationID) then
	 GameEvents.PlayerDoTurn.Add(Leugi_HaitiGABonus)
end