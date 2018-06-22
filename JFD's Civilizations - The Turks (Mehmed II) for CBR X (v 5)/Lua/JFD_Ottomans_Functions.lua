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
--Game_IsCPActive
function Game_IsCPActive()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPActive = Game_IsCPActive()

--HasTrait
function HasTrait(player, traitID)
	if isCPActive then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
end	
--==========================================================================================================================
-- GLOBALS
--==========================================================================================================================
-- GLOBALS
----------------------------------------------------------------------------------------------------------------------------
local traitOttomansID = GameInfoTypes["TRAIT_JFD_OTTOMAN"]
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- TRIBUTARY EMPIRE
----------------------------------------------------------------------------------------------------------------------------
--JFD_Ottomans_TributaryEmpire_PlayerDoTurn
local function JFD_Ottomans_TributaryEmpire_PlayerDoTurn(playerID)
	local player = Players[playerID]
	if (not player) then return end
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitOttomansID)) then return end
	
	local numGold = JFD_Ottomans_GetGoldFromPuppets(playerID)
	if numGold > 0 then 
		player:ChangeGold(numGold) 
	end
	
	local numFaith = JFD_Ottomans_GetFaithFromPuppets(playerID)
	if numFaith > 0 then 
		player:ChangeFaith(numFaith) 
	end
end
if userSettingOttomansUA then
	GameEvents.PlayerDoTurn.Add(JFD_Ottomans_TributaryEmpire_PlayerDoTurn)
end
--==========================================================================================================================
--==========================================================================================================================