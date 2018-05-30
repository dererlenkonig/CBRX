-- Hain Hut Functions
-- Author: User
-- DateCreated: 4/2/2018 6:10:56 PM
--------------------------------------------------------------

print("Yay this mod worked!")
include("PlotIterators.lua")
function GetRandom(lower, upper)
    return Game.Rand((upper + 1) - lower, "") + lower
end

function IsHasBuilding(playerID, buildingType)
	local pPlayer = Players[playerID]
	local b_HasBuilding = false
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(buildingType) then
			b_HasBuilding = true
		end
	end
	return b_HasBuilding
end

iFaith = 0;
iCulture = 0;





--------------------
---Hain Hut Constants---
--------------------
HainHutFaith = 1;
HainHutCulture = 2;



GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
		if (pCity:IsHasBuilding(GameInfoTypes.BUILDING_HAIN_HUT)) then
			local randomizer = GetRandom(1, 2)
			-- 1 = faith
			-- 2 = culture
			if (randomizer == 1) then
				pPlayer:ChangeFaith(HainHutFaith)
				print("In city " .. pCity:GetName() .. ", Hain Hut produces 1 faith.")
				iFaith = iFaith + HainHutFaith
			else  
				pPlayer:ChangeJONSCulture(HainHutCulture)
				print("In city " .. pCity:GetName() .. ", Hain Hut produces 2 culture.")
				iCulture = iCulture + HainHutCulture
			end
		end
	end
	if not IsHasBuilding(iPlayer, GameInfoTypes.BUILDING_HAIN_HUT) then
		return
	else
		if (pPlayer:GetNumCities() == 1) then
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_BUILDING_RANDOM_HAIN_YIELD", iFaith, iCulture))
		else
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_BUILDING_RANDOM_HAIN_YIELD_CITIES", iFaith, iCulture, pPlayer:GetNumCities()))
		end 
	end
	iFaith = 0;
	iCulture = 0;
end)