print("Hungary Civ Related")

include( "FLuaVector" );
include( "InstanceManager" );
local WorldPositionOffset2 = { x = 0, y = 0, z = 35 };
local g_ITG_symbols  = InstanceManager:new( "HunInstance", "HunWorldAnchor", ContextPtr:LookUpControl("/InGame/CityBannerManager/CityBanners") );
local instanceTab = {}
local IsStratV = false;
function OnStrategicViewStateChanged(bStrategicView, bCityBanners)
	IsStratV = bStrategicView
	for plot, instance in pairs(instanceTab) do
		if bStrategicView then
			instance.HunWorldAnchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/StrategicViewStrikeButtons"))
		else
			instance.HunWorldAnchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/CityBanners"))
		end
	end
end
Events.StrategicViewStateChanged.Add(OnStrategicViewStateChanged);

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LSHUNGARYUI";
local VegvarImpro = GameInfoTypes.IMPROVEMENT_LS_VEGVAR;
local dland = DomainTypes.DOMAIN_LAND;
local VegvarTab = {}
local GoodHut = GameInfoTypes.IMPROVEMENT_BARBARIAN_CAMP;
local bOkayToProcess = true;
local GoodyHuts = {}
local AncientRuins = GameInfoTypes.IMPROVEMENT_GOODY_HUT;
local sclass = GameInfoTypes.BUILDINGCLASS_DUMMY_LS_HUNGARY;
local ValidO = {}
local bTextRP = "Rally Point of:"
local genericUnitHexBorder = "GUHB";
local vTileImprovementColor = Vector4( 0.5, 0.0, 1.0, 1.0 );
local FakeInterFaceOn = false;
local VIC;
local bVegvar = GameInfoTypes.BUILDING_LS_VEGVAR;
local aCtiveHun = false;
ValidO[-1] = 1;
ValidO[63] = 1;
local hVal = 0;
local tabD = {}
local ValidPlayerTable = {}
local ValidTraitTable = {}
local ValidBuildingTable = {}

function GiveTableOfValidTraitPlayers(tab, tab2)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
		ValidTraitTable[iplayer] = 1;
		if load(Players[iplayer], "LS11HunBCC") == nil then
			Players[iplayer]:ChangeBarbarianCombatBonus(15);
			save(Players[iplayer], "LS11HunBCC", 1)
		end
	end
	for i, iplayer in pairs(tab2) do
		ValidPlayerTable[iplayer] = 1;
		ValidBuildingTable[iplayer] = 1;
	end
	if ValidPlayerTable[Game.GetActivePlayer()] then
		aCtiveHun = true;
	end
	if aCtiveHun then
		ContextPtr:SetInputHandler( InputHandler );
		Events.ActivePlayerTurnEnd.Add( OnActivePlayerTurnEnd );
		Events.ActivePlayerTurnStart.Add( OnActivePlayerTurnStart );
		Events.SerialEventCityCreated.Add( OnCityCreated );
	end
end

function IterateFBS(plot, cityID, iTeam, iPlayer)
	if hVal > 9 then
		return
	end
	tabD[plot] = 1;
	for i = 0, 5 do
		local iPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), i);
		if iPlot then
			if not tabD[iPlot] then
				if iPlot:GetOwner() == iPlayer then
					if iPlot:GetCityPurchaseID() == cityID then
						IterateFBS(iPlot, cityID, iTeam, iPlayer)
					end
				elseif iPlot:GetOwner() ~= -1 then
					if Players[iPlot:GetOwner()]:GetTeam() ~= iTeam then
						if hVal > 9 then
							return
						else
							hVal = hVal + 1;
						end
					end
				end
			end
		end
	end
end

function GetNumBorder(iCity)
	hVal = 0;
	tabD = {}
	IterateFBS(iCity:Plot(), iCity:GetID(), Players[iCity:GetOwner()]:GetTeam(), iCity:GetOwner())
	local prodN = iCity:GetBuildingProductionNeeded(bVegvar);
	return math.ceil(prodN * 0.05 * hVal);
end

