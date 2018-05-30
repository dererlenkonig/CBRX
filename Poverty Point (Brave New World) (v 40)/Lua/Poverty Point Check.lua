print ("Poverty Point Check")

--SaveUtils
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "Poverty";

--Support
include("IconSupport.lua")

-- Checks
local PovertyID = GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD;

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if player:GetCivilizationType() == PovertyID then
			include("Poverty Point Scripts")
			break;
		end
	end
end

--Dummy Prophet Check
local uProphet = GameInfoTypes.UNIT_POVERTY_POINT_MOD;
local uProphet2 = GameInfoTypes.UNIT_POVERTY_POINT_MOD_DUMMY;
local uBlessing = GameInfoTypes.PROMOTION_PP_BLESSING;
local pPRival = GameInfoTypes.PROMOTION_RIVAL_TERRITORY;

function PovertyReplaceDummyGP(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then
		for pUnit in pPlayer:Units() do
			if (pUnit:GetUnitType() == uProphet2) then
				if not pUnit:IsHasPromotion(pPRival) then
					local newUnit = pPlayer:InitUnit(uProphet, pUnit:GetX(), pUnit:GetY())
					newUnit:Convert(pUnit);
					if not newUnit:IsHasPromotion(pPRival) then
						newUnit:SetHasPromotion(pPRival, true)		
					end
					if not newUnit:IsHasPromotion(uBlessing) then
						newUnit:SetHasPromotion(uBlessing, true)		
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(PovertyReplaceDummyGP)

--Base Yield Fix
local pPPBaseUI = GameInfoTypes.POLICY_POVERTY_FIX_UI_BASE_YIELD;

GameEvents.PlayerCityFounded.Add(
function(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer];
	local pPlot = Map.GetPlot(iCityX, iCityY);
	local pCity = pPlot:GetPlotCity();
	if (pPlayer:IsAlive()) then
		if pCity:IsCapital() then
			if not pPlayer:HasPolicy(pPPBaseUI) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pPPBaseUI, true);
			end
		end
	end
end)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if not pPlayer:HasPolicy(pPPBaseUI) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(pPPBaseUI, true);
		end
	end
end)