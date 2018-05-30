-- DMS_Ethiopia_Decisions
-- Author: DMS
--==========================================================================================================================
-- includes
--==========================================================================================================================
include("PlotIterators.lua")
--==========================================================================================================================
print("DMS's The Ethiopian pack's Decisions: loaded")
--==========================================================================================================================
-- USER SETTINGS
--==========================================================================================================================
-- DMS_GetUserSetting (adapted from JFD's JFD_GetUserSetting - credit goes there!)
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetUserSetting(type)
	for row in GameInfo.DMS_GlobalUserSettings("Type = '" .. type .. "'") do
		return row.Value
	end
end
--==========================================================================================================================
-- UTILITIES
--==========================================================================================================================
-- Debug
----------------------------------------------------------------------------------------------------------------------------
local bPrintForDebug = DMS_GetUserSetting("DMS_ETHIOPIA_DECISIONS_DEBUGGING_ON") == 1

function DMS_PrintDecisions(string)
	if (not bPrintForDebug) then
		return
	else
		return print(string)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
----------------------------------------------------------------------------------------------------------------------------
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if (not player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_SendNotification
----------------------------------------------------------------------------------------------------------------------------
function JFD_SendNotification(playerID, notificationType, description, descriptionShort, global, iX, iY)
	local player = Players[playerID]
	if global then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
	else
		if player:IsHuman() then
			Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes[notificationType], description, descriptionShort, iX or -1, iY or -1)
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
----------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_GetNearestCity (adapted from Sukritact's Sami civ)
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetNearestCity(pPlayer, plotX, plotY)
	local iDistance = nil
	local pTargetCity = nil
	for pCity in pPlayer:Cities() do
		if not(iDistance) or iDistance > Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY()) then
			pTargetCity = pCity
			iDistance = Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY())
		end
	end
	return(pTargetCity)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_GetMostDistantCity
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetMostDistantCity(pPlayer, plotX, plotY)
	local iDistance = nil
	local pTargetCity = nil
	for pCity in pPlayer:Cities() do
		if not(iDistance) or iDistance < Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY()) then
			pTargetCity = pCity
			iDistance = Map.PlotDistance(plotX, plotY, pCity:GetX(), pCity:GetY())
		end
	end
	return(pTargetCity)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_GetWriterCity
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetWriterCity(pPlayer)
	local pWriterCity = nil
	for pCity in pPlayer:Cities() do
		if pCity then
			local buildingWritersGuildID = GameInfoTypes["BUILDING_WRITERS_GUILD"]
			if pCity:IsHasBuilding(buildingWritersGuildID) then
				pWriterCity = pCity
			end
		end
	end
	return pWriterCity
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_GetMusicianCity
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetMusicianCity(pPlayer)
	local pMusicianCity = pPlayer:GetCapitalCity()
	for pCity in pPlayer:Cities() do
		if pCity then
			local buildingMusiciansGuildID = GameInfoTypes["BUILDING_MUSICIANS_GUILD"]
			if pCity:IsHasBuilding(buildingMusiciansGuildID) then
				pMusicianCity = pCity
			end
		end
	end
	return pMusicianCity
end
----------------------------------------------------------------------------------------------------------------------------
-- GetRandomCity
----------------------------------------------------------------------------------------------------------------------------
function GetRandomCity(pPlayer)
	local iCity = math.random(pPlayer:GetNumCities())
	local i = 0
	for pCity in pPlayer:Cities() do
		i = i + 1
		if (i == iCity) then
			return pCity
		end
	end
  
	return nil
end
--==========================================================================================================================
-- Civ Specific Decisions
--==========================================================================================================================
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local civilisationAksumKalebID				= GameInfoTypes["CIVILIZATION_DMS_AKSUM_KALEB"]
local civilisationEthiopiaAmdaSeyonID		= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_SEYON_I"]
local civilisationEthiopiaZaraYaqobID		= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_YAQOB"]
local civilisationEthiopiaMenelikID			= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_MENELIK_II"]
local civilisationEthiopiaHaileSelassieID	= GameInfoTypes["CIVILIZATION_ETHIOPIA"]
local civilisationSemienGuditID				= GameInfoTypes["CIVILIZATION_DMS_SEMIEN_GUDIT"]