function OnActivePlayerTurnEnd()
	bOkayToProcess = false;
end

function OnActivePlayerTurnStart()
	bOkayToProcess = true;
	GreatControlUI()
end

function EndTurnFunc(iPlayer)
	if ValidBuildingTable[iPlayer] then
		for iCity in Players[iPlayer]:Cities() do
			CheckVegvarProduction(iCity)
		end
	end
end
Events.AIProcessingEndedForPlayer.Add(EndTurnFunc)

function CheckVegvarProduction(iCity)
	if iCity:CanConstruct(bVegvar, 1) then
		local pCurentP = iCity:GetBuildingYieldChange(sclass, 3);
		local gBorderP = GetNumBorder(iCity);
		if gBorder ~= pCurentP then
			iCity:ChangeBuildingProduction(bVegvar,gBorderP -pCurentP)
			iCity:SetBuildingYieldChange(sclass, 3, gBorderP);
		end
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	local pPlayer = Players[iPlayer];
	if ValidPlayerTable[iPlayer] then
		if ValidTraitTable[iPlayer] then
			for iPlot, bool in pairs(GoodyHuts) do
				if iPlot:GetImprovementType() ~= GoodHut then
					GoodyHuts[iPlot] = nil;
				end
			end
		end
		if not pPlayer:IsHuman() then
			StartAIRally(iPlayer)
		end
	end
	if pPlayer:IsBarbarian() then
		AddNewCamps(iPlayer)
	end
end)

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:GetImprovementType() == GoodHut then
			GoodyHuts[fPlot] = true;
		elseif fPlot:GetImprovementType() == VegvarImpro then
			VegvarTab[fPlot] = true;
			if aCtiveHun then
				MakeABannerForPlot(fPlot, true)
			end
		end
	end
	if aCtiveHun then
		for i, v in pairs(Players) do
			for iCity in v:Cities() do
				MakeABannerForPlot(iCity:Plot(), true)
			end
		end
		GreatControlUI()
	end
end)

function OBxy(player, unit, x, y)
	if ValidTraitTable[player] then
		if Players[player]:GetUnitByID(unit) then
			local cUnit = Players[player]:GetUnitByID(unit);
			cPlot = cUnit:GetPlot();
			if cPlot then
				if GoodyHuts[cPlot] ~= nil then
					GoodyHuts[cPlot] = nil;
					if cPlot:GetOwner() == -1 then
						local cCapital = Players[player]:GetCapitalCity();
						if cCapital then
							MakeVegvar(cPlot, player, cCapital)
						end
					end
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(OBxy)

function AddNewCamps(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		local iPlot = iUnit:GetPlot()
		if iPlot:GetImprovementType() == GoodHut then
			GoodyHuts[iPlot] = true;
		end
	end
end

function SetRallyPoint(iCity, pPlot)
	local iX, iY = pPlot:GetX(), pPlot:GetY();
	iCity:SetBuildingYieldChange(sclass, 1, iX);
	iCity:SetBuildingYieldChange(sclass, 2, iY);			
end

function RemoveRallyPoint(iCity)
	local iX, iY = iCity:GetX(), iCity:GetY();
	iCity:SetBuildingYieldChange(sclass, 1, iX);
	iCity:SetBuildingYieldChange(sclass, 2, iY);
end

function MakeABannerForPlot(pPlot, initial)
	if not instanceTab[pPlot] then
		local iHexID = ToHexFromGrid( Vector2( pPlot:GetX(), pPlot:GetY()) );
		local worldPos = HexToWorld( iHexID );
		local controlTable = g_ITG_symbols:GetInstance();						
		controlTable.HunWorldAnchor:SetWorldPosition( VecAdd( worldPos, WorldPositionOffset2 ) );
		controlTable.SetRallyPoint:SetVoid1(pPlot:GetPlotIndex())
		controlTable.SetRallyPoint:RegisterCallback( Mouse.eLClick, OnSetRallyPoint )
		controlTable.BoxToHide:SetAlpha(0.7)
		if bStrategicView then
			controlTable.HunWorldAnchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/StrategicViewStrikeButtons"))
		else
			controlTable.HunWorldAnchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/CityBanners"))
		end
		instanceTab[pPlot] = controlTable;
	end
	if not initial then
		GreatControlUI()
	end
end

GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if ValidPlayerTable[iNewOwner] then
		local pPlot = Map.GetPlot(iX, iY);
		local iCity = pPlot:GetPlotCity();
		RemoveRallyPoint(iCity)
		if iNewOwner == Game.GetActivePlayer() then
			MakeABannerForPlot(Map.GetPlot(iCityX, iCityY))
		end
		if ValidBuildingTable[iNewOwner] then
			iCity:SetBuildingYieldChange(sclass, 3, 0);
			CheckVegvarProduction(iCity)
		end
	end
	if ValidPlayerTable[iOldOwner] then
		if iOldOwner == Game.GetActivePlayer() then
			GreatControlUI()
		end
	end
end)

