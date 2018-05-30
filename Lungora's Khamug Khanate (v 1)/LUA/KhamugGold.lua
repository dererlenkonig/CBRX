local iBaseGoldOnDeclareWar = 150
local iEraMultiplier = 2
local iRequiredCiv = GameInfoTypes["CIVILIZATION_KHAMUG"]
function GetGoldForEra(player)
	return math.max(iBaseGoldOnDeclareWar, (iBaseGoldOnDeclareWar * iEraMultiplier * player:GetCurrentEra()))
end
function KhamugMongolGetGoldOnWarDeclare(teamID, otherTeamID)
	local playerID = Teams[teamID]:GetLeaderID()
	local player = Players[playerID]
	local otherPlayerID = Teams[otherTeamID]:GetLeaderID()
	local otherPlayer = Players[otherPlayerID]
	if (player:IsAlive() and player:GetCivilizationType() == iRequiredCiv) then
		player:ChangeGold(GetGoldForEra(player))
	elseif (otherPlayer:IsAlive() and otherPlayer:GetCivilizationType() == iRequiredCiv) then
		otherPlayer:ChangeGold(GetGoldForEra(otherPlayer))
	end
end
GameEvents.DeclareWar.Add(KhamugMongolGetGoldOnWarDeclare)