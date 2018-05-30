-- JFD_OttomanDTP
-- Author: JFD
-- DateCreated: 6/5/2015 2:42:50 AM
--=======================================================================================================================
-- USER SETTINGS
--=======================================================================================================================
--JFD_GetUserSetting
function JFD_GetUserSetting(type)
	for row in GameInfo.JFD_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
local userSettingPietyCore = JFD_GetUserSetting("JFD_RTP_PIETY_CORE") == 1
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
--JFD_Muscovy_GetGoldenAgePointsFromRazing
local mathCeil	   = math.ceil
local modGoldenAge = GameInfo.GameSpeeds[Game:GetGameSpeedType()].GoldenAgePercent
function JFD_Muscovy_GetGoldenAgePointsFromRazing(playerID)
	local player = Players[playerID]
	local numGoldenAgePoints = 0
	for city in player:Cities() do
		if city:IsRazing() then
			numGoldenAgePoints = numGoldenAgePoints + mathCeil((city:GetPopulation()*modGoldenAge)/4)
		end
	end
	return numGoldenAgePoints
end
--=======================================================================================================================
--=======================================================================================================================


