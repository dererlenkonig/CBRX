print("Haiti Decisions")

--Haiti Abolition
--------------------------------------
-- Abolition Variables
iHaitiBuilding = GameInfoTypes["BUILDING_HAITI_IDEOLOGY"]
iAbolitionTechPrereq = GameInfoTypes.TECH_ECONOMICS;
iAbolitionMagisCost = 3
iAbolitionCultureCost = 400
iGoldenAgeTurns = 10
---------------------------------------

local Decisions_Haiti_Abolition = {}
	Decisions_Haiti_Abolition.Name = "TXT_KEY_DECISIONS_LEUGI_HAITI_ABOLITION"
	Decisions_Haiti_Abolition.Desc = "TXT_KEY_DECISIONS_LEUGI_HAITI_ABOLITION_DESC"
	HookDecisionCivilizationIcon(Decisions_Haiti_Abolition, "CIVILIZATION_LEUGI_HAITI")
	Decisions_Haiti_Abolition.Weight = nil
	Decisions_Haiti_Abolition.CanFunc = (
		function(pPlayer)	
			-- Check Civ
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_LEUGI_HAITI"]) then return false, false end
			-- Check if the decision has been enacted before
			if load(pPlayer, "Decisions_Haiti_Abolition") == true then
				Decisions_Haiti_Abolition.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LEUGI_HAITI_ABOLITION_ENACTED_DESC")
				return false, false, true
			end	
			HaitiAbolitionEnactable = true
			-- Requirements
			---- Tech Prereq
			local pTeam = pPlayer:GetTeam();
			if not (Teams[pTeam]:IsHasTech(iAbolitionTechPrereq)) then HaitiAbolitionEnactable = false end
			-- Costs
			---- Magistrates
			if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < iAbolitionMagisCost) then HaitiAbolitionEnactable = false end	
			---- Culture
			local iCost = math.ceil((iAbolitionCultureCost) * iMod)
			if (pPlayer:GetJONSCulture() < iCost) then HaitiAbolitionEnactable = false end
			-- Build the Description 
			Decisions_Haiti_Abolition.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LEUGI_HAITI_ABOLITION_DESC", iAbolitionMagisCost, iCost)
			if HaitiAbolitionEnactable == false then
				return true, false 
			end
			-- Allow the decision!
			return true, true
		end
	)
	
	Decisions_Haiti_Abolition.DoFunc = (
	function(pPlayer)
		-- Pay the price
		---- Magistrates
		pPlayer:ChangeNumResourceTotal(iMagistrate, -iAbolitionMagisCost)
		---- Culture
		local iCost = math.ceil((iAbolitionCultureCost) * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		---- Global Denounce!
		for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
			if iPlayer ~= pPlayer:GetID() then
				pTeam = Teams[pPlayer:GetTeam()]
				iEnemy = iPlayer
				pEnemy = Players[iEnemy]
				iEnemyTeam = pEnemy:GetTeam()
				if pEnemy:IsEverAlive() and pEnemy:IsAlive() and pTeam:IsHasMet(iEnemyTeam) and pTeam:CanDeclareWar(iEnemyTeam) and not(pTeam:IsAtWar(iEnemyTeam)) then
					pPlayer:DoForceDenounce(iPlayer)
				end
			end
		end
		-- Rewards
		---- Ideology Building
		for pCity in pPlayer:Cities() do
			if pCity:IsCapital() then
				pCity:SetNumRealBuilding(iHaitiBuilding, 1)
			end
		end
		--if pPlayer:IsHuman() then
		--	heading = "Choose an Ideology!"
		--	text = "You may choose an ideology after declaring the abolition!"
		--	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_CHOOSE_IDEOLOGY, text, heading);
		--else
		--	pPlayer:SetPolicyBranchUnlocked(GameInfo.PolicyBranchTypes["POLICY_BRANCH_ORDER"].ID, true);
		--end
		str =  Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_CHOOSE_IDEOLOGY_HAITI");
		local tquery = {"UPDATE Language_en_US SET Text = '".. str .."' WHERE Tag = 'TXT_KEY_NOTIFICATION_CHOOSE_IDEOLOGY_FACTORIES'"}
		for i, iQuery in pairs(tquery) do
			for result in DB.Query(iQuery) do
			end
		end
		-- refresh UI texts
		Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
		---- GoldenAge
		local iGA = math.ceil((iGoldenAgeTurns) * iMod)
		pPlayer:ChangeGoldenAgeTurns(iGA)
		-- Save the Decision
		save(pPlayer, "Decisions_Haiti_Abolition", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_LEUGI_HAITI"], "Decisions_Haiti_Abolition", Decisions_Haiti_Abolition)

-------------------------------------------------------------------------------------------------
--Haiti Ritual
--------------------------------------
-- Ritual Variables
iRitualCultureMultiplier = 2
iRitualGiftUnit = GameInfoTypes.UNIT_LEUGI_HOUNGAN
iRitualMissionaryUnit = GameInfoTypes.UNIT_MISSIONARY
iRitualMagCost = 1
---------------------------------------


local Decisions_Haiti_Ritual = {}
	Decisions_Haiti_Ritual.Name = "TXT_KEY_DECISIONS_LEUGI_HAITI_RITUAL"
	Decisions_Haiti_Ritual.Desc = "TXT_KEY_DECISIONS_LEUGI_HAITI_RITUAL_DESC"
	HookDecisionCivilizationIcon(Decisions_Haiti_Ritual, "CIVILIZATION_LEUGI_HAITI")
	Decisions_Haiti_Ritual.Weight = nil
	Decisions_Haiti_Ritual.CanFunc = (
		function(pPlayer)	
			-- Check Civ
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_LEUGI_HAITI"]) then return false, false end
			-- Check if the decision has been enacted this era
			local iEra = load(pPlayer, "Decisions_Haiti_Ritual")
			local iCurrentEra = pPlayer:GetCurrentEra()
			if iEra ~= nil then
				if iEra < iCurrentEra then
					save(pPlayer, "Decisions_Haiti_Ritual", nil)
				else
					if pPlayer:IsHuman() then	
						Decisions_Haiti_Ritual.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LEUGI_HAITI_RITUAL_ENACTED_DESC")
					end
					return false, false, true
				end
			end
			HaitiRitualEnactable = true
			-- Get Religion
			if not (pPlayer:HasCreatedReligion()) then HaitiRitualEnactable = false end
			-- Get Culture
			local iCultureFromCities = pPlayer:GetJONSCulturePerTurnFromCities();
			local CultureBoost = iCultureFromCities * iRitualCultureMultiplier
			-- Requirements
			---- Get Workers
			if (pPlayer:GetUnitClassCount(GameInfo.UnitClasses.UNITCLASS_WORKER.ID) < 1) then HaitiRitualEnactable = false end
			-- Costs
			---- Magistrates
			if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < iRitualMagCost) then HaitiRitualEnactable = false end	
			-- Build the Description 
			Decisions_Haiti_Ritual.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_LEUGI_HAITI_RITUAL_DESC", iRitualMagCost, CultureBoost)
			if HaitiRitualEnactable == false then
				return true, false 
			end
			-- Allow the decision!
			return true, true
		end
	)
	
	Decisions_Haiti_Ritual.DoFunc = (

	function(pPlayer)
		-- Pay the price
		---- Magistrates
		pPlayer:ChangeNumResourceTotal(iMagistrate, -iRitualMagCost)
		---- Worker
		WorkerCount = 0
		local iWorkerID = GameInfo.Units.UNIT_WORKER.ID
		for pUnit in pPlayer:Units() do
			if (pUnit:GetUnitType() ==  iWorkerID) then
				if WorkerCount < 1 then
					pUnit:Kill(true, -1);
					WorkerCount = WorkerCount + 1
				end
			end
		end
		-- Rewards
		---- Culture
		local iCultureFromCities = pPlayer:GetJONSCulturePerTurnFromCities();
		local CultureBoost = iCultureFromCities * iRitualCultureMultiplier
		pPlayer:ChangeJONSCulture(CultureBoost)
		---- Houngan
		InitUnitFromCity(pPlayer:GetCapitalCity(), iRitualGiftUnit, 1)
		-- Save the decision
		local iCurrentEra = pPlayer:GetCurrentEra()
		save(pPlayer, "Decisions_Haiti_Ritual", iCurrentEra)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_LEUGI_HAITI"], "Decisions_Haiti_Ritual", Decisions_Haiti_Ritual)
