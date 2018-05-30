-------------------------------------------------------------------------------------------------------------------------
-- Oman: Request the services of the Balochi People
-------------------------------------------------------------------------------------------------------------------------
local Decisions_MC_OmanBalochi  = {}
    Decisions_MC_OmanBalochi .Name = "TXT_KEY_DECISIONS_MC_OMANBALOCHI"
    Decisions_MC_OmanBalochi .Desc = "TXT_KEY_DECISIONS_MC_OMANBALOCHI_DESC"
    HookDecisionCivilizationIcon(Decisions_MC_OmanBalochi , "CIVILIZATION_MC_OMAN")
    Decisions_MC_OmanBalochi .CanFunc = (
    function(pPlayer)
	    local pCity = pPlayer:GetCapitalCity()
        if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_OMAN then return false, false end
        if load(pPlayer, "Decisions_MC_OmanBalochi ") == true then
            Decisions_MC_OmanBalochi .Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_OMANBALOCHI_ENACTED_DESC")
            return false, false, true
        end
       
        local iCost = 2 * pCity:GetUnitPurchaseCost(GameInfoTypes.UNIT_MUSKETMAN)
        Decisions_MC_OmanBalochi .Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_OMANBALOCHI_DESC")
 
        if (pPlayer:GetGold() < iCost) then return true, false end
        if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
        if not (Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_GUNPOWDER)) then return true, false end
       
        return true, true      
    end
    )
   
    Decisions_MC_OmanBalochi .DoFunc = (
    function(pPlayer)
        local pCity = pPlayer:GetCapitalCity()
        local iCost = 2 * pCity:GetUnitPurchaseCost(GameInfoTypes.UNIT_MUSKETMAN)
        pPlayer:ChangeGold(-iCost)
        pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
       
        local tUnits = InitUnitFromCity(pCity, GameInfoTypes.UNIT_MUSKETMAN, 1)
        for iKey, pUnit in pairs(tUnits) do
            pUnit:ChangeExperience(30)
            pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_DRILL_1, true)
        end
       
        save(pPlayer, "Decisions_MC_OmanBalochi ", true)
    end
    )
   
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_OMAN, "Decisions_MC_OmanBalochi ", Decisions_MC_OmanBalochi )

-------------------------------------------------------------------------------------------------------------------------
-- Oman: Impose Omani governors
-------------------------------------------------------------------------------------------------------------------------
local Decisions_MC_OmanGovernors = {}
	Decisions_MC_OmanGovernors.Name = "TXT_KEY_DECISIONS_MC_OMANGOVERNORS"
	Decisions_MC_OmanGovernors.Desc = "TXT_KEY_DECISIONS_MC_OMANGOVERNORS_DESC"
	HookDecisionCivilizationIcon(Decisions_MC_OmanGovernors, "CIVILIZATION_MC_OMAN")
	Decisions_MC_OmanGovernors.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_OMAN then return false, false end
		if load(pPlayer, "Decisions_MC_OmanGovernors") == true then
			Decisions_MC_OmanGovernors.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_OMANGOVERNORS_ENACTED_DESC")
			return false, false, true
		end
		
		Decisions_MC_OmanGovernors.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MC_OMANGOVERNORS_DESC")
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 3) then return true, false end
		local bIsHasCoastaCaptured = false
		local iPlayer = pPlayer:GetID()
		for pCity in pPlayer:Cities() do 
			if (pCity:IsCoastal()) and (pCity:GetOriginalOwner() ~= iPlayer) then
				bIsHasCoastaCaptured = true
				break
			end
		end
		if not (bIsHasCoastaCaptured) then return true, false end
		if not (Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_COMPASS)) then return true, false end
		
		return true, true		
	end
	)
	
	Decisions_MC_OmanGovernors.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -3)
		
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_MC_OMANGOVERNORS, true)		
		
		save(pPlayer, "Decisions_MC_OmanGovernors", true)
	end
	)
	
	Decisions_MC_OmanGovernors.Monitors = {}
	Decisions_MC_OmanGovernors.Monitors[GameEvents.PlayerDoTurn] =  (	
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_MC_OmanGovernors") == true then
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(GameInfoTypes.BUILDING_MC_OMANI_MINAA) then
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_MC_OMANGOVERNORS, 1)
				else
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_MC_OMANGOVERNORS, 0)
				end
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_OMAN, "Decisions_MC_OmanGovernors", Decisions_MC_OmanGovernors)