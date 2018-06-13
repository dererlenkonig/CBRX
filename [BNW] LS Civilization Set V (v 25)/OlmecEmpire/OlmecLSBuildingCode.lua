print("Colossal Heads - Olmec Building Code")

local ValidPlayerTable = {}
local ColossalID = GameInfoTypes.BUILDING_COLOSSAL_HEADS;
local DummyID = GameInfoTypes.BUILDINGCLASS_DUMMY_OLMEC;
local CulturePerERA = GameInfoTypes.BUILDING_DUMMY_OLMEC_CULTURE;
local FaithID = YieldTypes.YIELD_FAITH;
local CultureID = YieldTypes.YIELD_CULTURE;

function GiveTableOfValidBuildingPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
	end
end

GameEvents.PlayerCityFounded.Add(function(iPlayer, iCityX, iCityY)
	if ValidPlayerTable[iPlayer] then
		OlmecCH(iPlayer)
	end
end)

GameEvents.PlayerAdoptPolicy.Add(function(iPlayer, policyID)
	if ValidPlayerTable[iPlayer] then		
		OlmecCH(iPlayer)
	end
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		OlmecCH(iPlayer)
	end
end)

function OlmecCH(iPlayer)
	for iCity in Players[iPlayer]:Cities() do
		if iCity:IsHasBuilding(ColossalID) then
			if iCity:GetBuildingYieldChange(DummyID, FaithID) == 0 then
				iCity:SetBuildingYieldChange(DummyID, FaithID, 1);
				for i= 0, 2 do
					iPlot = iCity:GetNextBuyablePlot();
					if iPlot then
						iPlot:SetOwner(iPlayer, iCity:GetID(), true, true);
					end
				end
			end
			if iCity:GetBuildingYieldChange(DummyID, CultureID) == 0 then
				iCity:SetBuildingYieldChange(DummyID, CultureID, Players[iPlayer]:GetCurrentEra() + 1);
			end
			iCity:SetNumRealBuilding(CulturePerERA, 1 + Players[iPlayer]:GetCurrentEra() - iCity:GetBuildingYieldChange(DummyID, CultureID));
		elseif iCity:GetBuildingYieldChange(DummyID, CultureID) ~= 0 then
			iCity:SetBuildingYieldChange(DummyID, CultureID, 0);
			iCity:SetNumRealBuilding(CulturePerERA, 0);
		end	
	end
end