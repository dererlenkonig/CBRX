print ("Last Bastion - Hungary Unit Code")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LS11HunUU";
include("IconSupport.lua")
include("FLuaVector.lua")
local BlArmOff = GameInfoTypes.UNIT_LS_BLACK_ARQUEBUSER;
local selUnit;
local isf = true;
local isOn = false;
local MyB = Controls.MyButton64;
local MyI = Controls.MyImage64;
local yve = 54;
local HetUUPP = Game.GetActivePlayer();
if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
	MyB = Controls.MyButton;
	MyI = Controls.MyImage45;
	yve = 38;
end
local luc = nil;
local isstretch = false;

function MyButtonFunction()
	MyB:SetDisabled(true)
	if CheckUI(selUnit) then
		DoBonusWlodyka(selUnit)
	end
end

function DoBonusWlodyka(kUnit)
	local iPlayer = kUnit:GetOwner();
	Players[iPlayer]:ChangeGold(-20);
	kUnit:ChangeDamage(-20);
	if iPlayer == Game.GetActivePlayer() then
		save(kUnit, "LS11HUU", Game.GetGameTurn())
		Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(kUnit:GetX(), kUnit:GetY()))), "-20[ICON_GOLD]", 1)
		DoCheckHetman()
	end
end

MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "HUNGARIAN_UNIT_ACTION_ATLAS", Controls.MyImage45 )
IconHookup(0, 64, "HUNGARIAN_UNIT_ACTION_ATLAS", Controls.MyImage64 )
MyB:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Soldier's Pay[ENDCOLOR][NEWLINE][NEWLINE]Heal up 20 damage for 20 [ICON_GOLD] Gold. Can be used only once per turn.[NEWLINE][NEWLINE]Does not cost movement.")
MyB:SetHide(true)

function Selection(player, unitID, x, y, a5, bool)
	selUnit = nil;
	if bool then
		MyB:SetHide(true)
		local cUnit = Players[player]:GetUnitByID(unitID);
		if cUnit:GetUnitType() == BlArmOff then
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
		if selUnit ~= nil then
			MakeItOn(selUnit)
		end
	else
		for iUnit in pPlayer:Units() do
			if iUnit:GetUnitType() == BlArmOff then
				if CheckUI(iUnit) then
					if iUnit:GetDamage() > 19 then
						DoBonusWlodyka(iUnit)
					end
				end
			end
		end
	end
end)

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	if Players[iPlayer]:IsHuman() then
		MyB:SetDisabled(true)
	end
end)

function CheckUI(iUnit)
	if iUnit then
		local hPlayer = iUnit:GetOwner();
		if iUnit:GetDamage() > 0 then
			if iUnit:GetMoves() > 0 then
				if Players[hPlayer]:GetGold() >= 20 then
					if load(iUnit, "LS11HUU") ~= Game.GetGameTurn() then
						return true;
					end
				end
			end
		end
	end
	return false;
end