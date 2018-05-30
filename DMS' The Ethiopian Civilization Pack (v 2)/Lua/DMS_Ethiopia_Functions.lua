-- DMS_Ethiopia_Functions
-- Author: DMS
--==========================================================================================================================
-- includes
--==========================================================================================================================
include("FLuaVector.lua")
include("PlotIterators.lua")
include("IconSupport")
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
local bPrintForAksumDebug			= DMS_GetUserSetting("DMS_AKSUM_DEBUGGING_ON") == 1
local bPrintForSemienDebug			= DMS_GetUserSetting("DMS_SEMIEN_DEBUGGING_ON") == 1
local bPrintForAmdaSeyonDebug		= DMS_GetUserSetting("DMS_ETHIOPIA_AMDA_SEYON_I_DEBUGGING_ON") == 1
local bPrintForZaraYaqobDebug		= DMS_GetUserSetting("DMS_ETHIOPIA_ZARA_YAQOB_DEBUGGING_ON") == 1
local bPrintForMenelikIIDebug		= DMS_GetUserSetting("DMS_ETHIOPIA_MENELIK_II_DEBUGGING_ON") == 1
local bPrintForHaileSelassieDebug	= DMS_GetUserSetting("DMS_ETHIOPIA_HAILE_SELASSIE_DEBUGGING_ON") == 1

function DMS_AksumPrint(string)
	if (not bPrintForAksumDebug) then
		return
	else
		return print(string)
	end
end

function DMS_SemienPrint(string)
	if (not bPrintForSemienDebug) then
		return
	else
		return print(string)
	end
end

function DMS_ASPrint(string)
	if (not bPrintForAmdaSeyonDebug) then
		return
	else
		return print(string)
	end
end

function DMS_ZYPrint(string)
	if (not bPrintForZaraYaqobDebug) then
		return
	else
		return print(string)
	end
end

function DMS_MIIPrint(string)
	if (not bPrintForMenelikIIDebug) then
		return
	else
		return print(string)
	end
end

function DMS_HSPrint(string)
	if (not bPrintForHaileSelassieDebug) then
		return
	else
		return print(string)
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_IsCivilisationActive
----------------------------------------------------------------------------------------------------------------------------
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
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
----------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
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
--IsCPDLL
----------------------------------------------------------------------------------------------------------------------------
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()
----------------------------------------------------------------------------------------------------------------------------
--HasTrait
----------------------------------------------------------------------------------------------------------------------------
function HasTrait(player, traitID)
	if isCPDLL then 
		return player:HasTrait(traitID)
	else
		if player then
			local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
			local traitType  = GameInfo.Traits[traitID].Type
			for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
				return true
			end
		end
	end
	return false
end
----------------------------------------------------------------------------------------------------------------------------
--IsUsingCiD
----------------------------------------------------------------------------------------------------------------------------
function IsUsingCiD()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "10e9728f-d61c-4317-be4f-7d52d6bae6f4" then
			return true
		end
	end
	return false
end
local isUsingCiD = IsUsingCiD()
----------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
----------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_CanBuyMoreTradeRouteSlots
----------------------------------------------------------------------------------------------------------------------------
function DMS_CanBuyMoreTradeRouteSlots(pPlayer)
	DMS_AksumPrint("DMS_CanBuyMoreTradeRouteSlots called..")
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital ~= nil then
		local iEra = pPlayer:GetCurrentEra()
		DMS_AksumPrint("DMS_CanBuyMoreTradeRouteSlots: iEra = " .. iEra .. "..")
		local buildingTradeRouteSlotDummyID	= GameInfoTypes["BUILDING_DMS_TRADE_ROUTE_SLOT_DUMMY"] -- this shouldn't be necessary?
		local iNumTradeRouteSlotDummyBuildings = pCapital:GetNumRealBuilding(buildingTradeRouteSlotDummyID)
		DMS_AksumPrint("DMS_CanBuyMoreTradeRouteSlots: iNumTradeRouteSlotDummyBuildings = " .. iNumTradeRouteSlotDummyBuildings .. "..")
		if iNumTradeRouteSlotDummyBuildings < iEra + 1 then
			DMS_AksumPrint("DMS_CanBuyMoreTradeRouteSlots: iNumTradeRouteSlotDummyBuildings < iEra + 1, return true..")

			return true

		else
			DMS_AksumPrint("DMS_CanBuyMoreTradeRouteSlots: iNumTradeRouteSlotDummyBuildings >= iEra + 1, return false..")
			return false
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_GetTradeRouteSlotCost
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetTradeRouteSlotCost(pPlayer)
	DMS_AksumPrint("DMS_GetTradeRouteSlotCost called..")
	local pCapital = pPlayer:GetCapitalCity()
	local iTradeRouteSlotCost = 0
	if pCapital ~= nil then
		local buildingTradeRouteSlotDummyID	= GameInfoTypes["BUILDING_DMS_TRADE_ROUTE_SLOT_DUMMY"] -- this shouldn't be necessary?
		local iNumTradeRouteSlotDummyBuildings = pCapital:GetNumRealBuilding(buildingTradeRouteSlotDummyID)
		DMS_AksumPrint("DMS_GetTradeRouteSlotCost:  iNumTradeRouteSlotDummyBuildings = " .. iNumTradeRouteSlotDummyBuildings .. "..")
		iTradeRouteSlotCost = math.ceil(150 + (50 * iNumTradeRouteSlotDummyBuildings * (( iNumTradeRouteSlotDummyBuildings + 1 ) / 2 )))
		DMS_AksumPrint("DMS_GetTradeRouteSlotCost:  iTradeRouteSlotCost = " .. iTradeRouteSlotCost .. "..")

	end

	return iTradeRouteSlotCost
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_convertUnit
----------------------------------------------------------------------------------------------------------------------------
function DMS_convertUnit(pUnit, pNewUnitType)
	local pPlayer = Players[pUnit:GetOwner()]
	local pNewUnit = pPlayer:InitUnit(pNewUnitType, pUnit:GetX(), pUnit:GetY())
	pNewUnit:SetDamage(pUnit:GetDamage())
	pNewUnit:SetExperience(pUnit:GetExperience())
	pNewUnit:SetLevel(pUnit:GetLevel())
	for unitPromotion in GameInfo.UnitPromotions() do
		local iPromotionID = unitPromotion.ID;
		if (pUnit:IsHasPromotion(iPromotionID)) then
			if (pNewUnit:IsPromotionValid(iPromotionID)) then
				pNewUnit:SetHasPromotion(iPromotionID, true)
			end
		end
	end
	-- kill off the old unit
	pUnit:Kill() 
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_GetWriterCity
----------------------------------------------------------------------------------------------------------------------------
function DMS_GetWriterCity(pPlayer)
	local pWriterCity = nil
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital then 
		pWriterCity = pCapital
	end
	for pCity in pPlayer:Cities() do
		if pCity and pCity ~= pWriterCity then
			local buildingWritersGuildID = GameInfoTypes["BUILDING_WRITERS_GUILD"]
			if pCity:IsHasBuilding(buildingWritersGuildID) then
				pWriterCity = pCity
				
			end
		end
	end

	return pWriterCity
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_GetNearestCity
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
-- JFD_GetEraAdjustedValue
----------------------------------------------------------------------------------------------------------------------------
function JFD_GetEraAdjustedValue(playerID, num)
	local player = Players[playerID]
	local currentEraID = player:GetCurrentEra()
	local eraMod = GameInfo.Eras[currentEraID].ResearchAgreementCost
	return math.ceil(num * eraMod/100)
end
----------------------------------------------------------------------------------------------------------------------------
-- CountDemGreatWorks
----------------------------------------------------------------------------------------------------------------------------
local sGreatWorkClass						= "GREAT_WORK_SLOT_LITERATURE"
local iGreatWorkClass						= GameInfoTypes[sGreatWorkClass]

local tGWBuildings = {}
for row in DB.Query("SELECT ID, BuildingClass, GreatWorkCount FROM Buildings WHERE GreatWorkCount > 0 AND GreatWorkSlotType = 'GREAT_WORK_SLOT_LITERATURE'") do
	tGWBuildings[row.ID] = {BuildingClassID = GameInfoTypes[row.BuildingClass], NumGreatWorksSlots = row.GreatWorkCount}
	--tGWBuildings[row.ID] = {["BuildingClass"] = row.BuildingClass, ["GreatWorkCount"] = row.GreatWorkCount}
	DMS_ZYPrint("tGWBuildings: added building to table..")
end

function CountDemGreatWorks(pCity, gwTable)
	DMS_ZYPrint("CountDemGreatWorks called..")
    local iCount = 0
	DMS_ZYPrint("CountDemGreatWorks: iterate table..")
    for k, v in pairs(tGWBuildings) do
        if pCity:IsHasBuilding(k) then
			DMS_ZYPrint("CountDemGreatWorks: city has great works building..")
            for i = 0, v.NumGreatWorksSlots - 1, 1 do
                local iGreatWorkType = pCity:GetBuildingGreatWork(v.BuildingClassID, i)
				DMS_ZYPrint("CountDemGreatWorks: Game.GetGreatWorkType(iGreatWorkType) = " .. Game.GetGreatWorkType(iGreatWorkType) .. "..")
                if gwTable[Game.GetGreatWorkType(iGreatWorkType)] then
                    iCount = iCount + 1
					DMS_ZYPrint("CountDemGreatWorks: iCount = " .. iCount .. "..")
                end
            end
        end
    end
    return iCount
end
----------------------------------------------------------------------------------------------------------------------------
-- Globals
----------------------------------------------------------------------------------------------------------------------------
local activePlayerID 						= Game.GetActivePlayer()
local activePlayer 							= Players[activePlayerID]
local activePlayerTeam 						= Teams[Game.GetActiveTeam()]
local civilisationAksumKalebID				= GameInfoTypes["CIVILIZATION_DMS_AKSUM_KALEB"]
local isAksumKalebCivActive 				= JFD_IsCivilisationActive(civilisationAksumKalebID)
local isAksumKalebActivePlayer 				= activePlayer:GetCivilizationType() == civilisationAksumKalebID
local civilisationEthiopiaAmdaSeyonID		= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_SEYON_I"]
local isEthiopiaAmdaSeyonCivActive 			= JFD_IsCivilisationActive(civilisationEthiopiaAmdaSeyonID)
local isEthiopiaAmdaSeyonActivePlayer 		= activePlayer:GetCivilizationType() == civilisationEthiopiaAmdaSeyonID
local civilisationEthiopiaZaraYaqobID		= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_YAQOB"]
local isEthiopiaZaraYaqobCivActive 			= JFD_IsCivilisationActive(civilisationEthiopiaZaraYaqobID)
local isEthiopiaZaraYaqobActivePlayer 		= activePlayer:GetCivilizationType() == civilisationEthiopiaZaraYaqobID
local civilisationEthiopiaMenelikID			= GameInfoTypes["CIVILIZATION_DMS_ETHIOPIA_MENELIK_II"]
local isEthiopiaMenelikCivActive 			= JFD_IsCivilisationActive(civilisationEthiopiaMenelikID)
local isEthiopiaMenelikActivePlayer 		= activePlayer:GetCivilizationType() == civilisationEthiopiaMenelikID
local civilisationEthiopiaHaileSelassieID	= GameInfoTypes["CIVILIZATION_ETHIOPIA"]
local isEthiopiaHaileSelassieCivActive 		= JFD_IsCivilisationActive(civilisationEthiopiaHaileSelassieID)
local isEthiopiaHaileSelassieActivePlayer 	= activePlayer:GetCivilizationType() == civilisationEthiopiaHaileSelassieID
local civilisationSemienGuditID				= GameInfoTypes["CIVILIZATION_DMS_SEMIEN_GUDIT"]
local isSemienGuditIDCivActive 				= JFD_IsCivilisationActive(civilisationSemienGuditID)
local isSemienGuditIDActivePlayer 			= activePlayer:GetCivilizationType() == civilisationSemienGuditID
-- traits
local traitSaintElesbaanID					= GameInfoTypes["TRAIT_DMS_SAINT_ELESBAAN"]
local traitFieldsOfJudithID					= GameInfoTypes["TRAIT_DMS_FIELDS_OF_JUDITH"]
local traitPillarOfZionID					= GameInfoTypes["TRAIT_DMS_PILLAR_OF_ZION"]
local traitSeedOfJacobID					= GameInfoTypes["TRAIT_DMS_SEED_OF_JACOB"]
local traitLionOfJudahID					= GameInfoTypes["TRAIT_DMS_THE_LION_OF_JUDAH"]
-- buildings, units, improvements
local buildingSteleID						= GameInfoTypes["BUILDING_STELE"]
local improvementMonolithicChurchID			= GameInfoTypes["IMPROVEMENT_DMS_MONOLITHIC_CHURCH"]
local improvementMonolithicChurch1ID		= GameInfoTypes["IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1"]
local improvementMonolithicChurch2ID		= GameInfoTypes["IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2"]
local improvementMonolithicChurch3ID		= GameInfoTypes["IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3"]
local improvementMonolithicChurch4ID		= GameInfoTypes["IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4"]
local improvementMonolithicChurch5ID		= GameInfoTypes["IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5"]
local unitSarawitID							= GameInfoTypes["UNIT_DMS_SARAWIT"]
local unitSarawitCheap1ID					= GameInfoTypes["UNIT_DMS_SARAWIT_CHEAP_1"]
local unitSarawitCheap2ID					= GameInfoTypes["UNIT_DMS_SARAWIT_CHEAP_2"]
local unitSarawitCheap3ID					= GameInfoTypes["UNIT_DMS_SARAWIT_CHEAP_3"]
local unitSarawitCheap4ID					= GameInfoTypes["UNIT_DMS_SARAWIT_CHEAP_4"]
local unitSarawitCheap5ID					= GameInfoTypes["UNIT_DMS_SARAWIT_CHEAP_5"]
local unitSarawitCheap6ID					= GameInfoTypes["UNIT_DMS_SARAWIT_CHEAP_6"]
local unitSarawitCheap7ID					= GameInfoTypes["UNIT_DMS_SARAWIT_CHEAP_7"]
local unitSarawitCheap8ID					= GameInfoTypes["UNIT_DMS_SARAWIT_CHEAP_8"]
local unitSpearmanID						= GameInfoTypes["UNIT_SPEARMAN"]
local unitKoremID							= GameInfoTypes["UNIT_DMS_KOREM"]
local unitShotelaiID						= GameInfoTypes["UNIT_DMS_SHOTELAI"]
local unitDebteraID							= GameInfoTypes["UNIT_DMS_DEBTERA"]
local iProphetID							= GameInfo.Units.UNIT_PROPHET.ID
local iProphetOverride						= GameInfo.Units.UNIT_DMS_DEBTERA.ID
local unitMehalSefariID						= GameInfoTypes["UNIT_MEHAL_SEFARI"]
local unitSebastopolID						= GameInfoTypes["UNIT_DMS_SEBASTOPOL"]
local unitKagnewID							= GameInfoTypes["UNIT_DMS_KAGNEW"]
local unitMakonnenID						= GameInfoTypes["UNIT_DMS_MAKONNEN"]
local unitMakonnenNoOilID					= GameInfoTypes["UNIT_DMS_MAKONNEN_NO_OIL"]
local buildingCourthouseID					= GameInfoTypes["BUILDING_COURTHOUSE"]
local buildingWritersGuildID				= GameInfoTypes["BUILDING_WRITERS_GUILD"]
local specialistWriter						= GameInfoTypes["SPECIALIST_WRITER"]
local unitWriterID							= GameInfoTypes["UNIT_WRITER"]
local buildingMasgidID						= GameInfoTypes["BUILDING_DMS_MASGID"]
local unitAgawArcherID						= GameInfoTypes["UNIT_DMS_AGAW_BOUDA"]
-- dummy buildings
local buildingTradeRouteSlotDummyID			= GameInfoTypes["BUILDING_DMS_TRADE_ROUTE_SLOT_DUMMY"]
local buildingTradeRouteGrowthDummyID		= GameInfoTypes["BUILDING_DMS_TRADE_ROUTE_GROWTH_DUMMY"]
local buildingAmdaSeyonWLTKDDummyID			= GameInfoTypes["BUILDING_DMS_AS_WLTKD_DUMMY"]
local buildingAmdaSeyonFreeCourthouseID		= GameInfoTypes["BUILDING_DMS_AS_FREE_COURTHOUSE"]
local buildingZaraYaqobGreatWorksWriting1ID	= GameInfoTypes["BUILDING_DMS_ZY_GREAT_WORKS_WRITING_1"]
local buildingZaraYaqobGreatWorksWriting2ID	= GameInfoTypes["BUILDING_DMS_ZY_GREAT_WORKS_WRITING_2"]
local buildingZaraYaqobGreatWorksWriting3ID	= GameInfoTypes["BUILDING_DMS_ZY_GREAT_WORKS_WRITING_3"]
local buildingZaraYaqobGreatWorksWriting4ID	= GameInfoTypes["BUILDING_DMS_ZY_GREAT_WORKS_WRITING_4"]
local buildingZaraYaqobGreatWorksWriting5ID	= GameInfoTypes["BUILDING_DMS_ZY_GREAT_WORKS_WRITING_5"]
local buildingDefenseFromFaithID			= GameInfoTypes["BUILDING_DMS_ZY_DEFENSE"]
local buildingReligiousPressureWriterID		= GameInfoTypes["BUILDING_DMS_ZY_RELIGIOUS_PRESSURE"]
local buildingDelegateIdeologicalTenetID	= GameInfoTypes["BUILDING_DMS_HS_DELEGATE_TENET"]
local buildingPillageImprovementFaithID		= GameInfoTypes["BUILDING_DMS_PILLAGE_IMPROVEMENT_FAITH"]
local buildingMasgidProductionID			= GameInfoTypes["BUILDING_DMS_MASGID_PRODUCTION_DUMMY"]
-- promotions
local promotionKoremID						= GameInfoTypes["PROMOTION_DMS_KOREM"]
local promotionShotelID						= GameInfoTypes["PROMOTION_DMS_SHOTEL"]
local promotionSeedOfJakob1ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_1"]
local promotionSeedOfJakob2ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_2"]
local promotionSeedOfJakob3ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_3"]
local promotionSeedOfJakob4ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_4"]
local promotionSeedOfJakob5ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_5"]
local promotionSeedOfJakob6ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_6"]
local promotionSeedOfJakob7ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_7"]
local promotionSeedOfJakob8ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_8"]
local promotionSeedOfJakob9ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_9"]
local promotionSeedOfJakob10ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_10"]
local promotionSeedOfJakob11ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_11"]
local promotionSeedOfJakob12ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_12"]
local promotionSeedOfJakob13ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_13"]
local promotionSeedOfJakob14ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_14"]
local promotionSeedOfJakob15ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_15"]
local promotionSeedOfJakob16ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_16"]
local promotionSeedOfJakob17ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_17"]
local promotionSeedOfJakob18ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_18"]
local promotionSeedOfJakob19ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_19"]
local promotionSeedOfJakob20ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_20"]
local promotionSeedOfJakob21ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_21"]
local promotionSeedOfJakob22ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_22"]
local promotionSeedOfJakob23ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_23"]
local promotionSeedOfJakob24ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_24"]
local promotionSeedOfJakob25ID				= GameInfoTypes["PROMOTION_DMS_SEED_OF_JACOB_25"]
local promotionTewodrosLegacyID				= GameInfoTypes["PROMOTION_TEWODROS_LEGACY"]
local promotionGreatMortar1ID				= GameInfoTypes["PROMOTION_DMS_GREAT_MOTAR_1_GG"]
local promotionGreatMortar2ID				= GameInfoTypes["PROMOTION_DMS_GREAT_MOTAR_2_GG"]
local promotionGreatMortar3ID				= GameInfoTypes["PROMOTION_DMS_GREAT_MOTAR_3_GG"]
local promotionGreatMortar4ID				= GameInfoTypes["PROMOTION_DMS_GREAT_MOTAR_4_GG"]
local promotionGreatMortar5ID				= GameInfoTypes["PROMOTION_DMS_GREAT_MOTAR_5_GG"]
local promotionGreatMortarDepletedID		= GameInfoTypes["PROMOTION_DMS_GREAT_MOTAR_DEPLETED"]
local promotionZebenyaID					= GameInfoTypes["PROMOTION_DMS_ZEBENYA"]
local promotionZebenyaStrength1ID			= GameInfoTypes["PROMOTION_DMS_ZEBENYA_1_STRENGTH"]
local promotionZebenyaStrength2ID			= GameInfoTypes["PROMOTION_DMS_ZEBENYA_2_STRENGTH"]
local promotionZebenyaStrength3ID			= GameInfoTypes["PROMOTION_DMS_ZEBENYA_3_STRENGTH"]
local promotionZebenyaStrength4ID			= GameInfoTypes["PROMOTION_DMS_ZEBENYA_4_STRENGTH"]
local promotionZebenyaStrength5ID			= GameInfoTypes["PROMOTION_DMS_ZEBENYA_5_STRENGTH"]
local promotionQestID						= GameInfoTypes["PROMOTION_DMS_QEST"]
local promotionAfterRandomID				= GameInfoTypes["PROMOTION_DMS_AFTERRANDOM"]
-- combat types
local unitCombatTypeRecon					= GameInfoTypes["UNITCOMBAT_RECON"]
local unitCombatTypeMounted					= GameInfoTypes["UNITCOMBAT_MOUNTED"]
local unitCombatTypeMelee					= GameInfoTypes["UNITCOMBAT_MELEE"]
local unitCombatTypeGun						= GameInfoTypes["UNITCOMBAT_GUN"]
local unitCombatTypeArmor					= GameInfoTypes["UNITCOMBAT_ARMOR"]
-- various
local domainLandID							= GameInfoTypes["DOMAIN_LAND"]
local greatWorkLiteratureID					= GameInfoTypes["GREAT_WORK_SLOT_LITERATURE"]
local techFlightID							= GameInfoTypes["TECH_FLIGHT"]
local yieldFaithID							= GameInfoTypes["YIELD_FAITH"]
local yieldProductionID						= GameInfoTypes["YIELD_PRODUCTION"]
local resourceOilID							= GameInfoTypes["RESOURCE_OIL"]

