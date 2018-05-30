local civilizationEvenksID	= GameInfoTypes["CIVILIZATION_SENSHI_EVENKS"]
local policyEvenksID = GameInfoTypes["POLICY_SENSHI_NIMAT"]
function Senshi_Nimat_Init()
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		if (player:IsAlive() and player:GetCivilizationType() == civilizationEvenksID) then
			if (not player:HasPolicy(policyEvenksID)) then
				player:SetNumFreePolicies(1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy(policyEvenksID, true)
			end
		end
	end 
end

Events.LoadScreenClose.Add(Senshi_Nimat_Init)