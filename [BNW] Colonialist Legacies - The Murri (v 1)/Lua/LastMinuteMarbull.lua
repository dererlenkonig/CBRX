local function CheckEmb(pPlayer, playerId)
    -- check if pPlayer has an embassy owned by the player identified by playerId
 
    if playerId == -1 then
        -- not a player
        return false
    end
 
    local pHost = Players[playerId]
    if pHost == pPlayer then
        -- don't bother with checking a player's own stuff
        return false
    end
 
    -- does pPlayer have an embassy with pHost?
    return Teams[pPlayer:GetTeam()]:HasEmbassyAtTeam(pHost:GetTeam())
end
 
local function TestBorders(playerId, unit)
-- KNOWN PROBLEM: Consider the case when two different enemy civilizations meet
-- at a point, and one of the enemies has an embassy but the other does not.
-- This unit will be able to enter both.
 
    local pPlayer = Players[playerId]
    local pPlot = unit:GetPlot()
 
    -- check the plot exists
    if pPlot ~= nil then
 
        -- get the owner of the plot
        -- don't do anything if the owner of the plot is the owner of the unit
        local pOwner = pPlot:GetOwner()
        if pOwner ~= playerId then
            -- is this unit in an area owned by someone with the right embassy?
            local hasEmb = CheckEmb(pPlayer, pOwner)
            if hasEmb == true then
                -- yes
                return true
            else
                -- no;
                -- check all neighbouring plots to see if it can validly move into
                -- enemy areas
                for i = 0, 5 do
                    local CheckPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), i);
                    if CheckPlot ~= nil then
                        pOwner = CheckPlot:GetOwner()
                        hasEmb = CheckEmb(pPlayer, pOwner)
                        print('hasEmb == ' .. tostring(hasEmb))
                        if hasEmb then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end
 
function TestBordersOnMoveForMarbull(playerid, unitid)
-- These guts are copied from the Cuban CL civilization, from CubanLua.lua
    local pPlayer = Players[playerid]
    if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CL_MURRI then
        local unit = pPlayer:GetUnitByID(unitid)
        if unit ~= nil then
            if unit:GetUnitType() == GameInfoTypes.UNIT_CL_MARBULL then
                local canEnter = TestBorders(playerid, unit)
                print('canEnter == '..tostring(canEnter))
                if canEnter then
                    unit:SetHasPromotion(GameInfoTypes.PROMOTION_RIVAL_TERRITORY, true)
                else
                    unit:SetHasPromotion(GameInfoTypes.PROMOTION_RIVAL_TERRITORY, false)
                end
            end
        end
    end
end
 
function EnterBordersForMarbull(playerId, unitId, x, y, k, isSelected)
-- These guts are also copied from the Cuban CL civilization, from CubanLua.lua
    if isSelected == false then
        return
    else
        TestBordersOnMoveForMarbull(playerId, unitId)
    end
end
 
for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
    local pPlayer = Players[i]
    if pPlayer:IsEverAlive() and pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_CL_MURRI then
        GameEvents.UnitSetXY.Add(TestBordersOnMoveForMarbull)
        Events.UnitSelectionChanged.Add(EnterBordersForMarbull)
        break
    end
end