local tGTI = {}
for row in GameInfo.Improvements() do
	if row.CreatedByGreatPerson == 1 then
		tGTI[row.ID] = true
	end
end

local tSarawits = {}
tSarawits[unitSarawitID]       = 0
tSarawits[unitSarawitCheap1ID] = 1
tSarawits[unitSarawitCheap2ID] = 2
tSarawits[unitSarawitCheap3ID] = 3
tSarawits[unitSarawitCheap4ID] = 4
tSarawits[unitSarawitCheap5ID] = 5
tSarawits[unitSarawitCheap6ID] = 6
tSarawits[unitSarawitCheap7ID] = 7
tSarawits[unitSarawitCheap8ID] = 8

local gwTable = {}
for work in GameInfo.GreatWorks() do
	if work.GreatWorkClassType == "GREAT_WORK_LITERATURE" then
		--DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: work is literature..")
		gwTable[work.ID] = work.ID
		--DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: work id = " .. work.ID .. "..")
	end
end

if isAksumKalebCivActive then
	print("Kaleb of Aksum enters the game!")
end
if isEthiopiaAmdaSeyonCivActive then
	print("Amda Seyon of Ethiopia enters the game!")
end
if isEthiopiaZaraYaqobCivActive then
	print("Zara Yaqob of Ethiopia enters the game!")
end
if isEthiopiaMenelikCivActive then
	print("Menelik II of Ethiopia enters the game!")
end
if isEthiopiaHaileSelassieCivActive then
	print("Haile Selassie of Ethiopia enters the game!")
end
if isSemienGuditIDCivActive then
	print("Gudit of Semien enters the game!")
end
--==========================================================================================================================
-- MAIN FUNCTIONS KALEB
--==========================================================================================================================
-- DMS_AksumCityTradeRouteTargetBonus
----------------------------------------------------------------------------------------------------------------------------
function DMS_AksumCityTradeRouteTargetBonus(iPlayer)
	local pPlayer = Players[iPlayer]
	local iTeam = pPlayer:GetTeam()
	if HasTrait(pPlayer, traitSaintElesbaanID) then
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(buildingTradeRouteGrowthDummyID, 0)
			DMS_AksumPrint("DMS_AksumCityTradeRouteTargetBonus: resetting number of dummy buildings in " .. pCity:GetName() .. "..")
		end
		DMS_AksumPrint("DMS_AksumCityTradeRouteTargetBonus: resetting complete, iterate through major civs..")
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i and i ~= iPlayer then
				local pOtherPlayer = Players[i]
				if pOtherPlayer then
					local iOtherTeam = pOtherPlayer:GetTeam()
					DMS_AksumPrint("DMS_AksumCityTradeRouteTargetBonus: checking for " .. pOtherPlayer:GetCivilizationShortDescription() .. " ..")
					if Teams[iOtherTeam]:IsHasMet(iTeam) then
						if (not Teams[iOtherTeam]:IsAtWar(iTeam)) then
							for _,v in ipairs(pOtherPlayer:GetTradeRoutes()) do
								local pToCity = v.ToCity
								if pToCity and pToCity:GetOwner() == iPlayer then
									DMS_AksumPrint("DMS_AksumCityTradeRouteTargetBonus: " .. pOtherPlayer:GetCivilizationShortDescription() .. " is sending a TR to " .. pToCity:GetName() .. "..")

									iNumIncomingTradeRoutes = pToCity:GetNumRealBuilding(buildingTradeRouteGrowthDummyID)
									pToCity:SetNumRealBuilding(buildingTradeRouteGrowthDummyID, iNumIncomingTradeRoutes + 1)
									DMS_AksumPrint("DMS_AksumCityTradeRouteTargetBonus: adding growth building to " .. pToCity:GetName() .. ". City now has " .. iNumIncomingTradeRoutes .. " of these building(s)..")
								end
							end
						end
					end
				end
			end
		end
	end
end

if isAksumKalebCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_AksumCityTradeRouteTargetBonus)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_AIBuyTradeRouteSlotWithFaith
----------------------------------------------------------------------------------------------------------------------------
function DMS_AIBuyTradeRouteSlotWithFaith(iPlayer)
	local pPlayer = Players[iPlayer]	
	if HasTrait(pPlayer, traitSaintElesbaanID) then 
		if (not pPlayer:IsHuman()) and (not pPlayer:IsBarbarian()) then
			DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith initializing..")
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital ~= nil then
				local faithProgress = pPlayer:GetFaith()
				DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: faithProgress = " .. faithProgress .. "..")
				local faithCost = DMS_GetTradeRouteSlotCost(pPlayer)
				DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: faithCost = " .. faithCost .. "..")
				if faithProgress >= faithCost then
					DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: faithProgress > faithCost, continue..")
					local iChanceMod = 1
					DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: iChanceMod = " .. iChanceMod .. "..")
					if pCapital and pCapital:GetReligiousMajority() ~= -1 then
						DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: Aksum does not have a religion yet..")
						iChanceMod = 0.25
						DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: iChanceMod = " .. iChanceMod .. "..")
					end
					local iChance = JFD_GetRandom(0,100) * iChanceMod
					DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: iChance = " .. iChance .. "..")
					if iChance > 25 then
						DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: " .. iChance .. " > 25, continue..")
						local bCanBuyMoreTradeRouteSlots = DMS_CanBuyMoreTradeRouteSlots(pPlayer)
						if (bCanBuyMoreTradeRouteSlots == true) then
							DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: bCanBuyMoreTradeRouteSlots = true, continue..")
							local iNumTradeRouteSlotsPurchased = pCapital:GetNumRealBuilding(buildingTradeRouteSlotDummyID)
							pPlayer:ChangeFaith(-faithCost)
							DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: AI Purchased TR slot for " .. faithCost .. " Faith..")
							pCapital:SetNumRealBuilding(buildingTradeRouteSlotDummyID, iNumTradeRouteSlotsPurchased + 1)
							DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: Added dummy building in the capital..")
						else
							DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: bCanBuyMoreTradeRouteSlots = false, terminate..")
						end
					else
						DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: " .. iChance .. " <= 25, terminate..")
					end
				else
					DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: " .. faithProgress .. " < " .. faithCost .. ", terminate..")
				end
			else
				DMS_AksumPrint("DMS_AIBuyTradeRouteSlotWithFaith: pCapital is nil, terminate..")
			end
		end
	end
end

if isAksumKalebCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_AIBuyTradeRouteSlotWithFaith)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Aksum_CaptitalCaptured
----------------------------------------------------------------------------------------------------------------------------
function DMS_Aksum_CaptitalCaptured(iOldPlayer, bCapital, iX, iY, iNewPlayer, conquest, conquest2)
	local pOldPlayer = Players[iOldPlayer]
	local pNewPlayer = Players[iNewPlayer]
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	-- move dummy buildings to new capital
	if pCity then
		if HasTrait(pOldPlayer, traitSaintElesbaanID) then
			if pOldPlayer:GetCapitalCity() == pCity then
				local iNumTradeRouteSlotsPurchased = pCity:GetNumRealBuilding(buildingTradeRouteSlotDummyID)
				if (iNumTradeRouteSlotsPurchased > 0) then
					pCity:SetNumRealBuilding(buildingTradeRouteSlotDummyID, 0)
					if (pOldPlayer:IsAlive()) then
						pOldPlayer:GetCapitalCity():SetNumRealBuilding(buildingTradeRouteSlotDummyID, iNumTradeRouteSlotsPurchased)
					end
				end
			end
		end
		-- moved dummy buildings to recaptured capital
		local pCapital = pNewPlayer:GetCapitalCity()
		if pCapital then
			if pCapital:GetID() == pCity:GetID() then
				for pCitytoRemove in pNewPlayer:Cities() do
					if pCitytoRemove:GetID() ~= pCity:GetID() and pCitytoRemove:IsHasBuilding(buildingTradeRouteSlotDummyID) then
						local iNumTradeRouteSlotsPurchased = pCity:GetNumRealBuilding(buildingTradeRouteSlotDummyID)
						pCity:SetNumRealBuilding(buildingTradeRouteSlotDummyID, iNumTradeRouteSlotsPurchased)
						pCitytoRemove:SetNumRealBuilding(buildingTradeRouteSlotDummyID, 0)
					end
				end
			end
		end
	end
end

if isAksumKalebCivActive then
	GameEvents.CityCaptureComplete.Add(DMS_Aksum_CaptitalCaptured)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_SarawitDiscount
----------------------------------------------------------------------------------------------------------------------------
function DMS_SarawitDiscount(playerID, unitID)
    local pPlayer = Players[playerID]
    local iNumSarawit = 0
    DMS_AksumPrint("DMS_SarawitDiscount: initializing..")
    for pUnit in pPlayer:Units() do
        if pUnit and tSarawits[pUnit:GetUnitType()] then -- Even if they'll all be base units this still looks nicer :p
            iNumSarawit = iNumSarawit + 1
            DMS_AksumPrint("DMS_SarawitDiscount: " .. iNumSarawit .. " Sarawit unit(s)..")
        end
    end
    if tSarawits[unitID] then
        if (not HasTrait(pPlayer, traitSaintElesbaanID)) then
            return false
        else
            if tSarawits[unitID] == iNumSarawit then
                DMS_AksumPrint("DMS_SarawitDiscount: Unit " .. tSarawits[unitID] .. " return true..")
                return true
            elseif unitID == unitSarawitCheap8ID and iNumSarawit >= 8 then -- Special case, I guess; idk how else to do it
                DMS_AksumPrint("DMS_SarawitDiscount: Special Case 8 return true..")
                return true
            else
                DMS_AksumPrint("DMS_SarawitDiscount: Unit " .. tSarawits[unitID] .. " return false..")
                return false
            end
			return true
        end
    end
    return true
end