local eraClassicalID						= GameInfoTypes["ERA_CLASSICAL"]
local eraMedievalID							= GameInfoTypes["ERA_MEDIEVAL"]
local eraRenaissanceID						= GameInfoTypes["ERA_RENAISSANCE"]
local eraIndustrialID						= GameInfoTypes["ERA_INDUSTRIAL"]
local techCurrencyID						= GameInfoTypes["TECH_CURRENCY"]
local techEngineeringID						= GameInfoTypes["TECH_ENGINEERING"]
local techTheologyID						= GameInfoTypes["TECH_THEOLOGY"]
local techBankingID							= GameInfoTypes["TECH_BANKING"]
local policyMintAksumiteCoinageID			= GameInfoTypes["POLICY_DECISIONS_DMS_AKSUM_COINAGE"]
local policyDungurPalaceID					= GameInfoTypes["POLICY_DECISIONS_DMS_DUNGUR_PALACE"]
local policyCentralizationReformsID			= GameInfoTypes["POLICY_DECISIONS_DMS_CENTRALIZATION_REFORMS"]
local buildingBankID						= GameInfoTypes["BUILDING_BANK"]
local buildingSteleID						= GameInfoTypes["BUILDING_STELE"]
local buildingTempleID						= GameInfoTypes["BUILDING_TEMPLE"]
local buildingWritersGuildID				= GameInfoTypes["BUILDING_WRITERS_GUILD"]
local buildingMusiciansGuildID				= GameInfoTypes["BUILDING_MUSICIANS_GUILD"]
local buildingMonumentID					= GameInfoTypes["BUILDING_MONUMENT"]
local buildingDungurPalaceID				= GameInfoTypes["BUILDING_DECISIONS_DMS_DUNGUR_PALACE"]
local buildingZagweDynastyID				= GameInfoTypes["BUILDING_DECISIONS_DMS_ZAGWE_DYNASTY"]
local buildingChronicleOfEldadHaDaniID		= GameInfoTypes["BUILDING_DECISIONS_DMS_ELDAD_HA_DANI"]
local buildingTempleGreatWorkWritingID		= GameInfoTypes["BUILDING_DECISIONS_DMS_KEBRA_NAGAST_TEMPLE"]
local buildingTempleWriterSpecialistID		= GameInfoTypes["BUILDING_DECISIONS_DMS_KEBRA_NAGAST_WRITER"]
local buildingTheologicalWorkID				= GameInfoTypes["BUILDING_DECISIONS_DMS_THEOLOGICAL_WORK"]
local buildingCentralizationReformsID		= GameInfoTypes["BUILDING_DECISIONS_DMS_CENTRALIZATION_REFORMS"]
local buildingBankOfEthiopiaID				= GameInfoTypes["BUILDING_DECISIONS_DMS_BANK_OF_ETHIOPIA"]
local buildingRewriteTheConstitutionID		= GameInfoTypes["BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION"]
local buildingRewriteTheConstitutionCapID	= GameInfoTypes["BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_CAP"]
local unitGreatWriterID						= GameInfoTypes["UNIT_WRITER"]
local unitSebastopolID						= GameInfoTypes["UNIT_DMS_SEBASTOPOL"]
local unitMusicianID						= GameInfoTypes["UNIT_MUSICIAN"]
local unitTheologicalWork1ID				= GameInfoTypes["UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_1"]
local unitTheologicalWork2ID				= GameInfoTypes["UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_2"]
local unitTheologicalWork3ID				= GameInfoTypes["UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_3"]
local promotionQesteNihbID					= GameInfoTypes["PROMOTION_DECISIONS_DMS_QESTE_NIHB"]
local promotionHarebGondaID					= GameInfoTypes["PROMOTION_DECISIONS_DMS_HAREB_GONDA"]
local promotionTekulaID						= GameInfoTypes["PROMOTION_DECISIONS_DMS_TEKULA"]
local promotionAxuaratAxuaraiID				= GameInfoTypes["PROMOTION_DECISIONS_DMS_AXUARAT_AXUARAI"]
local unitCombatArcherID					= GameInfoTypes["UNITCOMBAT_ARCHER"]
local unitCombatMountedID					= GameInfoTypes["UNITCOMBAT_MOUNTED"]
local unitCombatReconID						= GameInfoTypes["UNITCOMBAT_RECON"]
local unitCombatMeleeID						= GameInfoTypes["UNITCOMBAT_MELEE"]
local specialistMusicianID					= GameInfoTypes["SPECIALIST_MUSICIAN"]
local missionCreateGreatWorkID				= GameInfoTypes["MISSION_CREATE_GREAT_WORK"]

-- disable decisions from Sukritact's E&D for Ethiopia
tDecisions.Decisions_EthiopiaCoinage = nil
tDecisions.Decisions_EthiopiaSolomonic = nil
--==========================================================================================================================
-- KALEB
--==========================================================================================================================
-- Mint Aksumite Coinage
----------------------------------------------------------------------------------------------------------------------------
local Decisions_AksumCoinage = {}
    Decisions_AksumCoinage.Name = "TXT_KEY_DECISIONS_DMS_MINT_AKSUMITE_COINAGE"
	Decisions_AksumCoinage.Desc = "TXT_KEY_DECISIONS_DMS_MINT_AKSUMITE_COINAGE_DESC"
	HookDecisionCivilizationIcon(Decisions_AksumCoinage, "CIVILIZATION_DMS_AKSUM_KALEB")
	Decisions_AksumCoinage.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilisationAksumKalebID				then return false, false end
		if load(pPlayer, "Decisions_AksumCoinage") == true then
			Decisions_AksumCoinage.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_MINT_AKSUMITE_COINAGE_ENACTED_DESC")
			return false, false, true
		end
		
		local iCultureCost = math.ceil(150 * iMod)
		Decisions_AksumCoinage.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_MINT_AKSUMITE_COINAGE_DESC", iCultureCost)
		
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pPlayer:GetJONSCulture() < iCultureCost)								then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1)				then return true, false end
		if (pPlayer:GetNumCities() > pPlayer:CountNumBuildings(buildingSteleID))	then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(techCurrencyID))					then return true, false end
		
		return true, true
	end
	)
	
	Decisions_AksumCoinage.DoFunc = (
	function(pPlayer)
		local iCultureCost = math.ceil(150 * iMod)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(policyMintAksumiteCoinageID, true)
		
		save(pPlayer, "Decisions_AksumCoinage", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationAksumKalebID, "Decisions_AksumCoinage", Decisions_AksumCoinage)
----------------------------------------------------------------------------------------------------------------------------
-- Construct the Dungur Palace
----------------------------------------------------------------------------------------------------------------------------
local Decisions_DungurPalace = {}
	Decisions_DungurPalace.Name = "TXT_KEY_DECISIONS_DMS_CONSTRUCT_THE_DUNGUR_PALACE"
	Decisions_DungurPalace.Desc = "TXT_KEY_DECISIONS_DMS_CONSTRUCT_THE_DUNGUR_PALACE_DESC"
	HookDecisionCivilizationIcon(Decisions_DungurPalace, "CIVILIZATION_DMS_AKSUM_KALEB")
	Decisions_DungurPalace.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationAksumKalebID)			then return false, false end
		if load(pPlayer, "Decisions_DungurPalace") == true then
			Decisions_DungurPalace.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CONSTRUCT_THE_DUNGUR_PALACE_ENACTED_DESC")
			return false, false, true 
		end
		
		local iGoldCost = math.ceil(250 * iMod)
		Decisions_DungurPalace.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CONSTRUCT_THE_DUNGUR_PALACE_DESC", iGoldCost)
		
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pPlayer:GetGold() < iGoldCost)											then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2)				then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(techEngineeringID))				then return true, false end
		
		return true, true
	end
	)
	
	Decisions_DungurPalace.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iGoldCost = math.ceil(250 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(policyDungurPalaceID, true)
		local pCapital = pPlayer:GetCapitalCity()
		pCapital:SetNumRealBuilding(buildingDungurPalaceID, 1)
		
		save(pPlayer, "Decisions_DungurPalace", true)
	end
	)

