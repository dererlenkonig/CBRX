print ("Angkor - Khmer UB code ")

local ValidPlayerTable = {}
local BarayReq = GameInfoTypes.BUILDING_DUMMY_LS_KHMER_REQ;
local KhmerFoodKept = GameInfoTypes.BUILDING_DUMMY_LS_KHMER_FAKE_FOOD;
local bBaray = GameInfoTypes.BUILDING_LS_BARAY;

function GiveTableOfValidBuildingPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end
 
GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if ValidPlayerTable[iNewOwner] then
		CheckBaray(iNewOwner)
	end
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		CheckBaray(iPlayer)
	end
end)

GameEvents.CitySoldBuilding.Add(function(iPlayer, cityId, eBuilding)
	if eBuilding == bBaray then
		CheckBaray(iPlayer)
	end
end)

GameEvents.CityConstructed.Add(function(iPlayer, cityId, eBuilding, bGold, bFaithOrCulture)
	if eBuilding == bBaray then
		CheckBaray(iPlayer)
	end
end)

GameEvents.PlayerCityFounded.Add(function(iPlayer, iCityX, iCityY)
	if ValidPlayerTable[iPlayer] then
		CheckBaray(iPlayer)
	end
end)

function CheckBaray(iPlayer)
	for iCity in Players[iPlayer]:Cities() do
		if iCity:IsHasBuilding(bBaray) then
			iCity:SetNumRealBuilding(KhmerFoodKept, 1)
		else
			iCity:SetNumRealBuilding(KhmerFoodKept, 0)
			if (iCity:GetPopulation() > 7) or (iCity:Plot():IsRiverSide()) then
				iCity:SetNumRealBuilding(BarayReq, 1);
			else
				iCity:SetNumRealBuilding(BarayReq, 0);
			end
		end
	end
end