print ("Philosophy - Athens UB code ")

include( "IconSupport" );
include( "InstanceManager" );
include( "FLuaVector" );
local ValidPlayerTable = {}
local aCheck = {}
local dBuilding = GameInfoTypes.BUILDING_DUMMY_LS_ATHENS
local dImpro = GameInfoTypes.IMPROVEMENT_LS_LONG_WALLS
local uBuilding = GameInfoTypes.BUILDING_LS_LONG_WALLS
local tCoast = GameInfoTypes.TERRAIN_COAST;
local rRail = GameInfoTypes.ROUTE_RAILROAD
local rRoad = GameInfoTypes.ROUTE_ROAD
local g_PlotButtonIM;
local tRailroad = GameInfoTypes.TECH_RAILROAD;
local PotentialRailroadT = {}
local WorldPositionOffset = { x = 0, y = 0, z = 30 };
local IsCityView = false;

function GiveTableOfValidBuildingPlayers(tab)
	local bHuman = false;
	for i, player in pairs(tab) do
		if Players[player]:IsHuman() then
			bHuman = true;
		end
		ValidPlayerTable[player] = 1;
	end
	if bHuman then
		Events.SerialEventExitCityScreen.Add(ExitCity);
		Events.SerialEventEnterCityScreen.Add(EnterCity);
		Events.SerialEventCityScreenDirty.Add(IsNextCitySelected);
		g_PlotButtonIM = InstanceManager:new( "AthenPlotButtonInstance", "PlotButtonAnchor", "AthensButtonContainer" );
	end
end

GameEvents.TeamSetHasTech.Add(function(team,tech)
	if tech == tRailroad then
		CheckRailroads()
	end
end)

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:GetImprovementType() == dImpro then
			if fPlot:GetRouteType() == rRoad then
				PotentialRailroadT[fPlot] = 1;
			end
		end
	end
end)

function CheckIfCityShouldHaveNavalBonus(iCity)
	if not aCheck[iCity] then
		aCheck[iCity] = 1;
		for i = 0, 5 do
			local iPlot = Map.PlotDirection(iCity:GetX(), iCity:GetY(), i);
			if iPlot then
				if iPlot:IsWater() then
					if not iPlot:IsLake() then
						if iPlot:GetImprovementType() ~= dImpro then
							iCity:SetNumRealBuilding(dBuilding, 1)
							return;
						end
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		for iCity in Players[iPlayer]:Cities() do
			if iCity:IsHasBuilding(uBuilding) then
				if not iCity:IsHasBuilding(dBuilding) then
					CheckIfCityShouldHaveNavalBonus(iCity)
				end
			else
				iCity:SetNumRealBuilding(dBuilding, 0);
			end
		end
	end
	if Players[iPlayer]:IsBarbarian() then
		CheckRailroads()
	end
end)

function CheckRailroads()
	for iPlot, sth in pairs(PotentialRailroadT) do
		if iPlot:GetOwner() ~= -1 then
			if Teams[Players[iPlot:GetOwner()]:GetTeam()]:IsHasTech(tRailroad) then
				iPlot:SetRouteType(rRail)
				PotentialRailroadT[iPlot] = nil;
			end
		end
	end
end

GameEvents.CityConstructed.Add(function(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if uBuilding == buildingType then
		CheckIfCityShouldHaveNavalBonus(Players[ownerId]:GetCityByID(cityId))
		if not Players[ownerId]:IsHuman() then
			DoAIConsiderMakingCanal(ownerId, Players[ownerId]:GetCityByID(cityId))
		elseif ownerId == Game.GetActivePlayer() then
			if IsCityView then
				UpdateButton()
			end
		end
	end
end)

function SetWalls(iPlot, bool)
	iPlot:SetImprovementType(-1)
	iPlot:SetResourceType(-1)
	iPlot:SetNumResource(0);
	iPlot:SetFeatureType(-1)
	iPlot:SetTerrainType(tCoast)
	iPlot:SetWOfRiver(false)
	iPlot:SetNEOfRiver(false)
	iPlot:SetNWOfRiver(false)
	iPlot:SetImprovementType(dImpro)
	local wPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 4);
	wPlot:SetWOfRiver(false)
	local nePlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 0);
	nePlot:SetNEOfRiver(false)
	local nwPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 5);
	nwPlot:SetNWOfRiver(false)
	Map.RecalculateAreas()
	if bool then
		iPlot:SetRouteType(rRail)
	else
		iPlot:SetRouteType(rRoad)
		PotentialRailroadT[iPlot] = 1;
	end
	DoRecalculatePossibleStuff()