Decisions_AddCivilisationSpecific(civilisationAksumKalebID, "Decisions_DungurPalace", Decisions_DungurPalace)
--==========================================================================================================================
-- GUDIT
--==========================================================================================================================
-- Chronicle of Eldad ha-Dani
----------------------------------------------------------------------------------------------------------------------------
local Decisions_ChronicleOfEldadHaDani = {}
	Decisions_ChronicleOfEldadHaDani.Name = "TXT_KEY_DECISIONS_DMS_CHRONICLE_OF_ELDAD_HA_DANI"
	Decisions_ChronicleOfEldadHaDani.Desc = "TXT_KEY_DECISIONS_DMS_CHRONICLE_OF_ELDAD_HA_DANI_DESC"
	HookDecisionCivilizationIcon(Decisions_ChronicleOfEldadHaDani, "CIVILIZATION_DMS_SEMIEN_GUDIT")
	Decisions_ChronicleOfEldadHaDani.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationSemienGuditID)				then return false, false end
		if load(pPlayer, "Decisions_ChronicleOfEldadHaDani") == true then
			Decisions_ChronicleOfEldadHaDani.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CHRONICLE_OF_ELDAD_HA_DANI_ENACTED_DESC")
			return false, false, true 
		end
		
		local iFaithCost = math.ceil(150 * iMod)
		Decisions_ChronicleOfEldadHaDani.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CHRONICLE_OF_ELDAD_HA_DANI_DESC", iFaithCost)
		
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pPlayer:GetFaith() < iFaithCost)										then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1)				then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(techTheologyID))					then return true, false end
		
		return true, true
	end
	)
	
	Decisions_ChronicleOfEldadHaDani.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iFaithCost = math.ceil(150 * iMod)
		pPlayer:ChangeFaith(-iFaithCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		local pCapital = pPlayer:GetCapitalCity()
		pCapital:SetNumRealBuilding(buildingChronicleOfEldadHaDaniID, 1)

		
		save(pPlayer, "Decisions_ChronicleOfEldadHaDani", true)
	end
	)
	
	Decisions_ChronicleOfEldadHaDani.Monitors = {}
	Decisions_ChronicleOfEldadHaDani.Monitors[GameEvents.CityCaptureComplete] =  (	
	function(iOldPlayer, bCapital, iX, iY, iNewPlayer, conquest, conquest2)
		local pOldPlayer = Players[iOldPlayer]
		local pNewPlayer = Players[iNewPlayer]
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		if pCity then
			-- move dummy buildings to new capital
			if load(pOldPlayer, "Decisions_ChronicleOfEldadHaDani") == true and pOldPlayer:GetCapitalCity() == pCity then
				local iHasChronicleOfEldadHaDani = pCity:GetNumRealBuilding(buildingChronicleOfEldadHaDaniID)
				if (iHasChronicleOfEldadHaDani > 0) then
					pCity:SetNumRealBuilding(buildingChronicleOfEldadHaDaniID, 0)
					if (pOldPlayer:IsAlive()) then
						pOldPlayer:GetCapitalCity():SetNumRealBuilding(buildingChronicleOfEldadHaDaniID, iHasChronicleOfEldadHaDani)
					end
				end
			end
			-- moved dummy buildings to recaptured capital
			local pCapital = pNewPlayer:GetCapitalCity()
			if pCapital then
				if pCapital:GetID() == pCity:GetID() then
					for pCitytoRemove in pNewPlayer:Cities() do
						if pCitytoRemove:GetID() ~= pCity:GetID() and pCitytoRemove:IsHasBuilding(buildingChronicleOfEldadHaDaniID) then
							local iHasChronicleOfEldadHaDani = pCity:GetNumRealBuilding(buildingChronicleOfEldadHaDaniID)
							pCity:SetNumRealBuilding(buildingChronicleOfEldadHaDaniID, iHasChronicleOfEldadHaDani)
							pCitytoRemove:SetNumRealBuilding(buildingChronicleOfEldadHaDaniID, 0)
						end
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationSemienGuditID, "Decisions_ChronicleOfEldadHaDani", Decisions_ChronicleOfEldadHaDani)
----------------------------------------------------------------------------------------------------------------------------
-- Found the Zagwe Dynasty
----------------------------------------------------------------------------------------------------------------------------
local Decisions_FoundTheZagweDynasty = {}
	Decisions_FoundTheZagweDynasty.Name = "TXT_KEY_DECISIONS_DMS_FOUND_THE_ZAGWE_DYNASTY"
	Decisions_FoundTheZagweDynasty.Desc = "TXT_KEY_DECISIONS_DMS_FOUND_THE_ZAGWE_DYNASTY_DESC"
	HookDecisionCivilizationIcon(Decisions_FoundTheZagweDynasty, "CIVILIZATION_DMS_SEMIEN_GUDIT")
	Decisions_FoundTheZagweDynasty.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationSemienGuditID)				then return false, false end
		if load(pPlayer, "Decisions_FoundTheZagweDynasty") == true then
			Decisions_FoundTheZagweDynasty.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_FOUND_THE_ZAGWE_DYNASTY_ENACTED_DESC")
			return false, false, true 
		end
		
		local iFaithCost = math.ceil(25 * iMod)
		local iCultureCost = math.ceil(150 * iMod)
		Decisions_FoundTheZagweDynasty.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_FOUND_THE_ZAGWE_DYNASTY_DESC", iCultureCost, iFaithCost)
		
		local iPlayer = pPlayer:GetID()
		local bHasCapturedCapital = false
		for pCity in pPlayer:Cities() do
			if pCity and pCity:IsOriginalMajorCapital() and pCity:GetOriginalOwner() ~= iPlayer then
				bHasCapturedCapital = true
			end
		end

		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (not bHasCapturedCapital)												then return true, false end
		if (pPlayer:GetFaith() < iFaithCost)										then return true, false end
		if (pPlayer:GetJONSCulture() < iCultureCost)								then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2)				then return true, false end
		
		return true, true
	end
	)
	
	Decisions_FoundTheZagweDynasty.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iFaithCost = math.ceil(25 * iMod)
		local iCultureCost = math.ceil(150 * iMod)
		pPlayer:ChangeFaith(-iFaithCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		for pCity in pPlayer:Cities() do
			if pCity and pCity:GetOriginalOwner() ~= iPlayer then
				pCity:SetNumRealBuilding(buildingZagweDynastyID, 1)
			end
		end
		PreGame.SetCivilizationDescription(iPlayer, "TXT_KEY_CIV_ETHIOPIA_DESC")
		PreGame.SetCivilizationShortDescription(iPlayer, "TXT_KEY_CIV_ETHIOPIA_SHORT_DESC")
		
		save(pPlayer, "Decisions_FoundTheZagweDynasty", true)
	end
	)
	
	Decisions_FoundTheZagweDynasty.Monitors = {}
	Decisions_FoundTheZagweDynasty.Monitors[GameEvents.CityCaptureComplete] =  (	
	function(iOldPlayer, bCapital, iX, iY, iNewPlayer, conquest, conquest2)
		local pPlayer = Players[iNewPlayer]
		if load(pPlayer, "Decisions_FoundTheZagweDynasty") == true then
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(buildingZagweDynastyID, 1)
				if pCity:IsOriginalCapital() then
					pPlayer:ChangeGoldenAgeTurns(10)
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationSemienGuditID, "Decisions_FoundTheZagweDynasty", Decisions_FoundTheZagweDynasty)
--==========================================================================================================================
-- AMDA SEYON
--==========================================================================================================================
-- Restructure the Imperial Army
----------------------------------------------------------------------------------------------------------------------------
local Decisions_RestructureTheImperialArmy = {}
	Decisions_RestructureTheImperialArmy.Name = "TXT_KEY_DECISIONS_DMS_RESTRUCTURE_THE_IMPERIAL_ARMY"
	Decisions_RestructureTheImperialArmy.Desc = "TXT_KEY_DECISIONS_DMS_RESTRUCTURE_THE_IMPERIAL_ARMY_DESC"
	HookDecisionCivilizationIcon(Decisions_RestructureTheImperialArmy, "CIVILIZATION_DMS_ETHIOPIA_SEYON_I")
	Decisions_RestructureTheImperialArmy.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationEthiopiaAmdaSeyonID)				then return false, false end
		if load(pPlayer, "Decisions_RestructureTheImperialArmy") == true then
			Decisions_RestructureTheImperialArmy.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_RESTRUCTURE_THE_IMPERIAL_ARMY_ENACTED_DESC")
			return false, false, true 
		end
		
		local iGoldCost = math.ceil(400 * iMod)
		Decisions_RestructureTheImperialArmy.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_RESTRUCTURE_THE_IMPERIAL_ARMY_DESC", iGoldCost)
		
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pPlayer:GetGold() < iGoldCost)										then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2)				then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(techCivilServiceID))				then return true, false end
		
		return true, true
	end
	)
	
	Decisions_RestructureTheImperialArmy.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iGoldCost = math.ceil(400 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitCombatType() == unitCombatArcherID then
				pUnit:SetHasPromotion(promotionQesteNihbID, true)
			elseif pUnit:GetUnitCombatType() == unitCombatMountedID then
				pUnit:SetHasPromotion(promotionHarebGondaID, true)
			elseif pUnit:GetUnitCombatType() == unitCombatReconID then
				pUnit:SetHasPromotion(promotionTekulaID, true)
			elseif pUnit:GetUnitCombatType() == unitCombatMeleeID then
				pUnit:SetHasPromotion(promotionAxuaratAxuaraiID, true)
			end
		end
		
		save(pPlayer, "Decisions_RestructureTheImperialArmy", true)
	end
	)
	
	Decisions_RestructureTheImperialArmy.Monitors = {}
	Decisions_RestructureTheImperialArmy.Monitors[GameEvents.CityTrained] =  (	
	function(iPlayer, iCity, iUnit)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_RestructureTheImperialArmy") == true then
			if pPlayer:GetCurrentEra() <= eraIndustrialID then
				local pUnit = pPlayer:GetUnitByID(iUnit)
				if pUnit then
					if pUnit:GetUnitCombatType() == unitCombatArcherID then
						pUnit:SetHasPromotion(promotionQesteNihbID, true)
					elseif pUnit:GetUnitCombatType() == unitCombatMountedID then
						pUnit:SetHasPromotion(promotionHarebGondaID, true)
					elseif pUnit:GetUnitCombatType() == unitCombatReconID then
						pUnit:SetHasPromotion(promotionTekulaID, true)
					elseif pUnit:GetUnitCombatType() == unitCombatMeleeID then
						pUnit:SetHasPromotion(promotionAxuaratAxuaraiID, true)
					end
				end
			end
		end
	end
	)

	Decisions_RestructureTheImperialArmy.Monitors = {}
	Decisions_RestructureTheImperialArmy.Monitors[GameEvents.UnitPromoted] =  (	
	function(iOwner, iUnit, ePromotion)
		local pPlayer = Players[iOwner]
		if load(pPlayer, "Decisions_RestructureTheImperialArmy") == true then
			if pPlayer:GetCurrentEra() <= eraIndustrialID then
				local pUnit = pPlayer:GetUnitByID(iUnit)
				if pUnit then
					if pUnit:IsHasPromotion(promotionQesteNihbID) then
						local pPlot = pUnit:GetPlot()
						if pPlot then
							local pCity = DMS_GetNearestCity(pPlayer, pPlot:GetX(), pPlot:GetY())
							pCity:ChangeProduction(10)
							if pPlayer:IsHuman() then
								Events.GameplayAlertMessage("A Unit belonging to the Qeste-Nihb regiment has been promoted; +10 [ICON_PRODUCTION] Production in " .. pCity:GetName() .. "!")
							end
						end
					elseif pUnit:IsHasPromotion(promotionHarebGondaID) then
						pPlayer:ChangeCombatExperience(10)
						if pPlayer:IsHuman() then
							Events.GameplayAlertMessage("A Unit belonging to the Hareb Gonda regiment has been promoted; +10 [ICON_GREAT_GENERAL] Great General Points!")
						end
					elseif pUnit:IsHasPromotion(promotionTekulaID) then
						pPlayer:ChangeGold(25)
						if pPlayer:IsHuman() then
							Events.GameplayAlertMessage("A Unit belonging to the Tekula regiment has been promoted; +25 [ICON_GOLD] Gold!")
						end
					elseif pUnit:IsHasPromotion(promotionAxuaratAxuaraiID) then
						pPlayer:ChangeJONSCulture(15)
						if pPlayer:IsHuman() then
							Events.GameplayAlertMessage("A Unit belonging to the Axuarat Axuarai regiment has been promoted; +15 [ICON_CULTURE] Culture!")
						end
					end
				end
			end
		end
	end
	)
		
	Decisions_RestructureTheImperialArmy.Monitors = {}
	Decisions_RestructureTheImperialArmy.Monitors[GameEvents.PlayerDoTurn] =  (	
	function(iPlayer, iCity, iUnit)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_RestructureTheImperialArmy") == true then
			if pPlayer:GetCurrentEra() > eraIndustrialID then
				for pUnit in pPlayer:Units() do
					if pUnit and pUnit:IsHasPromotion(promotionQesteNihbID) or pUnit:IsHasPromotion(promotionHarebGondaID) or pUnit:IsHasPromotion(promotionTekulaID) or pUnit:IsHasPromotion(promotionAxuaratAxuaraiID) then
						pUnit:SetHasPromotion(promotionQesteNihbID, false)
						pUnit:SetHasPromotion(promotionHarebGondaID, false)
						pUnit:SetHasPromotion(promotionTekulaID, false)
						pUnit:SetHasPromotion(promotionAxuaratAxuaraiID, false)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationEthiopiaAmdaSeyonID, "Decisions_RestructureTheImperialArmy", Decisions_RestructureTheImperialArmy)
