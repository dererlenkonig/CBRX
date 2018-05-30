print ("Poverty Point Check 2")

--Support
include("IconSupport.lua")

-- Checks
local PovertyID = GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD;

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if player:GetCivilizationType() == PovertyID then
			include("PP Extra Scripts")
			break;
		end
	end
end