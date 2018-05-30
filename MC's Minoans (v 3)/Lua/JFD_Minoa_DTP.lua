-- JFD_Minoa_DTP
-- Author: JFD
-- DateCreated: 6/5/2015 2:42:50 AM
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
--JFD_Minoa_GetGoldenAgePointsFromCoastalCities
local mathCeil	   = math.ceil
local modGoldenAge = GameInfo.GameSpeeds[Game:GetGameSpeedType()].GoldenAgePercent
function JFD_Minoa_GetGoldenAgePointsFromCoastalCities(playerID)
	local player = Players[playerID]
	local numGoldenAgePoints = 0
	for city in player:Cities() do
		if city:IsCoastal() then
			numGoldenAgePoints = numGoldenAgePoints + mathCeil(city:GetPopulation() + (city:GetPopulation()*modGoldenAge)/100)
		end
	end
	return numGoldenAgePoints
end
--=======================================================================================================================
--=======================================================================================================================


