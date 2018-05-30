-- JFD_Ottoman_Functions
-- Author: JFD
-- DateCreated: 6/5/2015 2:45:49 AM
--==========================================================================================================================
-- INCLUDES
--==========================================================================================================================
include("JFD_Ottomans_DTP.lua")
--==========================================================================================================================
-- UTILITY FUNCTIONS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
--IsCPDLL
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()

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
-- GLOBALS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local traitOttomansID = GameInfoTypes["TRAIT_JFD_OTTOMAN"]
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- SUZEREIGNTY
----------------------------------------------------------------------------------------------------------------------------
--JFD_Ottomans_Suzereignty_PlayerDoTurn
function JFD_Ottomans_Suzereignty_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player) then return end
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitOttomansID)) then return end
	local numGoldFromPuppets = JFD_Ottomans_GetGoldFromPuppets(playerID)
	if numGoldFromPuppets > 0 then player:ChangeGold(numGoldFromPuppets) end
	local numFaithFromPuppets = JFD_Ottomans_GetFaithFromPuppets(playerID)
	if numFaithFromPuppets > 0 then player:ChangeFaith(numFaithFromPuppets) end
end
if userSettingOttomansUA then
	GameEvents.PlayerDoTurn.Add(JFD_Ottomans_Suzereignty_PlayerDoTurn)
end
--==========================================================================================================================
--==========================================================================================================================