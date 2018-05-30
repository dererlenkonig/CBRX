-- Nubia Decisions
-- Author: Sukritact
--=======================================================================================================================

print("Nubia Decisions: loaded")

--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_IsUsingPietyPrestige
--------------------------------------------------------------------------------------------------------------------------
function JFD_IsUsingPietyPrestige()
	local pietyPrestigeModID = "eea66053-7579-481a-bb8d-2f3959b59974"
	local isUsingPiety = false
	
	for _, mod in pairs(Modding.GetActivatedMods()) do
	  if (mod.ID == pietyPrestigeModID) then
	    isUsingPiety = true
	    break
	  end
	end

	return isUsingPiety
end
--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local bIsUsingPietyPrestige = JFD_IsUsingPietyPrestige()
-------------------------------------------------------------------------------------------------------------------------
-- Nubia: Restore the Temple of Amun
-------------------------------------------------------------------------------------------------------------------------
local Decisions_NubiaAmunTemple = {}
	Decisions_NubiaAmunTemple.Name = "TXT_KEY_DECISIONS_NUBIAAMUNTEMPLE"
	Decisions_NubiaAmunTemple.Desc = "TXT_KEY_DECISIONS_NUBIAAMUNTEMPLE_DESC"
	HookDecisionCivilizationIcon(Decisions_NubiaAmunTemple, "CIVILIZATION_MC_LITE_NUBIA")
	Decisions_NubiaAmunTemple.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_LITE_NUBIA then return false, false end
		if load(pPlayer, "Decisions_NubiaAmunTemple") == true then
			Decisions_NubiaAmunTemple.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NUBIAAMUNTEMPLE_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(200 * iMod)
		Decisions_NubiaAmunTemple.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NUBIAAMUNTEMPLE_DESC", iCost)

		if (pPlayer:GetFaith() < iCost) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetNumCities() > pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_TEMPLE)) then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_PHILOSOPHY)) then return true, false end

		local iReligion = -1
		if bIsUsingPietyPrestige then
			iReligion = JFD_GetStateReligion(pPlayer:GetID()) else iReligion = GetPlayerMajorityReligion(pPlayer)
		end
		if iReligion == -1 then return true, false end

		local pCity = Game.GetHolyCityForReligion(iReligion, -1)
		if (pCity:GetOwner() ~= pPlayer:GetID()) then return true, false end

		return true, true
	end
	)
	
	Decisions_NubiaAmunTemple.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		local iCost = math.ceil(300 * iMod)
		pPlayer:ChangeFaith(-iCost)

		local iReligion = -1
		if bIsUsingPietyPrestige then
			iReligion = JFD_GetStateReligion(pPlayer:GetID()) else iReligion = GetPlayerMajorityReligion(pPlayer)
		end
		local pCity = Game.GetHolyCityForReligion(iReligion, -1)
		pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_GRAND_TEMPLE, 1)
		pPlayer:ChangeGoldenAgeTurns(pPlayer:GetGoldenAgeLength())

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_NUBIAAMUNTEMPLE, true)

		save(pPlayer, "Decisions_NubiaAmunTemple", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_LITE_NUBIA, "Decisions_NubiaAmunTemple", Decisions_NubiaAmunTemple)
-------------------------------------------------------------------------------------------------------------------------
-- Nubia: Subsidise the Furnaces
-------------------------------------------------------------------------------------------------------------------------
local Decisions_NubiaFurnace = {}
	Decisions_NubiaFurnace.Name = "TXT_KEY_DECISIONS_NUBIAFURNACE"
	Decisions_NubiaFurnace.Desc = "TXT_KEY_DECISIONS_NUBIAFURNACE_DESC"
	HookDecisionCivilizationIcon(Decisions_NubiaFurnace, "CIVILIZATION_MC_LITE_NUBIA")
	Decisions_NubiaFurnace.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MC_LITE_NUBIA then return false, false end
		if load(pPlayer, "Decisions_NubiaFurnace") == true then
			Decisions_NubiaFurnace.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NUBIAFURNACE_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(200 * iMod)
		Decisions_NubiaFurnace.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NUBIAFURNACE_DESC", iCost)
		
		if (pPlayer:GetGold() < iCost) then	return true, false end
		if (pPlayer:GetCapitalCity() == nil) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_IRON_WORKING)) then return true, false end

		return true, true
	end
	)
	
	Decisions_NubiaFurnace.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		
		save(pPlayer, "Decisions_NubiaFurnace", true)

		Decisions_NubiaFurnace.Monitors[GameEvents.PlayerDoTurn](pPlayer:GetID())
	end
	)

	Decisions_NubiaFurnace.Monitors = {}
	Decisions_NubiaFurnace.Monitors[GameEvents.PlayerDoTurn] =  (	
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_NubiaFurnace") == true then
			local iFree = 4
			for pCity in pPlayer:Cities() do
				if iFree > 0 then
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_NUBIAFURNACEFREE, 1)
					iFree = iFree - 1
				end
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_NUBIAFURNACE, pCity:GetNumBuilding(GameInfoTypes.BUILDING_FORGE))
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MC_LITE_NUBIA, "Decisions_NubiaFurnace", Decisions_NubiaFurnace)
--=======================================================================================================================
--=======================================================================================================================