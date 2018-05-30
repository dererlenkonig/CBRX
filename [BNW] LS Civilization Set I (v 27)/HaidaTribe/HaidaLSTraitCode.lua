print("Scalping - Haida UA code")

local ValidPlayerTable = {}
local NavalMelee = GameInfoTypes.UNITCOMBAT_NAVALMELEE;
local uProm = GameInfoTypes.PROMOTION_HAIDA_LS_UA;
local HaidaXYOn = true;
local HaidaLV = {}
local HaidaLM = {}
local cStop = GameInfoTypes.COMMAND_CANCEL_ALL;
local VIT = {}
local BadImprov = {}
BadImprov[GameInfoTypes.IMPROVEMENT_BARBARIAN_CAMP] = 1;
BadImprov[GameInfoTypes.IMPROVEMENT_GOODY_HUT] = 1;

include("IconSupport.lua")
include( "FLuaVector" );
local RVIT = {}
local FakeInterFaceOn = false;
local MissionMoveTo = MissionTypes.MISSION_MOVE_TO;
local mPlunderTR = GameInfoTypes.MISSION_PLUNDER_TRADE_ROUTE
local selUnit;
local isf = true;
local isOn = false;
local MyB = Controls.MyButton64;
local MyI = Controls.MyImage64;
local yve = 54;
local isXY = true;
if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
	MyB = Controls.MyButton;
	MyI = Controls.MyImage45;
	yve = 38;
end
local luc = nil;
local isstretch = false;

function GiveTableOfValidTraitPlayers(tab)
	local bHuman = false;
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
		if Players[player]:IsHuman() then
			bHuman = true;
		end
	end
	for i, player in pairs(Players) do
		if ValidPlayerTable[i] then
			local isCP = (HaiPP == i);
			for iUnit in player:Units() do
				if iUnit:GetUnitCombatType() == NavalMelee then
					HaidaLV[iUnit] = iUnit:GetPlot();
					HaidaLM[iUnit] = iUnit:GetMoves();
					if HaiPP then
						iUnit:SetHasPromotion(uProm,HaidaUA(iUnit, iUnit:GetPlot()))
					end
				end
			end
		end
	end
	if bHuman then
		GameEvents.PlayerDoTurn.Add(ButtonStuffDoTurn)
		Events.UnitSelectionChanged.Add( Selection )
		Events.AIProcessingEndedForPlayer.Add(EndTurnButton)
		GameEvents.UnitSetXY.Add(WalkingHet)
		MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
		IconHookup(0, 45, "HAIDA_LS_ACTION_ATLAS", Controls.MyImage45 )
		IconHookup(0, 64, "HAIDA_LS_ACTION_ATLAS", Controls.MyImage64 )
		ContextPtr:SetInputHandler( InputHandler );
		MyB:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Boarding[ENDCOLOR][NEWLINE][NEWLINE]Allows unit to attack nearby naval targets or plunder a Cargo Ship.")
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		InitialCoast(iPlayer)
		if not Players[iPlayer]:IsHuman() then
			for iUnit in Players[iPlayer]:Units() do
				if IsValidUnitForEmbarkAttack(iUnit) then
					if CanPlunderOnPlot(iUnit:GetPlot(),iUnit) then
						DoNavalPlunder(iUnit)
					end
					if HasValidPlotToMoveOn(iUnit) then
						if #VIT > 0 then
							DoAILogicForVITTable(iUnit)
						end
					end
				end
			end
		end
	end
end)

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		for iUnit in Players[iPlayer]:Units() do
			iUnit:SetHasPromotion(uProm,false);
		end
	end
end)

function InitialCoast(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:GetUnitCombatType() == NavalMelee then
			HaidaLM[iUnit] = iUnit:GetMoves();
			iUnit:SetHasPromotion(uProm, HaidaUA(iUnit, iUnit:GetPlot()))
		end
	end
end

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	if HaidaXYOn then
		if ValidPlayerTable[player] then
			local cPlot = Map.GetPlot(x,y);
			if cPlot then
				local cUnit = Players[player]:GetUnitByID(unit);
				if cUnit:GetUnitCombatType() == NavalMelee then
					cUnit:SetHasPromotion(uProm,HaidaUA(cUnit, cPlot))
				end
			end
		end
	end
end)

function HaidaUA(cUnit, dPlot)
	local cPlot = dPlot;
	local cPlayer = cUnit:GetOwner();
	local hPlot = HaidaLV[cUnit];
	if hPlot then
		if (not cPlot:IsWater()) or cPlot:IsImpassable() then
			if not cPlot:IsCity() then
				if hPlot then
					HaidaXYOn = false;
					cUnit:DoCommand(cStop)
					cUnit:SetXY(hPlot:GetX(), hPlot:GetY())
					cUnit:SetMoves(HaidaLM[cUnit])
					HaidaXYOn = true;
					if cPlayer ~= Game.GetActivePlayer() then
						return false;
					else
						cPlot = hPlot;
					end
				end
			end
		end
		if Map.PlotDistance(cPlot:GetX(), cPlot:GetY(), hPlot:GetX(), hPlot:GetY()) > 1 then
			if cUnit:CanMoveThrough(hPlot) then
				HaidaXYOn = false;
				cUnit:DoCommand(cStop)
				cUnit:SetXY(hPlot:GetX(), hPlot:GetY())
				cUnit:SetMoves(HaidaLM[cUnit])
				HaidaXYOn = true;
				if cPlayer ~= Game.GetActivePlayer() then
					return false;
				else
					cPlot = hPlot;
				end
			end
		end
	end
	HaidaLV[cUnit] = cPlot;
	HaidaLM[cUnit] = cUnit:GetMoves();
	local cPlayer = cUnit:GetOwner();
	for i = 0, 5 do
		local iPlot = Map.PlotDirection(cPlot:GetX(), cPlot:GetY(), i)
		if iPlot ~= nil then
			if not iPlot:IsWater() then
				if BadImprov[iPlot:GetImprovementType()] then
					return true;
				end
				if iPlot:GetNumUnits() > 0 then
					local iUnit = iPlot:GetUnit(0);
					local iPlayer = iUnit:GetOwner();
					if Players[cPlayer]:GetTeam() ~= Players[iPlayer]:GetTeam() then
						return true;
					end
				end
			end
		end
	end
	return false;
