print ("Ndongo - Ndongo Building Code ")

include("IconSupport.lua")
include( "FLuaVector" );
local ValidPlayerTable = {}
local gRiverT = {}
local gRiverC = 0;
local hRiverT = {}
local tCoast = GameInfoTypes.TERRAIN_COAST;
local activePlayer = Game.GetActivePlayer();
local activeTeam = Game.GetActiveTeam();
local shadowT = {}
local VIT = {}
local RVIT = {}
local ValidD = {}
local dLand = GameInfoTypes.DOMAIN_LAND;
local dSea = GameInfoTypes.DOMAIN_SEA;
ValidD[dLand] = true;
ValidD[dSea] = true;
FakeInterFaceOn = false;
local bUnique = GameInfoTypes.BUILDING_LS_NDONGO_UB;

--button butter

local selUnit;
local isf = true;
local isOn = false;
local MyB = Controls.MyButton64;
local MyI = Controls.MyImage64;
local yve = 54;
local HetUUPP = 0;
local isXY = true;
if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
	MyB = Controls.MyButton;
	MyI = Controls.MyImage45;
	yve = 38;
end
local luc = nil;
local isstretch = false;

function GiveTableOfValidBuildingPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
	end
	if ValidPlayerTable[activePlayer] then
		GameEvents.PlayerDoTurn.Add(ButtonStuffDoTurn)
		Events.UnitSelectionChanged.Add( Selection )
		GameEvents.UnitSetXY.Add(WalkingHet)
		MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
		IconHookup(0, 45, "NDONGO_LS_ACTION_ATLAS", Controls.MyImage45 )
		IconHookup(0, 64, "NDONGO_LS_ACTION_ATLAS", Controls.MyImage64 )
		ContextPtr:SetInputHandler( InputHandler );
		MyB:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Rivercraft[ENDCOLOR][NEWLINE][NEWLINE]Can use Rivers to quick-travel. This action costs only 1 movement point, but unit will be unable to attack for the rest of turn.")
	end
end

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:IsRiver() then
			MakeRiverT(fPlot)
		end
	end
	hRiverT = nil;
end)

function MakeRiverT(iPlot)
	if iPlot:IsNEOfRiver() then
		if not hRiverT[iPlot:GetPlotIndex() .. "x3"] then
			hRiverT[iPlot:GetPlotIndex() .. "x3"] = 1;
			gRiverC = gRiverC + 1;
			gRiverT[gRiverC] = {}
			gRiverT[gRiverC][iPlot] = 1;
			MakeRiverNE(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 4), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 3), iPlot, gRiverC)
		end
	end
	if iPlot:IsNWOfRiver() then
		if not hRiverT[iPlot:GetPlotIndex() .. "x2"] then
			hRiverT[iPlot:GetPlotIndex() .. "x2"] = 1;
			gRiverC = gRiverC + 1;
			gRiverT[gRiverC] = {}
			gRiverT[gRiverC][iPlot] = 1;
			MakeRiverNW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 3), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), iPlot, gRiverC)
		end
	end
	if iPlot:IsWOfRiver() then		
		if not hRiverT[iPlot:GetPlotIndex() .. "x1"] then
			hRiverT[iPlot:GetPlotIndex() .. "x1"] = 1;
			gRiverC = gRiverC + 1;
			gRiverT[gRiverC] = {}
			gRiverT[gRiverC][iPlot] = 1;
			MakeRiverW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 0), iPlot, gRiverC)
		end
	end
end

