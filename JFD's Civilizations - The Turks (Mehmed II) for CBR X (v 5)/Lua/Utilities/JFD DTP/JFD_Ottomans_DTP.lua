-- JFD_Ottoman_DTP
-- Author: JFD
-- DateCreated: 6/5/2015 2:42:50 AM
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
--------------------------------------------------------------------------------------------------------------------------
-- UTILITIES
--------------------------------------------------------------------------------------------------------------------------
--Player_GetPrimaryReligionID
function Player_GetPrimaryReligionID(playerID)
	local player = Players[playerID]
	local religionID = player:GetReligionCreatedByPlayer()
	if religionID <= 0 then
		religionID = player:GetStateReligion()
	end
	if religionID <= 0 then
		local capital = player:GetCapitalCity()
		religionID = capital:GetReligiousMajority()
	end
	return religionID
end
--------------------------------------------------------------------------------------------------------------------------
-- TRIBUTARY EMPIRE
--------------------------------------------------------------------------------------------------------------------------
--JFD_Ottomans_GetGoldFromPuppets
function JFD_Ottomans_GetGoldFromPuppets(playerID)
	local player = Players[playerID]
	local numGoldFromPuppets = 0
	if isCPActive then
		for city in player:Cities() do
			if (city:IsPuppet() and city:HasAnyDomesticTradeRoute()) then
				numGoldFromPuppets = numGoldFromPuppets + 4
			end
		end
	else
		for city in player:Cities() do
			if city:IsPuppet() then
				for _,v in ipairs(player:GetTradeRoutes()) do
					if v.FromCivilizationType == v.ToCivilizationType then
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
	local religionID = Player_GetPrimaryReligionID(playerID)
	if isCPActive then
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


