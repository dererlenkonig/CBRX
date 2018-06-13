print ("Angkor - Khmer UA code ")

local ValidPlayerTable = {}
local KhmerD = GameInfoTypes.BUILDINGCLASS_KHMERLS_DUMMY;
local FaithID = YieldTypes.YIELD_FAITH;

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end
 
GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local kplot = Map.GetPlot(iX, iY);	
	local kCity = kplot:GetPlotCity();
	if ValidPlayerTable[iOldOwner] then
		kCity:SetBuildingYieldChange(KhmerD, FaithID, 0);
		CheckCitizens(iOldOwner)
	end
end)

function CheckCitizens(iPlayer)
	for iCity in Players[iPlayer]:Cities() do
		local iVal = 0;
		local cVal = iCity:GetBuildingYieldChange(KhmerD, FaithID);
		if iCity:IsCapital() then
			iVal = iCity:GetNumWorldWonders();
		end
		iCity:SetBuildingYieldChange(KhmerD, FaithID, iVal);
		if iVal ~= cVal then
			ChangeCitizens(iCity, iVal - cVal)
		end
	end
end

function ChangeCitizens(iCity, value)
	for i = 1, math.abs(value) do
		iCity:ChangePopulation(1, value > 0);
		iCity:ChangePopulation(-1, value < 0);
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		CheckCitizens(iPlayer)
	end
end)