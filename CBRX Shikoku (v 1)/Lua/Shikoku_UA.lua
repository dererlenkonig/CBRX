--Game_IsCPActive
function Game_IsCPActive()
    for _, mod in pairs(Modding.GetActivatedMods()) do
        if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
            return true
        end
    end
    return false
end
local isCPActive = Game_IsCPActive()

--HasTrait
function HasTrait(player, traitID)
    if isCPActive then 
        return player:HasTrait(traitID)
    else
        local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
        local traitType  = GameInfo.Traits[traitID].Type
        for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
            return true
        end
    end
    return false
end
--==========================================================================================================================
-- UNIQUE FUNCTIONS
--==========================================================================================================================
-- GLOBAL
----------------------------------------------------------------------------------------------------------------------------
include( "CBR_SaveUtils" ); MY_MOD_NAME = "CBRX_SHIKOKU"; WARN_NOT_SHARED = false

local traitShikokuID = GameInfoTypes["TRAIT_BLACK_SHIPS"]
local visitedContinents = {}
local researchToAdd = 0

function shikokuContinents(playerID, unitID, x, y)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitShikokuID)) then return end
	if (player:GetCurrentResearch() == -1) then return end
	visitedContinents = cbr_load(player, "ShikokuUA") or visitedContinents or {}
	for index, val in ipairs(visitedContinents) do
		print("Area " .. index .. ": " .. tostring(val))
	end

	local unit = player:GetUnitByID(unitID)
	local plot = unit:GetPlot()
	if not plot then return end 
	if plot:IsWater() then return end
	local pArea = plot:GetArea()
	
	if not isInTable(visitedContinents, pArea) then 
		if not (Game:GetGameTurn() < 1) then 
			local teamTechs = Teams[player:GetTeam()]:GetTeamTechs()
			researchToAdd = math.ceil(player:GetResearchCost(player:GetCurrentResearch())/4)
			teamTechs:ChangeResearchProgress(player:GetCurrentResearch(), researchToAdd , player)
			print("Adding " .. researchToAdd .. " to Shikoku's Science")
		end
		table.insert(visitedContinents, pArea)
		print("New area: " .. tostring(pArea))
	end
	cbr_save(player, "ShikokuUA", visitedContinents)
end

GameEvents.UnitSetXY.Add(shikokuContinents)
print("Shikoku UA - Black Ships is active")

function isInTable(table, value)
	for index, val in ipairs(table) do
		if val == value then return true end
	end
	return false		
end