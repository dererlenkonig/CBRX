print("Lord of the Rings - Niit UA code ")

include("FLuaVector.lua")
local ValidImproTable = {}
local dLand = GameInfoTypes.DOMAIN_LAND;
local EraMed = GameInfoTypes.ERA_MEDIEVAL;
local ImproTipiCamp = GameInfoTypes.IMPROVEMENT_LS_NIIT_TIPI;
local TipiCampTable = {}
local dummyB = GameInfoTypes.BUILDING_LS_NIIT_TIPI_CAMP;
local misFound = GameInfoTypes.MISSION_FOUND;
local FakeInterFaceOn = false;
local genericUnitHexBorder = "GUHB";
local vTileImprovementColor = Vector4( 0.5, 0.0, 1.0, 1.0 );

function RemovableCSM( playerID, unitID, missionID )
	if missionID == misFound then
		local iUnit = Players[playerID]:GetUnitByID(unitID);
		for dPlot, data in pairs(TipiCampTable) do
			if Map.PlotDistance(dPlot:GetX(), dPlot:GetY(), iUnit:GetX(), iUnit:GetY()) < 4 then
				if Players[playerID]:GetTeam() ~= Players[data]:GetTeam() then
					return false
				end
			end
		end
	end
	return true;
end

function GetTooltipStringTipi(iPlayer)
	local str = "You can have only one active Tipi Camp.[NEWLINE][NEWLINE]Tipi Camp can be only placed in neutral visible territory. Tipi Camps block rivals from settling cities within the radius of 3.[NEWLINE][NEWLINE]Tipi Camps cannot be placed in city radius or within 3 plots from another Tipi Camp. Founding a city will remove your Tipi Camp in the area.[NEWLINE][NEWLINE]Upon training Settler, your Tipi Camp is turned into new city.[NEWLINE][NEWLINE]Upon entering Medieval Era Tipi Camps become obsolete and disappear.[NEWLINE][NEWLINE]Left-Click to place new Tipi Camp.[NEWLINE]Right-Click to center map on your Tipi Camp.";
	return str;
end

function UpdateIndicatorTop()
	local iPlayer = Game.GetActivePlayer()
	Controls.DiploCornerLink:SetHide(false)
	Controls.DiploCornerLink:SetToolTipString(GetTooltipStringTipi(iPlayer))
	Controls.UnassignedPoints:SetText(GetNumberOfTipisAvailable(iPlayer))
end

function GetNumberOfTipisAvailable(iPlayer)
	if Players[iPlayer]:GetNumCities() == 0 then
		return "";
	end
	local numb = 1;
	for dPlot, data in pairs(TipiCampTable) do
		if data == iPlayer then
			numb = numb - 1;
		end
	end
	if numb > 0 then
		return numb;
	else
		return "";
	end
end

function CheckForDeadPlayers()
	for dPlot, data in pairs(TipiCampTable) do
		if (not Players[data]:IsAlive()) or (dPlot:GetOwner() ~= -1) or (dPlot:IsCityRadius() ~= 0) then
			dPlot:SetImprovementType(-1);
			TipiCampTable[dPlot] = nil;
		end
	end
	if ValidImproTable[Game.GetActivePlayer()] then
		UpdateIndicatorTop()
	end
end

function AddTipiCampOnPlot(iPlot, iPlayer)
	TipiCampTable[iPlot] = iPlayer
	save(iPlot:GetPlotIndex() .. "LS15NiitP", iPlayer)
	iPlot:SetImprovementType(ImproTipiCamp)
end

GameEvents.TeamSetEra.Add(function(teamId, eEra)
	if eEra == EraMed then
		for player, sth in pairs(ValidImproTable) do
			if Players[player]:GetTeam() == teamId then
				for iplot, data in pairs(TipiCampTable) do
					if data == player then
						iplot:SetImprovementType(-1);
						TipiCampTable[iplot] = nil;
					end
				end
				ValidImproTable[player] = nil;
				local bEmpty = true;
				for d,h in pairs(ValidImproTable) do
					bEmpty = false;
				end
				if bEmpty then
					GameEvents.CanStartMission.Remove(RemovableCSM)
				end
				if player == Game.GetActivePlayer() then
					Controls.DiploCornerLink:SetHide(true)
				end
			end
		end
	end
end)

function IsValidNotMedieval(player)
	local iTeam = Players[player]:GetTeam();
	if Players[player]:GetCurrentEra() == EraMed then
		return false
	end
	for row in GameInfo.Technologies() do
		if row.Era == "ERA_MEDIEVAL" then
			if Teams[iTeam]:IsHasTech(row.ID) then
				return false;
			end
		end
	end
	return true;
end