end

function DoAIConsiderMakingCanal(iPlayer, iCity)
--	local hTab = GetTableOfSurroundingOceans(iCity)
	for i = 0, 5 do
		local iPlot = Map.PlotDirection(iCity:GetX(), iCity:GetY(), i);
		if iPlot then
			if iPlot:GetResourceType() == -1 then
				if IsValidPlotForWalls(iPlot, iCity, i) then
					SetWalls(iPlot, Teams[Players[iPlayer]:GetTeam()]:IsHasTech(tRailroad))
				end
			end
		end
	end
end

function PlotButtonClicked(iPlotIndex)
	SetWalls(Map.GetPlotByIndex(iPlotIndex), Teams[Game.GetActiveTeam()]:IsHasTech(tRailroad))
	UpdateButton()
end

function UpdateButton()
	local sCity = UI.GetHeadSelectedCity();
	g_PlotButtonIM:ResetInstances();
	local iActiveTeam = Game.GetActiveTeam();
	if sCity then
		if ValidPlayerTable[Game.GetActivePlayer()] then
			if sCity:GetOwner() == Game.GetActivePlayer() then
				if sCity:IsHasBuilding(uBuilding) then
					local disable = UI.IsCityScreenViewingMode();
					for i = 0, 5 do
						local fPlot = Map.PlotDirection(sCity:GetX(), sCity:GetY(), i)
						if fPlot then
							if IsValidPlotForWalls(fPlot, sCity, i) then
								local iHexID = ToHexFromGrid( Vector2( fPlot:GetX(), fPlot:GetY()) );
								local worldPos = HexToWorld( iHexID );
								local controlTable = g_PlotButtonIM:GetInstance();						
								controlTable.PlotButtonAnchor:SetWorldPosition( VecAdd( worldPos, WorldPositionOffset ) );
								controlTable.PlotButtonImage:SetToolTipString( Locale.ConvertTextKey("This action will place permanent Improvement on the tile, making a water connection, which allows city to build naval units, building and be part of naval trade routes. It removes any resource, river and feature from tile, turning it into a Coast. Yields +1 [ICON_PRODUCTION] and counts as road or railroad (if you have proper technology). Those Improvements cannot be next to each other and must connect to the sea (lake doesn't count).") );
								IconHookup(	1, 45, "BUILDING_MOD_LS_17_ATLAS", controlTable.PlotButtonImage);
								controlTable.PlotButtonImage:SetVoid1( fPlot:GetPlotIndex() );
								controlTable.PlotButtonImage:RegisterCallback( Mouse.eLCLick, PlotButtonClicked);
								controlTable.PlotButtonImage:SetDisabled(disable)
							end
						end
					end
				end
			end
		end
	end
end

function EnterCity()
	IsCityView = true;
	UpdateButton()
end

function ExitCity()
	IsCityView = false;
	UpdateButton()
end

function IsNextCitySelected()
	if IsCityView then
		UpdateButton()
	end
end

function IsValidPlotForWalls(fPlot, sCity, i, tab)
	if not fPlot:IsMountain() then
		if not fPlot:IsImpassable() then
			if not fPlot:IsCity() then
				if fPlot:GetNumUnits() == 0 then
					if not fPlot:IsWater() then
						for j = 0, 1 do
							local jPlot = Map.PlotDirection(sCity:GetX(), sCity:GetY(), (i + math.pow(-1, j))%6)	
							if jPlot then
								if jPlot:IsWater() then
									return false;
								end
							end
						end
						local IsSea = false;
						for j = 0, 2 do
							local jPlot = Map.PlotDirection(fPlot:GetX(), fPlot:GetY(), (i - 1 + j)%6);
							if jPlot then
								if jPlot:IsWater() then
									if not jPlot:IsLake() then
										if not jPlot:IsImpassable() then
											IsSea = true;
											if jPlot:GetImprovementType() == dImpro then
												return false;
											end
										end		
									end
								end
							end
						end
						return IsSea;
					end
				end
			end
		end
	end
	return false;
end