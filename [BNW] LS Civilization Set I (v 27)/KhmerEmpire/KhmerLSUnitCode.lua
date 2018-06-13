print ("Angkor - Khmer UU code ")

local KhmerCivIDBuilding = {}
local KhmerLeaderIDTrait = {}
local KhmerPlayersBuilding = {}
local KhmerPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_ANGKOR_THE_MAGNIFICENT" then
		KhmerLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_BARAY" then
		KhmerCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if KhmerCivIDBuilding[player:GetCivilizationType()] then
			table.insert(KhmerPlayersBuilding, i)
		end
		if KhmerLeaderIDTrait[player:GetLeaderType()] then
			table.insert(KhmerPlayersTrait, i)
		end
	end
end

if #KhmerPlayersTrait > 0 then
	include("KhmerLSTraitCode")
	GiveTableOfValidTraitPlayers(KhmerPlayersTrait)
end
if #KhmerPlayersBuilding > 0 then
	include("KhmerLSBuildingCode")
	GiveTableOfValidBuildingPlayers(KhmerPlayersBuilding)
end

-- Unique unit code 

include("IconSupport.lua")
local VII;
local nyu = GameInfoTypes.PROMOTION_KHMER_NUY_LS;
local selUnit;
local isf = true;
local isOn = false;
local MyB = Controls.MyButton64;
local MyI = Controls.MyImage64;
local yve = 54;
local isXY = true;
local iconsize = 64;
if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
	MyB = Controls.MyButton;
	MyI = Controls.MyImage45;
	yve = 38;
	iconsize = 45;
end
local luc = nil;
local isstretch = false;

local BadFeature = {}
BadFeature[GameInfoTypes.FEATURE_MARSH] = 1;
BadFeature[GameInfoTypes.FEATURE_FOREST] = 1;
BadFeature[GameInfoTypes.FEATURE_JUNGLE] = 1;
local HelpImproTable = {}
HelpImproTable[GameInfoTypes.BUILD_FARM] = GameInfoTypes.IMPROVEMENT_FARM;
HelpImproTable[GameInfoTypes.BUILD_PASTURE] = GameInfoTypes.IMPROVEMENT_PASTURE;
HelpImproTable[GameInfoTypes.BUILD_PLANTATION] = GameInfoTypes.IMPROVEMENT_PLANTATION;

local bRemoveForest = GameInfoTypes.BUILD_REMOVE_FOREST;
local fFeatureForest = GameInfoTypes.FEATURE_FOREST;

function MyButtonFunction()
	if selUnit then
		if CheckUI(selUnit) then
			CreateImprovement(selUnit, VII)
			selUnit = nil;
			MyB:SetHide(true)
			isOn = false;
			ReprocessAnchorStack(-1)
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

function IsValidUnitForAction(cUnit)
	return cUnit:IsHasPromotion(nyu);
end

function Selection(player, unitID, x, y, a5, bool)
	selUnit = nil;
	if bool then
		MyB:SetHide(true)
		local cUnit = Players[player]:GetUnitByID(unitID);
		if IsValidUnitForAction(cUnit) then
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
	else
		for iUnit in Players[iPlayer]:Units() do
			if iUnit:IsHasPromotion(nyu) then
				if iUnit:GetPlot():GetNumUnits() == 1 then
					if iUnit:GetPlot():GetImprovementType() == -1 then
						if CheckUI(iUnit) then
							CreateImprovement(iUnit, VII)
						end
					end
				end
			end
		end
	end
end

function CheckUI(iUnit)
	local iPlot =  iUnit:GetPlot();
	local hPlayer = iUnit:GetOwner();
	local hTeam = Players[hPlayer]:GetTeam();
	if iUnit:GetMoves() > 0 then
		if Players[hPlayer]:IsTurnActive() then
			if iPlot:GetOwner() == hPlayer then
				for buildID, improID in pairs(HelpImproTable) do
					if iPlot:GetImprovementType() ~= improID then
						if iPlot:CanHaveImprovement(improID, hTeam) then
							VII = improID;
							IconHookup(GameInfo.Builds[buildID].IconIndex, iconsize, GameInfo.Builds[buildID].IconAtlas, MyI )
							return true;
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

GameEvents.PlayerDoTurn.Add(ButtonStuffDoTurn)
Events.UnitSelectionChanged.Add( Selection )
GameEvents.UnitSetXY.Add(WalkingHet)
MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(21, 45, "UNIT_ACTION_ATLAS", Controls.MyImage45 )
IconHookup(21, 64, "UNIT_ACTION_ATLAS", Controls.MyImage64 )
MyB:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Rice Harvest[ENDCOLOR][NEWLINE][NEWLINE]Perform a one-time ability in a friendly land to create a farm, pasture or plantation.")

function CreateImprovement(iUnit, improID)
	iUnit:SetHasPromotion(nyu, false)
	iUnit:SetMoves(0)
	local iPlot = iUnit:GetPlot();
	if iPlot:GetFeatureType() == fFeatureForest then
		iPlot:ChangeBuildProgress(bRemoveForest, 9999, Players[iUnit:GetOwner()]:GetTeam())
	end
	if BadFeature[iPlot:GetFeatureType()] then
		iPlot:SetFeatureType(-1)
	end
	iPlot:SetImprovementType(improID)
	if iPlot:IsVisible(Game.GetActiveTeam()) then
		local hex = ToHexFromGrid(Vector2(iPlot:GetX(), iPlot:GetY()))
		Events.GameplayFX(hex.x, hex.y)
	end
end
