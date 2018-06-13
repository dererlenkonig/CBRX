print ("Mapucho - Mapuche UU code ")

include("IconSupport.lua")
include("FLuaVector.lua")

local MapucheLeaderIDTrait = {}
local MapuchePlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_MAPUCHE" then
		MapucheLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if MapucheLeaderIDTrait[player:GetLeaderType()] then
			table.insert(MapuchePlayersTrait, i)
		end
	end
end

if #MapuchePlayersTrait > 0 then
	include("MapucheLSTraitCode")
	GiveTableOfValidTraitPlayers(MapuchePlayersTrait)
end

-- Unique unit code 


local TMC = GameInfoTypes.UNIT_LS_IRONWOOD_CLUBSMAN;
local Toqui = GameInfoTypes.UNIT_LS_TOQUI;
local HitPlots = {}
local dland = DomainTypes.DOMAIN_LAND;
local upgCommand = CommandTypes.COMMAND_UPGRADE;
local StratR = {}
local bTab = {}
for row in GameInfo.Resources() do
	if row.Happiness == 0 then
		table.insert(StratR, row.ID)
	end
end

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

for i, player in pairs(Players) do
	for iUnit in player:Units() do
		if iUnit:GetUnitType() == TMC then
			HitPlots[iUnit] = iUnit:GetPlot();
		end
	end
end

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	if Players[player]:GetUnitByID(unit) ~= nil then
		local cUnit = Players[player]:GetUnitByID(unit);
		if cUnit:GetUnitType() == TMC then
			local cPlot = cUnit:GetPlot();
			if cPlot ~= nil then
				if not cPlot:IsWater() then
					HitZoC(cUnit, cPlot)
				end
				HitPlots[cUnit] = cPlot;
			end
		end
	end
end)

function HitZoC(cUnit, cPlot)
	if HitPlots[cUnit] ~= nil then
		if not HitPlots[cUnit]:IsWater() then
			if Map.PlotDistance(cPlot:GetX(), cPlot:GetY(), HitPlots[cUnit]:GetX(), HitPlots[cUnit]:GetY()) == 1  then
				HitDir(cUnit, cPlot)
			end
		end
	end
end

function HitDir(cUnit, cPlot)
	for i = 0, 5 do
		if cPlot == Map.PlotDirection(HitPlots[cUnit]:GetX(), HitPlots[cUnit]:GetY(), i) then
			HitDmg(cUnit, i+6)
			return;
		end
	end
end

function HitDmg(cUnit, hTd)
	for i = 1, 2 do
		local iPlot = Map.PlotDirection(HitPlots[cUnit]:GetX(), HitPlots[cUnit]:GetY(), (hTd + math.pow(-1, i))%6)
		if iPlot:GetNumUnits() > 0 then
			if Teams[Players[cUnit:GetOwner()]:GetTeam()]:IsAtWar(Players[iPlot:GetUnit(0):GetOwner()]:GetTeam()) then
				cUnit:ChangeExperience(3)
				return;
			end
		end
	end
end

function IsInRange(iUnit, hT)
	for jUnit, jY in pairs(hT) do
		if Map.PlotDistance(iUnit:GetX(), iUnit:GetY(), jUnit:GetX(), jY) < 3 then
			return true;
		end
	end
	return false;
end

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	local isToq = false
	local ToqT = {}
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:GetUnitType() == Toqui then
			ToqT[iUnit] = iUnit:GetY();
			isToq = true;
		end
	end
	if isToq then
		local iTeam = Players[iPlayer]:GetTeam();
		for i, v in pairs(Players) do
			if Teams[v:GetTeam()]:IsAtWar(iTeam) then
				for iUnit in v:Units() do
					if iUnit:GetDamage() > 49 then
						if iUnit:GetDomainType() == dland then
							if IsInRange(iUnit, ToqT) then
								iUnit:ChangeMoves(-1 * iUnit:GetMoves() / 2)
								if iPlayer == Game.GetActivePlayer() or i == Game.GetActivePlayer() then
									if iUnit:GetPlot():IsVisible(Game.GetActiveTeam()) then
										Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iUnit:GetX(),iUnit:GetY()))), "-1[ICON_MOVES]", 0)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end)

--butter stuff

function MyButtonFunction()
	MyB:SetDisabled(true)
	if CheckUI(selUnit) then
		DoBonusWlodyka(selUnit)
	end
end

function IsValidToUpgrade(cType, iPlayer)
	if cType ~= -1 then
		local iTech = GameInfo.Technologies[GameInfo.Units[cType].PrereqTech].ID;
		if Teams[Players[iPlayer]:GetTeam()]:IsHasTech(iTech) then
			return true;
		end
	end
	return false;
end

function DoBonusWlodyka(kUnit)
	local iPlayer = kUnit:GetOwner();
	local iPlot = kUnit:GetPlot();
	if iPlayer == Game.GetActivePlayer() then
		local hex = ToHexFromGrid(Vector2(iPlot:GetX(), iPlot:GetY()))
		Events.GameplayFX(hex.x, hex.y)
	end
	kUnit:Kill()
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:IsCombatUnit() then
			if iUnit:GetDomainType() == dland then
				local modifier = 2 - Map.PlotDistance(iPlot:GetX(), iPlot:GetY(), iUnit:GetX(), iUnit:GetY());
				if modifier > 0 then
					if iUnit:GetBaseRangedCombatStrength() > 0 then
						iUnit:ChangeExperience(15 * modifier)
					else
						iUnit:ChangeExperience(25 * modifier)
					end
				end
			end
		end
	end
end

MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "MAPUCHE_LS_ACTION_ATLAS", Controls.MyImage45 )
IconHookup(0, 64, "MAPUCHE_LS_ACTION_ATLAS", Controls.MyImage64 )
MyB:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Tactical Innovation[ENDCOLOR][NEWLINE][NEWLINE]All adjacent land units have their XP increased by 25 (15 if ranged). Double bonus for stacked unit. This action consumes Great Person.")
MyB:SetHide(true)

function Selection(player, unitID, x, y, a5, bool)
	selUnit = nil;
	if bool then
		MyB:SetHide(true)
		local cUnit = Players[player]:GetUnitByID(unitID);
		if cUnit:GetUnitType() == Toqui then
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

function GetNumUnitsNearby(iPlot, iPlayer)
	local num = 0;
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:IsCombatUnit() then
			if iUnit:GetDomainType() == dland then
				if Map.PlotDistance(iPlot:GetX(), iPlot:GetY(), iUnit:GetX(), iUnit:GetY()) < 2 then
					num = num + 1;
				end
			end
		end
	end
	return num;
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	local pPlayer = Players[iPlayer];
	HetUUPP = iPlayer;
	if pPlayer:IsHuman() then
		if selUnit ~= nil then
			MakeItOn(selUnit)
		end
	elseif pPlayer:GetUnitClassCount(genClass) > 1 then
		for iUnit in pPlayer:Units() do
			if iUnit:GetUnitType() == Toqui then
				if CheckUI(iUnit) then
					if GetNumUnitsNearby(iUnit:GetPlot(), iPlayer) > 6 then
						DoBonusWlodyka(iUnit)
						break;
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
		if HetUUPP == hPlayer then
			if iUnit:GetMoves() > 0 then
				return true;
			end
		end
	end
	return false;
end