GameEvents.PlayerCanTrain.Add(DMS_SarawitDiscount)
----------------------------------------------------------------------------------------------------------------------------
-- DMS_SarawitConversion
----------------------------------------------------------------------------------------------------------------------------
function DMS_SarawitConversion(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	if pPlayer then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit then
			if HasTrait(pPlayer, traitSaintElesbaanID) then
				--for pUnit in pPlayer:Units() do
					if pUnit:GetUnitType() == unitSarawitCheap1ID or pUnit:GetUnitType() == unitSarawitCheap2ID or pUnit:GetUnitType() == unitSarawitCheap3ID or pUnit:GetUnitType() == unitSarawitCheap4ID or pUnit:GetUnitType() == unitSarawitCheap5ID or pUnit:GetUnitType() == unitSarawitCheap6ID or pUnit:GetUnitType() == unitSarawitCheap7ID or pUnit:GetUnitType() == unitSarawitCheap8ID then
						DMS_convertUnit(pUnit, unitSarawitID)
						DMS_AksumPrint("DMS_SarawitConversion: converted a discounted sarawit to a proper one..")
					end
				--end
			elseif (not HasTrait(pPlayer, traitSaintElesbaanID))  then
				if pUnit:GetUnitType() == unitSarawitID or pUnit:GetUnitType() == unitSarawitCheap1ID or pUnit:GetUnitType() == unitSarawitCheap2ID or pUnit:GetUnitType() == unitSarawitCheap3ID or pUnit:GetUnitType() == unitSarawitCheap4ID or pUnit:GetUnitType() == unitSarawitCheap5ID or pUnit:GetUnitType() == unitSarawitCheap6ID or pUnit:GetUnitType() == unitSarawitCheap7ID or pUnit:GetUnitType() == unitSarawitCheap8ID then
					DMS_convertUnit(pUnit, unitSpearmanID)
					DMS_AksumPrint("DMS_SarawitConversion: converted a sarawit to a spearman for civ other than Aksum..")
				end
			elseif pPlayer:IsBarbarian() or pPlayer:IsMinorCiv() then
				if pUnit:GetUnitType() == unitSarawitID or pUnit:GetUnitType() == unitSarawitCheap1ID or pUnit:GetUnitType() == unitSarawitCheap2ID or pUnit:GetUnitType() == unitSarawitCheap3ID or pUnit:GetUnitType() == unitSarawitCheap4ID or pUnit:GetUnitType() == unitSarawitCheap5ID or pUnit:GetUnitType() == unitSarawitCheap6ID or pUnit:GetUnitType() == unitSarawitCheap7ID or pUnit:GetUnitType() == unitSarawitCheap8ID then
					DMS_convertUnit(pUnit, unitSpearmanID)
					DMS_AksumPrint("DMS_SarawitConversion: converted a sarawit to a spearman for minor civ or barbs..")
				end
			end
		end
	end
end

Events.SerialEventUnitCreated.Add(DMS_SarawitConversion)
--==========================================================================================================================
-- MAIN FUNCTIONS GUDIT
--==========================================================================================================================
-- DMS_PillagedTilesFaith
----------------------------------------------------------------------------------------------------------------------------
function DMS_PillagedTilesFaith(iPlayer)
	local pPlayer = Players[iPlayer]	
	if HasTrait(pPlayer, traitFieldsOfJudithID) then
		local iNumPillageImprovements = 0
		
		DMS_SemienPrint("DMS_PillagedTilesFaith iterate units..")
		for pUnit in pPlayer:Units() do
			local pPlot = pUnit:GetPlot()
			if pPlot then
				DMS_SemienPrint("DMS_PillagedTilesFaith: unit on plot (" .. pPlot:GetX() .. "," .. pPlot:GetY() .. "), checking nearby plots..")
				for nearbyPlot in PlotAreaSweepIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
					if nearbyPlot and (nearbyPlot:GetImprovementType() ~= -1) and nearbyPlot:IsImprovementPillaged() then
						DMS_SemienPrint("DMS_PillagedTilesFaith: found nearby plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ") with pillage improvement..")
						local iPlotOwner = nearbyPlot:GetOwner()
						local pPlotOwner = Players[iPlotOwner]
						if pPlotOwner and Teams[pPlotOwner:GetTeam()]:IsAtWar(pPlayer:GetTeam()) then
							DMS_SemienPrint("DMS_PillagedTilesFaith: owner of nearby plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ") is at war with Gudit..")
							iNumPillageImprovements = iNumPillageImprovements + 1

							DMS_SemienPrint("DMS_PillagedTilesFaith: iNumPillageImprovements = " .. iNumPillageImprovements .. "..")
						end
					end
				end
			end
		end
		if iNumPillageImprovements >= 0 then
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				pCapital:SetNumRealBuilding(buildingPillageImprovementFaithID, iNumPillageImprovements)
				DMS_SemienPrint("DMS_PillagedTilesFaith: placed " .. iNumPillageImprovements .. " pillage dummy buildings in the capital..")
			end
		end
	end
end

if isSemienGuditIDCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_PillagedTilesFaith)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_PillagedTilesCapitalDamage
----------------------------------------------------------------------------------------------------------------------------
function DMS_PillagedTilesCapitalDamage(iPlayer)
	local pPlayer = Players[iPlayer]
	if (not HasTrait(pPlayer, traitFieldsOfJudithID)) then
		if (not pPlayer:IsMinorCiv()) and (not pPlayer:IsBarbarian()) then
			DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: processesing for " .. pPlayer:GetCivilizationShortDescription() .. "..")
			local pBetaIsrael = nil
			DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: iterating other civs (pOtherPlayer)..")
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				local pOtherPlayer = Players[i]
				DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: i = " .. i .. "..")
				if pOtherPlayer then
					DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: pOtherPlayer = " .. pOtherPlayer:GetCivilizationShortDescription() .. "..")
					if (pOtherPlayer ~= pPlayer) and (not pOtherPlayer:IsBarbarian()) then
						DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: pOtherPlayer is not the processing civ (" .. pPlayer:GetCivilizationShortDescription() .. ") nor barbarian..")
						if HasTrait(pOtherPlayer, traitFieldsOfJudithID) then
							pBetaIsrael = pOtherPlayer
							DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: found Beta Israel..")
							if pBetaIsrael ~= nil then break end -- stop for loop
							else DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: Beta Israel still not found ', continue iteration of civs..")
						end
					end
				end
			end
			DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: civ iteration complete..")
			if pBetaIsrael ~= nil then
				DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: pBetaIsrael not nil..")
				if Teams[pPlayer:GetTeam()]:IsAtWar(pBetaIsrael:GetTeam()) then
					DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: " .. pPlayer:GetCivilizationShortDescription() .. " is at war with pBetaIsrael..")
					local pCapital = pPlayer:GetCapitalCity()
					if pCapital then
						local pPlot = pCapital:Plot()
						if pPlot then
							DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: " .. pPlayer:GetCivilizationAdjective() .. " capital found at plot (" .. pPlot:GetX() .. "," .. pPlot:GetY() .. ")..")
							for nearbyPlot in PlotAreaSweepIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
								if nearbyPlot and nearbyPlot:GetOwner() == iPlayer then
									DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ") is owned by " .. pPlayer:GetCivilizationShortDescription() .. "..")
									local improvementType = nearbyPlot:GetImprovementType()
									if improvementType ~= -1 then
										DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ") has improvement ..")
										if tGTI[improvementType] then
											DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: improvement is GTI ..")
											if nearbyPlot:IsImprovementPillaged() then
												DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: improvement is pillaged..")
															
												local iDamage = math.min((5/100) * pCapital:GetMaxHitPoints(), pCapital:GetMaxHitPoints() - pCapital:GetDamage())
												DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: iDamage = " .. iDamage .. "..")
												pCapital:ChangeDamage(iDamage)
												DMS_SemienPrint("DMS_PillagedTilesCapitalDamage: damage dealt to capital..")
												Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))), "[COLOR_NEGATIVE_TEXT]-" .. iDamage .. " HP from pillaged Great Improvement Tiles[ENDCOLOR]", 0)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

if isSemienGuditIDCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_PillagedTilesCapitalDamage)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_CaptureCityGreatWorksYield
----------------------------------------------------------------------------------------------------------------------------
function DMS_CaptureCityGreatWorksYield(iOldPlayer, bCapital, iX, iY, iNewPlayer, conquest, conquest2)
	local pOldPlayer = Players[iOldPlayer]
	local pNewPlayer = Players[iNewPlayer]
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if pCity and pCity:GetOriginalOwner() ~= iNewPlayer then
		if HasTrait(pNewPlayer, traitFieldsOfJudithID) then
			DMS_SemienPrint("DMS_CaptureCityGreatWorksYield: Gudit has captured the city of " .. pCity:GetName() .. "..")
			local iNumGreatWorks = pCity:GetNumGreatWorks()
			DMS_SemienPrint("DMS_CaptureCityGreatWorksYield: " .. pCity:GetName() .. " has " .. iNumGreatWorks .. " Great Work(s)..")
			if iNumGreatWorks > 0 then
				pNewPlayer:ChangeFaith(iNumGreatWorks * 8)
				DMS_SemienPrint("DMS_CaptureCityGreatWorksYield: Gudit receives " .. iNumGreatWorks * 8 .. " Faith..")
				if pNewPlayer:IsHuman() then
					Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]+" .. iNumGreatWorks * 8 .. " [ICON_PEACE] Faith[ENDCOLOR] from capturing a City (" .. pCity:GetName() .. ") with " .. iNumGreatWorks .. " Great Work(s)!");
				end
			end
		end
	end
end

if isSemienGuditIDCivActive then
	GameEvents.CityCaptureComplete.Add(DMS_CaptureCityGreatWorksYield)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_MasgidProduction
----------------------------------------------------------------------------------------------------------------------------
function DMS_MasgidProduction(iPlayer)
	local pPlayer = Players[iPlayer]
	local pCapital = pPlayer:GetCapitalCity()
	if pCapital then
		local iCapitalFaith = pCapital:GetFaithPerTurn()
		if iCapitalFaith > 0 then
			DMS_SemienPrint("DMS_MasgidProduction: Capital is producing " .. iCapitalFaith .. " Faith per turn..")
			for pCity in pPlayer:Cities() do
				if pCity and pCity:IsHasBuilding(buildingMasgidID) then
					DMS_SemienPrint("DMS_MasgidProduction: city of " .. pCity:GetName() .. " has a Masgid building..")
					if iCapitalFaith > 30 then
						iCapitalFaith = 30
					end
					pCity:SetNumRealBuilding(buildingMasgidProductionID, math.floor(iCapitalFaith / 2))
					DMS_SemienPrint("DMS_MasgidProduction: added " .. math.floor(iCapitalFaith / 2) .. " production dummy buildings to " .. pCity:GetName() .. "..")
				end
			end
		end
	end
end

if isSemienGuditIDCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_MasgidProduction)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_AgawArcherAttackPillageUnitSetDamage
----------------------------------------------------------------------------------------------------------------------------
function DMS_AgawArcherAttackPillageUnitSetDamage(iPlayer, iUnit, iNewDamage, iOldDamage)
    if iNewDamage > iOldDamage then
        local pPlayer = Players[iPlayer]
        for pUnit in pPlayer:Units() do
            if pUnit:GetID() == iUnit then
                if (not pUnit:IsHasPromotion(promotionAfterRandomID)) then
					DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitSetDamage: unit attacked..")
					local pPlot = pUnit:GetPlot()
					if pPlot then
						local iRange = 4
						for dX = -iRange, iRange do
							for dY = -iRange, iRange do
								local pSpecificPlot = Map.PlotXYWithRangeCheck(pPlot:GetX(), pPlot:GetY(), dX, dY, iRange)
								if pSpecificPlot ~= nil then
									if pSpecificPlot:GetNumUnits() > 0 then
										DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitSetDamage: found possible attacker..")
										for i = 0, pSpecificPlot:GetNumUnits() - 1 do
											local pSH = pSpecificPlot:GetUnit(i)
											if pSH and pSH:IsHasPromotion(promotionAfterRandomID) then
												DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitSetDamage: found attacker..")
												-- attacker found
												if (pPlot:GetOwner() == iPlayer) and (pPlot:GetImprovementType() ~= nil) and (not pPlot:IsImprovementPillaged()) then
													DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitSetDamage: attacked unit is on pillage-able tile..")
													pPlot:SetImprovementPillaged(true)
													pSH:ChangeDamage(-1 * math.min(15, pSH:GetMaxHitPoints() - pSH:GetCurrHitPoints()))
													local iGold = 12 -- check this
													Players[pSH:GetOwner()]:ChangeGold(iGold)
													if Players[pSH:GetOwner()]:IsHuman() or pPlayer:IsHuman() then
														Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iGold .. " [ICON_GOLD] Gold[ENDCOLOR]", 0)
													end
													DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitSetDamage: tile pillaged, attacker healed, gold granted, message sent..")
													pSH:SetHasPromotion(promotionAfterRandomID, false)
													pSH:SetHasPromotion(promotionQestID, true)
													DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitSetDamage: promotions resat..")
													return
												end
												pSH:SetHasPromotion(promotionAfterRandomID, false)
												pSH:SetHasPromotion(promotionQestID, true)
												DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitSetDamage: promotions resat..")
												return
											end
										end  
									end
								end
							end
						end
                    end
                end 
            end
        end
    end
end

if isSemienGuditIDCivActive then
	Events.SerialEventUnitSetDamage.Add(DMS_AgawArcherAttackPillageUnitSetDamage)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_AgawArcherAttackPillagePlayerDoTurn
----------------------------------------------------------------------------------------------------------------------------
function DMS_AgawArcherAttackPillagePlayerDoTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(GameInfoTypes.promotionAfterRandomID) then -- unit attacked someone
			DMS_SemienPrint("DMS_AgawArcherAttackPillagePlayerDoTurn: found attacker..")
            pUnit:SetHasPromotion(GameInfoTypes.promotionAfterRandomID, false)
            pUnit:SetHasPromotion(GameInfoTypes.promotionQestID, true)
			DMS_SemienPrint("DMS_AgawArcherAttackPillagePlayerDoTurn: promotions resat..")
        end
    end
end

if isSemienGuditIDCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_AgawArcherAttackPillagePlayerDoTurn)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_AgawArcherAttackPillageUnitPrekill
----------------------------------------------------------------------------------------------------------------------------
local iFirstTimeThroughKillerData_Agaw = "NONE"
function DMS_AgawArcherAttackPillageUnitPrekill(iOwner, iUnit, iUnitType, iX, iY, bDelay, iKiller)
    if bDelay then
        iFirstTimeThroughKillerData_Agaw = iKiller
			DMS_ASPrint("DMS_AgawArcherAttackPillageUnitPrekill initializing..")
        return
    end
    if iOwner == Game.GetActivePlayer() then
        return
    end
    if iFirstTimeThroughKillerData_Agaw == -1 then
        iFirstTimeThroughKillerData_Agaw = "NONE"
        return
    end
    if iFirstTimeThroughKillerData_Agaw == "NONE" then
        return
    end
    local pOwnerPlayer = Players[iOwner]
    local pUnitKilled = pOwnerPlayer:GetUnitByID(iUnit)
    --if pUnitKilled:GetDomainType() ~= domainLandID then
	--	return
    --end
	
    local pKillerPlayer = Players[iFirstTimeThroughKillerData_Agaw]
    iFirstTimeThroughKillerData_Agaw = "NONE"
	DMS_ASPrint("DMS_AgawArcherAttackPillageUnitPrekill: land unit killed by " .. pKillerPlayer:GetCivilizationShortDescription() .. "..")

    local pPlot = Map.GetPlot(iX, iY)
	DMS_ASPrint("DMS_AgawArcherAttackPillageUnitPrekill: pPlot is (" .. iX .. "," .. iY .. ")..")
    local iRange = 4
	for dX = -iRange, iRange do
		for dY = -iRange, iRange do
			local pSpecificPlot = Map.PlotXYWithRangeCheck(iX, iY, dX, dY, iRange)
			if pSpecificPlot ~= nil then
				if pSpecificPlot:GetNumUnits() > 0 then
					DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitPrekill: found possible attacker..")
					for i = 0, pSpecificPlot:GetNumUnits() - 1 do
						local pSH = pSpecificPlot:GetUnit(i)
						if pSH and pSH:IsHasPromotion(promotionAfterRandomID) then
							DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitPrekill: found attacker..")
							if (pPlot:GetOwner() == iOwner) and (pPlot:GetImprovementType() ~= nil) and (not pPlot:IsImprovementPillaged()) then
								DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitPrekill: killed unit is on pillage-able tile..")
								pPlot:SetImprovementPillaged(true)
								pSH:ChangeDamage(-1 * math.min(25, pSH:GetMaxHitPoints() - pSH:GetCurrHitPoints()))
								local iGold = 10 -- check this
								Players[pSH:GetOwner()]:ChangeGold(iGold)
								if Players[pSH:GetOwner()]:IsHuman() or pPlayer:IsHuman() then
									Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))), "[COLOR_POSITIVE_TEXT]+" .. iGold .. " [ICON_GOLD] Gold[ENDCOLOR]", 0)
								end
								DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitPrekill: tile pillaged, attacker healed, gold granted, message sent..")
								pSH:SetHasPromotion(promotionAfterRandomID, false)
								pSH:SetHasPromotion(promotionQestID, true)
								DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitPrekill: promotions resat..")
								return
							end
							pSH:SetHasPromotion(promotionAfterRandomID, false)
							pSH:SetHasPromotion(promotionQestID, true)
							DMS_SemienPrint("DMS_AgawArcherAttackPillageUnitPrekill: promotions resat..")
							return
						end
					end
				end
			end
		end
	end			
