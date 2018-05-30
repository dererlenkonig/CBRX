--Murri Decisions
 
--Hold a Bunya Feast
--The Bunya Nuts have begun falling around the Capital! We should hold a tribal gathering to enjoy them once more!
--
--Requirements:
--> Player must be the Murri
--> Capital must be working Forest
--> May only be enacted once per era
--
--Costs:
--> 300 Faith
--
--Rewards:
--> A We Love the King Day begins in the Capital and all cities with a City Connection
--> Border expansion increased by 100% in cities with a City Connection for 10 Turns
 
 
 
function isWorkingForest(pCity)
    for pCity in pPlayer:Cities() do
        for pCityPlot = 0, pCity:GetNumCityPlots() - 1, 1 do
            local pSpecificPlot = pCity:GetCityIndexPlot(pCityPlot)
            if pSpecificPlot ~= nil then
                if pCity:IsWorkingPlot(pSpecificPlot) then
                    if pSpecificPlot:GetFeatureType() == FeatureTypes.FEATURE_FOREST then
                        return true
                    end
                end
            end
        end
    end
    return false
end
 
local Decisions_CLMURRI_BUNYA = {}
print('Decisions_CLMURRI_BUNYA loaded')
Decisions_CLMURRI_BUNYA.Name = 'Hold a Bunya Feast'
Decisions_CLMURRI_BUNYA.Desc = '"The Bunya Nuts have begun falling around the Capital! We should hold a tribal gathering to enjoy them once more![NEWLINE][NEWLINE]Requirements:[NEWLINE][ICON_BULLET]Player must be the Murri[NEWLINE][ICON_BULLET]Your [ICON_CAPITAL] Capital must be working a tile with Forest[NEWLINE][ICON_BULLET]Can be enacted once per Era[NEWLINE][NEWLINE]Costs:[NEWLINE][ICON_BULLET]300 [ICON_PEACE] Faith[NEWLINE][NEWLINE]Rewards: [NEWLINE][ICON_BULLET]A "We Love the King" Day begins in the [ICON_CAPITAL] Capital and all cities with a [ICON_CONNECTED] City Connection.[NEWLINE][ICON_BULLET]Border expansion increases by 100% in cities with a city connection for 10 turns.'
HookDecisionCivilizationIcon(Decisions_CLMURRI_BUNYA, 'CIVILIZATION_CL_MURRI')
Decisions_CLMURRI_BUNYA.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_CL_MURRI then
            return false, false
        end
        if load(pPlayer, 'Decisions_CLMURRI_BUNYA') == true then
            Decisions_CLMURRI_BUNYA.Desc = '"The Bunya Nuts have begun falling around the Capital! We should hold a tribal gathering to enjoy them once more![NEWLINE][NEWLINE]Rewards: [NEWLINE][ICON_BULLET]A "We Love the King" Day begins in the [ICON_CAPITAL] Capital and all cities with a [ICON_CONNECTED] City Connection.[NEWLINE][ICON_BULLET]Border expansion increases by 100% in cities with a city connection for 10 turns.'
            return false, false, true
        end
        local pCap = pPlayer:GetCapitalCity()
        if pCap == nil then
            return true, false
        end
        if isWorkingForest(pCap) == false then
            return true, false
        end
        return true, true
    end
)
Decisions_CLMURRI_BUNYA.DoFunc = (
    function(pPlayer)
        pPlayer:ChangeFaith(-300)
        for pCity in pPlayer:Cities() do
            if pCity:IsCapital() or pPlayer:IsCapitalConnectedToCity(pCity) then
                local WLKD = pCity:GetWeLoveTheKingDayCounter()
                if WLKD == 0 then
                    pCity:SetWeLoveTheKingDayCounter(10)
                else
                    pCity:ChangeWeLoveTheKingDayCounter(WLKD + 10)
                end
                pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_CLMURRI_BUNYAWIDGET, 1)
                save(pCity, "BunyaLength", 10)
            end
        end
        save(pPlayer, 'Decisions_CLMURRI_BUNYA', true)
    end
)
 
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_CL_MURRI, 'Decisions_CLMURRI_BUNYA', Decisions_CLMURRI_BUNYA)
 
function BunyaDo(playerId)
    local pPlayer = Players[playerId]
    for pCity in pPlayer:Cities() do
        local BunyaTime = load(pCity, "BunyaLength")
        if BunyaTime ~= nil then
            if BunyaTime == 0 then
                pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_CLMURRI_BUNYAWIDGET, 0)
                save(pCity, "BunyaLength", nil)
            else
                save(pCity, "BunyaLength", BunyaTime - 1)
            end
        end
    end