function OnCityCreated( hexPos, playerID, cityID, cultureType, eraType, continent, populationSize, size, fowState )
	if Players[playerID] then
		local iCity = Players[playerID]:GetCityByID(cityID);
		if iCity then
			MakeABannerForPlot(iCity:Plot())
		end
	end
end

GameEvents.PlayerCityFounded.Add(function(iPlayer, iCityX, iCityY)
	if ValidPlayerTable[iPlayer] then
		local iCity = Map.GetPlot(iCityX, iCityY):GetPlotCity();
		RemoveRallyPoint(iCity)
		if ValidBuildingTable[iPlayer] then
			iCity:SetBuildingYieldChange(sclass, 3, 0);
			CheckVegvarProduction(iCity)
		end
	end
end)

function MakeVegvar(cPlot, player, cCapital)
	cPlot:SetImprovementType(VegvarImpro)
	cPlot:SetOwner(player, cCapital:GetID());
	for i = 0, 5 do
		local iPlot = Map.PlotDirection(cPlot:GetX(), cPlot:GetY(), i);
		if iPlot then
			if not iPlot:IsWater() then
				if ValidO[iPlot:GetOwner()] then
					iPlot:SetOwner(player, cCapital:GetID());
				end
			end
		end
	end
	VegvarTab[cPlot] = true;
	if aCtiveHun then
		MakeABannerForPlot(cPlot)
	end
end

function IsValidPointForRallyPoint(rPoint, iPlayer)
	if rPoint:GetOwner() == iPlayer then
		if rPoint:GetImprovementType() == VegvarImpro then
			if not rPoint:IsImprovementPillaged() then
				return true;
			end
		else
			local rCity = rPoint:GetPlotCity();
			if rCity then
				if rCity:IsHasBuilding(bVegvar) then
					return true;
				end
			end
		end
	end
	return false;
end

function GetTextCo(rPoint, plot)
	local text = ""
	local iX = rPoint:GetX() - plot:GetX();
	local iY = rPoint:GetY() - plot:GetY();
	if iY >= 0 then
		text = text .. iY .. " N" 
	else
		text = text .. -iY .. " S" 
	end
	if iX >= 0 then
		text = iX .. " W, " 
	else
		text = -iX .. " E, " 
	end
	return text;
end

function HasPossibleRallyPoint(kCity, iPlayer, iPoint)
	for cPlot, bool in pairs(VegvarTab) do
		if cPlot ~= iPoint then
			if cPlot:GetImprovementType() == VegvarImpro then
				if cPlot:GetOwner() == iPlayer then
					if not cPlot:IsImprovementPillaged() then
						return true;
					end
				end
			end
		end
	end
	for iCity in Players[iPlayer]:Cities() do
		if iCity ~= kCity then
			if iPoint ~= iCity:Plot() then
				if iCity:IsHasBuilding(bVegvar) then
					return true;
				end
			end
		end
	end
	return false;
end