end

if isSemienGuditIDCivActive then
	GameEvents.UnitPrekill.Add(DMS_AgawArcherAttackPillageUnitPrekill)
end
--==========================================================================================================================
-- MAIN FUNCTIONS AMDA SEYON
--==========================================================================================================================
-- DMS_AS_WLTKD
----------------------------------------------------------------------------------------------------------------------------
function DMS_AS_WLTKD(iPlayer)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitPillarOfZionID) then
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local pCapitalWLTKDCounter = pCapital:GetWeLoveTheKingDayCounter()
			DMS_ASPrint("DMS_AS_WLTKD: pCapitalWLTKDCounter = " .. pCapitalWLTKDCounter .. "..")
			if pCapitalWLTKDCounter > 0 then
				DMS_ASPrint("DMS_AS_WLTKD: capital is celebrating WLTKD")
				if (not pCapital:IsHasBuilding(buildingAmdaSeyonWLTKDDummyID)) then
					-- first turn celebrating WLTKD
					DMS_ASPrint("DMS_AS_WLTKD: must be first turn of WLTKD")
					pCapital:SetNumRealBuilding(buildingAmdaSeyonWLTKDDummyID, 1)
					DMS_ASPrint("DMS_AS_WLTKD: added dummy building")
					for pCity in pPlayer:Cities() do
						if pCity and (not pCity:IsCapital()) then
							if pCity:IsHasBuilding(buildingCourthouseID) then
								DMS_ASPrint("DMS_AS_WLTKD: " .. pCity:GetName() .. " has a courthouse..")
								pCity:SetNumRealBuilding(buildingAmdaSeyonFreeCourthouseID, 1)
								pCity:SetNumRealBuilding(buildingCourthouseID, 0)
								DMS_ASPrint("DMS_AS_WLTKD: replaced regular courthouse with free one in " .. pCity:GetName() .. "..")
							end
							if (pCity:GetWeLoveTheKingDayCounter() == 0) then
								DMS_ASPrint("DMS_AS_WLTKD: " .. pCity:GetName() .. " is not celebrating WLTKD..")
								-- city is not celebrating WLTKD
								pCity:SetWeLoveTheKingDayCounter(pCapitalWLTKDCounter)
								DMS_ASPrint("DMS_AS_WLTKD: WLTKD started in " .. pCity:GetName() .. "..")
							elseif (pCity:GetWeLoveTheKingDayCounter() > 0) then
								DMS_ASPrint("DMS_AS_WLTKD: " .. pCity:GetName() .. " is already celebrating a WLTKD..")
								-- city is already celebrating WLTKD
								pCity:ChangeWeLoveTheKingDayCounter(pCapitalWLTKDCounter)
								DMS_ASPrint("DMS_AS_WLTKD: WLTKD extended in " .. pCity:GetName() .. "..")
							end
						end
					end
					local description = "The Capital has started celebrating a 'We Love The King Day', thus all other Cities start celebrating one as well and any Courthouses become maintenance free and increase [ICON_PRODUCTION] Unit Production by +25%."
					local descriptionShort = "Pillar of Zion"
					JFD_SendNotification(iPlayer, 'NOTIFICATION_GENERIC', description, descriptionShort)
				end
			elseif pCapitalWLTKDCounter == 0 then
				DMS_ASPrint("DMS_AS_WLTKD: pCapitalWLTKDCounter has reached " .. pCapitalWLTKDCounter .. "..")
				if pCapital:IsHasBuilding(buildingAmdaSeyonWLTKDDummyID) then
					pCapital:SetNumRealBuilding(buildingAmdaSeyonWLTKDDummyID, 0)
					DMS_ASPrint("DMS_AS_WLTKD: removed dummy building from capital..")
				end
			end
		end
    end
end
 
if isEthiopiaAmdaSeyonCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_AS_WLTKD)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_AS_WLTKD_Courthouse
----------------------------------------------------------------------------------------------------------------------------
function DMS_AS_WLTKD_Courthouse(iPlayer)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitPillarOfZionID) then
		for pCity in pPlayer:Cities() do
            if pCity and pCity:GetWeLoveTheKingDayCounter() > 0 then
				DMS_ASPrint("DMS_AS_WLTKD_Courthouse: " .. pCity:GetName() .. " is in WLTKD..")
				if pCity:IsHasBuilding(buildingCourthouseID) then
					DMS_ASPrint("DMS_AS_WLTKD_Courthouse: " .. pCity:GetName() .. " has courthouse..")
					pCity:SetNumRealBuilding(buildingAmdaSeyonFreeCourthouseID, 1)
					pCity:SetNumRealBuilding(buildingCourthouseID, 0)
					DMS_ASPrint("DMS_AS_WLTKD_Courthouse: replaced regular courthouse with free one in " .. pCity:GetName() .. "..")
				end
			elseif pCity and pCity:GetWeLoveTheKingDayCounter() == 0 then
				DMS_ASPrint("DMS_AS_WLTKD_Courthouse: " .. pCity:GetName() .. " is not in WLTKD..")
				if pCity:IsHasBuilding(buildingAmdaSeyonFreeCourthouseID) then
					DMS_ASPrint("DMS_AS_WLTKD_Courthouse: " .. pCity:GetName() .. " has free courthouse..")
					pCity:SetNumRealBuilding(buildingCourthouseID, 1)
					pCity:SetNumRealBuilding(buildingAmdaSeyonFreeCourthouseID, 0)
					DMS_ASPrint("DMS_AS_WLTKD_Courthouse: replaced free courthouse with regular one in " .. pCity:GetName() .. "..")
				end
            end
        end
    end
end
 
if isEthiopiaAmdaSeyonCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_AS_WLTKD_Courthouse)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Korem_Experience
----------------------------------------------------------------------------------------------------------------------------
local iFirstTimeThroughKillerData_Korem = "NONE"
function DMS_Korem_Experience(iOwner, iUnit, iUnitType, iX, iY, bDelay, iKiller)
    if bDelay then
        iFirstTimeThroughKillerData_Korem = iKiller
			DMS_ASPrint("DMS_Korem_Experience initializing..")
        return
    end
    if iOwner == Game.GetActivePlayer() then
        return
    end
    if iFirstTimeThroughKillerData_Korem == -1 then
        iFirstTimeThroughKillerData_Korem = "NONE"
        return
    end
    if iFirstTimeThroughKillerData_Korem == "NONE" then
        return
    end
    local pOwnerPlayer = Players[iOwner]
    local pUnitKilled = pOwnerPlayer:GetUnitByID(iUnit)
    if pUnitKilled:GetDomainType() ~= domainLandID then
		return
    end
	
    local pKillerPlayer = Players[iFirstTimeThroughKillerData_Korem]
    iFirstTimeThroughKillerData_Korem = "NONE"
	DMS_ASPrint("DMS_Korem_Experience: land unit killed by " .. pKillerPlayer:GetCivilizationShortDescription() .. "..")

    local pPlot = Map.GetPlot(iX, iY)
	DMS_ASPrint("DMS_Korem_Experience: pPlot is (" .. iX .. "," .. iY .. ")..")
    local iNumTileUnits = pPlot:GetNumUnits()
    if iNumTileUnits >= 1 then
		DMS_ASPrint("DMS_Korem_Experience: iterate units on plot..")
        for i = 0, pPlot:GetNumUnits() do
            local pUnit = pPlot:GetUnit(i)
            if pUnit then
                if pUnit ~= pUnitKilled then
					DMS_ASPrint("DMS_Korem_Experience: plot contains another unit than the dead one..")
                    if pUnit:GetUnitType() == unitKoremID or pUnit:IsHasPromotion(promotionKoremID) then
						DMS_ASPrint("DMS_Korem_Experience: korem unit killed enemy at plot (" .. iX .. "," .. iY .. ")..")
                        local iExp = 0
                        local iCapturedCities = 0
                        for pCity in pKillerPlayer:Cities() do
                            if pCity:GetOriginalOwner() == iOwner then
                                iCapturedCities = iCapturedCities + 1
                            end
                        end
						DMS_ASPrint("DMS_Korem_Experience: civ has captured " .. iCapturedCities .. " " .. pOwnerPlayer:GetCivilizationAdjective() .. " cities..")
                        if iCapturedCities > 0 then
                            iExp = math.ceil(30 * ( 1 - math.exp(- 0.2 * iCapturedCities)))
							DMS_ASPrint("DMS_Korem_Experience: iExp calculated to " .. iExp .. "..")
                               
                            pUnit:ChangeExperience(iExp)
                               
                            if pKillerPlayer:IsHuman() then
								DMS_ASPrint("DMS_Korem_Experience: should send a notification..")
								local sUnitType = "Korem"
								local sCity = "City"
								if pUnit:GetUnitType() ~= unitKoremID then
									sUnitType = "Unit with the Digna's Wrath Promotion"
								end
								if iCapturedCities > 1 then
									sCity = "Cities"
								end
									Events.GameplayAlertMessage("A " .. sUnitType .. " has killed an enemy and receives " .. iExp .. " extra Experience since you control " .. iCapturedCities .. " " .. pOwnerPlayer:GetCivilizationAdjective() .. " " .. sCity .. "!");
								
								DMS_ASPrint("DMS_Korem_Experience: notification sent..")
                            end
                        end
                    end
                end
            end
        end
    end
end
 
if isEthiopiaAmdaSeyonCivActive then
	GameEvents.UnitPrekill.Add(DMS_Korem_Experience)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_Shotelai_ReducingMovement
----------------------------------------------------------------------------------------------------------------------------
function DMS_Shotelai_ReducingMovement(iPlayer)
    local pPlayer = Players[iPlayer]
    if (not HasTrait(pPlayer, traitPillarOfZionID)) then
		DMS_ASPrint("DMS_Shotelai_ReducingMovement: processessing for " .. pPlayer:GetCivilizationShortDescription() .. "..")
        for pUnit in pPlayer:Units() do
            if pUnit and pUnit:IsCombatUnit() then
                local pPlot = pUnit:GetPlot()
                if pPlot then
					DMS_ASPrint("DMS_Shotelai_ReducingMovement: checking for unit at plot (" .. pPlot:GetX() .. "," .. pPlot:GetY() .. ")..")
                    for adjPlot in PlotAreaSweepIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
                        if adjPlot and adjPlot:IsUnit() then
                            local iAdjPlotUnits = adjPlot:GetNumUnits()
                            if iAdjPlotUnits > 0 then
								for i = 0, iAdjPlotUnits do
									local pAdjUnit = adjPlot:GetUnit(i)
									if pAdjUnit and pAdjUnit:IsHasPromotion(promotionShotelID) then
										DMS_ASPrint("DMS_Shotelai_ReducingMovement: found adjacent shotelai unit at (" .. adjPlot:GetX() .. "," .. adjPlot:GetY() .. ")..")
										local iAdjUnitOwner = pAdjUnit:GetOwner()
										if iAdjUnitOwner and iAdjUnitOwner ~= iPlayer and Teams[Players[iAdjUnitOwner]:GetTeam()]:IsAtWar(pPlayer:GetTeam()) then
											DMS_ASPrint("DMS_Shotelai_ReducingMovement: " .. pPlayer:GetCivilizationShortDescription() .. " is at war with " .. Players[iAdjUnitOwner]:GetCivilizationShortDescription() .. "..")
											if pUnit:GetDamage() >= 0 and pUnit:GetDamage() < 50 then -- damage between 0 and 49
												DMS_ASPrint("DMS_Shotelai_ReducingMovement: unit has " .. 100 - pUnit:GetDamage() .. " HP (between 50 and 100)..")
												if pUnit:GetMoves() > 60 then -- more than 1 move
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: unit has " .. pUnit:GetMoves() .. " Moves (more than 1 move)..")
													pUnit:ChangeMoves(-60) -- lose 1 move
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: -60 Moves..")
													if Players[iAdjUnitOwner]:IsHuman() then
														local sUnitType = "Shotelai"
														if pUnit:GetUnitType() ~= unitKoremID then
															sUnitType = "Unit with the Jan Amora Promotion"
														end
														Events.GameplayAlertMessage("A " .. sUnitType .. " has reduced the [ICON_MOVES] Movement of an enemy Unit by 1!");
													end
												end
											elseif pUnit:GetDamage() >= 50 and pUnit:GetDamage() < 85 then -- damage between 50 and 84
												DMS_ASPrint("DMS_Shotelai_ReducingMovement: unit has " .. 100 - pUnit:GetDamage() .. " HP (between 16 and 50)..")
												if pUnit:GetMoves() > 120 then -- more than 2 moves
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: unit has " .. pUnit:GetMoves() .. " Moves (more than 2 moves)..")
													pUnit:ChangeMoves(-120) -- lose 2 moves
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: -120 Moves..")
													if Players[iAdjUnitOwner]:IsHuman() then
														local sUnitType = "Shotelai"
														if pUnit:GetUnitType() ~= unitKoremID then
															sUnitType = "Unit with the Jan Amora Promotion"
														end
														Events.GameplayAlertMessage("A " .. sUnitType .. " has reduced the [ICON_MOVES] Movement of an enemy Unit by 2!");
													end
												elseif pUnit:GetMoves() <= 120 and pUnit:GetMoves() >= 60 then -- 1 or 2 moves
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: unit has " .. pUnit:GetMoves() .. " Moves (1 or 2 moves)..")
													pUnit:ChangeMoves(-60) -- lose 1 move
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: -60 Moves..")
													if Players[iAdjUnitOwner]:IsHuman() then
														local sUnitType = "Shotelai"
														if pUnit:GetUnitType() ~= unitKoremID then
															sUnitType = "Unit with the Jan Amora Promotion"
														end
														Events.GameplayAlertMessage("A " .. sUnitType .. " has reduced the [ICON_MOVES] Movement of an enemy Unit by 1!");
													end
												end
											elseif pUnit:GetDamage() >= 85 then -- damage between 85 and 99
												DMS_ASPrint("DMS_Shotelai_ReducingMovement: unit has " .. 100 - pUnit:GetDamage() .. " HP (between 1 and 15)..")
												if pUnit:GetMoves() >= 180 then -- 3 moves or more
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: unit has " .. pUnit:GetMoves() .. " Moves (3 moves or more)..")
													pUnit:ChangeMoves(-180) -- lose 3 moves
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: -180 Moves..")
													if Players[iAdjUnitOwner]:IsHuman() then
														local sUnitType = "Shotelai"
														if pUnit:GetUnitType() ~= unitKoremID then
															sUnitType = "Unit with the Jan Amora Promotion"
														end
														Events.GameplayAlertMessage("A " .. sUnitType .. " has reduced the [ICON_MOVES] Movement of an enemy Unit by 3!");
													end
												elseif pUnit:GetMoves() < 180 and pUnit:GetMoves() >= 120 then -- 2 moves
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: unit has " .. pUnit:GetMoves() .. " Moves (2 moves)..")
													pUnit:ChangeMoves(-120) -- lose 2 moves
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: -120 Moves..")
													if Players[iAdjUnitOwner]:IsHuman() then
														local sUnitType = "Shotelai"
														if pUnit:GetUnitType() ~= unitKoremID then
															sUnitType = "Unit with the Jan Amora Promotion"
														end
														Events.GameplayAlertMessage("A " .. sUnitType .. " has reduced the [ICON_MOVES] Movement of an enemy Unit by 2!");
													end
												elseif pUnit:GetMoves() < 120 and pUnit:GetMoves() >= 60 then -- 1 move
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: unit has " .. pUnit:GetMoves() .. " Moves (1 move)..")
													pUnit:ChangeMoves(-60) -- lose 1 move
													DMS_ASPrint("DMS_Shotelai_ReducingMovement: -60 Moves..")
													if Players[iAdjUnitOwner]:IsHuman() then
														local sUnitType = "Shotelai"
														if pUnit:GetUnitType() ~= unitKoremID then
															sUnitType = "Unit with the Jan Amora Promotion"
														end
														Events.GameplayAlertMessage("A " .. sUnitType .. " has reduced the [ICON_MOVES] Movement of an enemy Unit by 1!");
													end
												end
											end
										end
									end        
								end
							end
                        end
                    end
                end
            end
        end
    end
