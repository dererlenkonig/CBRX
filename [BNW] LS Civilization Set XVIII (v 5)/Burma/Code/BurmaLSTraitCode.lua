print("Burma - Trait Code")

local ValidPlayerTable = {}
local bHap = GameInfoTypes.BUILDING_DUMMY_LS_BURMA_HAP
local yFaith = GameInfoTypes.YIELD_FAITH

function GiveTableOfValidTraitPlayers(tab)
	for i, iPlayer in pairs(tab) do
		ValidPlayerTable[iPlayer] = Players[iPlayer]:GetNumCities();
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		AdjustHapFromFaithWork(iPlayer)	
	end 
end)

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		AdjustHapFromFaithWork(iPlayer)	
	end
end)

function AdjustHapFromFaithWork(iPlayer)	
	for iCity in Players[iPlayer]:Cities() do
		iCity:SetNumRealBuilding(bHap, GetNumHapFromFaithInCity(iCity))
	end 
end

function GetNumHapFromFaithInCity(iCity)
	local ci = 0;
	for i = 0, iCity:GetNumCityPlots() -1, 1 do
		local iPlot = iCity:GetCityIndexPlot(i);
		if iPlot then
			if iCity:IsWorkingPlot(iPlot) then
				if iPlot:GetYield(yFaith) > 0 then
					ci = ci + 1
				end
			end
		end
	end
	for i = 1, 15 do
		if i > ci then
			return i -1;
		else
			ci = ci - i;
		end
	end
end