function GreatControlUI()
	local iPlayer = Game.GetActivePlayer();
	local RallyPoints = {}
	local isPossible = false;
	for iCity in Players[iPlayer]:Cities() do
		local rPoint = Map.GetPlot(iCity:GetBuildingYieldChange(sclass, 1), iCity:GetBuildingYieldChange(sclass, 2));
		if rPoint ~= iCity:Plot() then
			if IsValidPointForRallyPoint(rPoint, iPlayer) then
				RallyPoints[iCity] = rPoint
			else
				RemoveRallyPoint(iCity)
			end
		end
	end
	for plot, instance in pairs(instanceTab) do
		instance.SetRallyPoint:SetHide(true)
		instance.EmptyButton:SetHide(true)
		if plot:GetOwner() == iPlayer then
			local sText = bTextRP;
			if plot:IsCity() then
				local iCity = plot:GetPlotCity();
				local iPoint = Map.GetPlot(iCity:GetBuildingYieldChange(sclass, 1), iCity:GetBuildingYieldChange(sclass, 2));
				if iPoint == plot then
					instance.SetRallyPointLabel:SetText("[ICON_TEAM_2]")
					instance.SetRallyPoint:SetToolTipString("City currently has no Rally point.[NEWLINE]Left-Click here to set one.")
					instance.SetRallyPoint:SetHide(not HasPossibleRallyPoint(iCity, iPlayer, iPoint))
				else
					instance.SetRallyPoint:SetHide(false)
					instance.SetRallyPointLabel:SetText("[ICON_TEAM_4]")
					if iPoint:IsCity() then
						instance.SetRallyPoint:SetToolTipString("City's rally point is set on " .. iPoint:GetPlotCity():GetName() .. ".[NEWLINE][NEWLINE]Left-Click to change.[NEWLINE]Set on City to remove.")
					else
						instance.SetRallyPoint:SetToolTipString("City's rally point is set on Vegvar Improvement.[NEWLINE][NEWLINE]Left-Click to change.[NEWLINE]Set on City to remove.")
					end
				end
			end
			for iCity, rPoint in pairs(RallyPoints) do
				if rPoint == plot then
					sText = sText .. "[NEWLINE][ICON_BULLET]" .. iCity:GetName();
				end
			end
			if sText ~= bTextRP then
				instance.EmptyButton:SetToolTipString(sText)
				instance.EmptyButton:SetHide(false)
			end
		end
	end
end

function OnSetRallyPoint(plotID)
	if bOkayToProcess then
		FakeInterFaceOn = true;
		HighlightProperTiles(Map.GetPlotByIndex(plotID))
	end
end

function HighlightProperTiles(iPlot)
	local dCity = iPlot:GetPlotCity();
	local iPlayer = dCity:GetOwner();
	VIC = dCity;
	for iCity in Players[iPlayer]:Cities() do
		if iCity:IsHasBuilding(bVegvar) or iCity == dCity then
			local iHexID = ToHexFromGrid( Vector2( iCity:GetX(), iCity:GetY()) );
			Events.SerialEventHexHighlight( iHexID, true, vTileImprovementColor, genericUnitHexBorder );
		end
	end
	for cPlot, bool in pairs(VegvarTab) do
		if cPlot:GetImprovementType() == VegvarImpro then
			if cPlot:GetOwner() == iPlayer then
				if not cPlot:IsImprovementPillaged() then
					local iHexID = ToHexFromGrid( Vector2( cPlot:GetX(), cPlot:GetY()) );
					Events.SerialEventHexHighlight( iHexID, true, vTileImprovementColor, genericUnitHexBorder );
				end
			end
		end
	end	
end

function DoSetRallyPoint(pPlot)
	if VIC then
		if VIC:Plot() ~= pPlot then
			if IsValidPointForRallyPoint(pPlot, Game.GetActivePlayer()) then
				SetRallyPoint(VIC, pPlot)
			end
		else
			RemoveRallyPoint(VIC)
		end
		GreatControlUI()
	end
end

function InputHandler( uiMsg, wParam, lParam )
	if FakeInterFaceOn then
		if uiMsg == MouseEvents.LButtonUp or uiMsg == MouseEvents.RButtonUp or uiMsg == MouseEvents.PointerUp then
			local pPlot = Map.GetPlot( UI.GetMouseOverHex() );
			if (pPlot == nil) then
				return;
			end
			DoSetRallyPoint(pPlot)
			Events.ClearHexHighlights()
			FakeInterFaceOn = false;
			return;
		end
	end
