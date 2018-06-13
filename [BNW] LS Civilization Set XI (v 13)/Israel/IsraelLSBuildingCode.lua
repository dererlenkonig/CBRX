print ("Exodus - Israeli Building Code")

local eicClass = GameInfoTypes.BUILDINGCLASS_LIBRARY;
local yeshiwa = GameInfoTypes.BUILDING_LS_YESHIVA;
local specScien = GameInfoTypes.SPECIALIST_SCIENTIST;
local hBuild = {}
hBuild[specScien] = {}
for building in GameInfo.Buildings{SpecialistType = "SPECIALIST_SCIENTIST"} do
	hBuild[specScien][building.ID] = building.GreatPeopleRateChange;
end
local ValidPlayerTable = {}

function GiveTableOfValidBuildingPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		if Players[iPlayer]:GetBuildingClassCount(eicClass) > 1 then
			ShareGPP(iPlayer, specScien)
		end
	end
end)

function ShareGPP(iPlayer, iSpec)
	local theCities = {}
	local theb = 0;
	for iCity in Players[iPlayer]:Cities() do
		if iCity:IsHasBuilding(yeshiwa) then
			local am =  GetSpec(iCity, iSpec, iPlayer);
			theb = theb + am;
			theCities[iCity] = am;
		end
	end
	for iCity, ab in pairs(theCities) do
		iCity:ChangeSpecialistGreatPersonProgressTimes100(iSpec,  (theb - ab) / 3);
	end
end

function GetSpec(pCity, iSpec, iPlayer)
	local iGPPChange = GameInfo.Specialists[iSpec].GreatPeopleRateChange * pCity:GetSpecialistCount( iSpec ) * 100;
	for buildingID, amount in pairs(hBuild[iSpec]) do
		if pCity:IsHasBuilding(buildingID) then
			iGPPChange = iGPPChange + amount * 100;
		end
	end
	if iGPPChange > 0 then
		local pPlayer = Players[iPlayer];
		local iPlayerMod = pPlayer:GetGreatPeopleRateModifier() + pCity:GetGreatPeopleRateModifier();
		if iSpec == specScien then
			iPlayerMod = iPlayerMod + pPlayer:GetGreatScientistRateModifier();
		end
		return ((iGPPChange * (100 + iPlayerMod)) / 100);
	end
	return 0;
end