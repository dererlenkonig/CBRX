-- Leugi Haiti Events
-- Author: Leugi
--=======================================================================================================================
print("Leugi's Haiti Events: loaded")
--=======================================================================================================================
-- Civ Specific Events
--=======================================================================================================================
--  French Revolution
MinFaithRevolution = 100
MinGoldRevolution = 100
--------------------------------------------------------------------------------------------------------------------------
local Event_Leugi_Haiti_French_Revolution = {}
	Event_Leugi_Haiti_French_Revolution.Name = "TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION"
	Event_Leugi_Haiti_French_Revolution.Desc = "TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_DESC"
	Event_Leugi_Haiti_French_Revolution.Weight = 20
	Event_Leugi_Haiti_French_Revolution.CanFunc = (
		function(pPlayer)
			-- Check if the event fired before			
			if load(pPlayer, "Event_Leugi_Haiti_French_Revolution") == true then return false end
			--
			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_LEUGI_HAITI"] then return false end
			--
			-- Check the Era
			if (pPlayer:GetCurrentEra() ~= GameInfo.Eras["ERA_INDUSTRIAL"].ID) then return false end
			--
			-- Check minimum faith
			local iMinFaith = math.ceil((MinFaithRevolution) * iMod)
			if (pPlayer:GetFaith() < iMinFaith) then return false end
			--
			-- Check minimum gold
			local iMinGold = math.ceil((MinGoldRevolution) * iMod)
			if (pPlayer:GetGold() < iMinGold) then return false end
			--
			-- Fire the Event! (if chances are met)
			return true
		end
		)
	Event_Leugi_Haiti_French_Revolution.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Leugi_Haiti_French_Revolution.Outcomes[1] = {}
	Event_Leugi_Haiti_French_Revolution.Outcomes[1].Name = "TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OUTCOME_1"
	Event_Leugi_Haiti_French_Revolution.Outcomes[1].Desc = "TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OUTCOME_RESULT_1"
	Event_Leugi_Haiti_French_Revolution.Outcomes[1].Weight = 1
	Event_Leugi_Haiti_French_Revolution.Outcomes[1].CanFunc = (
		function(pPlayer)			
			-- Create Description			
			Event_Leugi_Haiti_French_Revolution.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_Leugi_Haiti_French_Revolution.Outcomes[1].DoFunc = (
		function(pPlayer) 
			-- Remove all Faith
			pPlayer:SetFaith(0);
			-- Grant a free Social Policy
			pPlayer:ChangeNumFreePolicies(1)
			-- Save the event
			save(pPlayer, "Event_Leugi_Haiti_French_Revolution", true)
			-- Send the notification
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION"))
			Event_Leugi_Haiti_French_Revolution.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_DESC")
			for _, nPlayer in pairs(Players) do
				if (nPlayer:IsAlive()) then
					local pteamID = pPlayer:GetTeam();
					local pTeam = Teams[pteamID];
					local notifyteamID = nPlayer:GetTeam();
					local nTeam = Teams[notifyteamID];
					if (nTeam:IsHasMet(pTeam)) then
						if nPlayer:IsHuman() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OTHERS_ALERT"))
						end
					end
				end
			end
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Leugi_Haiti_French_Revolution.Outcomes[2] = {}
	Event_Leugi_Haiti_French_Revolution.Outcomes[2].Name = "TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OUTCOME_2"
	Event_Leugi_Haiti_French_Revolution.Outcomes[2].Desc = "TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OUTCOME_RESULT_2"
	Event_Leugi_Haiti_French_Revolution.Outcomes[2].Weight = 10
	Event_Leugi_Haiti_French_Revolution.Outcomes[2].CanFunc = (
		function(pPlayer)			
			-- Create Description			
			Event_Leugi_Haiti_French_Revolution.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OUTCOME_RESULT_2")
			return true
		end
		)
	Event_Leugi_Haiti_French_Revolution.Outcomes[2].DoFunc = (
		function(pPlayer) 
			-- Remove all Gold
			pPlayer:SetGold(0);
			-- Grant Mawons
			InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_LEUGI_MAWON, 4)
			-- Save the event
			save(pPlayer, "Event_Leugi_Haiti_French_Revolution", true)
			-- Send the notification
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION"))
			Event_Leugi_Haiti_French_Revolution.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_DESC")
			for _, nPlayer in pairs(Players) do
				if (nPlayer:IsAlive()) then
					local pteamID = pPlayer:GetTeam();
					local pTeam = Teams[pteamID];
					local notifyteamID = nPlayer:GetTeam();
					local nTeam = Teams[notifyteamID];
					if (nTeam:IsHasMet(pTeam)) then
						if nPlayer:IsHuman() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_FRENCH_REVOLUTION_OTHERS_ALERT"))
						end
					end
				end
			end
		end)
	

Events_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_LEUGI_HAITI"], "Event_Leugi_Haiti_French_Revolution", Event_Leugi_Haiti_French_Revolution)


--=======================================================================================================================
--=======================================================================================================================
-- DuttyBoukman

--------------------------------------------------------------------------------------------------------------------------
local Event_Leugi_Haiti_DuttyBoukman = {}
	Event_Leugi_Haiti_DuttyBoukman.Name = "TXT_KEY_EVENT_HAITI_DUTTY_BOUKMAN"
	Event_Leugi_Haiti_DuttyBoukman.Desc = "TXT_KEY_EVENT_HAITI_DUTTY_BOUKMAN_DESC"
	Event_Leugi_Haiti_DuttyBoukman.Weight = 5
	Event_Leugi_Haiti_DuttyBoukman.CanFunc = (
		function(pPlayer)
			-- Check if the event fired before			
			if load(pPlayer, "Event_Leugi_Haiti_DuttyBoukman") == true then return false end
			--
			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_LEUGI_HAITI"] then return false end
			--
			-- Check Era
			if (pPlayer:GetCurrentEra() < GameInfo.Eras["ERA_INDUSTRIAL"].ID) then return false end
			--
			--Check War
			local pTeam = pPlayer:GetTeam();
			local isWar = 0;
			for ioPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1 do
				local oPlayer = Players[ioPlayer];
				if oPlayer ~= pPlayer then
					if (oPlayer:IsAlive()) then
						local oTeam = oPlayer:GetTeam();
						if Teams[pTeam]:IsAtWar(oTeam) then
							isWar = isWar + 1;
							break
						end
					end
				end
			end
			if isWar <= 0 then return false end
			--
			-- Fire the Event! (if chances are met)
			Event_Leugi_Haiti_DuttyBoukman.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_DUTTY_BOUKMAN_DESC")
			return true
		end
		)
	Event_Leugi_Haiti_DuttyBoukman.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Leugi_Haiti_DuttyBoukman.Outcomes[1] = {}
	Event_Leugi_Haiti_DuttyBoukman.Outcomes[1].Name = "TXT_KEY_EVENT_HAITI_DUTTY_BOUKMAN_OUTCOME_1"
	Event_Leugi_Haiti_DuttyBoukman.Outcomes[1].Desc = "TXT_KEY_EVENT_HAITI_DUTTY_BOUKMAN_OUTCOME_RESULT_1"
	Event_Leugi_Haiti_DuttyBoukman.Outcomes[1].Weight = 10
	Event_Leugi_Haiti_DuttyBoukman.Outcomes[1].CanFunc = (
		function(pPlayer)			
			-- Create Description			
			Event_Leugi_Haiti_DuttyBoukman.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_DUTTY_BOUKMAN_OUTCOME_RESULT_1")
			return true
		end
		)
	Event_Leugi_Haiti_DuttyBoukman.Outcomes[1].DoFunc = (
		function(pPlayer) 
			-- Grant the unit
			InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_LEUGI_UBER_HOUNGAN, 1)
			-- Save the event
			save(pPlayer, "Event_Leugi_Haiti_DuttyBoukman", true)
			-- Send the notification
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_DUTTY_BOUKMAN_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_DUTTY_BOUKMAN"))
			for _, nPlayer in pairs(Players) do
				if (nPlayer:IsAlive()) then
					local pteamID = pPlayer:GetTeam();
					local pTeam = Teams[pteamID];
					local notifyteamID = nPlayer:GetTeam();
					local nTeam = Teams[notifyteamID];
					if (nTeam:IsHasMet(pTeam)) then
						if nPlayer:IsHuman() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_DUTTY_BOUKMAN_OTHERS_ALERT"))
						end
					end
				end
			end
		end)