end

--New Stuff
function HunMove(ownerId, cityId, unitId, bGold, bFaithOrCulture)
	if ValidPlayerTable[ownerId] then
		local iCity = Players[ownerId]:GetCityByID(cityId);
		local iUnit = Players[ownerId]:GetUnitByID(unitId);
		if iUnit:GetDomainType() == dland then
			if not iUnit:IsTrade() then
				local iPoint =  Map.GetPlot(iCity:GetBuildingYieldChange(sclass, 1), iCity:GetBuildingYieldChange(sclass, 2));
				if iPoint ~= iCity:Plot() then
					if IsValidPointForRallyPoint(iPoint, ownerId) then
						iUnit:SetXY(iPoint:GetX(), iPoint:GetY())
						if not IsProperForUnit(iUnit, iPoint) then
							iUnit:JumpToNearestValidPlot()
						end
					else
						RemoveRallyPoint(iCity)
					end
				end
			end
		end
	end
end
GameEvents.CityTrained.Add(HunMove)

function IsProperForUnit(iUnit, iPlot)
	local isC = iUnit:IsCombatUnit();
	local iPlayer = iUnit:GetOwner();
	for i = 0, iPlot:GetNumUnits() - 1 do
		local nUnit = iPlot:GetUnit(i);
		if nUnit ~= iUnit then
			if nUnit:IsCombatUnit() == isC then
				return false;
			end
			if nUnit:GetOwner() ~= iPlayer then
				return false;
			end
		end
	end
	return true;
end

--AI stuff

function StartAIRally(iPlayer)
	for iCity in Players[iPlayer]:Cities() do
		local iut = iCity:GetProductionUnit();
		if iut ~= -1 then
			if iCity:GetUnitProductionTurnsLeft(iut) == 1 then
				SetAIRallyPointNow(iCity, iPlayer)
			end
		end
	end
end

function SetAIRallyPointNow(tCity, iPlayer)
	local pTab = {}
	for cPlot, bool in pairs(VegvarTab) do
		if cPlot:GetImprovementType() == VegvarImpro then
			if cPlot:GetOwner() == iPlayer then
				if not cPlot:IsImprovementPillaged() then
					table.insert(pTab, {Plot = cPlot, Val = 0})
				end
			end
		end
	end
	for iCity in Players[iPlayer]:Cities() do
		if iCity:IsHasBuilding(bVegvar) or iCity == tCity then
			table.insert(pTab, {Plot = iCity:Plot(), Val = 0})
		end
	end
	if #pTab > 1 then
		local iTeam = Players[iPlayer]:GetTeam();
		for i, v in pairs(Players) do
			if Teams[iTeam]:IsAtWar(v:GetTeam()) then
				for iUnit in v:Units() do
					if iUnit:IsCombatUnit() then
						if iUnit:GetPlot():IsVisible(iTeam) then
							for it, data in pairs(pTab) do
								data.Val = data.Val + Map.PlotDistance(iUnit:GetX(), iUnit:GetY(), data.Plot:GetX(), data.Plot:GetY());
							end
						end
					end
				end
				for iCity in v:Cities() do
					if iCity:Plot():IsVisible(iTeam) then
						for it, data in pairs(pTab) do
							data.Val = data.Val + Map.PlotDistance(iCity:GetX(), iCity:GetY(), data.Plot:GetX(), data.Plot:GetY());
						end
					end
				end
			end
		end
		local minValue = 999999;
		local rPoint;
		for it, data in pairs(pTab) do
			if data.Val < minValue then
				if data.Val ~= 0 then
					minValue = data.Val;
					rPoint = data.Plot;
				end
			end
		end
		if not rPoint then
			rPoint = pTab[math.random(1, #pTab)].Plot;
		end
		SetRallyPoint(tCity, rPoint)
	end
end