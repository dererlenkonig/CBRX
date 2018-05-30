print("Roof of the World - Nepal Trait code")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LS4NepalUA";

local ValidPlayerTable = {}
local DurMountains = {}
local GetCurrentBonus = {}
local yProd = GameInfoTypes.YIELD_PRODUCTION;
local yFood = GameInfoTypes.YIELD_FOOD;
local yCulture = GameInfoTypes.YIELD_CULTURE;
local techGuild = GameInfoTypes.TECH_GUILDS;
local ValidBuildingTable = {}
local DummyB = GameInfoTypes.BUILDING_DUMMY_LS_NEPAL_REQ

function GiveTableOfValidBuildingPlayers(tab)
	for i, player in pairs(tab) do
		ValidBuildingTable[player] = 1;
	end
end

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end

function ChangePlotYield(fPlot, nYield, value)
	local cYield = fPlot:GetYield(nYield);
	Game.SetPlotExtraYield(fPlot:GetX(), fPlot:GetY(), nYield, 0)
	Game.SetPlotExtraYield(fPlot:GetX(), fPlot:GetY(), nYield, value + cYield - fPlot:GetYield(nYield))
end

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:IsMountain() then
			if (fPlot:GetFeatureType() == -1) or (not GameInfo.Features[fPlot:GetFeatureType()].NaturalWonder) then
				table.insert(DurMountains, fPlot)
				GetCurrentBonus[fPlot] = load(fPlot, "LS4MountBonus") or 0;
			end
		end
	end
end)

GameEvents.CityBoughtPlot.Add(function(ownerId, cityId, plotX, plotY, bGold, bFaithOrCulture)
	if ValidBuildingTable[ownerId] then
		NepalBuildingCheck(Players[ownerId]:GetCityByID(cityId), false)
	end
	if ValidPlayerTable[ownerId] then
		NepalMainCheck()
	end
end)

GameEvents.BuildFinished.Add(function(iPlayer, x, y, improID)
	if GameInfo.Improvements[improID] then
		if GameInfo.Improvements[improID].CultureBombRadius > 0 then
			NepalMainCheck()
			if ValidBuildingTable[iPlayer] then
				for iCity in Players[iPlayer]:Cities() do
					NepalBuildingCheck(iCity, false)
				end
			end
		end
	end
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if Players[iPlayer]:IsBarbarian() or ValidPlayerTable[iPlayer] then
		NepalMainCheck()
	end
	if ValidBuildingTable[iPlayer] then
		for iCity in Players[iPlayer]:Cities() do
			NepalBuildingCheck(iCity, false)
		end
	end
end)

GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if ValidPlayerTable[iNewOwner] or ValidPlayerTable[iOldOwner] then
		NepalMainCheck()
	end
	if ValidBuildingTable[iNewOwner] then
		NepalBuildingCheck(Map.GetPlot(iX, iY):GetPlotCity(), false)
	end
end)

GameEvents.PlayerCityFounded.Add(function(iPlayer, iCityX, iCityY)
	if ValidPlayerTable[iPlayer] then
		local kplot = Map.GetPlot(iCityX, iCityY);
		local kCity = kplot:GetPlotCity();
		NepalBuildingCheck(kCity, true)
		NepalMainCheck()
	end
end)

function GetProperBonusNow(fPlot)
	if fPlot:GetOwner() ~= -1 then
		fOwner = fPlot:GetOwner();
		if ValidPlayerTable[fOwner] then
			if Teams[Players[fOwner]:GetTeam()]:IsHasTech(techGuild) then
				return 2;
			else
				return 1;
			end
		end
	end
	return 0;
end

function NepalBuildingCheck(kCity, kFound)
	local IsValidCity = kCity:Plot():IsRiver();
	local kPlayer = kCity:GetOwner();
	for i, iPlot in pairs(DurMountains) do
		if Map.PlotDistance(iPlot:GetX(), iPlot:GetY(), kCity:GetX(), kCity:GetY()) < 3 then
			if kFound then
				if iPlot:GetOwner() == - 1 then	
					iPlot:SetOwner(kCity:GetOwner(), kCity:GetID());
				end
			end
			if iPlot:GetOwner() == kPlayer then
				IsValidCity = true;
			end
		end
	end
	if ValidPlayerTable[kCity:GetOwner()] then
		if IsValidCity then
			kCity:SetNumRealBuilding(DummyB, 1);
		else
			kCity:SetNumRealBuilding(DummyB, 0);
		end
	end
end

function NepalMainCheck()
	for i, fPlot in pairs(DurMountains) do
		local propBonus = GetProperBonusNow(fPlot);
		if GetCurrentBonus[fPlot] ~= propBonus then
			if propBonus == 2 then
				if GetCurrentBonus[fPlot] == 0 then
					ChangePlotYield(fPlot, yProd, 1)
					ChangePlotYield(fPlot, yFood, 2)
				end
				ChangePlotYield(fPlot, yCulture, 1)
			elseif propBonus == 1 then
				if GetCurrentBonus[fPlot] == 0 then
					ChangePlotYield(fPlot, yProd, 1)
					ChangePlotYield(fPlot, yFood, 2)
				else
					ChangePlotYield(fPlot, yCulture, -1)
				end
			elseif propBonus == 0 then
				ChangePlotYield(fPlot, yProd, -1)
				ChangePlotYield(fPlot, yFood, -2)
				if GetCurrentBonus[fPlot] == 2 then
					ChangePlotYield(fPlot, yCulture, -1)
				end
			end
			save(fPlot, "LS4MountBonus", propBonus)
			GetCurrentBonus[fPlot] = propBonus;
		end
	end
end