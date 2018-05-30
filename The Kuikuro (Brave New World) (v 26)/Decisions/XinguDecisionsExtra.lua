print ("Xingu Extra Check")

local isEaD = (GameInfoTypes.BUILDING_DECISIONS_THAIALPHABET ~= nil)

local pExpFinisherDummy = GameInfoTypes.POLICY_EXPLORATION_FINISHER_DUMMY;
local pExpFinisher = GameInfoTypes.POLICY_EXPLORATION_FINISHER;
local pExp4 = GameInfoTypes.POLICY_NAVIGATION_SCHOOL;
local pExp5 = GameInfoTypes.POLICY_TREASURE_FLEETS;

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if isEaD then
			if pPlayer:HasPolicy(pExpFinisher) then
				if not pPlayer:HasPolicy(pExpFinisherDummy) then
					pPlayer:SetNumFreePolicies(1)
					pPlayer:SetNumFreePolicies(0)
					pPlayer:SetHasPolicy(pExpFinisherDummy, true);
				end
			end
		end
	end
end)

function ExplorationDummyAdopted (playerID, policyID)
	local pPlayer = Players[playerID]
	if (pPlayer:IsAlive()) then
		if isEaD then
			if (policyID == pExp4) and pPlayer:HasPolicy(pExp5) then
				if pPlayer:HasPolicy(pExpFinisher) then
					if not pPlayer:HasPolicy(pExpFinisherDummy) then
						pPlayer:SetNumFreePolicies(1)
						pPlayer:SetNumFreePolicies(0)
						pPlayer:SetHasPolicy(pExpFinisherDummy, true);
					end
				end
			end
			if (policyID == pExp5) and pPlayer:HasPolicy(pExp4) then
				if pPlayer:HasPolicy(pExpFinisher) then
					if not pPlayer:HasPolicy(pExpFinisherDummy) then
						pPlayer:SetNumFreePolicies(1)
						pPlayer:SetNumFreePolicies(0)
						pPlayer:SetHasPolicy(pExpFinisherDummy, true);
					end
				end
			end
		end
	end
end

GameEvents.PlayerAdoptPolicy.Add(ExplorationDummyAdopted)