local uSettler = GameInfoTypes.UNIT_SETTLER;
function CityTrainSettler(ownerId, cityId, unitId, bGold, bFaithOrCulture)
	if ValidImproTable[ownerId] then
		local iUnit = Players[ownerId]:GetUnitByID(unitId);
		if iUnit:GetUnitType() == uSettler then
			CheckForDeadPlayers()
			local vPlot = GetOldestValidTipi(ownerId)
			if vPlot then
				vPlot:SetImprovementType(-1);
				TipiCampTable[vPlot] = nil;
				for i = 0, vPlot:GetNumUnits() -1 do
					local iUnit = vPlot:GetUnit(i);
					if not iUnit:IsTrade() then
						if iUnit:GetOwner() ~= iPlayer then
							iUnit:JumpToNearestValidPlot()
						end
					end
				end
				iUnit:Kill();
				Players[ownerId]:Found(vPlot:GetX(), vPlot:GetY())
				LuaEvents.LSNiitCityFounded(ownerId)
				if ownerId == Game.GetActivePlayer() then
					Players[ownerId]:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "Our Tipi Camp turned into a new city!", "New City!", vPlot:GetX(), vPlot:GetY())
					UpdateIndicatorTop()
				end
			end
		end
	end
 end

function GiveTableOfValidBuildingPlayers(improT)
	local bEmpty = false;
	local bHuman = false;
	for i, player in pairs(improT) do
		if IsValidNotMedieval(player) then
			ValidImproTable[player] = 1;
			bEmpty = true;
			if Players[player]:IsHuman() then
				bHuman = true;
			end
		end
	end
	if ValidImproTable[Game.GetActivePlayer()] then
		UpdateIndicatorTop()
	end
	if bHuman then
		Events.GameplaySetActivePlayer.Add(UpdateIndicatorOnPlayerChange)
		GameEvents.PlayerCityFounded.Add(UpdateCityFound)
	end
	if bEmpty then
		GameEvents.CanStartMission.Add(RemovableCSM)
		GameEvents.CityTrained.Add(CityTrainSettler)
	end
end

function UpdateIndicatorOnPlayerChange()
	Controls.DiploCornerLink:SetHide(true)
	if ValidImproTable[Game.GetActivePlayer()] then
		UpdateIndicatorTop()
	end
end


function UpdateCityFound(iPlayer, x, y)
	if ValidImproTable[iPlayer] then
		CheckForDeadPlayers()
		if iPlayer == Game.GetActivePlayer() then
			UpdateIndicatorTop()
		end
	end
end

function GetOldestValidTipi(iPlayer)
	for iPlot, data in pairs(TipiCampTable) do
		if (data == iPlayer) then
			if (iPlot:GetOwner() == -1) and (iPlot:IsCityRadius() == 0) then
				return iPlot;
			end
		end
	end
	return nil;
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidImproTable[iPlayer] then
		if not Players[iPlayer]:IsHuman() then
			if Game.GetElapsedGameTurns() > 9 then
				if GetNumberOfTipisAvailable(iPlayer) ~= "" then
					DoAICheckOverNiceTipis(iPlayer)
				end
			end
		end
	end
	if Players[iPlayer]:IsBarbarian() then
		CheckForDeadPlayers()
	end
end)

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:GetImprovementType() == ImproTipiCamp then
			TipiCampTable[fPlot] = load(fPlot:GetPlotIndex() .. "LS15NiitP")
		end
	end
end)

function IndicatorClicked()
	if Players[Game.GetActivePlayer()]:IsTurnActive() then
		if Game.GetElapsedGameTurns() ~= 0 then
			if GetNumberOfTipisAvailable(Game.GetActivePlayer()) == "" then
				return;
			end
			local hTab = GetValidPlotsForImprovement(Game.GetActivePlayer());
			if #hTab > 0 then
				FakeInterFaceOn = true;
				for i, nPlot in pairs(hTab) do
					local iHexID = ToHexFromGrid( Vector2( nPlot:GetX(), nPlot:GetY()) );
					Events.SerialEventHexHighlight( iHexID, true, vTileImprovementColor, genericUnitHexBorder );
				end
			else
				Events.GameplayAlertMessage("There is no valid plot!")
			end
		else
			Events.GameplayAlertMessage("Cannot be used yet!")
		end
	end
end
Controls.DiploCornerLink:RegisterCallback( Mouse.eLClick, IndicatorClicked);

function RightClicked()
	local vPlot = GetOldestValidTipi(Game.GetActivePlayer())
	if vPlot then
		UI.LookAt(vPlot)
		local hex = ToHexFromGrid(Vector2(vPlot:GetX(), vPlot:GetY()))
		Events.GameplayFX(hex.x, hex.y)
	end
end
Controls.DiploCornerLink:RegisterCallback( Mouse.eRClick, RightClicked);