function MakeRiverW(iPlot, sPlot, dPlot, riverID)
	if iPlot then
		gRiverT[riverID][iPlot] = 1;
		if not hRiverT[iPlot:GetPlotIndex() .. "x3"] then
			hRiverT[iPlot:GetPlotIndex() .. "x3"] = 1;
			if iPlot:IsNEOfRiver() then
				MakeRiverNE(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 4), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 3), iPlot, riverID)
			end
		end
	end
	if sPlot then
		if not (sPlot:IsNEOfRiver() or sPlot:IsNWOfRiver()) then
			if sPlot:GetTerrainType() == tCoast then
				gRiverT[riverID][sPlot] = 1;
			end
		else
			if not hRiverT[sPlot:GetPlotIndex() .. "x2"] then
				hRiverT[sPlot:GetPlotIndex() .. "x2"] = 1;
				if sPlot:IsNWOfRiver() then
					gRiverT[riverID][sPlot] = 1;
					MakeRiverNW(Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 3), Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 1), sPlot, riverID)
				end
			end
			if not hRiverT[sPlot:GetPlotIndex() .. "x3"] then
				hRiverT[sPlot:GetPlotIndex() .. "x3"] = 1;
				if sPlot:IsNEOfRiver() then
					gRiverT[riverID][sPlot] = 1;
					MakeRiverNE(Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 4), Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 3), sPlot, riverID)
				end
			end
		end
	end
	if dPlot:IsNWOfRiver() then
		if not hRiverT[dPlot:GetPlotIndex() .. "x2"] then
			hRiverT[dPlot:GetPlotIndex() .. "x2"] = 1;
			MakeRiverNW(Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 3), Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 1), dPlot, gRiverC)
		end
	end
	local lPlot = Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 2)
	if lPlot:GetTerrainType() == tCoast then
		gRiverT[riverID][lPlot] = 1;
	end
end

function MakeRiverNE(iPlot, sPlot, dPlot, riverID)
	if iPlot then
		if not (iPlot:IsWOfRiver() or iPlot:IsNWOfRiver()) then
			if iPlot:GetTerrainType() == tCoast then
				gRiverT[riverID][iPlot] = 1;
			end
		else
			if not hRiverT[iPlot:GetPlotIndex() .. "x1"] then
				hRiverT[iPlot:GetPlotIndex() .. "x1"] = 1;
				if iPlot:IsWOfRiver() then
					gRiverT[riverID][iPlot] = 1;
					MakeRiverW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 0), iPlot, riverID)
				end
			end
			if not hRiverT[iPlot:GetPlotIndex() .. "x2"] then
				hRiverT[iPlot:GetPlotIndex() .. "x2"] = 1;
				if iPlot:IsNWOfRiver() then
					gRiverT[riverID][iPlot] = 1;
					MakeRiverNW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 3), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), iPlot, riverID)
				end
			end
		end
	end
	if sPlot then
		gRiverT[riverID][sPlot] = 1;
		if not hRiverT[sPlot:GetPlotIndex() .. "x1"] then
			hRiverT[sPlot:GetPlotIndex() .. "x1"] = 1;
			if sPlot:IsWOfRiver() then
				MakeRiverW(Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 1), Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 0), sPlot, riverID)
			end
		end
	end
	if dPlot:IsNWOfRiver() then
		if not hRiverT[dPlot:GetPlotIndex() .. "x2"] then
			hRiverT[dPlot:GetPlotIndex() .. "x2"] = 1;
			MakeRiverNW(Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 3), Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 1), dPlot, gRiverC)
		end
	end
	local lPlot = Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 2)
	if lPlot:GetTerrainType() == tCoast then
		gRiverT[riverID][lPlot] = 1;
	end
end

function MakeRiverNW(iPlot, sPlot, dPlot, riverID)
	if iPlot then
		if not hRiverT[iPlot:GetPlotIndex() .. "x1"] then
			hRiverT[iPlot:GetPlotIndex() .. "x1"] = 1;
			if iPlot:IsWOfRiver() then
				gRiverT[riverID][iPlot] = 1;
				MakeRiverW(Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 1), Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), 0), iPlot, riverID)
			end
		end
		if iPlot:GetTerrainType() == tCoast then
			gRiverT[riverID][iPlot] = 1;
		end
	end
	if sPlot then
		if not hRiverT[sPlot:GetPlotIndex() .. "x3"] then
			hRiverT[sPlot:GetPlotIndex() .. "x3"] = 3;
			if sPlot:IsNEOfRiver() then
				gRiverT[riverID][sPlot] = 1;
				MakeRiverNE(Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 4), Map.PlotDirection(sPlot:GetX(), sPlot:GetY(), 3), sPlot, riverID)
			end
		end
		if sPlot:GetTerrainType() == tCoast then
			gRiverT[riverID][sPlot] = 1;
		end
	end
	if dPlot:IsNEOfRiver() then
		if not hRiverT[dPlot:GetPlotIndex() .. "x3"] then
			hRiverT[dPlot:GetPlotIndex() .. "x3"] = 1;
			MakeRiverNE(Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 4), Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 3), dPlot, gRiverC)
		end
	end
	if dPlot:IsWOfRiver() then
		if not hRiverT[dPlot:GetPlotIndex() .. "x1"] then
			hRiverT[dPlot:GetPlotIndex() .. "x1"] = 1;
			MakeRiverW(Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 1), Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 0), dPlot, gRiverC)
		end
	end
	local lPlot = Map.PlotDirection(dPlot:GetX(), dPlot:GetY(), 2);
	if lPlot then
		gRiverT[riverID][lPlot] = 1;
	end