----------------------------------------------------------------------------------------------------------------------------
-- Formulate the Kebra Nagast
----------------------------------------------------------------------------------------------------------------------------
local Decisions_FormulateTheKebraNagast = {}
	Decisions_FormulateTheKebraNagast.Name = "TXT_KEY_DECISIONS_DMS_FORMULATE_THE_KEBRA_NAGAST"
	Decisions_FormulateTheKebraNagast.Desc = "TXT_KEY_DECISIONS_DMS_FORMULATE_THE_KEBRA_NAGAST_DESC"
	HookDecisionCivilizationIcon(Decisions_FormulateTheKebraNagast, "CIVILIZATION_DMS_ETHIOPIA_SEYON_I")
	Decisions_FormulateTheKebraNagast.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationEthiopiaAmdaSeyonID)		then return false, false end
		if load(pPlayer, "Decisions_FormulateTheKebraNagast") == true then
			Decisions_FormulateTheKebraNagast.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_FORMULATE_THE_KEBRA_NAGAST_ENACTED_DESC")
			return false, false, true 
		end
		
		local iFaithCost = math.ceil(50 * iMod)
		local iCultureCost = math.ceil(125 * iMod)
		Decisions_FormulateTheKebraNagast.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_FORMULATE_THE_KEBRA_NAGAST_DESC", iCultureCost, iFaithCost)
		
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pPlayer:GetFaith() < iFaithCost)										then return true, false end
		if (pPlayer:GetJONSCulture() < iCultureCost)								then return true, false end
		if (not pCapital:IsHasBuilding(buildingTempleID))							then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1)				then return true, false end
		
		return true, true
	end
	)
	
	Decisions_FormulateTheKebraNagast.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local pCapital = pPlayer:GetCapitalCity()
		local iFaithCost = math.ceil(50 * iMod)
		local iCultureCost = math.ceil(125 * iMod)
		pPlayer:ChangeFaith(-iFaithCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pCapital:SetNumRealBuilding(buildingTempleID, 0)
		pCapital:SetNumRealBuilding(buildingTempleGreatWorkWritingID, 1)
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(buildingTempleWriterSpecialistID, 1)
		end
				
		save(pPlayer, "Decisions_FormulateTheKebraNagast", true)
	end
	)
	
	Decisions_FormulateTheKebraNagast.Monitors = {}
	Decisions_FormulateTheKebraNagast.Monitors[GameEvents.CityCaptureComplete] =  (	
	function(iOldPlayer, bCapital, iX, iY, iNewPlayer, conquest, conquest2)
		local pPlayer = Players[iNewPlayer]
		if load(pPlayer, "Decisions_FormulateTheKebraNagast") == true then
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(buildingTempleWriterSpecialistID, 1)
			end
		end
	end
	)	

	Decisions_FormulateTheKebraNagast.Monitors = {}
	Decisions_FormulateTheKebraNagast.Monitors[GameEvents.PlayerCityFounded] =  (	
	function(iPlayer, iX, iY)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_FormulateTheKebraNagast") == true then
			local pPlot = Map.GetPlot(iX, iY)
			if pPlot then
				local pCity = pPlot:GetPlotCity()
				if pCity then
					pCity:SetNumRealBuilding(buildingTempleWriterSpecialistID, 1)
				end
			end	
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationEthiopiaAmdaSeyonID, "Decisions_FormulateTheKebraNagast", Decisions_FormulateTheKebraNagast)
--==========================================================================================================================
-- ZARA YAQOB
--==========================================================================================================================
-- Author a theological work
----------------------------------------------------------------------------------------------------------------------------
local Decisions_AuthorATheologicalWork = {}
	Decisions_AuthorATheologicalWork.Name = "TXT_KEY_DECISIONS_DMS_AUTHOR_A_THEOLOGICAL_WORK"
	Decisions_AuthorATheologicalWork.Desc = "TXT_KEY_DECISIONS_DMS_AUTHOR_A_THEOLOGICAL_WORK_DESC"
	HookDecisionCivilizationIcon(Decisions_AuthorATheologicalWork, "CIVILIZATION_DMS_ETHIOPIA_YAQOB")
	Decisions_AuthorATheologicalWork.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationEthiopiaZaraYaqobID)				then return false, false end
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital	then
			if load(pPlayer, "Decisions_AuthorATheologicalWork") == true and (pCapital:GetNumRealBuilding(buildingTheologicalWorkID) == 3) then
				Decisions_AuthorATheologicalWork.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_AUTHOR_A_THEOLOGICAL_WORK_ENACTED_DESC")
				return false, false, true 
			end
		else
			if load(pPlayer, "Decisions_AuthorATheologicalWork") == true then
				Decisions_AuthorATheologicalWork.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_AUTHOR_A_THEOLOGICAL_WORK_ENACTED_DESC")
				return false, false, true 
			end
		end
		
		local iFaithCost = math.ceil(100 * iMod)
		local iCultureCost = math.ceil(100 * iMod)
		Decisions_AuthorATheologicalWork.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_AUTHOR_A_THEOLOGICAL_WORK_DESC", iCultureCost, iFaithCost)
		
		local pWriterCity = DMS_GetWriterCity(pPlayer)
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pWriterCity == nil)														then return true, false end
		if (pPlayer:GetFaith() < iFaithCost)										then return true, false end
		if (pPlayer:GetJONSCulture() < iCultureCost)								then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1)				then return true, false end
		
		return true, true
	end
	)
	
	Decisions_AuthorATheologicalWork.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iFaithCost = math.ceil(100 * iMod)
		local iCultureCost = math.ceil(100 * iMod)
		pPlayer:ChangeFaith(-iFaithCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		local pWriterCity = DMS_GetWriterCity(pPlayer)
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital:GetNumRealBuilding(buildingTheologicalWorkID) == 0 then
			unitTheologicalWork1 = pPlayer:InitUnit(unitTheologicalWork1ID, pWriterCity:GetX(), pWriterCity:GetY()):PushMission(missionCreateGreatWorkID)
			unitTheologicalWork1:JumpToNearestValidPlot()
			pCapital:SetNumRealBuilding(buildingTheologicalWorkID, 1)
		elseif pCapital:GetNumRealBuilding(buildingDecisionArchimedes) == 1 then
			unitTheologicalWork2 = pPlayer:InitUnit(unitTheologicalWork2ID, pWriterCity:GetX(), pWriterCity:GetY()):PushMission(missionCreateGreatWorkID)
			unitTheologicalWork2:JumpToNearestValidPlot()
			pCapital:SetNumRealBuilding(buildingTheologicalWorkID, 2)
		elseif pCapital:GetNumRealBuilding(buildingTheologicalWorkID) == 2 then
			pCapital:SetNumRealBuilding(buildingTheologicalWorkID, 3)
			unitTheologicalWork3 = pPlayer:InitUnit(unitTheologicalWork3ID, pWriterCity:GetX(), pWriterCity:GetY()):PushMission(missionCreateGreatWorkID)
			unitTheologicalWork3:JumpToNearestValidPlot()
		end
		local pCity = GetRandomCity(pPlayer)
		if pCity then
			pCity:SetWeLoveTheKingDayCounter(20)
		end
		save(pPlayer, "Decisions_AuthorATheologicalWork", true)
	end
	)
	
	Decisions_AuthorATheologicalWork.Monitors = {}
	Decisions_AuthorATheologicalWork.Monitors[GameEvents.CityCaptureComplete] =  (	
	function(iOldPlayer, bCapital, iX, iY, iNewPlayer, conquest, conquest2)
		local pOldPlayer = Players[iOldPlayer]
		local pNewPlayer = Players[iNewPlayer]
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		if pCity then
			-- move dummy buildings to new capital
			if load(pOldPlayer, "Decisions_AuthorATheologicalWork") == true and pOldPlayer:GetCapitalCity() == pCity then
				local iNumTheologicalWork = pCity:GetNumRealBuilding(buildingTheologicalWorkID)
				if (iNumTheologicalWork > 0) then
					pCity:SetNumRealBuilding(buildingTheologicalWorkID, 0)
					if (pOldPlayer:IsAlive()) then
						pOldPlayer:GetCapitalCity():SetNumRealBuilding(buildingTheologicalWorkID, iNumTheologicalWork)
					end
				end
			end
			-- moved dummy buildings to recaptured capital
			local pCapital = pNewPlayer:GetCapitalCity()
			if pCapital then
				if pCapital:GetID() == pCity:GetID() then
					for pCitytoRemove in pNewPlayer:Cities() do
						if pCitytoRemove:GetID() ~= pCity:GetID() and pCitytoRemove:IsHasBuilding(buildingTheologicalWorkID) then
							local iNumTheologicalWork = pCity:GetNumRealBuilding(buildingTheologicalWorkID)
							pCity:SetNumRealBuilding(buildingTheologicalWorkID, iNumTheologicalWork)
							pCitytoRemove:SetNumRealBuilding(buildingTheologicalWorkID, 0)
						end
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationEthiopiaZaraYaqobID, "Decisions_AuthorATheologicalWork", Decisions_AuthorATheologicalWork)
----------------------------------------------------------------------------------------------------------------------------
-- Introduce Centralization Reforms
----------------------------------------------------------------------------------------------------------------------------
local Decisions_IntroduceCentralizationReforms = {}
	Decisions_IntroduceCentralizationReforms.Name = "TXT_KEY_DECISIONS_DMS_INTRODUCE_CENTRALIZATION_REFORMS"
	Decisions_IntroduceCentralizationReforms.Desc = "TXT_KEY_DECISIONS_DMS_INTRODUCE_CENTRALIZATION_REFORMS_DESC"
	HookDecisionCivilizationIcon(Decisions_IntroduceCentralizationReforms, "CIVILIZATION_DMS_ETHIOPIA_YAQOB")
	Decisions_IntroduceCentralizationReforms.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationEthiopiaZaraYaqobID)		then return false, false end
		if load(pPlayer, "Decisions_IntroduceCentralizationReforms") == true then
			Decisions_IntroduceCentralizationReforms.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_INTRODUCE_CENTRALIZATION_REFORMS_ENACTED_DESC")
			return false, false, true 
		end
		
		local iGoldCost = math.ceil(350 * iMod)
		Decisions_IntroduceCentralizationReforms.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_INTRODUCE_CENTRALIZATION_REFORMS_DESC", iGoldCost)
		
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pPlayer:GetGold() < iGoldCost)											then return true, false end
		if (pPlayer:GetNumCities() < 3)												then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2)				then return true, false end
		
		return true, true
	end
	)
	
	Decisions_IntroduceCentralizationReforms.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iGoldCost = math.ceil(350 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(policyCentralizationReformsID, true)
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			pCity = DMS_GetMostDistantCity(pPlayer, pCapital:GetX(), pCapital:GetY())
			if pCity then
				pCity:SetNumRealBuilding(buildingCentralizationReformsID, 1)
			end
		end
				
		save(pPlayer, "Decisions_IntroduceCentralizationReforms", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationEthiopiaZaraYaqobID, "Decisions_IntroduceCentralizationReforms", Decisions_IntroduceCentralizationReforms)
--==========================================================================================================================
-- MENELIK
--==========================================================================================================================
-- Found the Bank of Ethiopia
----------------------------------------------------------------------------------------------------------------------------
local Decisions_FoundTheBankOfEthiopia = {}
	Decisions_FoundTheBankOfEthiopia.Name = "TXT_KEY_DECISIONS_DMS_FOUND_THE_BANK_OF_ETHIOPIA"
	Decisions_FoundTheBankOfEthiopia.Desc = "TXT_KEY_DECISIONS_DMS_FOUND_THE_BANK_OF_ETHIOPIA_DESC"
	HookDecisionCivilizationIcon(Decisions_FoundTheBankOfEthiopia, "CIVILIZATION_DMS_ETHIOPIA_MENELIK_II")
	Decisions_FoundTheBankOfEthiopia.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationEthiopiaMenelikID)			then return false, false end
		if load(pPlayer, "Decisions_FoundTheBankOfEthiopia") == true then
			Decisions_FoundTheBankOfEthiopia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_FOUND_THE_BANK_OF_ETHIOPIA_ENACTED_DESC")
			return false, false, true 
		end
		
		local iGoldCost = math.ceil(500 * iMod)
		Decisions_FoundTheBankOfEthiopia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_FOUND_THE_BANK_OF_ETHIOPIA_DESC", iGoldCost)
		
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pPlayer:GetGold() < iGoldCost)											then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2)				then return true, false end
		if not(Teams[pPlayer:GetTeam()]:IsHasTech(techBankingID))					then return true, false end
		
		return true, true
	end
	)
	
	Decisions_FoundTheBankOfEthiopia.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iGoldCost = math.ceil(500 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital:IsHasBuilding(buildingBankID)) then
			pCapital:SetNumRealBuilding(buildingBankID, 1)
		else
			local bPlacedBank = false
			for pCity in pPlayer:Cities() do
				if pCity and (not pCity:IsHasBuilding(buildingBankID)) then
					pCity:SetNumRealBuilding(buildingBankID, 1)
					bPlacedBank = true
				end
			end
		end
		-- DoF modifier
		local iNumDoF = 0
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i and i ~= iPlayer then
				local pOtherPlayer = Players[i]
				if pOtherPlayer:IsDoF(iPlayer) then
					iNumDoF = iNumDoF + 1
				end
			end
		end
		if iNumDoF > 0 then
			for pCity in pPlayer:Cities() do
				if pCity and pCity:IsHasBuilding(buildingBankID) then
					pCity:SetNumRealBuilding(buildingBankOfEthiopiaID, iNumDoF)
				end
			end
		end
		
		save(pPlayer, "Decisions_FoundTheBankOfEthiopia", true)
	end
	)
	
	Decisions_FoundTheBankOfEthiopia.Monitors = {}
	Decisions_FoundTheBankOfEthiopia.Monitors[GameEvents.PlayerDoTurn] =  (	
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_FoundTheBankOfEthiopia") == true then
			local iNumDoF = 0
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				if i and i ~= iPlayer then
					local pOtherPlayer = Players[i]
					if pOtherPlayer:IsDoF(iPlayer) then
						iNumDoF = iNumDoF + 1
					end
				end
			end
			if iNumDoF > 0 then
				for pCity in pPlayer:Cities() do
					if pCity and pCity:IsHasBuilding(buildingBankID) then
						pCity:SetNumRealBuilding(buildingBankOfEthiopiaID, iNumDoF)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationEthiopiaMenelikID, "Decisions_FoundTheBankOfEthiopia", Decisions_FoundTheBankOfEthiopia)
