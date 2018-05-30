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
--------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
--GetPlayerMajorityReligion
function GetPlayerMajorityReligion(pPlayer)
	local iMajorityReligion = -1
	for row in GameInfo.Religions() do
		local iReligion = row.ID
		if pPlayer:HasReligionInMostCities(iReligion) then
			iMajorityReligion = iReligion
			break
		end
	end
	return iMajorityReligion
end

--JFD_GetMainReligionID
function JFD_GetMainReligionID(playerID)
	local player = Players[playerID]
	local religionID = player:GetReligionCreatedByPlayer()
	if religionID <= 0 then religionID = GetPlayerMajorityReligion(player) end
	if (player:GetCapitalCity() and religionID <= 0) then religionID = player:GetCapitalCity():GetReligiousMajority() end
	if userSettingPietyCore then religionID = player:GetStateReligion() end
	return religionID
end

--JFD_Ottomans_GetGoldFromPuppets
function JFD_Ottomans_GetGoldFromPuppets(playerID)
	local player = Players[playerID]
	local numGoldFromPuppets = 0
	if isCPDLL then
		for city in player:Cities() do
			if city:IsPuppet() and city:HasAnyDomesticTradeRoute() then
				numGoldFromPuppets = numGoldFromPuppets + 4
			end
		end
	else
		for city in player:Cities() do
			if city:IsPuppet() then
				for _,v in ipairs(player:GetTradeRoutes()) do
					if v.FromCivilizationTyp == v.ToCivilizationType then
						if (v.FromCity == city or v.ToCity == city) then
							numGoldFromPuppets = numGoldFromPuppets + 4
						end
					end
				end
			end
		end
	end
	return numGoldFromPuppets
end

--JFD_Ottomans_GetFaithFromPuppets
function JFD_Ottomans_GetFaithFromPuppets(playerID)
	local player = Players[playerID]
	local numFaithFromPuppets = 0
	local religionID = JFD_GetMainReligionID(playerID)
	if isCPDLL then
		for city in player:Cities() do
			if city:GetReligiousMajority() ~= religionID then
				numFaithFromPuppets = numFaithFromPuppets + 5
			end
		end
	else
		for city in player:Cities() do
			if city:IsPuppet() then
				for _,v in ipairs(player:GetTradeRoutes()) do
					if v.FromCivilizationType == v.ToCivilizationType then
						if (v.FromCity == city or v.ToCity == city) then
							if city:GetReligiousMajority() ~= religionID then
								numFaithFromPuppets = numFaithFromPuppets + 5
							end
						end
					end
				end
			end
		end
	end
	return numFaithFromPuppets
end
--=======================================================================================================================
--=======================================================================================================================


