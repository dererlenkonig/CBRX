print("Age of Thor - Viking Unit Code")

local VikingLeaderIDTrait = {}
local VikingPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_VIKING_AGE" then
		VikingLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if VikingLeaderIDTrait[player:GetLeaderType()] then
			table.insert(VikingPlayersTrait, i)
		end
	end
end

if #VikingPlayersTrait > 0 then
	include("VikingLSTraitCode")
	GiveTableOfValidTraitPlayers(VikingPlayersTrait)
end

--Unit stuff

include("IconSupport.lua")
local bType = GameInfoTypes.UNIT_LS_BERSERKER;
local misMT = GameInfoTypes.MISSION_MOVE_TO;
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
local VIP;

include( "FLuaVector" );
local genericUnitHexBorder = "GUHB";
local vTileImprovementColor = Vector4( 0.5, 0.0, 1.0, 1.0 );
local FakeInterFaceOn = false;
--newstuff

function MyButtonFunction()
	MyB:SetDisabled(true)
	if CheckUI(selUnit) then
		FakeInterFaceOn = true;
		HighlightProperTiles(selUnit:GetPlot())
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
GameEvents.UnitSetXY.Add(WalkingHet)

MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "VIKING_UNIT_ACTION_ATLAS", Controls.MyImage45 )
IconHookup(0, 64, "VIKING_UNIT_ACTION_ATLAS", Controls.MyImage64 )
MyI:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Fury[ENDCOLOR][NEWLINE][NEWLINE]Lose 10 HP and gain extra [ICON_STRENGTH] Combat Strength based on total HP missing in the combat (+4-16[ICON_STRENGTH]).[NEWLINE][NEWLINE]Cannot be used on cities.")
MyB:SetHide(true)
MyB:EnableToolTip(false)

function Selection(player, unitID, x, y, a5, bool)
	selUnit = nil;
	if bool then
		MyB:SetHide(true)
		local cUnit = Players[player]:GetUnitByID(unitID);
		if cUnit:GetUnitType() == bType then
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
Events.UnitSelectionChanged.Add( Selection );

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

GameEvents.PlayerDoTurn.Add(function(iPlayer)
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
	else
		for iUnit in Players[iPlayer]:Units() do
			if iUnit:GetUnitType() == bType then
				if CheckUI(iUnit) then
					if HasSenseForAIToUseBerserk(iUnit, iPlayer) then
						VIP = GetValidEnemyTargetForBerserk(iUnit, iPlayer)
						Vday(iUnit, iPlayer)
					end
				end
			end
		end
	end
end)

function HasSenseForAIToUseBerserk(iUnit, iPlayer)
	if iUnit:GetDamage() > 50 then
		return false;
	end
	local iPlot = GetValidEnemyTargetForBerserk(iUnit, iPlayer)
	if not iPlot then
		return false;
	end
	for i = 0, iPlot:GetNumUnits() -1 do
		local jUnit = iPlot:GetUnit(i);
		if jUnit:GetBaseCombatStrength() > 16 then
			return false;
		end
	end
	return true;
end

function EndTurnFunc(iPlayer)
	if Players[iPlayer]:IsHuman() then
		MyB:SetDisabled(true)
		if isXY then
			GameEvents.UnitSetXY.Remove(WalkingHet)
			isXY = false;
		end
	end
end
Events.AIProcessingEndedForPlayer.Add(EndTurnFunc)

function CheckUI(iUnit)
	local hPlot = iUnit:GetPlot();
	local hPlayer = iUnit:GetOwner();
	if hPlayer == HetUUPP then
		if iUnit:GetMoves() > 0 then
			if iUnit:GetDamage() < 90 then
				if not iUnit:IsEmbarked() then
					for i = 0, 5 do
						local jPlot = Map.PlotDirection(hPlot:GetX(), hPlot:GetY(), i)
						if ValidPlotToAttack(jPlot, hPlayer) then
							return true;
						end
					end
				end
			end
		end
	end
	return false;
