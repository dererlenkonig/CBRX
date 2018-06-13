print ("Army with the Army - PRussia Trait code ")

include( "LSxSU.lua" );
local ValidPlayerTable = {}

function GiveTableOfValidTraitPlayers(tab)
	local bHuman = false;
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
		if Players[player]:IsHuman() then
			bHuman = true;
		end
	end
	if bHuman then
		Events.UnitSelectionChanged.Add( Selection );
		Events.AIProcessingEndedForPlayer.Add(EndTurnFunc)
		GameEvents.UnitSetXY.Add(WalkingHet)
	end
end

include("IconSupport.lua")
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
local VIP;

include( "FLuaVector" );
local genericUnitHexBorder = "GUHB";
local vTileImprovementColor = Vector4( 0.5, 0.0, 1.0, 1.0 );
local FakeInterFaceOn = false;
--newstuff
local dLand = DomainTypes.DOMAIN_LAND;
local prom = GameInfoTypes.PROMOTION_LS_PRUSSIA_ARMY;

function MyButtonFunction()
	MyB:SetDisabled(true)
	if CheckUI(selUnit) then
		MyB:SetDisabled(false)
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

MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "PRUSSIA_UNIT_ACTION_ATLAS", Controls.MyImage45 )
IconHookup(0, 64, "PRUSSIA_UNIT_ACTION_ATLAS", Controls.MyImage64 )
MyI:SetToolTipString("[COLOR_POSITIVE_TEXT]Create an Army[ENDCOLOR][NEWLINE][NEWLINE]Can merge with other unit of the same type to create a powerful unit with +10% Combat Bonus and reserved healing. The level, experience and kept promotions are based on the more experienced unit. This action consumes all movement points.")
MyB:SetHide(true)
MyB:EnableToolTip(false)

function IsValidUnit(cUnit)
	if ValidPlayerTable[cUnit:GetOwner()] then
		if cUnit:IsCombatUnit() then
			if cUnit:GetDomainType() == dLand then
				if ValidPlayerTable[cUnit:GetOwner()] then
					return true;
				end
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
		if IsValidUnit(cUnit) then
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
		MyB:SetText("")
		MyB:SetHide(false)
		MyB:SetDisabled(true)
		DoCheckHetman()
		if not isOn then
			isOn = true;
			ReprocessAnchorStack(1)
		end			
	end
end

function GetTextFromHP(HP)
	if HP > 66 then
		return "[COLOR_POSITIVE_TEXT]" .. HP .. "[ENDCOLOR]";
	elseif HP < 33 then
		return "[COLOR_NEGATIVE_TEXT]" .. HP .. "[ENDCOLOR]";
	else
		return "[COLOR_YELLOW]" .. HP .. "[ENDCOLOR]";
	end
end

function DoCheckHetman()
	MyI:SetAlpha(0.25)
	if selUnit:IsHasPromotion(prom) then
		local uID = selUnit:GetGameTurnCreated() .. "p" .. selUnit:GetOwner() .. "i" .. selUnit:GetID();
		local HP = Xload("LSxPrussiaUU" .. uID)
		MyB:SetText(GetTextFromHP(HP))
		MyI:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Army[ENDCOLOR][NEWLINE][NEWLINE]This unit has a reserve that heals it each turn till it is fully used. Reserve can be restored if unit is stationing in your territory and is undamaged (restore rate is 20 per turn).")
	else
		MyI:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Create an Army[ENDCOLOR][NEWLINE][NEWLINE]Can merge with other unit of the same type to create a powerful unit with +10% Combat Bonus and reserved healing. The level, experience and kept promotions are based on the more experienced unit. This action consumes all movement points.")
		if CheckUI(selUnit) then
			MyI:SetAlpha(1)
			MyB:SetDisabled(false)
		end
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		local pPlayer = Players[iPlayer];
		DoHealFromArmy(iPlayer)
		if pPlayer:IsHuman() then
			if not isXY then
				GameEvents.UnitSetXY.Add(WalkingHet)
				isXY = true;
			end
			if selUnit ~= nil then
				MakeItOn(selUnit)
			end
		elseif Players[iPlayer]:GetNumMilitaryUnits() > 20 then
			for iUnit in Players[iPlayer]:Units() do
				if IsValidUnit(iUnit) then
					if iUnit:GetDamage() == 0 then
						if not iUnit:IsHasPromotion(prom) then
							if iUnit:GetPlot():GetOwner() == iPlayer then
								local hTab = {}
								for i = 0, 5 do
									local jPlot = Map.PlotDirection(iUnit:GetX(), iUnit:GetY(), i);
									if jPlot then
										local bUnit = ValidPlotToMerge(jPlot, iUnit);
										if bUnit then
											if bUnit:GetDamage() == 0 then
												table.insert(hTab, bUnit)
											end
										end
									end
								end
								if #hTab > 0 then
									local exp, chosen = -1, nil;
									for i, dUnit in pairs(hTab) do
										if dUnit:GetExperience() > exp then
											exp = dUnit:GetExperience();
											chosen = dUnit;
										end
									end
									if chosen then
										VIP = chosen:GetPlot();
										DoMerge(iUnit)
										break;
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

function EndTurnFunc(iPlayer)
	if Players[iPlayer]:IsHuman() then
		MyB:SetDisabled(true)
		if isXY then
			GameEvents.UnitSetXY.Remove(WalkingHet)
			isXY = false;
		end
	end
