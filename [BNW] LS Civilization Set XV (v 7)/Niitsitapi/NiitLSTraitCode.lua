print("Lord of the Rings - Niit UA code ")

local ValidPlayerTable = {}
local GoodHut = GameInfoTypes.IMPROVEMENT_GOODY_HUT;
local GoodyHuts = {}
local GhostsOfGoody = {}

function GiveTableOfValidTraitPlayers(traitT, improT)
	for i, player in pairs(traitT) do
		ValidPlayerTable[player] = 1;
	end	
end

Events.SequenceGameInitComplete.Add(function()
	if load("LSNiitFirstLoad") then
		for i = 0, Map:GetNumPlots() - 1, 1 do
			local fPlot = Map.GetPlotByIndex( i );
			if fPlot:GetImprovementType() == GoodHut then
				GoodyHuts[fPlot] = 1;
			elseif load(fPlot:GetPlotIndex() .. "LSNiitHadGOODY") then
				for player, i in pairs(ValidPlayerTable) do
					if not load(fPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. player) then
						GhostsOfGoody[fPlot] = 1;
						break;
					end
				end
			end
		end
	else
		save("LSNiitFirstLoad", 1) 
		for i = 0, Map:GetNumPlots() - 1, 1 do
			local fPlot = Map.GetPlotByIndex( i );
			if fPlot:GetImprovementType() == GoodHut then
				save(fPlot:GetPlotIndex() .. "LSNiitHadGOODY")
				GoodyHuts[fPlot] = 1;
			end
		end
	end
end)

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	local cPlot = Map.GetPlot(x, y);
	if cPlot then
		if Players[player]:IsMinorCiv() or Players[player]:IsBarbarian() then
			return;
		end
		if GoodyHuts[cPlot] then
			if ValidPlayerTable[player] then
				save(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. player, 1)
			end
			for vplayer, i in pairs(ValidPlayerTable) do
				if not load(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. vplayer) then
					GhostsOfGoody[cPlot] = 1;
				end
			end
			GoodyHuts[cPlot] = nil;
		elseif GhostsOfGoody[cPlot] then
			if ValidPlayerTable[player] then
				if not load(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. player) then
					save(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. player, 1)
					local cUnit = Players[player]:GetUnitByID(unit);
					local cImpro = cPlot:GetImprovementType();
					local cPillaged = cPlot:IsImprovementPillaged();
					local bRemove = true;
					for vplayer, i in pairs(ValidPlayerTable) do
						if not load(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. vplayer) then
							bRemove = false;
							break;
						end
					end
					if bRemove then
						GhostsOfGoody[cPlot] = nil;
					end
					cPlot:SetImprovementType(GoodHut)
					cUnit:SetXY(x,y)
					if cImpro ~= -1 then
						cPlot:SetImprovementType(cImpro);
						cPlot:SetImprovementPillaged(cPillaged);
					end
				end
			end
		end
	end
end)

GameEvents.CityBoughtPlot.Add(function(ownerId, cityId, plotX, plotY, bGold, bFaithOrCulture)
	UpdateBasedOnTileAcquisition(ownerId)
end)

GameEvents.PlayerCityFounded.Add(function(iPlayer, x, y)
	UpdateBasedOnTileAcquisition(iPlayer)
end)

GameEvents.CityCaptureComplete.Add(function(iPlayer, bCapital, x, y, nPlayer)
	UpdateBasedOnTileAcquisition(nPlayer)
end)

LuaEvents.LSNiitCityFounded.Add(function(iPlayer)
	UpdateBasedOnTileAcquisition(iPlayer)
end)

function UpdateBasedOnTileAcquisition(ownerId)
	if Players[ownerId]:IsMinorCiv() or Players[ownerId]:IsBarbarian() then
		return;
	end
	for cPlot, sth in pairs(GoodyHuts) do
		if cPlot:GetOwner() ~= -1 then
			GhostsOfGoody[cPlot] = 1;
			local cOwner = cPlot:GetOwner();
			if ValidPlayerTable[cOwner] then
				save(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. cOwner, 1)
			end
			for vplayer, i in pairs(ValidPlayerTable) do
				if not load(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. vplayer) then
					GhostsOfGoody[cPlot] = 1;
				end
			end
		end
	end
	if ValidPlayerTable[ownerId] then
		for cPlot, sth in pairs(GhostsOfGoody) do
			if cPlot:GetOwner() == ownerId then
				if not load(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. ownerId) then
					save(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. ownerId, 1)
					local cImpro = cPlot:GetImprovementType();
					local cPillaged = cPlot:IsImprovementPillaged();
					local bRemove = true;
					for vplayer, i in pairs(ValidPlayerTable) do
						if not load(cPlot:GetPlotIndex() .. "LSNiitPlayerVisited" .. vplayer) then
							bRemove = false;
							break;
						end
					end
					if bRemove then
						GhostsOfGoody[cPlot] = nil;
					end
					local cityID = cPlot:GetCityPurchaseID();
					cPlot:SetOwner(-1)
					cPlot:SetImprovementType(GoodHut)
					cPlot:SetOwner(ownerId, cityID)
					if cImpro ~= -1 then
						cPlot:SetImprovementType(cImpro);
						cPlot:SetImprovementPillaged(cPillaged);
					end
				end
			end
		end
	end
end