end

function AdjustStrengthOnHPMissing(iUnit, baseStrength)
	local bonus = 0;
	local iDmg = iUnit:GetDamage();
	if iDmg > 90 then
		bonus = 16;
	elseif iDmg > 75 then
		bonus = 12;
	elseif iDmg > 50 then
		bonus = 8;
	else
		bonus = 4;
	end
	iUnit:SetBaseCombatStrength(baseStrength + bonus)
end

function Vday(iUnit, iPlayer)
	iUnit:ChangeDamage(10)
	local baseStrength = iUnit:GetBaseCombatStrength()
	local opPlot = VIP;
	AdjustStrengthOnHPMissing(iUnit, baseStrength)
	iUnit:SetMoves(1)
	iUnit:SetMadeAttack(false)
	iUnit:PushMission(misMT, opPlot:GetX(), opPlot:GetY())
	iUnit:SetBaseCombatStrength(baseStrength)
	iUnit:SetMoves(0);
end

function GetValidEnemyTargetForBerserk(iUnit, iPlayer)
	local pTeam = Teams[Players[iPlayer]:GetTeam()];
	local iPlot = iUnit:GetPlot();
	local hPlot;
	local hStr = 999;
	for i = 0, 5 do
		local jPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), i);
		if jPlot then
			if not jPlot:IsWater() then	
				if not jPlot:IsCity() then
					if not jPlot:IsImpassable() then
						if jPlot:GetNumUnits() > 0 then
							if jPlot:IsVisibleEnemyUnit(iPlayer) then
								local maxStrength = 0;
								for j = 0, jPlot:GetNumUnits() - 1 do
									local jUnit = jPlot:GetUnit(j);
									local jStr = math.floor(jUnit:GetBaseCombatStrength() * (200 - jUnit:GetDamage()) / 200);
									if jStr > maxStrength then
										maxStrength = jStr;
									end
								end
								if maxStrength < hStr then
									hPlot = jPlot;
									hStr = maxStrength;
								elseif maxStrength == hStr then
									if math.random(1,2) == 1 then
										hPlot = jPlot;
									end
								end
							end
						end
					end
				end
			end
		end
	end
	return hPlot;
end

--new targetway
function InputHandler( uiMsg, wParam, lParam )
	if FakeInterFaceOn then
		if uiMsg == MouseEvents.LButtonUp or uiMsg == MouseEvents.RButtonUp or uiMsg == MouseEvents.PointerUp then
			local pPlot = Map.GetPlot( UI.GetMouseOverHex() );
			if (pPlot == nil) then
				return;
			end
			if selUnit then
				if ValidPlotToAttack(pPlot, selUnit:GetOwner()) then
					VIP = pPlot;
					Vday(selUnit, selUnit:GetOwner())
				end
			end
			Events.ClearHexHighlights()
			FakeInterFaceOn = false;
			return;
		end
	end
end
ContextPtr:SetInputHandler( InputHandler );

function HighlightProperTiles(iPlot)
	for i = 0, 5 do
		local nPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), i);
		if ValidPlotToAttack(nPlot, Game.GetActivePlayer()) then
			local iHexID = ToHexFromGrid( Vector2( nPlot:GetX(), nPlot:GetY()) );
			Events.SerialEventHexHighlight( iHexID, true, vTileImprovementColor, genericUnitHexBorder );
		end
	end
end

function ValidPlotToAttack(jPlot, hPlayer)
	if jPlot then
		if not jPlot:IsCity() then
			if not jPlot:IsWater() then
				if not jPlot:IsImpassable() then
					if jPlot:GetNumUnits() > 0 then
						local jUnit = jPlot:GetUnit(0);
						if Teams[Players[hPlayer]:GetTeam()]:IsAtWar(Players[jUnit:GetOwner()]:GetTeam()) then
							return true;
						end
					end
				end
			end
		end
	end
end