end

function ValidPlotToMerge(jPlot, iUnit)
	local iPlayer = iUnit:GetOwner();
	if Map.PlotDistance(iUnit:GetX(), iUnit:GetY(), jPlot:GetX(), jPlot:GetY()) == 1 then
		for i = 0, jPlot:GetNumUnits() - 1 do
			local jUnit = jPlot:GetUnit(i);
			if jUnit:GetUnitType() == iUnit:GetUnitType() then
				if jUnit:GetOwner() == iPlayer then
					if not jUnit:IsHasPromotion(prom) then
						return jUnit;
					end
				end
			end
		end
	end
	return false;
end

function CheckUI(iUnit)
	local hPlot = iUnit:GetPlot();
	local hPlayer = iUnit:GetOwner();
	if Players[hPlayer]:IsTurnActive() then
		if iUnit:GetMoves() > 0 then
			if not iUnit:IsEmbarked() then
				for i = 0, 5 do
					local jPlot = Map.PlotDirection(hPlot:GetX(), hPlot:GetY(), i)
					if jPlot then
						if ValidPlotToMerge(jPlot, iUnit) then
							return true;
						end
					end
				end
			end
		end
	end
	return false;
end

function InputHandler( uiMsg, wParam, lParam )
	if FakeInterFaceOn then
		if uiMsg == MouseEvents.LButtonUp or uiMsg == MouseEvents.RButtonUp or uiMsg == MouseEvents.PointerUp then
			local pPlot = Map.GetPlot( UI.GetMouseOverHex() );
			if (pPlot == nil) then
				return;
			end
			if selUnit then
				if ValidPlotToMerge(pPlot, selUnit) then
					VIP = pPlot;
					DoMerge(selUnit)
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
		if ValidPlotToMerge(nPlot, selUnit) then
			local iHexID = ToHexFromGrid( Vector2( nPlot:GetX(), nPlot:GetY()) );
			Events.SerialEventHexHighlight( iHexID, true, vTileImprovementColor, genericUnitHexBorder );
		end
	end
end

function DoMerge(iUnit)
	local iPlot = iUnit:GetPlot();
	local getTargetUnit = ValidPlotToMerge(VIP, iUnit)
	if getTargetUnit then
		local meUnit = iUnit;
		local leUnit = getTargetUnit;
		if getTargetUnit:GetExperience() > iUnit:GetExperience() then
			meUnit = getTargetUnit;
			leUnit = iUnit;
--no extra xp
			iUnit:SetExperience(meUnit:GetExperience())
		end
		for row in GameInfo.UnitPromotions() do
			if meUnit:IsHasPromotion(row.ID) then
				iUnit:SetHasPromotion(row.ID, true)
			elseif row.CannotBeChosen then
				iUnit:SetHasPromotion(row.ID, leUnit:IsHasPromotion(row.ID))
			else
				iUnit:SetHasPromotion(row.ID, false)
			end
		end
		local HP = math.max(0, 100 - getTargetUnit:GetDamage())
		local heal = math.min(HP, iUnit:GetDamage())
		iUnit:SetLevel(meUnit:GetLevel())
		iUnit:SetMoves(0)
		if heal > 0 then
			iUnit:ChangeDamage(- heal)
			HP = HP - heal;
		end
		local uID = iUnit:GetGameTurnCreated() .. "p" .. iUnit:GetOwner() .. "i" .. iUnit:GetID();
		Xsave("LSxPrussiaUU" .. uID, HP)
		iUnit:SetHasPromotion(prom, true)
		if iPlot:IsVisible(Game.GetActiveTeam()) then
			local hex = ToHexFromGrid(Vector2(iPlot:GetX(), iPlot:GetY()))
			Events.GameplayFX(hex.x, hex.y)
		end
		getTargetUnit:Kill();
	end
end

GameEvents.UnitUpgraded.Add(function(playerId, unitId, newUnitId, bGoodyHut)
	if ValidPlayerTable[playerId] then
		local iUnit = Players[playerId]:GetUnitByID(unitId);
		local nUnit = Players[playerId]:GetUnitByID(newUnitId);
		local uID = iUnit:GetGameTurnCreated() .. "p" .. iUnit:GetOwner() .. "i" .. iUnit:GetID();
		local HP = Xload("LSxPrussiaUU" .. uID);
		if HP then
			local nID = iUnit:GetGameTurnCreated() .. "p" .. nUnit:GetOwner() .. "i" .. nUnit:GetID();
			Xsave("LSxPrussiaUU" .. nID, HP)
		end
	end
end)

function DoHealFromArmy(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		local uID = iUnit:GetGameTurnCreated() .. "p" .. iUnit:GetOwner() .. "i" .. iUnit:GetID();
		local HP = Xload("LSxPrussiaUU" .. uID);
		if HP then
			if iUnit:GetDamage() > 0 then
				local heal = math.min(HP, iUnit:GetDamage())
				iUnit:ChangeDamage(- heal)
				Xsave("LSxPrussiaUU" .. uID, HP - heal)
			elseif HP < 100 then
				if iUnit:GetPlot():GetOwner() == iPlayer then
					Xsave("LSxPrussiaUU" .. uID, math.min(100, HP + 20))
				end
			end
		end
	end
end