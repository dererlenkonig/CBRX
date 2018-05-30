--HasTrait
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
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBAL
----------------------------------------------------------------------------------------------------------------------------
include("PlotIterators")

local traitGHID = GameInfoTypes["TRAIT_CBR_GOLDEN_HORDE"]
local promotionZOCID = GameInfoTypes.PROMOTION_CBR_GH_ZOC
local promotionCityCombatID = GameInfoTypes.PROMOTION_CBR_GH_CITY_COMBAT


function ugraCityBonus(playerID, unitID, x, y)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitGHID)) then return end
	
	local unit = player:GetUnitByID(unitID)
	if not unit:IsHasPromotion(promotionZOCID) then return end
	
	--print("Running Golden Horde UA")
	
	local plot = unit:GetPlot()
	for loopPlot in PlotAreaSweepIterator(plot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
		if loopPlot:IsCity() then
			local pCity = loopPlot:GetPlotCity()
			if pCity:GetPreviousOwner() == playerID then
				unit:SetHasPromotion(promotionCityCombatID, true)
				print("Found a recently captured nearby city.")
				break
			end
		end
		unit:SetHasPromotion(promotionCityCombatID, false)
	end
end

GameEvents.UnitSetXY.Add(ugraCityBonus)
print("The Golden Horde is in the game. ")