function InputHandler( uiMsg, wParam, lParam )
	if FakeInterFaceOn then
		if uiMsg == MouseEvents.LButtonUp or uiMsg == MouseEvents.RButtonUp or uiMsg == MouseEvents.PointerUp then
			local pPlot = Map.GetPlot( UI.GetMouseOverHex() );
			if (pPlot == nil) then
				return;
			end
			if CanHaveTipiCamp(pPlot, Game.GetActivePlayer()) then
				AddTipiCampOnPlot(pPlot, Game.GetActivePlayer())
				UpdateIndicatorTop()
				local hex = ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))
				Events.GameplayFX(hex.x, hex.y)
			end
			Events.ClearHexHighlights()
			FakeInterFaceOn = false;
			return true;
		elseif uiMsg == KeyEvents.KeyDown then
			if wParam == Keys.VK_ESCAPE or wParam == Keys.VK_RETURN then
				Events.ClearHexHighlights()
				FakeInterFaceOn = false;
				return true;
			end
		end
		return false;
	end
end
ContextPtr:SetInputHandler( InputHandler );

function IsNotNearAnyOtherTipiCamp(plot)
	for splot, sth in pairs(TipiCampTable) do
		if Map.PlotDistance(splot:GetX(), splot:GetY(), plot:GetX(), plot:GetY()) < 4 then
			return false;
		end
	end
	return true;
end

function CanHaveTipiCamp(plot, bPlayer)
	if plot:GetOwner() == -1 then
		if plot:IsVisible(Players[bPlayer]:GetTeam()) then
			if not plot:IsWater() then
				if not plot:IsImpassable() then
					if not plot:IsMountain() then
						if plot:GetImprovementType() == -1 then
							if plot:IsCityRadius() == 0 then
								if IsNotNearAnyOtherTipiCamp(plot) then
									return true;
								end
							end
						end
					end
				end
			end
		end
	end
	return false;
end

function GetValidPlotsForImprovement(iPlayer)
	local hTab = {}
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local plot = Map.GetPlotByIndex( i );
		if CanHaveTipiCamp(plot, iPlayer) then
			table.insert(hTab, plot)
		end
	end	
	return hTab;
end

local alAIT = {}
local pAIval = {}
local GetRiverValDis = {6,5,2}
local GetResValDis = {9,7,2}
local GetNatWondDis = {20, 10, 4}
local GetMouDist = {4, 1, 0}
local GetNWDis = {2,1,0}
local GetCtRFDis = {7,3,0}
local tSnow = GameInfoTypes.TERRAIN_SNOW;

function GetValueAIOfPlotForSettle(iPlot)
	if not pAIval[iPlot] then
		local val = 0;
		if iPlot:GetTerrainType() == tSnow then
			pAIval[iPlot] = 0;
		else
			if iPlot:IsHills() then
				val = val + 15;
			end
			if iPlot:IsRiver() then
				val = val + 9;
			end
			if iPlot:GetResourceType() ~= -1 then
				val = val + 6;
			end
			for ix = -3, 3 do
				for iy = -3, 3 do
					local nPlot = Map.GetPlot(iPlot:GetX() + ix, iPlot:GetY() + iy)
					if nPlot then
						local dis = Map.PlotDistance(iPlot:GetX(), iPlot:GetY(), nPlot:GetX(), nPlot:GetY());
						if dis < 4 and dis > 0 then
							if nPlot:GetOwner() == -1 then
								if nPlot:IsRiver() then
									val = val + GetRiverValDis[dis];
								end
								if nPlot:GetResourceType() ~= -1 then
									val = val + GetResValDis[dis];
								end
								if nPlot:GetFeatureType() ~= -1 then
									if GameInfo.Features[nPlot:GetFeatureType()].NaturalWonder then
										val = val + GetNatWondDis[dis];
									end
								end
								if nPlot:IsMountain() then
									val = val + GetMouDist[dis];
								end
								if not nPlot:IsWater() then
									val = val + GetNWDis[dis];
								end
								if nPlot:IsCityRadius() == 0 then
									val = val + GetCtRFDis[dis];
								end
							end
						end
					end
				end
			end
			pAIval[iPlot] = val;
		end
	end
	return pAIval[iPlot];
end

function CanAIHaveTipiCamp(plot, iPlayer)
	if plot:IsRevealed(Players[iPlayer]:GetTeam()) then
		if alAIT[plot] then
			return false;
		end
		if CanHaveTipiCamp(plot, iPlayer) then
			return true;
		end
		alAIT[plot] = 1;
	end
	return false;
end

function DoAICheckOverNiceTipis(iPlayer)
	local hTab = {}
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local plot = Map.GetPlotByIndex( i );
		if CanAIHaveTipiCamp(plot, iPlayer) then
			table.insert(hTab, plot)
		end
	end
	if #hTab > 0 then
		local lPlot, lValue = nil, 0;
		for i, plot in pairs(hTab) do
			local val = GetValueAIOfPlotForSettle(plot);
			if val > lValue then
				lValue = val;
				lPlot = plot;
			end
		end
		if lPlot then
			if lValue >= 75 then
				AddTipiCampOnPlot(lPlot, iPlayer)
			end
		end
	end
end

