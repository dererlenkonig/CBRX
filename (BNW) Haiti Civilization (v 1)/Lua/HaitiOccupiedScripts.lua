-- OccupiedScripts
-- Author: Leugi, JFD
--==========================================================================================================================	
--==========================================================================================================================	
-- Variables
--==========================================================================================================================	
GoldenAgePoints = 5
SpeedGA = (GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldenAgePercent / 100)

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

--==========================================================================================================================	
-- function itself
--==========================================================================================================================	

function JFD_HaitiResistance(playerID)
	local player = Players[playerID]
	if not player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_LEUGI_HAITI"] then
		for pCity in player:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes["BUILDING_LEUGI_FAKE_COURTHOUSE"]) then
				pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_LEUGI_FAKE_COURTHOUSE"], 0)
				pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_COURTHOUSE"], 1)
			end
			if pCity:IsHasBuilding(GameInfoTypes["BUILDING_HAITI_CHECK"]) then
				pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_HAITI_CHECK"], 0)
				pCity:SetOccupied(false)
			end
		end
	end
	for htPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		nPlayer = Players[htPlayer]
		if nPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_LEUGI_HAITI"] then
			hPlayer = nPlayer
			if (hPlayer:HasCreatedReligion()) then
   				haitiReligionID = hPlayer:GetReligionCreatedByPlayer()
   			end
   		end
	end
   
			for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
			
				local otherPlayer = Players[iPlayer]
				local oTeam = otherPlayer:GetTeam();
				local pTeam = hPlayer:GetTeam();
				if Teams[pTeam]:IsAtWar(oTeam) then
					for city in otherPlayer:Cities() do
						if city:GetReligiousMajority() == haitiReligionID then
							if city:IsHasBuilding(GameInfoTypes["BUILDING_COURTHOUSE"]) then
								city:SetNumRealBuilding(GameInfoTypes["BUILDING_LEUGI_FAKE_COURTHOUSE"], 1)
								city:SetNumRealBuilding(GameInfoTypes["BUILDING_COURTHOUSE"], 0)
							end
							if not city:IsOccupied() then
								city:SetNumRealBuilding(GameInfoTypes["BUILDING_HAITI_CHECK"], 1)
							end
							if (otherPlayer:IsHuman()) then
									local alert = Locale.ConvertTextKey("TXT_KEY_CIV_LEUGI_HAITI_OCCUPIED_OTHERS_ALERT", city:GetName());
									Events.GameplayAlertMessage(alert)
							end
							city:SetOccupied(true)
							if player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_LEUGI_HAITI"] then
								local goldenAgeBoost = player:GetGoldenAgeProgressThreshold() * 5 /100
								local goldenAgeBoost = math.floor(goldenAgeBoost + (GoldenAgePoints * SpeedGA))
								player:ChangeGoldenAgeProgressMeter(goldenAgeBoost)
								if (player:IsHuman()) then
									local alert = Locale.ConvertTextKey("TXT_KEY_CIV_LEUGI_HAITI_OCCUPIED_ALERT", city:GetName(), goldenAgeBoost);
									Events.GameplayAlertMessage(alert)
								end
							end
						end
					end
				end
		
			end

end
   




if JFD_IsCivilisationActive(civilisationID) then
	 GameEvents.PlayerDoTurn.Add(JFD_HaitiResistance)
end