----------------------------------------------------------------------------------------------------------------------------
-- Construct War Monuments
----------------------------------------------------------------------------------------------------------------------------
local Decisions_ConstructWarMonuments = {}
	Decisions_ConstructWarMonuments.Name = "TXT_KEY_DECISIONS_DMS_CONSTRUCT_WAR_MONUMENTS"
	Decisions_ConstructWarMonuments.Desc = "TXT_KEY_DECISIONS_DMS_CONSTRUCT_WAR_MONUMENTS_DESC"
	HookDecisionCivilizationIcon(Decisions_ConstructWarMonuments, "CIVILIZATION_DMS_ETHIOPIA_MENELIK_II")
	Decisions_ConstructWarMonuments.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationEthiopiaMenelikID)			then return false, false end
		if load(pPlayer, "Decisions_ConstructWarMonuments") == true then
			Decisions_ConstructWarMonuments.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CONSTRUCT_WAR_MONUMENTS_ENACTED_DESC")
			return false, false, true 
		end
		
		local iGoldCost = math.ceil(400 * iMod)
		local iCultureCost = math.ceil(200 * iMod)
		Decisions_ConstructWarMonuments.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_CONSTRUCT_WAR_MONUMENTS_DESC", iGoldCost, iCultureCost)
		
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pPlayer:GetGold() < iGoldCost)											then return true, false end
		if (pPlayer:GetJONSCulture() < iCultureCost)								then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1)				then return true, false end
		if (pPlayer:GetCurrentEra() < eraIndustrialID)								then return true, false end
		
		return true, true
	end
	)
	
	Decisions_ConstructWarMonuments.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iGoldCost = math.ceil(400 * iMod)
		local iCultureCost = math.ceil(200 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
				
		save(pPlayer, "Decisions_ConstructWarMonuments", true)
	end
	)

	Decisions_ConstructWarMonuments.Monitors = {}
	Decisions_ConstructWarMonuments.Monitors[GameEvents.CityTrained] =  (	
	function(iPlayer, iCity, iUnit)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_ConstructWarMonuments") == true then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit and pUnit:GetUnitType() == unitSebastopolID then
				local pCity = pPlayer:GetCityByID(iCity)
				if pCity then
					local iNumMonumets = pCity:GetNumRealBuilding(buildingMonumentID)
					pCity:SetNumRealBuilding(buildingMonumentID, iNumMonuments + 1)
				end
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationEthiopiaMenelikID, "Decisions_ConstructWarMonuments", Decisions_ConstructWarMonuments)
--==========================================================================================================================
-- HAILE SELASSIE
--==========================================================================================================================
-- Adopt the Arba Lijoch
----------------------------------------------------------------------------------------------------------------------------
local Decisions_AdoptTheArbaLijoch = {}
	Decisions_AdoptTheArbaLijoch.Name = "TXT_KEY_DECISIONS_DMS_ADOPT_THE_ARBA_LIJOCH"
	Decisions_AdoptTheArbaLijoch.Desc = "TXT_KEY_DECISIONS_DMS_ADOPT_THE_ARBA_LIJOCH_DESC"
	HookDecisionCivilizationIcon(Decisions_AdoptTheArbaLijoch, "CIVILIZATION_ETHIOPIA")
	Decisions_AdoptTheArbaLijoch.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationEthiopiaHaileSelassieID)			then return false, false end
		if load(pPlayer, "Decisions_AdoptTheArbaLijoch") == true then
			Decisions_AdoptTheArbaLijoch.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_ADOPT_THE_ARBA_LIJOCH_ENACTED_DESC")
			return false, false, true 
		end
		
		local iGoldCost = math.ceil(400 * iMod)
		Decisions_AdoptTheArbaLijoch.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_ADOPT_THE_ARBA_LIJOCH_DESC", iGoldCost)
		
		local iPlayer = pPlayer:GetID()
		local iNumDoF = 0
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i and i ~= iPlayer then
				local pOtherPlayer = Players[i]
				if pOtherPlayer:IsDoF(iPlayer) then
					iNumDoF = iNumDoF + 1
				end
			end
		end

		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (iNumDoF < 1)															then return true, false end
		if (pPlayer:GetGold() < iGoldCost)											then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1)				then return true, false end
		if (pPlayer:GetCurrentEra() < eraIndustrialID)								then return true, false end
		
		return true, true
	end
	)
	
	Decisions_AdoptTheArbaLijoch.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iGoldCost = math.ceil(400 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		local pCapital = pPlayer:GetCapitalCity()
		pPlayer:InitUnit(unitMusicianID, pCapital:GetX(), pCapital:GetY())
				
		save(pPlayer, "Decisions_AdoptTheArbaLijoch", true)
	end
	)
	
	Decisions_AdoptTheArbaLijoch.Monitors = {}
	Decisions_AdoptTheArbaLijoch.Monitors[GameEvents.GreatPersonExpended] =  (	
	function(iPlayer, eGreatPersonType, eGreatPersonTypeCP)
		local pPlayer = Players[iPlayer]
		if eGreatPersonTypeCP then eGreatPersonType = eGreatPersonTypeCP end
			if eGreatPersonType == unitMusicianID then
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				if i and i ~= iPlayer and pPlayer:IsDoF(i) then
					local pEthiopiaPlayer = Players[i]
					if load(pEthiopiaPlayer, "Decisions_AdoptTheArbaLijoch") == true then
						local pCity = DMS_GetMusicianCity(pEthiopiaPlayer)
						local iMusicianPoints = JFD_GetRandom(15, 50)
						pCity:ChangeSpecialistGreatPersonProgressTimes100(specialistMusicianID, iMusicianPoints * 100)

						if pEthiopiaPlayer:IsHuman() then
							local description = "A Great Musician has been expended in " .. pPlayer:GetCivilizationShortDescription() .. " and our Declaration of Friendship with them has generated +" .. iMusicianPoints .. " Great Musician Points for us as well!"
							local descriptionShort = "Adopt the Arba Lijoch"
							JFD_SendNotification(iPlayer, 'NOTIFICATION_GENERIC', description, descriptionShort)
						end
					end
				end
			end	
		end
	end
	)