end
 
--Events.ActivePlayerTurnStart.Add(DMS_Shotelai_ReducingMovement)
if isEthiopiaAmdaSeyonCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_Shotelai_ReducingMovement)
end
--==========================================================================================================================
-- MAIN FUNCTIONS ZARA YAQOB
--==========================================================================================================================
-- DMS_ZY_OnExpendedDebtera
----------------------------------------------------------------------------------------------------------------------------
local bDebtera = false

function DMS_ZY_OnExpendedDebtera(iPlayer, eGreatPersonType, eGreatPersonTypeCP)
	if eGreatPersonTypeCP then eGreatPersonType = eGreatPersonTypeCP end
	local pPlayer = Players[iPlayer]
	if eGreatPersonType == unitDebteraID then
		bDebtera = true
		DMS_ZYPrint("DMS_ZY_OnExpendedDebtera: bDebtera = true")
	end
end

if isEthiopiaZaraYaqobCivActive then
	GameEvents.GreatPersonExpended.Add(DMS_ZY_OnExpendedDebtera)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_ZY_ExpendedDebtera
----------------------------------------------------------------------------------------------------------------------------
function DMS_ZY_ExpendedDebtera(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	if bDebtera == true then
		DMS_ZYPrint("DMS_ZY_ExpendedDebtera: bDebtera = true..")
		local pPlot = Map.GetPlot(iX, iY)
		if pPlot then
			DMS_ZYPrint("DMS_ZY_ExpendedDebtera: pPlot (" .. iX .. "," .. iY .. ")..")
			for pAdjPlot in PlotAreaSweepIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				if pAdjPlot and pAdjPlot:IsUnit() then
					local iNumTileUnits = pAdjPlot:GetNumUnits()
					if iNumTileUnits > 0 then
						for i = 0, pAdjPlot:GetNumUnits() do
							local pAdjUnit = pAdjPlot:GetUnit(i)
							if pAdjUnit and pAdjUnit:GetOwner() == iPlayer and pAdjUnit:IsCombatUnit() and pAdjUnit:GetDomainType() == domainLandID then
								DMS_ZYPrint("DMS_ZY_ExpendedDebtera: found nearby combat land unit at pPlot (" .. pAdjPlot:GetX() .. "," .. pAdjPlot:GetY() .. ")..")
								local iDamage = pAdjUnit:GetDamage()
								DMS_ZYPrint("DMS_ZY_ExpendedDebtera: iDamage = (" .. iDamage .. ")..")
								if iDamage > 0 then
									pAdjUnit:ChangeDamage(-1 * math.min(25, pAdjUnit:GetMaxHitPoints() - pAdjUnit:GetCurrHitPoints()))
									DMS_ZYPrint("DMS_ZY_ExpendedDebtera: healed unit " .. math.min(25, pAdjUnit:GetMaxHitPoints() - pAdjUnit:GetCurrHitPoints()) .. " HP..")
								end
								if (pAdjUnit:GetUnitCombatType() == unitCombatTypeMelee) or (pAdjUnit:GetUnitCombatType() == unitCombatTypeRecon) or (pAdjUnit:GetUnitCombatType() == unitCombatTypeMounted) or (pAdjUnit:GetUnitCombatType() == unitCombatTypeGun) or (pAdjUnit:GetUnitCombatType() == unitCombatTypeArmor) then
									DMS_ZYPrint("DMS_ZY_ExpendedDebtera: unit is correct type to get Seed of Jacob promotion..")
									if	(not pAdjUnit:IsHasPromotion(promotionSeedOfJakob1ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob2ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob3ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob4ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob5ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob6ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob7ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob8ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob9ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob10ID)) or
										(not pAdjUnit:IsHasPromotion(promotionSeedOfJakob11ID)) or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob12ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob13ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob14ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob15ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob16ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob17ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob18ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob19ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob20ID)) or
										(not pAdjUnit:IsHasPromotion(promotionSeedOfJakob21ID)) or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob22ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob23ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob24ID)) 	or (not pAdjUnit:IsHasPromotion(promotionSeedOfJakob25ID)) then
										DMS_ZYPrint("DMS_ZY_ExpendedDebtera: unit does not  already have Seed of Jacob promotion..")
										pAdjUnit:SetHasPromotion(promotionSeedOfJakob1ID, true)
										Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pAdjPlot:GetX(), pAdjPlot:GetY()))), "'Seed of Jacob' Promotion granted", 0)
										DMS_ZYPrint("DMS_ZY_ExpendedDebtera: Seed of Jacob promotion granted..")
									end
								end 
							end
						end
					end
				end
			end
		end
		
		bDebtera = false
		DMS_ZYPrint("DMS_ZY_ExpendedDebtera: reset bDebtera = false..")
	end
end

if isEthiopiaZaraYaqobCivActive then
	GameEvents.UnitPrekill.Add(DMS_ZY_ExpendedDebtera)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_ZY_SeedOfJacobPromotion
----------------------------------------------------------------------------------------------------------------------------
function DMS_ZY_SeedOfJacobPromotion(iPlayer)
	local pPlayer = Players[iPlayer]	
	if HasTrait(pPlayer, traitSeedOfJacobID) then
		for pUnit in pPlayer:Units() do
			if pUnit and pUnit:IsCombatUnit() and pUnit:GetDomainType() == domainLandID then
				if pUnit:IsHasPromotion(promotionSeedOfJakob1ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 1 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob2ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 2 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob1ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 1 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob2ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 2 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob3ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 3 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob2ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 2 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob3ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 3 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob4ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 4 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob3ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 3 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob4ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 4 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob5ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 5 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob4ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 4 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob5ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 5 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob6ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 6 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob5ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 5 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob6ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 6 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob7ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 7 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob6ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 6 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob7ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 7 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob8ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 8 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob7ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 7 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob8ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 8 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob9ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 9 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob8ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 8 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob9ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 9 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob10ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 10 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob9ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 9 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob10ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 10 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob11ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 11 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob10ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 10 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob11ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 11 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob12ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 12 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob11ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 11 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob12ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 12 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob13ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 13 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob12ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 12 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob13ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 13 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob14ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 14 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob13ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 13 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob14ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 14 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob15ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 15 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob14ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 14 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob15ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 15 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob16ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 16 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob15ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 15 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob16ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 16 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob17ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 17 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob16ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 16 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob17ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 17 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob18ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 18 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob17ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 17 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob18ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 18 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob19ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 19 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob18ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 18 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob19ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 19 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob20ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 20 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob19ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 19 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob20ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 20 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob21ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 21 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob20ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 20 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob21ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 21 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob22ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 22 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob21ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 21 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob22ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 22 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob23ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 23 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob22ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 22 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob23ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 23 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob24ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 24 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob23ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 23 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob24ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 24 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob25ID, true)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: granted Seed of Jacob 25 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob24ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 24 promotion..")
				elseif pUnit:IsHasPromotion(promotionSeedOfJakob25ID) then
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: unit at plot (" .. pUnit:GetPlot():GetX() .. "," .. pUnit:GetPlot():GetY() .. ") has the Seed of Jacob 25 promotion..")
					pUnit:SetHasPromotion(promotionSeedOfJakob25ID, false)
					DMS_ZYPrint("DMS_ZY_SeedOfJacobPromotion: removed Seed of Jacob 25 promotion..")
				end
			end
		end
	end
end

if isEthiopiaZaraYaqobCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_ZY_SeedOfJacobPromotion)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_ZY_SeedOfJacobKill
----------------------------------------------------------------------------------------------------------------------------
local iFirstTimeThroughKillerData = "NONE"
function DMS_ZY_SeedOfJacobKill(iOwner, iUnit, iUnitType, iX, iY, bDelay, iKiller)
	if bDelay then
		iFirstTimeThroughKillerData = iKiller
		return
	end
	if iOwner == Game.GetActivePlayer() then
		return
	end
	if iFirstTimeThroughKillerData == -1 then
		iFirstTimeThroughKillerData = "NONE"
		return
	end
	if iFirstTimeThroughKillerData == "NONE" then
		return
	end
	local pOwnerPlayer = Players[iOwner]
	local pUnitKilled = pOwnerPlayer:GetUnitByID(iUnit)
	if pUnitKilled:GetDomainType() ~= domainLandID then
		return	
	end
	local pKillerPlayer = Players[iFirstTimeThroughKillerData]
	iFirstTimeThroughKillerData = "NONE"
	if (not HasTrait(pKillerPlayer, traitSeedOfJacobID)) then
		return
	end
	local pPlot = Map.GetPlot(iX, iY)
	local iNumTileUnits = pPlot:GetNumUnits()
	if iNumTileUnits > 1 then
		for i = 0, pPlot:GetNumUnits() do
			local pUnit = pPlot:GetUnit(i)
			if pUnit then
				local iPlotUnitOwner = pUnit:GetOwner()
				local iPlotUnitType = pUnit:GetUnitType()

				if pUnit ~= pUnitKilled then
					if pUnit:IsHasPromotion(promotionSeedOfJakob1ID) or pUnit:IsHasPromotion(promotionSeedOfJakob2ID) or pUnit:IsHasPromotion(promotionSeedOfJakob3ID) or pUnit:IsHasPromotion(promotionSeedOfJakob4ID) or pUnit:IsHasPromotion(promotionSeedOfJakob5ID) or pUnit:IsHasPromotion(promotionSeedOfJakob6ID) or pUnit:IsHasPromotion(promotionSeedOfJakob7ID) or pUnit:IsHasPromotion(promotionSeedOfJakob8ID) or pUnit:IsHasPromotion(promotionSeedOfJakob9ID) or pUnit:IsHasPromotion(promotionSeedOfJakob10ID) or pUnit:IsHasPromotion(promotionSeedOfJakob11ID) or pUnit:IsHasPromotion(promotionSeedOfJakob12ID) or pUnit:IsHasPromotion(promotionSeedOfJakob13ID) or pUnit:IsHasPromotion(promotionSeedOfJakob14ID) or pUnit:IsHasPromotion(promotionSeedOfJakob15ID) or pUnit:IsHasPromotion(promotionSeedOfJakob16ID) or pUnit:IsHasPromotion(promotionSeedOfJakob17ID) or pUnit:IsHasPromotion(promotionSeedOfJakob18ID) or pUnit:IsHasPromotion(promotionSeedOfJakob19ID) or pUnit:IsHasPromotion(promotionSeedOfJakob20ID) or pUnit:IsHasPromotion(promotionSeedOfJakob21ID) or pUnit:IsHasPromotion(promotionSeedOfJakob22ID) or pUnit:IsHasPromotion(promotionSeedOfJakob23ID) or pUnit:IsHasPromotion(promotionSeedOfJakob24ID) or pUnit:IsHasPromotion(promotionSeedOfJakob25ID) then
						DMS_ZYPrint("DMS_ZY_SeedOfJacobKill: unit killed by unit with a Seed of Jacob promotion..")
						local pCity = DMS_GetWriterCity(pKillerPlayer)
						if pCity then
							DMS_ZYPrint("DMS_ZY_SeedOfJacobKill: city of " .. pCity:GetName() .. " is writer city..")
							local iMinNum = 5
							local iGreatWriterPoints = math.ceil(iMinNum * JFD_GetRandom(1,3))
							DMS_ZYPrint("DMS_ZY_SeedOfJacobKill: iGreatWriterPoints = " .. iGreatWriterPoints .. "..")
							pCity:ChangeSpecialistGreatPersonProgressTimes100(specialistWriter, iGreatWriterPoints * 100)
							DMS_ZYPrint("DMS_ZY_SeedOfJacobKill: " .. iGreatWriterPoints .. " great writer points added..")
							if pKillerPlayer:IsHuman() then
								Events.GameplayAlertMessage("A Unit with the 'Seed of Jacob' Promotion has killed an enemy and generated " .. iGreatWriterPoints .. " [ICON_GREAT_WRITER] Great Writer Points!");
								DMS_ZYPrint("DMS_ZY_SeedOfJacobKill: notification sent..")
							end
						end
					end
				end
			end
		end
	end
end

if isEthiopiaZaraYaqobCivActive then
	GameEvents.UnitPrekill.Add(DMS_ZY_SeedOfJacobKill)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_ProphetToDebteraConverter
----------------------------------------------------------------------------------------------------------------------------
function DMS_ProphetToDebteraConverter(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitSeedOfJacobID) then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if (not pUnit) then return end
		local pUnitType = pUnit:GetUnitType()
		if pUnitType and (pUnitType == iProphetID) then
			DMS_ZYPrint("DMS_ProphetToDebteraConverter: prophet found for Zara Yaqob..")
			local pNewUnit = pPlayer:InitUnit(unitDebteraID, pUnit:GetX(), pUnit:GetY())
			DMS_ZYPrint("DMS_ProphetToDebteraConverter: init debtera..")
			pNewUnit:Convert(pUnit)	
			pUnit:Kill(-1)
			DMS_ZYPrint("DMS_ProphetToDebteraConverter: kill old unit..")
		end
	elseif (not HasTrait(pPlayer, traitSeedOfJacobID)) then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if (not pUnit) then return end
		local pUnitType = pUnit:GetUnitType()
		if (pUnitType == unitDebteraID) then
			DMS_ZYPrint("DMS_ProphetToDebteraConverter: debtera found for other civ NOT the correct type..")
			local pNewUnit = pPlayer:InitUnit(iProphetID, pUnit:GetX(), pUnit:GetY())
			DMS_ZYPrint("DMS_ProphetToDebteraConverter: init prophet..")
			pNewUnit:Convert(pUnit)	
			pUnit:Kill(-1)
			DMS_ZYPrint("DMS_ProphetToDebteraConverter: kill old unit..")
		end
	end
end

if isEthiopiaZaraYaqobCivActive then
	--Events.SerialEventUnitCreated.Add(DMS_ProphetToDebteraConverter)
end

function DMS_CanTrainProphet(iPlayer, iUnit)
    local pPlayer = Players[iPlayer]
    local bIs = HasTrait(pPlayer, traitSeedOfJacobID)
    if bIs and iUnit == iProphetID then
        return false
    elseif (not bIs) and iUnit == unitDebteraID then
        return false
    else
        return true
    end
    return true
end

GameEvents.PlayerCanTrain.Add(DMS_CanTrainProphet)
----------------------------------------------------------------------------------------------------------------------------
-- DebteraOverride
----------------------------------------------------------------------------------------------------------------------------
function DebteraOverride(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitSeedOfJacobID) then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit and (pUnit:GetUnitType() == iProphetID) then
			--Events.SerialEventUnitCreated.Remove(ProphetOverride)
			local newUnit = pPlayer:InitUnit(iProphetOverride, pUnit:GetX(), pUnit:GetY())				
			newUnit:Convert(pUnit);	
			--Events.SerialEventUnitCreated.Add(AbiiruOverride)
        end
    end
end

if isEthiopiaZaraYaqobCivActive then
	Events.SerialEventUnitCreated.Add(DebteraOverride)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_ZY_MonolithicChurches_GreatWorksWritingSlot
