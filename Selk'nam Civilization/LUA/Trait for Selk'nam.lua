-- Trait for Selk'nam
-- Author: User
-- DateCreated: 4/11/2018 8:48:06 PM
--------------------------------------------------------------
include("Strict.lua")

local iSelknamCiv = GameInfoTypes.CIVILIZATION_SELKNAM
local tPolicyBranchEraConditions = {
	[GameInfoTypes.POLICY_BRANCH_AESTHETICS] = { DefaultRequirement=GameInfoTypes.ERA_CLASSICAL, SelknamRequirement=GameInfoTypes.ERA_ANCIENT }
}
function SelknamPolicyBranchAffects(iPlayer, iPolicyBranch)
	if tPolicyBranchEraConditions[iPolicyBranch] then
		--print("SelknamPolicyBranchAffects fired for values iPlayer " .. iPlayer .. ", iPolicyBranch " .. iPolicyBranch)
		local pPlayer = Players[iPlayer]
		local iCurrentEra = pPlayer:GetCurrentEra()
		if pPlayer:GetCivilizationType() == iSelknamCiv then
			return (iCurrentEra >= tPolicyBranchEraConditions[iPolicyBranch]["SelknamRequirement"])
		else
			return (iCurrentEra >= tPolicyBranchEraConditions[iPolicyBranch]["DefaultRequirement"])
		end
	end
	return true
end
GameEvents.PlayerCanAdoptPolicyBranch.Add(SelknamPolicyBranchAffects)



