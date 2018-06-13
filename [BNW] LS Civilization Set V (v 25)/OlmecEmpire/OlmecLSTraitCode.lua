print("Olmec Civ Related")

local ValidPlayerTable = {}
local DummyPalace = GameInfoTypes.BUILDING_DUMMY_OLMEC;
local CFT = CityAIFocusTypes.NO_CITY_AI_FOCUS_TYPE;

function GiveTableOfValidTraitPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
	end
end

GameEvents.PlayerCityFounded.Add(function(iPlayer, iCityX, iCityY)
	if ValidPlayerTable[iPlayer] then
		local kplot = Map.GetPlot(iCityX, iCityY);
		local kCity = kplot:GetPlotCity();
		if kCity ~= Players[iPlayer]:GetCapitalCity() then
			kCity:SetPuppet(true);
			kCity:SetNumRealBuilding(DummyPalace, 1);
			kCity:SetProductionAutomated(true);
			Players[iPlayer]:AddNotification(NotificationTypes.NOTIFICATION_PRODUCTION);
			kCity:SetFocusType(CFT);
			for i = 1, kCity:GetNumCityPlots() - 1 do
				local nPlot = kCity:GetCityIndexPlot( i );
				if nPlot and kCity:IsWorkingPlot(nPlot) then
					kCity:AlterWorkingPlot(i)
					kCity:AlterWorkingPlot(i)
				end
			end
		end
	end
end)

function OlmecCities(player)
	for iCity in Players[player]:Cities() do
		if iCity:GetOriginalOwner() == player then
			if iCity:IsPuppet() and (not iCity:IsCapital()) then
				iCity:SetNumRealBuilding(DummyPalace, 1);
				iCity:AlterWorkingPlot(0)
				iCity:SetFocusType(CFT)
				for i = 1, iCity:GetNumCityPlots() - 1 do
					local nPlot = iCity:GetCityIndexPlot( i );
					if nPlot and iCity:IsWorkingPlot(nPlot) then
						iCity:AlterWorkingPlot(i)
						iCity:AlterWorkingPlot(i)
					end
				end
			else
				iCity:SetNumRealBuilding(DummyPalace, 0);
			end
		end
		if not Players[player]:IsHuman() then
			if iCity:IsPuppet() then
				if iCity:IsCapital() and iCity:GetOriginalOwner() == player then
					iCity:SetPuppet(false); 
				elseif iCity:GetPopulation() > 7 or iCity:GetDamage() > 100 then
					iCity:SetPuppet(false); 
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		OlmecCities(iPlayer)
	end
end)

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		OlmecCities(iPlayer)
	end
end)