end

function GetRiverT(i)
	return gRiverT[i];
end

function GetRiversOfPlot(iPlot)
	local nTab = {}
	for i = 1, gRiverC do
		if gRiverT[i][iPlot] then
			table.insert(nTab, i)
		end
	end
	if #nTab > 0 then
		return nTab;
	end
end



function MyButtonFunction()
	if CheckUI(selUnit) then
		HighLightUpPlots(selUnit)
	end
end

function WalkingHet(player, unit, x, y)
	if Map.GetPlot(x,y) ~= nil then
		local cUnit = Players[player]:GetUnitByID(unit);
		if cUnit then
			if cUnit == selUnit then
				MyB:SetDisabled(true)
				DoCheckHetman()
			end
		end
	end
end

MyB:SetHide(true)

function ValidUnitForAction(cUnit)
	if ValidD[cUnit:GetDomainType()] and (not cUnit:IsTrade()) then
		return true;
	end
	return false;
end

function Selection(player, unitID, x, y, a5, bool)
	selUnit = nil;
	if bool then
		MyB:SetHide(true)
		local cUnit = Players[player]:GetUnitByID(unitID);
		if ValidUnitForAction(cUnit) then
			selUnit = cUnit;
			if isf then
			isf = false;
				if ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStack") then
					MyB:ChangeParent(ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStack"))
					luc = "/InGame/WorldView/UnitPanel/PrimaryStack"
					if ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStretchy") then
						isstretch = true;
					end
				else
					MyB:ChangeParent(ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel"))
					MyB:SetAnchor("L,B")
					MyB:SetOffsetVal(55, 80)
				end
			end
			MakeItOn(cUnit)
		elseif isOn then
			isOn = false;
			ReprocessAnchorStack(-1)
		end
	end
end

function ReprocessAnchorStack(int)
	if luc then
		ContextPtr:LookUpControl(luc):CalculateSize()
		ContextPtr:LookUpControl(luc):ReprocessAnchoring()
	end
	if isstretch then
		local yvh = ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStretchy"):GetSizeY()
		ContextPtr:LookUpControl("/InGame/WorldView/UnitPanel/PrimaryStretchy"):SetSizeY(yvh + int * yve)
	end

end

function MakeItOn(cUnit)
	if cUnit:GetMoves() > 0 then
		MyB:SetHide(false)
		MyB:SetDisabled(true)
		DoCheckHetman()
		if not isOn then
			isOn = true;
			ReprocessAnchorStack(1)
		end			
	end
end

function DoCheckHetman()
	MyI:SetAlpha(0.25)
	if CheckUI(selUnit) then
		MyI:SetAlpha(1)
		MyB:SetDisabled(false)
	end
end

function ButtonStuffDoTurn(iPlayer)
	local pPlayer = Players[iPlayer];
	HetUUPP = iPlayer;
	if pPlayer:IsHuman() then
		if not isXY then
			GameEvents.UnitSetXY.Add(WalkingHet)
			isXY = true;
		end
		if selUnit ~= nil then
			MakeItOn(selUnit)
		end
	end
end

function CheckUI(iUnit)
	local hPlot = iUnit:GetPlot();
	local hPlayer = iUnit:GetOwner();
	if hPlot:GetOwner() == hPlayer then
		if hPlot:IsCity() then
			if hPlot:GetPlotCity():IsHasBuilding(bUnique) then
				if iUnit:GetMoves() > 0 then
					if HetUUPP == hPlayer then
						if not iUnit:IsEmbarked() then
							if HasValidPlotToMoveOn(iUnit) then
								return true;
							end
						end
					end
				end
			end
		end
	end
	return false;
end

function EndTurnButton(iPlayer)
	if Players[iPlayer]:IsHuman() then
		MyB:SetDisabled(true)
		if isXY then
			GameEvents.UnitSetXY.Remove(WalkingHet)
			isXY = false;
		end
	end
end

function InputHandler( uiMsg, wParam, lParam )
	if FakeInterFaceOn then
		if uiMsg == MouseEvents.LButtonUp or uiMsg == MouseEvents.RButtonUp or uiMsg == MouseEvents.PointerUp then
			local pPlot = Map.GetPlot( UI.GetMouseOverHex() );
			if (pPlot == nil) then
				return;
			end
			DoMoveRiverUP(pPlot)
			Events.ClearHexHighlights()
			FakeInterFaceOn = false;
		end
	end
end


function HasValidPlotToMoveOn(iUnit)
	VIT = {}
	RVIT = {}
	local nTab = GetRiversOfPlot(iUnit:GetPlot());
	if nTab then
		for i, riverId in pairs(nTab) do
			for jPlot, nth in pairs(gRiverT[riverId]) do
				if CanMoveOntoRiverPlot(jPlot, iUnit) then
					table.insert(VIT, jPlot)
					RVIT[jPlot] = true;
				end
			end
		end
	end
	if #VIT > 0 then
		return true
	end
	return false;
end

function CanMoveOntoRiverPlot(iPlot, iUnit)
	if iPlot:IsImpassable() or iPlot:IsMountain() then
		return false;
	end
	if not iPlot:IsRevealed(iTeam) then
		return false;
	end
	local isC = iUnit:IsCombatUnit();
	local iPlayer = iUnit:GetOwner();
	local pOwner = iPlot:GetOwner();
	local iTeam = Players[iPlayer]:GetTeam();
	local isOwnT = (iPlayer == pOwner);
	local domainType = iUnit:GetDomainType();
	if not isOwnT then
		if pOwner ~= -1 then
			local pTeam = Players[pOwner]:GetTeam();
			if not Players[pOwner]:IsMinorCiv() then
				if pTeam ~= iTeam then
					if not Teams[pTeam]:IsAtWar(iTeam) then
						if not Teams[pTeam]:IsAllowsOpenBordersToTeam(iTeam) then
							return false;
						end
					end
				end
			end
		end
		if iPlot:IsCity() then
			return false;
		end
	end
	for i = 0, iPlot:GetNumUnits() - 1 do
		local nUnit = iPlot:GetUnit(i);
		if nUnit:IsCombatUnit() == isC then
			return false;
		end
		if nUnit:GetOwner() ~= iPlayer then
			return false;
		end
	end
	if domainType == dLand then
		if iPlot:IsWater() then
			return false;
		end
	elseif domainType == dSea then
		if not (iPlot:IsWater() or (iPlot:IsCity() and isOwnT)) then
			return false;
		end
	end
	return true;
end

function HighLightUpPlots()
	for i, iPlot in pairs(VIT) do
		local iHexID = ToHexFromGrid( Vector2( iPlot:GetX(), iPlot:GetY()) );
		Events.SerialEventHexHighlight( iHexID, true, turn1Color, "MovementRangeBorder" );
	end
	FakeInterFaceOn = true;
end

local pRivAt = GameInfoTypes.PROMOTION_LS_NDONGO_CHARGE_BASE
function DoMoveRiverUP(pPlot)
	if selUnit then
		if CanMoveOntoRiverPlot(pPlot, selUnit) then
			if RVIT[pPlot] then
				selUnit:SetXY(pPlot:GetX(), pPlot:GetY())
				selUnit:ChangeMoves(-60);
				if not selUnit:IsHasPromotion(pRivAt) then
					selUnit:SetMadeAttack(true);
				end
				MyB:SetDisabled(true)
				DoCheckHetman()
			end
		end
	end
end

--new code