Decisions_AddCivilisationSpecific(civilisationEthiopiaHaileSelassieID, "Decisions_AdoptTheArbaLijoch", Decisions_AdoptTheArbaLijoch)
----------------------------------------------------------------------------------------------------------------------------
-- Rewrite the Constitution
----------------------------------------------------------------------------------------------------------------------------
local Decisions_RewriteTheConstitution = {}
	Decisions_RewriteTheConstitution.Name = "TXT_KEY_DECISIONS_DMS_REWRITE_THE_CONSTITUTION"
	Decisions_RewriteTheConstitution.Desc = "TXT_KEY_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_DESC"
	HookDecisionCivilizationIcon(Decisions_RewriteTheConstitution, "CIVILIZATION_ETHIOPIA")
	Decisions_RewriteTheConstitution.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= civilisationEthiopiaHaileSelassieID)			then return false, false end
		if load(pPlayer, "Decisions_RewriteTheConstitution") == true then
			Decisions_RewriteTheConstitution.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_ENACTED_DESC")
			return false, false, true 
		end
		
		local iCultureCost = math.ceil(300 * iMod)
		Decisions_RewriteTheConstitution.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_DESC", iCultureCost)
		
		local pCapital = pPlayer:GetCapitalCity()
		if (not pCapital)															then return true, false end
		if (pPlayer:GetJONSCulture() < iCultureCost)								then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2)				then return true, false end
		if (pPlayer:GetCurrentEra() < eraModernID)									then return true, false end
		
		return true, true
	end
	)
	
	Decisions_RewriteTheConstitution.DoFunc = (
	function(pPlayer)
		local iPlayer = pPlayer:GetID()
		local iCultureCost = math.ceil(300 * iMod)
		local pCapital = pPlayer:GetCapitalCity()
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pCapital:SetNumRealBuilding(buildingRewriteTheConstitutionCapitalID, 1)
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(buildingRewriteTheConstitutionID, 1)
		end
				
		save(pPlayer, "Decisions_RewriteTheConstitution", true)
	end
	)
		
Decisions_AddCivilisationSpecific(civilisationEthiopiaHaileSelassieID, "Decisions_RewriteTheConstitution", Decisions_RewriteTheConstitution)
--==========================================================================================================================
--==========================================================================================================================