----------------------------------------------------------------------------------------------------------------------------
DMS_ZaraYaqobImprovements_PlayerID = 0
DMS_ZaraYaqobImprovements_X = 0
DMS_ZaraYaqobImprovements_Y = 0

function DMS_ZY_MonolithicChurches_GreatWorksWritingSlot(iPlayer, iX, iY)
	if(DMS_ZaraYaqobImprovements_PlayerID == iPlayer and DMS_ZaraYaqobImprovements_X == iX and DMS_ZaraYaqobImprovements_Y == iY) then
		
		return
	end
	-- Store inputs for duplication check
	DMS_ZaraYaqobImprovements_PlayerID = iPlayer
	DMS_ZaraYaqobImprovements_X = iX
	DMS_ZaraYaqobImprovements_Y = iY
	
	local pPlayer = Players[iPlayer]
	DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: Improvement built at plot (" .. iX .. "," .. iY .. ")..")
	--if pPlayer and pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == civilisationDervishStateID then
	local pPlot = Map.GetPlot(iX, iY)
	local pCity = DMS_GetNearestCity(pPlayer, iX, iY)
	if pCity then
		DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: nearest city is (" .. pCity:GetName() .. ")..")
		if pPlot then
			if pPlot:GetImprovementType() == improvementMonolithicChurchID then
				DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: improvement is a Monolithic church..") 
				if pCity:IsHasBuilding(buildingZaraYaqobGreatWorksWriting6ID) then
					-- city cannot receive more great works of writing from monolithic churches
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: city has max Great Writer slots from monolithic churches..")
				elseif pCity:IsHasBuilding(buildingZaraYaqobGreatWorksWriting5ID) then
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: city has 5 Great Writer slots from monolithic churches..")
					pCity:SetNumRealBuilding(buildingZaraYaqobGreatWorksWriting6ID, 1)
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: added one more..")
				elseif pCity:IsHasBuilding(buildingZaraYaqobGreatWorksWriting4ID) then
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: city has 4 Great Writer slots from monolithic churches..")
					pCity:SetNumRealBuilding(buildingZaraYaqobGreatWorksWriting5ID, 1)
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: added one more..")
				elseif pCity:IsHasBuilding(buildingZaraYaqobGreatWorksWriting3ID) then
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: city has 3 Great Writer slots from monolithic churches..")
					pCity:SetNumRealBuilding(buildingZaraYaqobGreatWorksWriting4ID, 1)
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: added one more..")
				elseif pCity:IsHasBuilding(buildingZaraYaqobGreatWorksWriting2ID) then
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: city has 2 Great Writer slots from monolithic churches..")
					pCity:SetNumRealBuilding(buildingZaraYaqobGreatWorksWriting3ID, 1)
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: added one more..")
				elseif pCity:IsHasBuilding(buildingZaraYaqobGreatWorksWriting1ID) then
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: city has 1 Great Writer slot from monolithic churches..")
					pCity:SetNumRealBuilding(buildingZaraYaqobGreatWorksWriting2ID, 1)
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: added one more..")
				elseif (not pCity:IsHasBuilding(buildingZaraYaqobGreatWorksWriting1ID)) then
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: city does not have any Great Writer slots from monolithic churches..")
					pCity:SetNumRealBuilding(buildingZaraYaqobGreatWorksWriting1ID, 1)
					DMS_ZYPrint("DMS_ZY_MonolithicChurches_GreatWorksWritingSlot: added one..")
				end
			end
		end
	end
end

if isEthiopiaZaraYaqobCivActive then
	GameEvents.BuildFinished.Add(DMS_ZY_MonolithicChurches_GreatWorksWritingSlot)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_ZY_MonolithicChurches_ExtraYields
----------------------------------------------------------------------------------------------------------------------------
function DMS_ZY_MonolithicChurches_ExtraYields(iPlayer)
	local pPlayer = Players[iPlayer]	
	if HasTrait(pPlayer, traitSeedOfJacobID) then
		for pCity in pPlayer:Cities() do
			DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: iterating cities..")
			if pCity then
				--local iNumGreatWorks = pCity:GetNumGreatWorks(greatWorkLiteratureID) -- issue is here!!
				local iNumGreatWorks = CountDemGreatWorks(pCity, gwTable)
				DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: iNumGreatWorks = " .. iNumGreatWorks .. "..")
				if iNumGreatWorks > 0 then
				DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: city of " .. pCity:GetName() .. " has " .. iNumGreatWorks .. " Great Work of Writing slots..")
					for nearbyPlot in PlotAreaSweepIterator(pCity:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						if nearbyPlot and nearbyPlot:GetOwner() == iPlayer and nearbyPlot:GetWorkingCity() == pCity then
							DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: city of " .. pCity:GetName() .. " is working plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ")..")
							if nearbyPlot:GetImprovementType() == improvementMonolithicChurchID or nearbyPlot:GetImprovementType() == improvementMonolithicChurch1ID or nearbyPlot:GetImprovementType() == improvementMonolithicChurch2ID or nearbyPlot:GetImprovementType() == improvementMonolithicChurch3ID or nearbyPlot:GetImprovementType() == improvementMonolithicChurch4ID or nearbyPlot:GetImprovementType() == improvementMonolithicChurch5ID then
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: plot has monolithic church improvement..")
								if iNumGreatWorks == 1 then
									nearbyPlot:SetImprovementType(improvementMonolithicChurch1ID)
									DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: set improvement monolithic church 1..")
								elseif iNumGreatWorks == 2 then
									nearbyPlot:SetImprovementType(improvementMonolithicChurch2ID)
									DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: set improvement monolithic church 2..")
								elseif iNumGreatWorks == 3 then
									nearbyPlot:SetImprovementType(improvementMonolithicChurch3ID)
									DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: set improvement monolithic church 3..")
								elseif iNumGreatWorks == 4 then
									nearbyPlot:SetImprovementType(improvementMonolithicChurch4ID)
									DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: set improvement monolithic church 4..")
								elseif iNumGreatWorks >= 5 then
									nearbyPlot:SetImprovementType(improvementMonolithicChurch5ID)
									DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields: set improvement monolithic church 5..")
								end
							end
						end
					end
				end
			end
		end
	end
end

function DMS_ZY_MonolithicChurches_ExtraYields_New(iPlayer)
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer]
	if HasTrait(pPlayer, traitSeedOfJacobID) then
		for pCity in pPlayer:Cities() do
			if pCity then
				local iNumGreatWorks = CountDemGreatWorks(pCity, gwTable)
				DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: " .. pCity:GetName() .. ", iNumGreatWorks = " .. iNumGreatWorks .. "..")
				if iNumGreatWorks > 0 then
					for nearbyPlot in PlotAreaSweepIterator(pCity:Plot(), 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
						if nearbyPlot and nearbyPlot:GetOwner() == iPlayer and nearbyPlot:GetWorkingCity() == pCity then
							DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: checking plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ") near " .. pCity:GetName() .. "")
							if nearbyPlot:GetImprovementType() == improvementMonolithicChurchID then
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ") near " .. pCity:GetName() .. " has a monolithic church, lets increase dem yields!")
								-- Production
								local iNearbyPlotProductionYield = nearbyPlot:GetYield(yieldProductionID)
								local iNearbyPlotProductionNatureYield = nearbyPlot:CalculateNatureYield(yieldProductionID, pTeam, false)
								local iNearbyPlotProductionImprovementYield = nearbyPlot:CalculateImprovementYieldChange(improvementMonolithicChurchID, yieldProductionID, pPlayer)
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotProductionYield = " .. iNearbyPlotProductionYield .. "")
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotProductionNatureYield = " .. iNearbyPlotProductionNatureYield .. "")
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotProductionImprovementYield = " .. iNearbyPlotProductionImprovementYield .. "")
								if iNearbyPlotProductionYield == iNearbyPlotProductionNatureYield + iNearbyPlotProductionImprovementYield + (iNumGreatWorks - 1) then
									Game.SetPlotExtraYield(nearbyPlot:GetX(), nearbyPlot:GetY(), yieldProductionID, iNumGreatWorks)
									DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: added extra production yield from plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ")")
								end
								-- Faith
								local iNearbyPlotFaithYield = nearbyPlot:GetYield(yieldFaithID)
								local iNearbyPlotFaithNatureYield = nearbyPlot:CalculateNatureYield(yieldFaithID, pTeam, false)
								local iNearbyPlotFaithImprovementYield = nearbyPlot:CalculateImprovementYieldChange(improvementMonolithicChurchID, yieldFaithID, pPlayer)
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotFaithYield = " .. iNearbyPlotFaithYield .. "")
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotFaithNatureYield = " .. iNearbyPlotFaithNatureYield .. "")
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotFaithImprovementYield = " .. iNearbyPlotFaithImprovementYield .. "")
								if iNearbyPlotFaithYield == iNearbyPlotFaithNatureYield + iNearbyPlotFaithImprovementYield + (iNumGreatWorks - 1) then
									Game.SetPlotExtraYield(nearbyPlot:GetX(), nearbyPlot:GetY(), yieldFaithID, iNumGreatWorks)
									DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: added extra faith yield from plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ")")
								end
							else
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ") near " .. pCity:GetName() .. " does not have a monolithic church, check if it has extra yields")
								local iNearbyPlotProductionYield = nearbyPlot:GetYield(yieldProductionID)
								local iNearbyPlotProductionNatureYield = nearbyPlot:CalculateNatureYield(yieldProductionID, pTeam, false)
								local iNearbyPlotProductionImprovementYield = nearbyPlot:CalculateImprovementYieldChange(improvementMonolithicChurchID, yieldProductionID, pPlayer)
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotProductionYield = " .. iNearbyPlotProductionYield .. "")
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotProductionNatureYield = " .. iNearbyPlotProductionNatureYield .. "")
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotProductionImprovementYield = " .. iNearbyPlotProductionImprovementYield .. "")
								if iNearbyPlotProductionYield == iNearbyPlotProductionNatureYield + iNearbyPlotProductionImprovementYield then
									Game.SetPlotExtraYield(nearbyPlot:GetX(), nearbyPlot:GetY(), yieldProductionID, -iNumGreatWorks)
									DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: removed extra production yield from plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ")")
								end
								-- Faith
								local iNearbyPlotFaithYield = nearbyPlot:GetYield(yieldFaithID)
								local iNearbyPlotFaithNatureYield = nearbyPlot:CalculateNatureYield(yieldFaithID, pTeam, false)
								local iNearbyPlotFaithImprovementYield = nearbyPlot:CalculateImprovementYieldChange(improvementMonolithicChurchID, yieldFaithID, pPlayer)
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotFaithYield = " .. iNearbyPlotFaithYield .. "")
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotFaithNatureYield = " .. iNearbyPlotFaithNatureYield .. "")
								DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: iNearbyPlotFaithImprovementYield = " .. iNearbyPlotFaithImprovementYield .. "")
								if iNearbyPlotFaithYield == iNearbyPlotFaithNatureYield + iNearbyPlotFaithImprovementYield then
									Game.SetPlotExtraYield(nearbyPlot:GetX(), nearbyPlot:GetY(), yieldFaithID, -iNumGreatWorks)
									DMS_ZYPrint("DMS_ZY_MonolithicChurches_ExtraYields_New: removed extra faith yield from plot (" .. nearbyPlot:GetX() .. "," .. nearbyPlot:GetY() .. ")")
								end
							end
						end
					end
				else
				-- reduce yields of monolithic churches accordingly
				end
			end
		end
	end
end

if isEthiopiaZaraYaqobCivActive then
--	GameEvents.PlayerDoTurn.Add(DMS_ZY_MonolithicChurches_ExtraYields)
	GameEvents.PlayerDoTurn.Add(DMS_ZY_MonolithicChurches_ExtraYields_New)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_ZY_OnReligiousPressureFromWriters
----------------------------------------------------------------------------------------------------------------------------
local bWritersReligiousPressure = false

function DMS_ZY_OnReligiousPressureFromWriters(iPlayer, eGreatPersonType, eGreatPersonTypeCP)
	if eGreatPersonTypeCP then eGreatPersonType = eGreatPersonTypeCP end
	local pPlayer = Players[iPlayer]
	if eGreatPersonType == unitWriterID then
		if HasTrait(pPlayer, traitSeedOfJacobID) then
			bWritersReligiousPressure = true
			DMS_ZYPrint("DMS_ZY_OnReligiousPressureFromWriters: bWritersReligiousPressure = true..")
		end
	end
end

if isEthiopiaZaraYaqobCivActive then
	GameEvents.GreatPersonExpended.Add(DMS_ZY_OnReligiousPressureFromWriters)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_ZY_ReligiousPressureFromWriters
----------------------------------------------------------------------------------------------------------------------------
function DMS_ZY_ReligiousPressureFromWriters(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	if bWritersReligiousPressure == true then
		local pPlot = Map.GetPlot(iX, iY)
		if pPlot then
			DMS_ZYPrint("DMS_ZY_ReligiousPressureFromWriters: bWritersReligiousPressure = true, plot (" .. iX .. "," .. iY .. ")..")
			for pNearbyPlot in PlotAreaSweepIterator(pPlot, 4, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_INCLUDE) do
				if pNearbyPlot and pNearbyPlot:IsCity() then
					local pCity = pNearbyPlot:GetPlotCity()
					if pCity and pCity:GetOwner() == iPlayer then
						DMS_ZYPrint("DMS_ZY_ReligiousPressureFromWriters: found city of " .. pCity:GetName() .. " at plot (" .. pNearbyPlot:GetX() .. "," .. pNearbyPlot:GetY() .. ")..")
						local iNumPressureBuildings = pCity:GetNumRealBuilding(buildingReligiousPressureWriterID)
						pCity:SetNumRealBuilding(buildingReligiousPressureWriterID, iNumPressureBuildings + 1)

						if Players[iPlayer]:IsHuman() then
							Events.GameplayAlertMessage("Religious Pressure increased by [COLOR_POSITIVE_TEXT]+" .. 5 .. " [ENDCOLOR] in " .. pCity:GetName() .. "!");
						end

						DMS_ZYPrint("DMS_ZY_ReligiousPressureFromWriters: added religious pressure dummy building to city of " .. pCity:GetName() .. "..")
					end
				end
			end
		end
		
		bWritersReligiousPressure = false
		DMS_ZYPrint("DMS_ZY_ReligiousPressureFromWriters: bWritersReligiousPressure = false..")
	end
end

if isEthiopiaZaraYaqobCivActive then
	GameEvents.UnitPrekill.Add(DMS_ZY_ReligiousPressureFromWriters)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_ZY_CityDefenseFromTerrainFaith
----------------------------------------------------------------------------------------------------------------------------
function DMS_ZY_CityDefenseFromTerrainFaith(iPlayer)
    local pPlayer = Players[iPlayer]
    if HasTrait(pPlayer, traitSeedOfJacobID) then
		DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: iterating cities..")
        for pCity in pPlayer:Cities() do
            if pCity then
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: processessing for city of " .. pCity:GetName() .. "..")
                local iFaithFromTerrainAndImprovements = math.ceil(pCity:GetFaithPerTurn() - (pCity:GetFaithPerTurnFromBuildings() + pCity:GetFaithPerTurnFromPolicies() + pCity:GetFaithPerTurnFromReligion() + pCity:GetFaithPerTurnFromTraits()))
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: iFaithFromTerrainAndImprovements = math.ceil(pCity:GetFaithPerTurn() - (pCity:GetFaithPerTurnFromBuildings() + pCity:GetFaithPerTurnFromPolicies() + pCity:GetFaithPerTurnFromReligion() + pCity:GetFaithPerTurnFromTraits())..")
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: pCity:GetFaithPerTurn() = " .. pCity:GetFaithPerTurn() .. "..")
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: pCity:GetFaithPerTurnFromBuildings() = " .. pCity:GetFaithPerTurnFromBuildings() .. "..")
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: pCity:GetFaithPerTurnFromPolicies() = " .. pCity:GetFaithPerTurnFromPolicies() .. "..")
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: pCity:GetFaithPerTurnFromReligion() = " .. pCity:GetFaithPerTurnFromReligion() .. "..")
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: pCity:GetFaithPerTurnFromTraits() = " .. pCity:GetFaithPerTurnFromTraits() .. "..")
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: iFaithFromTerrainAndImprovements = " .. iFaithFromTerrainAndImprovements .. "..")
               
                if iFaithFromTerrainAndImprovements > 0 and iFaithFromTerrainAndImprovements <= 2 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 1)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 1 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 2 and iFaithFromTerrainAndImprovements <= 4 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 2)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 2 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 4 and iFaithFromTerrainAndImprovements <= 6 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 3)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 3 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 6 and iFaithFromTerrainAndImprovements <= 8 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 4)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 4 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 8 and iFaithFromTerrainAndImprovements <= 10 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 5)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 5 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 10 and iFaithFromTerrainAndImprovements <= 12 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 6)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 6 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 12 and iFaithFromTerrainAndImprovements <= 14 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 7)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 7 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 14 and iFaithFromTerrainAndImprovements <= 16 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 8)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 8 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 16 and iFaithFromTerrainAndImprovements <= 18 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 9)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 9 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 18 and iFaithFromTerrainAndImprovements <= 20 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 10)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 10 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 20 and iFaithFromTerrainAndImprovements <= 22 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 11)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 11 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 22 and iFaithFromTerrainAndImprovements <= 24 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 12)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 12 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 24 and iFaithFromTerrainAndImprovements <= 26 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 13)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 13 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 26 and iFaithFromTerrainAndImprovements <= 28 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 14)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 14 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 28 and iFaithFromTerrainAndImprovements <= 30 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 15)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 15 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 30 and iFaithFromTerrainAndImprovements <= 32 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 16)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 16 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 32 and iFaithFromTerrainAndImprovements <= 34 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 17)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 17 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 34 and iFaithFromTerrainAndImprovements <= 36 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 18)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 18 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 36 and iFaithFromTerrainAndImprovements <= 38 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 19)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 19 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                elseif iFaithFromTerrainAndImprovements > 38 then
                    pCity:SetNumRealBuilding(buildingDefenseFromFaithID, 20)
				DMS_ZYPrint("DMS_ZY_CityDefenseFromTerrainFaith: 20 buildingDefenseFromFaithID in " .. pCity:GetName() .. "..")
                end
            end
        end
    end