Events_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_LEUGI_HAITI"], "Event_Leugi_Haiti_DuttyBoukman", Event_Leugi_Haiti_DuttyBoukman)


--=======================================================================================================================
--=======================================================================================================================
--  Clairvius Narcisse 
iClairviusNarcisseFaith = 400
iClairviusNarcisseCulture = 400
iHaitiBuilding = GameInfoTypes["BUILDING_HAITI_TOURISM"]
--------------------------------------------------------------------------------------------------------------------------
local Event_Leugi_Haiti_ClairviusNarcisse = {}
	Event_Leugi_Haiti_ClairviusNarcisse.Name = "TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE"
	Event_Leugi_Haiti_ClairviusNarcisse.Desc = "TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_DESC"
	Event_Leugi_Haiti_ClairviusNarcisse.Weight = 30
	Event_Leugi_Haiti_ClairviusNarcisse.CanFunc = (
		function(pPlayer)
			-- Check if the event fired before			
			if load(pPlayer, "Event_Leugi_Haiti_ClairviusNarcisse") == true then return false end
			--
			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_LEUGI_HAITI"] then return false end
			--
			-- Check Era
			if (pPlayer:GetCurrentEra() < GameInfo.Eras["ERA_INDUSTRIAL"].ID) then return false end
			--
			-- CheckMinFaith
			local iMinFaith = math.ceil((iClairviusNarcisseFaith) * iMod)
			if (pPlayer:GetFaith() < iMinFaith) then return false end
			--
			-- CheckMinCulture
			local iMinCulture = math.ceil((iClairviusNarcisseCulture) * iMod)
			if (pPlayer:GetJONSCulture() < iMinCulture) then return false end
			--
			-- Fire the Event! (if chances are met)
			return true
		end
		)
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[1] = {}
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[1].Name = "TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_1"
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[1].Desc = "TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_RESULT_1"
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[1].Weight = 1
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[1].CanFunc = (
		function(pPlayer)		
			-- Faith
			local iMinFaith = math.ceil((iClairviusNarcisseFaith) * iMod)
			-- Culture 	
			local iMinCulture = math.ceil((iClairviusNarcisseCulture) * iMod)
			-- Create Description			
			Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_RESULT_1", iMinFaith, iMinCulture)
			return true
		end
		)
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[1].DoFunc = (
		function(pPlayer) 
			-- ChangeFaith
			local iFaith = math.ceil((iClairviusNarcisseFaith) * iMod)
			pPlayer:ChangeFaith(-iFaith)
			-- ChangeCulture
			local iCulture = math.ceil((iClairviusNarcisseCulture) * iMod)
			pPlayer:ChangeJONSCulture(iCulture)
			-- Save the event
			save(pPlayer, "Event_Leugi_Haiti_ClairviusNarcisse", true)
			-- Send the notification
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE"))
			Event_Leugi_Haiti_ClairviusNarcisse.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_DESC")
			for _, nPlayer in pairs(Players) do
				if (nPlayer:IsAlive()) then
					local pteamID = pPlayer:GetTeam();
					local pTeam = Teams[pteamID];
					local notifyteamID = nPlayer:GetTeam();
					local nTeam = Teams[notifyteamID];
					if (nTeam:IsHasMet(pTeam)) then
						if nPlayer:IsHuman() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OTHERS_ALERT"))
						end
					end
				end
			end
		end
		)
			--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[2] = {}
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[2].Name = "TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_2"
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[2].Desc = "TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_RESULT_2"
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[2].Weight = 1
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[2].CanFunc = (
		function(pPlayer)		
			-- Culture 	
			local iMinCulture = math.ceil((iClairviusNarcisseCulture) * iMod)
			-- Create Description			
			Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_RESULT_2", iMinCulture)
			return true
		end
		)
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[2].DoFunc = (
		function(pPlayer) 
			-- ChangeCulture
			local iCulture = math.ceil((iClairviusNarcisseCulture) * iMod)
			pPlayer:ChangeJONSCulture(-iCulture)
			-- Grant building
			for pCity in pPlayer:Cities() do
				if pCity:IsCapital() then
					pCity:SetNumRealBuilding(iHaitiBuilding, 1)
				end
			end
			-- Save the event
			save(pPlayer, "Event_Leugi_Haiti_ClairviusNarcisse", true)
			-- Send the notification
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE"))
			Event_Leugi_Haiti_ClairviusNarcisse.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_DESC")
			for _, nPlayer in pairs(Players) do
				if (nPlayer:IsAlive()) then
					local pteamID = pPlayer:GetTeam();
					local pTeam = Teams[pteamID];
					local notifyteamID = nPlayer:GetTeam();
					local nTeam = Teams[notifyteamID];
					if (nTeam:IsHasMet(pTeam)) then
						if nPlayer:IsHuman() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OTHERS_ALERT"))
						end
					end
				end
			end
		end)
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[3] = {}
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[3].Name = "TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_3"
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[3].Desc = "TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_RESULT_3"
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[3].Weight = 1
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[3].CanFunc = (
		function(pPlayer)		
			-- Faith
			local iMinFaith = math.ceil((iClairviusNarcisseFaith) * iMod)
			-- Culture 	
			local iMinCulture = math.ceil((iClairviusNarcisseCulture) * iMod)
			-- Create Description			
			Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_RESULT_3", iMinCulture, iMinFaith)
			return true
		end
		)
	Event_Leugi_Haiti_ClairviusNarcisse.Outcomes[3].DoFunc = (
		function(pPlayer) 
			-- ChangeFaith
			local iFaith = math.ceil((iClairviusNarcisseFaith) * iMod)
			pPlayer:ChangeFaith(-iFaith)
			-- ChangeCulture
			local iCulture = math.ceil((iClairviusNarcisseCulture) * iMod)
			pPlayer:ChangeJONSCulture(-iCulture)
			-- Grant the Scientist
			InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_SCIENTIST, 1)
			-- Save the event
			save(pPlayer, "Event_Leugi_Haiti_ClairviusNarcisse", true)
			-- Send the notification
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE"))
			Event_Leugi_Haiti_ClairviusNarcisse.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_DESC")
			for _, nPlayer in pairs(Players) do
				if (nPlayer:IsAlive()) then
					local pteamID = pPlayer:GetTeam();
					local pTeam = Teams[pteamID];
					local notifyteamID = nPlayer:GetTeam();
					local nTeam = Teams[notifyteamID];
					if (nTeam:IsHasMet(pTeam)) then
						if nPlayer:IsHuman() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_EVENT_HAITI_CLAIRVIUS_NARCISSE_OTHERS_ALERT"))
						end
					end
				end
			end
		end)
	

Events_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_LEUGI_HAITI"], "Event_Leugi_Haiti_ClairviusNarcisse", Event_Leugi_Haiti_ClairviusNarcisse)


--=======================================================================================================================
--=======================================================================================================================

