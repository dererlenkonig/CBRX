--=======================================================================================================================
-- UTILITIES
--=======================================================================================================================
-- JFD_SendWorldEvent
------------------------------------------------------------------------------------------------------------------------
include("PlotIterators")
function JFD_SendWorldEvent(playerID, description)
    local player = Players[playerID]
    local playerTeam = Teams[player:GetTeam()]
    local activePlayer = Players[Game.GetActivePlayer()]
    if not (player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
        Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
    end
end
--=======================================================================================================================
-- Civ Specific Decisions
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
local buildingKoreanExaminationID = GameInfoTypes["BUILDING_SENSHI_KOREAN_EXAMINATION"]
local promotionKoreanFortressID = GameInfoTypes["PROMOTION_CL_DIVIDEDATTENTION"]
local policyFortsID = GameInfoTypes["POLICY_KOREAN_FORTRESS"]
local civilisationID = GameInfoTypes["CIVILIZATION_SENSHI_KOREA"]
local techCivilServiceID = GameInfoTypes["TECH_CIVIL_SERVICE"]
local eraReinassanceID = GameInfoTypes["ERA_RENAISSANCE"]
local mathCeil = math.ceil
--------------------------------------------------------------------------------------------------------------------------
-- Seonjo: Reform the Civil Examination System
-------------------------------------------------------------------------------------------------------------------------
local Decisions_KoreaCivilExamination = {}
    Decisions_KoreaCivilExamination.Name = "TXT_KEY_DECISIONS_KOREA_CIVIL_EXAMINATION_REFORMS"
    Decisions_KoreaCivilExamination.Desc = "TXT_KEY_DECISIONS_KOREA_CIVIL_EXAMINATION_REFORMS_DESC"
    HookDecisionCivilizationIcon(Decisions_KoreaCivilExamination, "CIVILIZATION_SENSHI_KOREA")
    Decisions_KoreaCivilExamination.CanFunc = (
    function(player)
        if player:GetCivilizationType() ~= civilisationID then return false, false end
        if load(player, "Decisions_KoreaCivilExamination") == true then
            Decisions_KoreaCivilExamination.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KOREA_CIVIL_EXAMINATION_REFORMS_ENACTED_DESC")
            return false, false, true
        end
       
       
        local goldCost = mathCeil(750 * iMod)
        if player:GetNumResourceAvailable(iMagistrate, false) < 2       then return true, false end
        Decisions_KoreaCivilExamination.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KOREA_CIVIL_EXAMINATION_REFORMS_DESC", goldCost)
        if player:GetGold() < goldCost                                  then return true, false end
        if (not Teams[player:GetTeam()]:IsHasTech(techCivilServiceID))  then return true, false end
 
 
        return true, true
    end
    )
   
    Decisions_KoreaCivilExamination.DoFunc = (
    function(player)
        local goldCost = mathCeil(750 * iMod)
        local capital = player:GetCapitalCity()
        player:ChangeGold(-goldCost)
        player:ChangeNumResourceTotal(iMagistrate, -2)
        capital:SetNumRealBuilding(buildingKoreanExaminationID, 1)
        JFD_SendWorldEvent(player:GetID(), Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_KOREA_CIVIL_EXAMINATION_REFORMS"))
        save(player, "Decisions_KoreaCivilExamination", true)
    end
    )
   
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_SENSHI_KOREA"], "Decisions_KoreaCivilExamination", Decisions_KoreaCivilExamination)
-------------------------------------------------------------------------------------------------------------------------
-- Seonjo: Rush Fort Construction
-------------------------------------------------------------------------------------------------------------------------
local Decisions_KoreaNavalFortress = {}
    Decisions_KoreaNavalFortress.Name = "TXT_KEY_DECISIONS_KOREA_FORT_CONSTRUCTION"
    Decisions_KoreaNavalFortress.Desc = "TXT_KEY_DECISIONS_KOREA_FORT_CONSTRUCTION_DESC"
    HookDecisionCivilizationIcon(Decisions_KoreaNavalFortress, "CIVILIZATION_SENSHI_KOREA")
    Decisions_KoreaNavalFortress.CanFunc = (
    function(player)
        if player:GetCivilizationType() ~= civilisationID then return false, false end
        if load(player, "Decisions_KoreaNavalFortress") == true then
            Decisions_KoreaNavalFortress.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KOREA_FORT_CONSTRUCTION_ENACTED_DESC")
            return false, false, true
        end
       
        local goldCost = mathCeil(400 * iMod)
        Decisions_KoreaNavalFortress.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_KOREA_FORT_CONSTRUCTION_DESC", goldCost)
        if player:GetNumResourceAvailable(iMagistrate, false) < 1   then return true, false end
        if player:GetGold() < goldCost                              then return true, false end
        if player:GetCurrentEra() < eraReinassanceID                then return true, false end
       
        return true, true
    end
    )
   
    Decisions_KoreaNavalFortress.DoFunc = (
    function(player)
        local goldCost = mathCeil(400 * iMod)
        player:ChangeGold(-goldCost)
        player:ChangeNumResourceTotal(iMagistrate, -1)
        player:SetNumFreePolicies(1)
        player:SetNumFreePolicies(0)
        player:SetHasPolicy(policyFortsID, true)
 
        JFD_SendWorldEvent(player:GetID(), Locale.ConvertTextKey("TXT_KEY_WORLD_EVENT_KOREA_FORT_CONSTRUCTION"))
        save(player, "Decisions_KoreaNavalFortress", true)
    end
    )
   
    Decisions_KoreaNavalFortress.Monitors = {}
    Decisions_KoreaNavalFortress.Monitors[GameEvents.UnitSetXY] =  (
    function(playerID, unitID, unitX, unitY)
        local player = Players[playerID]
        local nearbyFort = false
        local unit = player:GetUnitByID(unitID)
        if player:HasPolicy(policyFortsID) then
			--print("Player has policy")
            if (unit and (unit:GetUnitCombatType() == GameInfoTypes["UNITCOMBAT_NAVALRANGED"] or unit:GetUnitCombatType() == GameInfoTypes["UNITCOMBAT_NAVALMELEE"])) then
                --for i = 0, Map.GetNumPlots() - 1, 1 do
                  --local plot = Map.GetPlotByIndex(i)
				--print("Unitcombat valid")
				local pPlot = Map.GetPlot(unitX, unitY)
				for plot in PlotAreaSpiralIterator(pPlot, 2, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
					--print("Checking plot")
                    if plot:GetImprovementType() == GameInfoTypes["IMPROVEMENT_FORT"] or plot:GetImprovementType() == GameInfoTypes["IMPROVEMENT_CITADEL"] then
						--print("Fort found")
                        if plot:GetOwner() == playerID then
							--print("friendly")
                           nearbyFort = true
                        end
                    end
                end
			end
			--print("nearbyFort = ", nearbyFort)
            if nearbyFort then
                if (not unit:IsHasPromotion(promotionKoreanFortressID)) then
                    unit:SetHasPromotion(promotionKoreanFortressID, true)
                end
            else
                if unit:IsHasPromotion(promotionKoreanFortressID) then
                    unit:SetHasPromotion(promotionKoreanFortressID, false)
                end
            end
        end
	end
	)
 
    --end
    --)
   
Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_SENSHI_KOREA"], "Decisions_KoreaNavalFortress", Decisions_KoreaNavalFortress)
--=======================================================================================================================
--=======================================================================================================================