end

if isEthiopiaZaraYaqobCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_ZY_CityDefenseFromTerrainFaith)
end
--==========================================================================================================================
-- MAIN FUNCTIONS MENELIK
--==========================================================================================================================
-- DMS_MII_Sebastopol
----------------------------------------------------------------------------------------------------------------------------
function DMS_MII_Sebastopol(iPlayer, iUnit, iX, iY)
    local pPlayer = Players[iPlayer]
    local pUnit = pPlayer:GetUnitByID(iUnit)
    if pUnit and (pUnit:GetUnitType() == unitSebastopolID or pUnit:IsHasPromotion(promotionTewodrosLegacyID)) then
        local pPlot = Map.GetPlot(iX, iY)
        if pPlot and (pPlot:GetOwner() ~= -1 and pPlot:GetOwner() ~= iPlayer) then
			local bGGEffect = false
            if (not pUnit:IsHasPromotion(promotionGreatMortar1ID)) and (not pUnit:IsHasPromotion(promotionGreatMortar2ID)) and (not pUnit:IsHasPromotion(promotionGreatMortar3ID)) and (not pUnit:IsHasPromotion(promotionGreatMortar4ID)) and (not pUnit:IsHasPromotion(promotionGreatMortar5ID)) and (not pUnit:IsHasPromotion(promotionGreatMortarDepletedID)) then
                -- first turn in foreign territory
				DMS_MIIPrint("DMS_MII_Sebastopol: Sebastopol is in foreign territory and does not have any of the Great Mortar Promotions - grant it the first one..")
                pUnit:SetHasPromotion(promotionGreatMortar1ID, true)
				bGGEffect = true
			end
			if bGGEffect == true then
				DMS_MIIPrint("DMS_MII_Sebastopol: bGGEffect is true, then find units to grant movement to..")
				for pAdjPlot in PlotAreaSweepIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if pAdjPlot and pAdjPlot:IsUnit() then
						local iNumTileUnits = pAdjPlot:GetNumUnits()
						for i = 0, pAdjPlot:GetNumUnits() do
							local pAdjUnit = pAdjPlot:GetUnit(i)
							if pAdjUnit and pAdjUnit:IsCombatUnit() and pAdjUnit:GetOwner() == iPlayer then
								pAdjUnit:SetMoves(pAdjUnit:GetMoves() + 60)
								DMS_MIIPrint("DMS_MII_Sebastopol: found combat unit and added movement..")
							end
						end
					end
				end
			end
		elseif pPlot and (pPlot:GetOwner() == -1 or pPlot:GetOwner() == iPlayer) then
			if pUnit:IsHasPromotion(promotionGreatMortar1ID) or pUnit:IsHasPromotion(promotionGreatMortar2ID) or pUnit:IsHasPromotion(promotionGreatMortar3ID) or pUnit:IsHasPromotion(promotionGreatMortar4ID) or pUnit:IsHasPromotion(promotionGreatMortar5ID) or pUnit:IsHasPromotion(promotionGreatMortarDepletedID) then
				DMS_MIIPrint("DMS_MII_Sebastopol: Sebastopol is in neutral or friendly territory and has one of the Great Mortar Promotions - remove them..")
                pUnit:SetHasPromotion(promotionGreatMortar1ID, false)
                pUnit:SetHasPromotion(promotionGreatMortar2ID, false)
                pUnit:SetHasPromotion(promotionGreatMortar3ID, false)
                pUnit:SetHasPromotion(promotionGreatMortar4ID, false)
                pUnit:SetHasPromotion(promotionGreatMortar5ID, false)
                pUnit:SetHasPromotion(promotionGreatMortarDepletedID, false)
            end
        end
    end
end
 
if isEthiopiaMenelikCivActive then
	GameEvents.UnitSetXY.Add(DMS_MII_Sebastopol)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_MII_Sebastopol_PlayerDoTurn
----------------------------------------------------------------------------------------------------------------------------
function DMS_MII_Sebastopol_PlayerDoTurn(iPlayer)
    local pPlayer = Players[iPlayer]
	if pPlayer then
	for pUnit in pPlayer:Units() do
		local pPlot = pUnit:GetPlot()
		if pPlot and ((pUnit:IsHasPromotion(promotionGreatMortar1ID)) or (pUnit:IsHasPromotion(promotionGreatMortar2ID)) or (pUnit:IsHasPromotion(promotionGreatMortar3ID)) or (pUnit:IsHasPromotion(promotionGreatMortar4ID)) or (pUnit:IsHasPromotion(promotionGreatMortar5ID)) or (pUnit:IsHasPromotion(promotionGreatMortarDepletedID))) then
			DMS_MIIPrint("DMS_MII_Sebastopol_PlayerDoTurn: found Sebastopol with Great Mortar promotion, find units to grant movement to..")
				for pAdjPlot in PlotAreaSweepIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					if pAdjPlot and pAdjPlot:IsUnit() then
						local iNumTileUnits = pAdjPlot:GetNumUnits()
						for i = 0, pAdjPlot:GetNumUnits() do
							local pAdjUnit = pAdjPlot:GetUnit(i)
							if pAdjUnit and pAdjUnit:IsCombatUnit() and pAdjUnit:GetOwner() == iPlayer then
								pAdjUnit:SetMoves(pAdjUnit:GetMoves() + 60)
								DMS_MIIPrint("DMS_MII_Sebastopol_PlayerDoTurn: found combat unit and added movement..")
							end
						end
					end
				end
				if pUnit:IsHasPromotion(promotionGreatMortar1ID) then
					DMS_MIIPrint("DMS_MII_Sebastopol: Sebastopol has the first of the Great Mortar Promotions - grant it the second one and remove the first one..")
					pUnit:SetHasPromotion(promotionGreatMortar1ID, false)
					pUnit:SetHasPromotion(promotionGreatMortar2ID, true)
					bGGEffect = true
				elseif pUnit:IsHasPromotion(promotionGreatMortar2ID) then
					DMS_MIIPrint("DMS_MII_Sebastopol: Sebastopol has the second of the Great Mortar Promotions - grant it the third one and remove the second one..")
					pUnit:SetHasPromotion(promotionGreatMortar2ID, false)
					pUnit:SetHasPromotion(promotionGreatMortar3ID, true)
					bGGEffect = true
				elseif pUnit:IsHasPromotion(promotionGreatMortar3ID) then
					DMS_MIIPrint("DMS_MII_Sebastopol: Sebastopol has the third of the Great Mortar Promotions - grant it the fourth one and remove the third one..")
					pUnit:SetHasPromotion(promotionGreatMortar3ID, false)
					pUnit:SetHasPromotion(promotionGreatMortar4ID, true)
					bGGEffect = true
				elseif pUnit:IsHasPromotion(promotionGreatMortar4ID) then
					DMS_MIIPrint("DMS_MII_Sebastopol: Sebastopol has the fourth of the Great Mortar Promotions - grant it the fifth one and remove the fourth one..")
					pUnit:SetHasPromotion(promotionGreatMortar4ID, false)
					pUnit:SetHasPromotion(promotionGreatMortar5ID, true)
					bGGEffect = true
				elseif pUnit:IsHasPromotion(promotionGreatMortar5ID) then
					DMS_MIIPrint("DMS_MII_Sebastopol: Sebastopol has the fifth of the Great Mortar Promotions - grant it the depleted one and remove the fifth one..")
					pUnit:SetHasPromotion(promotionGreatMortar5ID, false)
					pUnit:SetHasPromotion(promotionGreatMortarDepletedID, true)
				end
			end
		end
    end
end
 
if isEthiopiaMenelikCivActive then
	GameEvents.PlayerDoTurn.Add(DMS_MII_Sebastopol_PlayerDoTurn)
end
--==========================================================================================================================
-- MAIN FUNCTIONS HAILE SELASSIE
--==========================================================================================================================
-- DMS_HS_PolicyCulture
----------------------------------------------------------------------------------------------------------------------------
function DMS_HS_PolicyCulture(iPlayer, ePolicy)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitLionOfJudahID) then
		DMS_HSPrint("DMS_HS_PolicyCulture: Haile Selassie adopted a policy..")
		local iNumCivsAdoptedPolicy = 0
		-- iterate through Major Civs to count number of civs having adopted the policy
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pOtherPlayer = Players[i]
			if pOtherPlayer and ((not pOtherPlayer:IsMinorCiv()) and (not pOtherPlayer:IsBarbarian())) then
				local pOtherPlayerCapital = pOtherPlayer:GetCapitalCity()
				if pOtherPlayerCapital then
					if (not HasTrait(pOtherPlayer, traitLionOfJudahID)) and pOtherPlayer:HasPolicy(ePolicy) then
						DMS_HSPrint("DMS_HS_PolicyCulture: " .. pOtherPlayer:GetCivilizationShortDescription() .. " has also adopted the policy..")
						iNumCivsAdoptedPolicy = iNumCivsAdoptedPolicy + 1
						DMS_HSPrint("DMS_HS_PolicyCulture: iNumCivsAdoptedPolicy = " .. iNumCivsAdoptedPolicy .. "..")
					end
				end
			end
		end
		if iNumCivsAdoptedPolicy > 0 then
			local iCulture = JFD_GetEraAdjustedValue(iPlayer, iNumCivsAdoptedPolicy * 5)
			DMS_HSPrint("DMS_HS_PolicyCulture: iCulture = " .. iCulture .. "..")

			pPlayer:ChangeJONSCulture(iCulture)
			DMS_HSPrint("DMS_HS_PolicyCulture: culture added..")
			local sSingularPlural = ""
			if iNumCivsAdoptedPolicy > 1 then
				sSingularPlural = "s"
			end
			local description = "You receive +" .. iCulture .. " [ICON_CULTURE] Culture since " .. iNumCivsAdoptedPolicy .. " Civilization" .. sSingularPlural .. " had already adopted the Social Policy."
			local descriptionShort = "Lion of Judah"
			JFD_SendNotification(iPlayer, 'NOTIFICATION_GENERIC', description, descriptionShort)
			DMS_HSPrint("DMS_HS_PolicyCulture: notification sent..")
		end
	end
end

if isEthiopiaHaileSelassieCivActive then
	GameEvents.PlayerAdoptPolicy.Add(DMS_HS_PolicyCulture)
	GameEvents.PlayerAdoptPolicyBranch.Add(DMS_HS_PolicyCulture)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_HS_FreeMakonnen
----------------------------------------------------------------------------------------------------------------------------
function DMS_HS_FreeMakonnen(iTeam, iTech, iChange)
	local pTeam = Teams[iTeam]
	if iTech == techFlightID then
		DMS_HSPrint("DMS_HS_FreeMakonnen: a civ researched flight..")
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pPlayer = Players[i]
			if HasTrait(pPlayer, traitLionOfJudahID) then
				if pPlayer:GetTeam() ~= iTeam then
					--if pPlayer:IsDoF()
					if (not Teams[pPlayer:GetTeam()]:IsAtWar(iTeam)) then
						DMS_HSPrint("DMS_HS_FreeMakonnen: Haile Selassie was not the one to research flight, continue..")
						local pCapital = pPlayer:GetCapitalCity()
						if pCapital then
							if (pPlayer:GetNumResourceAvailable(resourceOilID, true) > 0) then
								DMS_HSPrint("DMS_HS_FreeMakonnen: has " .. pPlayer:GetNumResourceAvailable(resourceOilID, true) .. " oil resource(s)..")
								pPlayer:InitUnit(unitMakonnenID, pCapital:Plot():GetX(), pCapital:Plot():GetY())
								DMS_HSPrint("DMS_HS_FreeMakonnen: free makonnen unit (oil version) added..")
								local description = "You receive a free Makonnen Unit in the Capital since another Civilization researched the Flight Technology."
								local descriptionShort = "Makonnen"
								JFD_SendNotification(pPlayer:GetID(), 'NOTIFICATION_GENERIC', description, descriptionShort)
							elseif (pPlayer:GetNumResourceAvailable(resourceOilID, true) == 0) then
								DMS_HSPrint("DMS_HS_FreeMakonnen: has 0 oil resources..")
								pPlayer:InitUnit(unitMakonnenNoOilID, pCapital:Plot():GetX(), pCapital:Plot():GetY())
								DMS_HSPrint("DMS_HS_FreeMakonnen: free makonnen unit (no oil version) added..")
								local description = "You receive a free Makonnen Unit in the Capital since another Civilization researched the Flight Technology."
								local descriptionShort = "Makonnen"
								JFD_SendNotification(pPlayer:GetID(), 'NOTIFICATION_GENERIC', description, descriptionShort)
							end
						end
					end
				end
			end
		end
	end
end

if isEthiopiaHaileSelassieCivActive then
	GameEvents.TeamTechResearched.Add(DMS_HS_FreeMakonnen)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_HS_Kagnew