end
GameEvents.PlayerDoTurn.Add(BunyaDo)
 
function BunyaReset(iTeam)
    for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
        local pPlayer = Players[iPlayer]
        if pPlayer:GetTeam() == iTeam then
            if load(pPlayer, 'Decisions_CLMURRI_BUNYA') == true then
                save(pPlayer, 'Decisions_CLMURRI_BUNYA', nil)
            end
        end
    end
end
GameEvents.TeamSetEra.Add(BunyaReset)
 
----------------------------------------------
--Carve a Burial Tree
--A person of great importance is no longer with us! We should carve a Burial Tree in their honour!
--
--Requirements:
--> Player must be the Murri
--> Must have at least one unimproved Forest within your borders
--> Must have expended a Great Person in the last five turns
--
--Costs:
--> 300 Gold
--> 300 Culture
--
--Rewards:
--> 300 Faith
--> Forest tiles claim adjacent (neutral) tiles
 
function PlayerHasUnimprovedForest(playerId)
    for plotLoop = 0, Map.GetNumPlots() - 1, 1 do
        local pPlot = Map.GetPlotByIndex(plotLoop)
        if pPlot:GetOwner() == playerId then
            if pPlot:GetFeatureType() == FeatureTypes.FEATURE_FOREST and pPlot:GetImprovementType() == -1 then
                return true
            end
        end
    end
    return false
end
 
local Decisions_CLMURRI_BURIALTREE = {}
print('Decisions_CLMURRI_BURIALTREE loaded')
Decisions_CLMURRI_BURIALTREE.Name = 'Carve a Burial Tree'
Decisions_CLMURRI_BURIALTREE.Desc = '"A person of great importance is no longer with us! We should carve a Burial Tree in their honour!"[NEWLINE][NEWLINE]Requirements:[NEWLINE][ICON_BULLET]Player must be the Murri[NEWLINE][ICON_BULLET]Player must have at least one unimproved forest tile within their borders[NEWLINE][ICON_BULLET]Player must have expended a Great Person in the last 5 turns[NEWLINE][NEWLINE]Costs:[NEWLINE][ICON_BULLET]300 [ICON_GOLD] Gold[NEWLINE][ICON_BULLET]300 [ICON_CULTURE] Culture[NEWLINE][NEWLINE]Rewards:[NEWLINE][ICON_BULLET]300 [ICON_PEACE] Faith[NEWLINE][ICON_BULLET]Your Forest tiles claim adjacent neutral tiles.'
HookDecisionCivilizationIcon(Decisions_CLMURRI_BURIALTREE, 'CIVILIZATION_CL_MURRI')
Decisions_CLMURRI_BURIALTREE.CanFunc = (
    function(pPlayer)
        if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_CL_MURRI then
            return false, false
        end
        local pCap = pPlayer:GetCapitalCity()
        if pCap == nil then
            return true, false
        end
        if PlayerHasUnimprovedForest(pPlayer:GetID()) == false then
            return true, false
        end
        if pPlayer:GetGold() < 300 then
            return true, false
        end
        if pPlayer:GetJONSCulture() < 300 then
            return true, false
        end
        if load(pPlayer, "GreatPersonMourning") == nil then
            return true, false
        end
        return true, true
    end
)
Decisions_CLMURRI_BURIALTREE.DoFunc = (
    function(pPlayer)
        pPlayer:ChangeGold(-300)
        pPlayer:ChangeJONSCulture(-300)
        pPlayer:ChangeFaith(300)
        save(pPlayer, "GreatPersonMourning", nil)
        for plotLoop = 0, Map.GetNumPlots() - 1, 1 do
            local pPlot = Map.GetPlotByIndex(plotLoop)
            if pPlot:GetOwner() == playerId then
                if pPlot:GetFeatureType() == FeatureTypes.FEATURE_FOREST then
                    for i = 0, 5 do
                        local pAdj = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), i);
                        if pAdj:GetOwner() == -1 then
                            pAdj:SetOwner(player)
                        end
                    end
                end
            end
        end
    end
)
 
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_CL_MURRI, 'Decisions_CLMURRI_BURIALTREE', Decisions_CLMURRI_BURIALTREE)
 
function BurialTreeDo(playerId)
    local pPlayer = Players[playerId]
    local MourningTime = load(pCity, "GreatPersonMourning")
    if MourningTime ~= nil then
        if MourningTime == 0 then
            save(pCity, "GreatPersonMourning", nil)
        else
            save(pCity, "GreatPersonMourning", MourningTime - 1)
        end
    end
end
GameEvents.PlayerDoTurn.Add(BurialTreeDo)