-- Moors Decisions
-- Author: Sukritact
--=======================================================================================================================

print("Moors Decisions: loaded")

--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Moors: Claim the Caliphate
-------------------------------------------------------------------------------------------------------------------------
local Decisions_MoorCaliphate = {}
	Decisions_MoorCaliphate.Name = "TXT_KEY_DECISIONS_MOORCALIPHATE"
	Decisions_MoorCaliphate.Desc = "TXT_KEY_DECISIONS_MOORCALIPHATE_DESC"
	HookDecisionCivilizationIcon(Decisions_MoorCaliphate, "CIVILIZATION_MC_LITE_MOOR")
	Decisions_MoorCaliphate.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_LITE_MOOR then return false, false end
		if load(pPlayer, "Decisions_MoorCaliphate") == true then
			Decisions_MoorCaliphate.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MOORCALIPHATE_ENACTED_DESC")
			return false, false, true
		end
		Decisions_MoorCaliphate.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MOORCALIPHATE_DESC")

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		local pCity = pPlayer:GetCapitalCity()
		if pCity == nil then return true, false end
		if pCity:GetNumWorldWonders() < 1 then return true, false end
		if pCity:GetPopulation() < 10 then return true, false end

		return true, true
	end
	)
	
	Decisions_MoorCaliphate.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		local iPlayer = pPlayer:GetID()
		PreGame.SetCivilizationAdjective(iPlayer, Locale.ConvertTextKey("TXT_KEY_CIV_MC_LITE_CORDOBA_ADJECTIVE"))
		PreGame.SetCivilizationDescription(iPlayer, Locale.ConvertTextKey("TXT_KEY_CIV_MC_LITE_CORDOBA_DESC"))
		PreGame.SetCivilizationShortDescription(iPlayer, Locale.ConvertTextKey("TXT_KEY_CIV_MC_LITE_CORDOBA_SHORT_DESC"))

		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_MC_LITE_CALIPHATE, 1)

		save(pPlayer, "Decisions_MoorCaliphate", true)
	end
	)

	Decisions_MoorCaliphate.Monitors = {}
	Decisions_MoorCaliphate.Monitors[GameEvents.PlayerDoTurn] = (	
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_MoorCaliphate") == true then
			pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_MC_LITE_CALIPHATE, 1)
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_LITE_MOOR, "Decisions_MoorCaliphate", Decisions_MoorCaliphate)
-------------------------------------------------------------------------------------------------------------------------
-- Moors: Construct the Great Mosque
-------------------------------------------------------------------------------------------------------------------------
local Decisions_MoorMosque = {}
	Decisions_MoorMosque.Name = "TXT_KEY_DECISIONS_MOORMOSQUE"
	Decisions_MoorMosque.Desc = "TXT_KEY_DECISIONS_MOORMOSQUE_DESC"
	Decisions_MoorMosque.Pedia = "TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_DESC"
	HookDecisionCivilizationIcon(Decisions_MoorMosque, "CIVILIZATION_MC_LITE_MOOR")
	Decisions_MoorMosque.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_LITE_MOOR then return false, false end
		if load(pPlayer, "Decisions_MoorMosque") == true then
			Decisions_MoorMosque.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MOORMOSQUE_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(150 * iMod)
		Decisions_MoorMosque.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MOORMOSQUE_DESC", iCost)
		if pPlayer:GetFaith() < iCost then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_THEOLOGY)) then return true, false end
		if not(pPlayer:GetCapitalCity()) then return true, false end

		return true, true
	end
	)
	
	Decisions_MoorMosque.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(150 * iMod)
		pPlayer:ChangeFaith(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA, 1)

		save(pPlayer, "Decisions_MoorMosque", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_LITE_MOOR, "Decisions_MoorMosque", Decisions_MoorMosque)
--=======================================================================================================================
--=======================================================================================================================