----------------------------------------------------------------------------------------------------------------------------
function DMS_HS_Kagnew(iPlayer, iUnit, iX, iY)
    local pPlayer = Players[iPlayer]
    if pPlayer then
        local pUnit = pPlayer:GetUnitByID(iUnit)
        if pUnit and pUnit:IsHasPromotion(promotionZebenyaID) then
			local pPlot = Map.GetPlot(iX, iY)
            if pPlot then
				DMS_HSPrint("DMS_HS_Kagnew: Kagnew or upgraded unit at plot (" .. iX .. "," .. iY .. ")..")
                local iPlotOwner = pPlot:GetOwner()
                if iPlotOwner then
                    if iPlotOwner ~= -1 or iPlotOwner ~= iPlayer then
						DMS_HSPrint("DMS_HS_Kagnew: plot (" .. iX .. "," .. iY .. ") is neither friendly or neutral..")
						local pPlotPlayer = Players[iPlotOwner]
						if pPlotPlayer and Teams[pPlotPlayer:GetTeam()]:IsAtWar(pPlayer:GetTeam()) then
							DMS_HSPrint("DMS_HS_Kagnew: is at war with " .. pPlotPlayer:GetCivilizationShortDescription() .. " (plot owner); find other civs at war with plot owner..")
							local iNumEnemies = 0
							-- iterate through Major Civs to count number of civs at war with plotOwner besides you
							for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
								local pOtherPlayer = Players[i]
								if pOtherPlayer and ((not pOtherPlayer:IsMinorCiv()) and (not pOtherPlayer:IsBarbarian())) then
									if Teams[pPlotPlayer:GetTeam()]:IsAtWar(pOtherPlayer:GetTeam()) then
										DMS_HSPrint("DMS_HS_Kagnew: " .. pPlotPlayer:GetCivilizationShortDescription() .. " is also at war with " .. pPlotPlayer:GetCivilizationShortDescription() .. " (plot owner)..")
										if (iPlayer ~= i) then
											iNumEnemies = iNumEnemies + 1
											DMS_HSPrint("DMS_HS_Kagnew: iNumEnemies = " .. iNumEnemies .. "..")
										end
									end
								end
							end
							if iNumEnemies == 0 then
								pUnit:SetHasPromotion(promotionZebenyaStrength1ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength2ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength3ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength4ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength5ID, false)
								DMS_HSPrint("DMS_HS_Kagnew: iNumEnemies = " .. iNumEnemies .. ", all promotions removed..")
							elseif iNumEnemies == 1 then
								pUnit:SetHasPromotion(promotionZebenyaStrength1ID, true)
								pUnit:SetHasPromotion(promotionZebenyaStrength2ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength3ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength4ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength5ID, false)
								DMS_HSPrint("DMS_HS_Kagnew: iNumEnemies = " .. iNumEnemies .. ", promotions 1 added, others removed..")
							elseif iNumEnemies == 2 then
								pUnit:SetHasPromotion(promotionZebenyaStrength2ID, true)
								pUnit:SetHasPromotion(promotionZebenyaStrength1ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength3ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength4ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength5ID, false)
								DMS_HSPrint("DMS_HS_Kagnew: iNumEnemies = " .. iNumEnemies .. ", promotions 2 added, others removed..")
							elseif iNumEnemies == 3 then
								pUnit:SetHasPromotion(promotionZebenyaStrength3ID, true)
								pUnit:SetHasPromotion(promotionZebenyaStrength1ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength2ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength4ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength5ID, false)
								DMS_HSPrint("DMS_HS_Kagnew: iNumEnemies = " .. iNumEnemies .. ", promotions 3 added, others removed..")
							elseif iNumEnemies == 4 then
								pUnit:SetHasPromotion(promotionZebenyaStrength4ID, true)
								pUnit:SetHasPromotion(promotionZebenyaStrength1ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength2ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength3ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength5ID, false)
								DMS_HSPrint("DMS_HS_Kagnew: iNumEnemies = " .. iNumEnemies .. ", promotions 4 added, others removed..")
							elseif iNumEnemies >= 5 then
								pUnit:SetHasPromotion(promotionZebenyaStrength5ID, true)
								pUnit:SetHasPromotion(promotionZebenyaStrength1ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength2ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength3ID, false)
								pUnit:SetHasPromotion(promotionZebenyaStrength4ID, false)
								DMS_HSPrint("DMS_HS_Kagnew: iNumEnemies = " .. iNumEnemies .. ", promotions 5 added, others removed..")
							end
						else -- not at war
							pUnit:SetHasPromotion(promotionZebenyaStrength1ID, false)
							pUnit:SetHasPromotion(promotionZebenyaStrength2ID, false)
							pUnit:SetHasPromotion(promotionZebenyaStrength3ID, false)
							pUnit:SetHasPromotion(promotionZebenyaStrength4ID, false)
							pUnit:SetHasPromotion(promotionZebenyaStrength5ID, false)
							DMS_HSPrint("DMS_HS_Kagnew: is not at war, promotions removed..")
						end
					else -- in neutral or owned territory
						pUnit:SetHasPromotion(promotionZebenyaStrength1ID, false)
						pUnit:SetHasPromotion(promotionZebenyaStrength2ID, false)
						pUnit:SetHasPromotion(promotionZebenyaStrength3ID, false)
						pUnit:SetHasPromotion(promotionZebenyaStrength4ID, false)
						pUnit:SetHasPromotion(promotionZebenyaStrength5ID, false)
						DMS_HSPrint("DMS_HS_Kagnew: is not in foreign territory, promotions removed..")
					end
                end
            end
        end
    end
end

if isEthiopiaHaileSelassieCivActive then
	GameEvents.UnitSetXY.Add(DMS_HS_Kagnew)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_HS_DelegateFromIdeologicalTenets
----------------------------------------------------------------------------------------------------------------------------
function DMS_HS_DelegateFromIdeologicalTenets(iPlayer, ePolicy)
	local pPlayer = Players[iPlayer]
	if HasTrait(pPlayer, traitLionOfJudahID) then
        local policyLevel = GameInfo.Policies[ePolicy].Level
		DMS_HSPrint("DMS_HS_DelegateFromIdeologicalTenets: Haile Selassie adopted a policy/tenet..")
        if policyLevel == 2 or policyLevel == 3 then
			DMS_HSPrint("DMS_HS_DelegateFromIdeologicalTenets: tenet is of level " .. policyLevel .. "..")
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				local iNumDelegatesFromTenets = pCapital:GetNumRealBuilding(buildingDelegateIdeologicalTenetID)
				DMS_HSPrint("DMS_HS_DelegateFromIdeologicalTenets: already granted " .. iNumDelegatesFromTenets .. " delegates from level 2/3 tenet(s)..")

				pCapital:SetNumRealBuilding(buildingDelegateIdeologicalTenetID, iNumDelegatesFromTenets + 1)
				DMS_HSPrint("DMS_HS_DelegateFromIdeologicalTenets: granting one more..")
			end
		end
    end
end

if isEthiopiaHaileSelassieCivActive then
	GameEvents.PlayerAdoptPolicy.Add(DMS_HS_DelegateFromIdeologicalTenets)
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_HS_CaptitalCaptured
----------------------------------------------------------------------------------------------------------------------------
function DMS_HS_CaptitalCaptured(iOldPlayer, bCapital, iX, iY, iNewPlayer, conquest, conquest2)
	local pOldPlayer = Players[iOldPlayer]
	local pNewPlayer = Players[iNewPlayer]
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	-- move dummy buildings to new capital
	if pCity then
		if HasTrait(pOldPlayer, traitLionOfJudahID) and pOldPlayer:GetCapitalCity() == pCity then
			local iNumDelegatesFromTenets = pCity:GetNumRealBuilding(buildingDelegateIdeologicalTenetID)
			if (iNumDelegatesFromTenets > 0) then
				pCity:SetNumRealBuilding(buildingDelegateIdeologicalTenetID, 0)
				if (pOldPlayer:IsAlive()) then
					pOldPlayer:GetCapitalCity():SetNumRealBuilding(buildingDelegateIdeologicalTenetID, iNumDelegatesFromTenets)
				end
			end
		end
		-- moved dummy buildings to recaptured capital
		local pCapital = pNewPlayer:GetCapitalCity()
		if pCapital then
			if pCapital:GetID() == pCity:GetID() then
				for pCitytoRemove in pNewPlayer:Cities() do
					if pCitytoRemove:GetID() ~= pCity:GetID() and pCitytoRemove:IsHasBuilding(buildingDelegateIdeologicalTenetID) then
						local iNumDelegatesFromTenets = pCity:GetNumRealBuilding(buildingDelegateIdeologicalTenetID)
						pCity:SetNumRealBuilding(buildingDelegateIdeologicalTenetID, iNumDelegatesFromTenets)
						pCitytoRemove:SetNumRealBuilding(buildingDelegateIdeologicalTenetID, 0)
					end
				end
			end
		end
	end
end

if isEthiopiaHaileSelassieCivActive then
	GameEvents.CityCaptureComplete.Add(DMS_HS_CaptitalCaptured)
end
--==========================================================================================================================
-- UI FUNCTIONS (AKSUM)
--==========================================================================================================================
--Globals
----------------------------------------------------------------------------------------------------------------------------
local isCityViewOpen						= false
----------------------------------------------------------------------------------------------------------------------------
-- DMS_UpdateBuyTradeRouteSlotWithFaith
----------------------------------------------------------------------------------------------------------------------------
function DMS_UpdateBuyTradeRouteSlotWithFaith()
	Controls.TradeRouteSlotBackground:SetHide(true)
	Controls.TradeRouteSlotImage:SetHide(true)
	Controls.TradeRouteSlotButton:SetDisabled(true)
	Controls.TradeRouteSlotButton:LocalizeAndSetToolTip(nil)
	local pCity = UI.GetHeadSelectedCity()
	if pCity and (not pCity:IsPuppet()) then
		local iPlayer = pCity:GetOwner()
		local pPlayer = Players[iPlayer]
		if HasTrait(pPlayer, traitSaintElesbaanID) then 
			DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith called..")
			Controls.TradeRouteSlotBackground:SetHide(false)
		
			local faithProgress = pPlayer:GetFaith()
			DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith: faithProgress = " .. faithProgress .. "..")
			DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith: calling DMS_GetTradeRouteSlotCost..")
			local faithCost = DMS_GetTradeRouteSlotCost(pPlayer)
			DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith: faithCost = " .. faithCost .. "..")
			local buttonText = Locale.ConvertTextKey("TXT_KEY_TRAIT_DMS_AKSUM_BUY_TRADE_ROUTE_SLOT_WITH_FAITH", faithProgress, faithCost)
			DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith: calling DMS_CanBuyMoreTradeRouteSlots..")
			local bCanBuyMoreTradeRouteSlots = DMS_CanBuyMoreTradeRouteSlots(pPlayer)
			local sMaxedTradeSlots = "[NEWLINE][NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]You have already purchased the current maximal number of Trade Route slots.[ENDCOLOR]"
			local sNotEnoughFaith = "[NEWLINE][NEWLINE][ICON_BULLET][COLOR_NEGATIVE_TEXT]You do not have enough [ICON_PEACE] Faith to purchase an additional Trade Route slot.[ENDCOLOR]"
			if (faithProgress < faithCost) or (bCanBuyMoreTradeRouteSlots == false) then
				DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith: (faithProgress < faithCost) or (bCanBuyMoreTradeRouteSlots == false)..")
				if (faithProgress < faithCost) and (bCanBuyMoreTradeRouteSlots == false) then
					DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith: (faithProgress < faithCost) and (bCanBuyMoreTradeRouteSlots == false)..")
					local buttonToolTipDisabled = Locale.ConvertTextKey("TXT_KEY_TRAIT_DMS_AKSUM_BUY_TRADE_ROUTE_SLOT_WITH_FAITH_HELP_DISABLED_2", sMaxedTradeSlots, sNotEnoughFaith)
					Controls.TradeRouteSlotButton:SetText(buttonText)
					Controls.TradeRouteSlotButton:LocalizeAndSetToolTip(buttonToolTipDisabled)
				elseif (faithProgress >= faithCost) and (bCanBuyMoreTradeRouteSlots == false) then
					DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith: (faithProgress >= faithCost) and (bCanBuyMoreTradeRouteSlots == false)..")
					sNotEnoughFaith = ""
					local buttonToolTipDisabled = Locale.ConvertTextKey("TXT_KEY_TRAIT_DMS_AKSUM_BUY_TRADE_ROUTE_SLOT_WITH_FAITH_HELP_DISABLED_2", sMaxedTradeSlots, sNotEnoughFaith)
					Controls.TradeRouteSlotButton:SetText(buttonText)
					Controls.TradeRouteSlotButton:LocalizeAndSetToolTip(buttonToolTipDisabled)
				elseif (faithProgress < faithCost) and (bCanBuyMoreTradeRouteSlots == true) then
					DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith: (faithProgress < faithCost) and (bCanBuyMoreTradeRouteSlots == true)..")
					sMaxedTradeSlots = ""
					local buttonToolTipDisabled = Locale.ConvertTextKey("TXT_KEY_TRAIT_DMS_AKSUM_BUY_TRADE_ROUTE_SLOT_WITH_FAITH_HELP_DISABLED_1", sMaxedTradeSlots, sNotEnoughFaith)
					Controls.TradeRouteSlotButton:SetText(buttonText)
					Controls.TradeRouteSlotButton:LocalizeAndSetToolTip(buttonToolTipDisabled)
				end
			elseif (faithProgress >= faithCost) and (bCanBuyMoreTradeRouteSlots == true) then
				DMS_AksumPrint("DMS_UpdateBuyTradeRouteSlotWithFaith: (faithProgress >= faithCost) and (bCanBuyMoreTradeRouteSlots == true)..")
				local buttonToolTip = Locale.ConvertTextKey("TXT_KEY_TRAIT_DMS_AKSUM_BUY_TRADE_ROUTE_SLOT_WITH_FAITH_HELP")
				Controls.TradeRouteSlotButton:SetText(buttonText)
				Controls.TradeRouteSlotButton:SetDisabled(false)
				Controls.TradeRouteSlotButton:LocalizeAndSetToolTip(buttonToolTip)
			end
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- DMS_OnBuyTradeRouteSlotWithFaith
----------------------------------------------------------------------------------------------------------------------------
function DMS_OnBuyTradeRouteSlotWithFaith()
	local pCity = UI.GetHeadSelectedCity();
	if pCity then
		local iPlayer = pCity:GetOwner()
		local pPlayer = Players[iPlayer]
		local pCapital = pPlayer:GetCapitalCity()
		local faithProgress = pPlayer:GetFaith()
		DMS_AksumPrint("DMS_OnBuyTradeRouteSlotWithFaith: faithProgress =  " .. faithProgress .. "..")
		DMS_AksumPrint("DMS_OnBuyTradeRouteSlotWithFaith: calling DMS_GetTradeRouteSlotCost..")
		local faithCost = DMS_GetTradeRouteSlotCost(pPlayer)
		DMS_AksumPrint("DMS_OnBuyTradeRouteSlotWithFaith: faithCost = " .. faithCost .. "..")
		local iNumTradeRouteSlotsPurchased = pCapital:GetNumRealBuilding(buildingTradeRouteSlotDummyID)
		DMS_AksumPrint("DMS_OnBuyTradeRouteSlotWithFaith: iNumTradeRouteSlotsPurchased = " .. iNumTradeRouteSlotsPurchased .. "..")

		pPlayer:ChangeFaith(-faithCost)
		DMS_AksumPrint("DMS_OnBuyTradeRouteSlotWithFaith: Purchased TR slot for " .. faithCost .. " Faith..")
		pCapital:SetNumRealBuilding(buildingTradeRouteSlotDummyID, iNumTradeRouteSlotsPurchased + 1)
		DMS_AksumPrint("DMS_OnBuyTradeRouteSlotWithFaith: capital now has " .. pCapital:GetNumRealBuilding(buildingTradeRouteSlotDummyID) .. " dummy building(s)..")

	end
	DMS_UpdateBuyTradeRouteSlotWithFaith()
end
Controls.TradeRouteSlotButton:RegisterCallback(Mouse.eLClick, DMS_OnBuyTradeRouteSlotWithFaith)
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnEnterCityScreen
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnEnterCityScreen()
	isCityViewOpen = true
	DMS_UpdateBuyTradeRouteSlotWithFaith()
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnExitCityScreen
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnExitCityScreen()
	isCityViewOpen = false
	DMS_UpdateBuyTradeRouteSlotWithFaith()
end
----------------------------------------------------------------------------------------------------------------------------
-- JFD_OnNextCityScren
----------------------------------------------------------------------------------------------------------------------------
function JFD_OnNextCityScren()
	if isCityViewOpen then
		DMS_UpdateBuyTradeRouteSlotWithFaith()
	end
end

if (isAksumKalebCivActive and isAksumKalebActivePlayer) then
	Events.SerialEventEnterCityScreen.Add(JFD_OnEnterCityScreen)
	Events.SerialEventExitCityScreen.Add(JFD_OnExitCityScreen)
	Events.SerialEventCityScreenDirty.Add(JFD_OnNextCityScren)
end
--==========================================================================================================================
--==========================================================================================================================