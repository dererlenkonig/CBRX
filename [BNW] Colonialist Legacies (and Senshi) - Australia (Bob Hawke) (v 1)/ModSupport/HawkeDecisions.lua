--------------------------------------------------------------------------------------------------------------------------
-- Kirribilli
--------------------------------------------------------------------------------------------------------------------------

local Decisions_Kirribilli = {}
	Decisions_Kirribilli.Name = "TXT_KEY_DECISIONS_SENSHI_KIRRIBILLI"
	Decisions_Kirribilli.Desc = "TXT_KEY_DECISIONS_SENSHI_KIRRIBILLI_DESC"
	Decisions_Kirribilli.Pedia = "TXT_KEY_DECISIONS_BUILDING_SENSHI_KIRRIBILLI"
	HookDecisionCivilizationIcon(Decisions_Kirribilli, "CIVILIZATION_SENSHI_HAWKE")
	Decisions_Kirribilli.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_SENSHI_HAWKE then return false, false end
		if load(pPlayer, "Decisions_Kirribilli") == true then
			Decisions_Kirribilli.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SENSHI_KIRRIBILLI_ENACTED_DESC")
			return false, false, true
		end
		local pCity = pPlayer:GetCapitalCity()
		if not(pCity) then return false, false end
		local iCost = math.ceil(pCity:GetBuildingPurchaseCost(GameInfoTypes.BUILDING_CONSTABLE) * 1.5)
		Decisions_Kirribilli.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SENSHI_KIRRIBILLI_DESC", iCost)
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:GetCurrentEra() < GameInfoTypes.ERA_MODERN) then return true, false end
	end
	)
	
	Decisions_Kirribilli.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SENSHI_KIRRIBILLI, 1)
		InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_GREAT_MERCHANT, 1)
		save(pPlayer, "Decisions_Kirribilli", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_SENSHI_HAWKE, "Decisions_Kirribilli", Decisions_Kirribilli)

--------------------------------------------------------------------------------------------------------------------------
-- New Parliament
--------------------------------------------------------------------------------------------------------------------------

local Decisions_NewParliament = {}
	Decisions_NewParliament.Name = "TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT"
	Decisions_NewParliament.Desc = "TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT_DESC"
	Decisions_NewParliament.Pedia = "TXT_KEY_DECISIONS_BUILDING_SENSHI_NEWPARLIAMENT"
	HookDecisionCivilizationIcon(Decisions_NewParliament, "CIVILIZATION_SENSHI_HAWKE")
	Decisions_NewParliament.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_SENSHI_HAWKE then return false, false end
		if load(pPlayer, "Decisions_NewParliament") == true then
			Decisions_NewParliament.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT_ENACTED_DESC")
			return false, false, true
		end
		local pCity = pPlayer:GetCapitalCity()
		if not(pCity) then return false, false end
		local iCost = math.ceil(pCity:GetBuildingPurchaseCost(GameInfoTypes.BUILDING_CONSTABLE) * 1.5)
		Decisions_NewParliament.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT_DESC", iCost)
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_BANKING)) and (pPlayer:GetGold() >= iCost) then
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_NewParliament.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil((pPlayer:GetCapitalCity():GetBuildingPurchaseCost(GameInfoTypes.BUILDING_CONSTABLE)) * 1.5)
		
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_SENSHI_NEWPARLIAMENT, 1)
		InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_GREAT_ENGINEER, 1)
		save(pPlayer, "Decisions_NewParliament", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_SENSHI_HAWKE, "Decisions_NewParliament", Decisions_NewParliament)