end

--New Code For Embarked Units Attacking Naval Targets


function DoNavalPlunder(iUnit)	
	iUnit:SetEmbarked(false)
	iUnit:SetHasPromotion(uProm, true)
	iUnit:PushMission(mPlunderTR)
	iUnit:SetHasPromotion(uProm, false)
	iUnit:SetEmbarked(true)
end

function MyButtonFunction()
	if CheckUI(selUnit) then
		local sPlot = selUnit:GetPlot()
		if CanPlunderOnPlot(sPlot,selUnit) then
			DoNavalPlunder(selUnit)
			MyB:SetDisabled(true)
			DoCheckHetman()
		else
			HighLightUpPlots(selUnit)
		end
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

function IsValidUnitForEmbarkAttack(cUnit)
	if ValidPlayerTable[cUnit:GetOwner()] then
		if cUnit:IsEmbarked() then
			if cUnit:GetBaseRangedCombatStrength() < 1 then
				return true;
			end
		end
	end
	return false;
end

function Selection(player, unitID, x, y, a5, bool)
	selUnit = nil;
	if bool then
		MyB:SetHide(true)
		local cUnit = Players[player]:GetUnitByID(unitID);
		if IsValidUnitForEmbarkAttack(cUnit) then
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
	if Players[iPlayer]:IsHuman() then
		if not isXY then
			GameEvents.UnitSetXY.Add(WalkingHet)
			isXY = true;
		end
		if selUnit then
			MakeItOn(selUnit)
		end
	end
end

function CheckUI(iUnit)
	local hPlayer = iUnit:GetOwner();
	if iUnit:GetMoves() > 0 then
		if Players[hPlayer]:IsTurnActive() then
			if iUnit:IsEmbarked() then
				if CanPlunderOnPlot(iUnit:GetPlot(), iUnit) or HasValidPlotToMoveOn(iUnit) then
					return true;
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
			AttackNavalTargetNow(pPlot)
			Events.ClearHexHighlights()
			FakeInterFaceOn = false;
		end
	end
end

function HasValidPlotToMoveOn(iUnit)
	VIT = {}
	RVIT = {}
	local bPlot = iUnit:GetPlot()
	for i = 0, 5 do
		local jPlot = Map.PlotDirection(iUnit:GetX(), iUnit:GetY(), i)
		if jPlot then
			if CanAttackNavalTargetThere(jPlot, iUnit) then
				table.insert(VIT, jPlot)
				RVIT[jPlot] = true;
			end
		end
	end
	if #VIT > 0 then
		return true
	end
	return false;
end

function CanAttackNavalTargetThere(iPlot, iUnit)
	if iPlot:IsImpassable() or (not iPlot:IsWater()) or (iPlot:GetNumUnits() == 0) then
		return false;
	end
	return Teams[Players[iUnit:GetOwner()]:GetTeam()]:IsAtWar(Players[iPlot:GetUnit(0):GetOwner()]:GetTeam());
end

function HighLightUpPlots()
	for i, iPlot in pairs(VIT) do
		local iHexID = ToHexFromGrid( Vector2( iPlot:GetX(), iPlot:GetY()) );
		Events.SerialEventHexHighlight( iHexID, true, turn1Color, "MovementRangeBorder" );
	end
	FakeInterFaceOn = true;
end

function AttackNavalTargetNow(pPlot)
	if selUnit then
		if CanAttackNavalTargetThere(pPlot, selUnit) then
			NowTruelyAttackATarget(selUnit, pPlot)
			MyB:SetDisabled(true)
			DoCheckHetman()
		end
	end
end

function NowTruelyAttackATarget(selUnit, pPlot)
	selUnit:SetHasPromotion(uProm, true)
	selUnit:SetEmbarked(false)
	selUnit:PushMission(MissionMoveTo, pPlot:GetX(), pPlot:GetY())
	if selUnit then
		if not selUnit:IsDead() then
			selUnit:SetHasPromotion(uProm, false)
			selUnit:SetEmbarked(true)
		end
	end
end

function DoAILogicForVITTable(iUnit)
	local hstr = (100 - iUnit:GetDamage()) * iUnit:GetBaseCombatStrength();
	for i, plot in pairs(VIT) do
		local bstr = -1;
		for j =0, plot:GetNumUnits() -1 do
			local jUnit = plot:GetUnit(j);
			local jStr = (100 - jUnit:GetDamage()) * jUnit:GetBaseCombatStrength();
			if jStr > bstr then
				bstr = jStr;
			end
		end
		if bstr <= hstr then
			NowTruelyAttackATarget(iUnit, plot)
			return;
		end
	end
end

function CanPlunderOnPlot(plot, unit)
	local pTeam = Teams[Players[unit:GetOwner()]:GetTeam()];
	for i = 0, plot:GetNumLayerUnits() -1 do
		if pTeam:IsAtWar(Players[plot:GetLayerUnit(i):GetOwner()]:GetTeam()) then
			return true;
		end
	end
	return false;
end