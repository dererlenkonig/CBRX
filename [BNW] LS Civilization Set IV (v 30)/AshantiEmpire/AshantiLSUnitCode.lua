print("Golden Stool - Ashanti Unit Code")

local AshantiCivIDBuilding = {}
local AshantiLeaderIDTrait = {}
local AshantiPlayersBuilding = {}
local AshantiPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_GOLDEN_STOOL" then
		AshantiLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_KENTE_LOOM" then
		AshantiCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if AshantiCivIDBuilding[player:GetCivilizationType()] then
			table.insert(AshantiPlayersBuilding, i)
		end
		if AshantiLeaderIDTrait[player:GetLeaderType()] then
			table.insert(AshantiPlayersTrait, i)
		end
	end
end

if #AshantiPlayersTrait > 0 then
	include("AshantiLSTraitCode")
	GiveTableOfValidTraitPlayers(AshantiPlayersTrait)
end
if #AshantiPlayersBuilding > 0 then
	include("AshantiLSBuildingCode")
	GiveTableOfValidBuildingPlayers(AshantiPlayersBuilding)
end

--

include("IconSupport.lua")
local landD = GameInfoTypes.DOMAIN_LAND;
local AkanDrummer = GameInfoTypes.UNIT_ASHANTI_WARRIOR;
local selUnit;
local isf = true;
local isOn = false;
local MyB = Controls.MyButton64;
local MyI = Controls.MyImage64;
local yve = 54;
local HetUUPP = Game.GetActivePlayer();
local akDP = GameInfoTypes.PROMOTION_AKAN_DRUMS_BONUS_MOD;
if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
	MyB = Controls.MyButton;
	MyI = Controls.MyImage45;
	yve = 38;
end
local luc = nil;
local isstretch = false;

function AkanBoomBoom(iUnit)
	local iPlayer = iUnit:GetOwner();
	iUnit:SetMoves(0);
	for jUnit in Players[iPlayer]:Units() do
		if IsValidForBoom(iUnit, jUnit) then
			jUnit:SetHasPromotion(akDP, true)
			jUnit:ChangeMoves(60);
		end
	end
end

local VPMUT = {}
local eModern = GameInfoTypes.ERA_MODERN;
function IsValidPreModernUnit(unitType)
	if not VPMUT[unitType] then
		local iTech = GameInfo.Units[unitType].PrereqTech;
		if iTech then
			local iEra = GameInfo.Technologies[iTech].Era;
			if iEra then
				VPMUT[unitType] = GameInfoTypes[iEra] < eModern;
			else
				VPMUT[unitType] = true;
			end
		end
	end
	return VPMUT[unitType];
end

function IsValidForBoom(iUnit, jUnit)
	if jUnit:GetMoves() >= jUnit:MaxMoves() then
		if not jUnit:IsHasPromotion(akDP) then
			if jUnit:IsCombatUnit() then
				if jUnit:GetDomainType() == landD then
					if not jUnit:IsEmbarked() then
						if Map.PlotDistance(jUnit:GetX(), jUnit:GetY(), iUnit:GetX(), iUnit:GetY()) < 4 then
							if IsValidPreModernUnit(jUnit:GetUnitType()) then
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

function IsSenseToBoomBoom(iUnit, iPlayer)
	local aCount = 0;
	for jUnit in Players[iPlayer]:Units() do
		if jUnit ~= iUnit then
			if IsValidForBoom(iUnit, jUnit) then
				aCount = aCount + 1;
				if aCount > 3 then
					return true;
				end
			end
		end
	end
	return false;
end

function MyButtonFunction()
	MyB:SetDisabled(true)
	if CheckUI(selUnit) then
		AkanBoomBoom(selUnit)
	end
end

MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "ASHANTI_ACTION_ALPHA_ATLAS", Controls.MyImage45 )
IconHookup(0, 64, "ASHANTI_ACTION_ALPHA_ATLAS", Controls.MyImage64 )
MyB:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Akan Drum[ENDCOLOR][NEWLINE][NEWLINE]Pre-Modern land units within 3 tiles gain +1 movement and heals +10 HP this turn. Works only on units that have not spend movement yet.[NEWLINE][NEWLINE]This action requires and consumes all movement points.")
MyB:SetHide(true)

function Selection(player, unitID, x, y, a5, bool)
	selUnit = nil;
	if bool then
		MyB:SetHide(true)
		local cUnit = Players[player]:GetUnitByID(unitID);
		if cUnit:GetUnitType() == AkanDrummer then
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
	for iUnit in pPlayer:Units() do
		if iUnit:IsHasPromotion(akDP) then
			iUnit:SetHasPromotion(akDP, false)
			iUnit:ChangeMoves(-60);
		end
	end
	HetUUPP = iPlayer;
	if pPlayer:IsHuman() then
		if selUnit ~= nil then
			MakeItOn(selUnit)
		end
	else
		for iUnit in pPlayer:Units() do
			if iUnit:GetUnitType() == AkanDrummer then
				if not iUnit:IsEmbarked() then
					if IsSenseToBoomBoom(iUnit, iPlayer) then
						AkanBoomBoom(iUnit)
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
			if iUnit:GetMoves() >= iUnit:MaxMoves() then
				if not iUnit:IsEmbarked() then
					return true;
				end
			end
		end
	end
	return false;
end