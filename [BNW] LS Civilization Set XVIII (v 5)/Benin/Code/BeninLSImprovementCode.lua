print("Benin - Improvement Code")

include( "FLuaVector" );
include( "InstanceManager" );
include("IconSupport.lua")

-------------------------------------------------
-- Yield Icon Manager
-------------------------------------------------
local g_AnchorIM = InstanceManager:new( "AnchorInstance", "Anchor", Controls.Scrap );
local afterLoad = false;
local gTA = {}
local sImageLink = {[0] = "Image0", [4] = "Image4", [5] = "Image5"}
local gIYAt = {}
local gMTT = {}
local ValidPlayerTable = {}
local dLand = GameInfoTypes.DOMAIN_LAND;
local buildingHP = GameInfoTypes.BUILDING_DUMMY_LS_BENIN_HP;
local defProms = {GameInfoTypes.PROMOTION_LS_BENIN_IYA_1, GameInfoTypes.PROMOTION_LS_BENIN_IYA_2, GameInfoTypes.PROMOTION_LS_BENIN_IYA_3, GameInfoTypes.PROMOTION_LS_BENIN_IYA_4, GameInfoTypes.PROMOTION_LS_BENIN_IYA_5, GameInfoTypes.PROMOTION_LS_BENIN_IYA_6}
local cBPL = {}
local bCBPL = false;
local bCR = 0;
local iDelay = 0;
local AIDream = {}
local BeninTT = {}
BeninTT[0] = {
{"BeninLSWallD0V1F.dds" , "BeninLSWallD0V1.dds"},
{"BeninLSWallD0V2F.dds" , "BeninLSWallD0V2.dds"},
{"BeninLSWallD0V3F.dds" , "BeninLSWallD0V3.dds"},
{"BeninLSWallD0V4F.dds" , "BeninLSWallD0V4.dds"},
{"BeninLSWallD0V5F.dds" , "BeninLSWallD0V5.dds"}
}
BeninTT[4] = {
{"BeninLSWallD4V1F.dds" , "BeninLSWallD4V1.dds"},
{"BeninLSWallD4V2F.dds" , "BeninLSWallD4V2.dds"},
{"BeninLSWallD4V3F.dds" , "BeninLSWallD4V3.dds"},
{"BeninLSWallD4V4F.dds" , "BeninLSWallD4V4.dds"},
{"BeninLSWallD4V5F.dds" , "BeninLSWallD4V5.dds"}
}
BeninTT[5] = {
{"BeninLSWallD5V1F.dds" , "BeninLSWallD5V1.dds"},
{"BeninLSWallD5V2F.dds" , "BeninLSWallD5V2.dds"},
{"BeninLSWallD5V3F.dds" , "BeninLSWallD5V3.dds"},
{"BeninLSWallD5V4F.dds" , "BeninLSWallD5V4.dds"},
{"BeninLSWallD5V5F.dds" , "BeninLSWallD5V5.dds"}
}

for i,v in pairs(Players) do
	for iUnit in v:Units() do
		if iUnit:GetDomainType() == dLand then
			if not iUnit:IsTrade() then
				gMTT[iUnit] = iUnit:GetPlot()
			end
		end
	end
end

function UpdateVisibilityAll()
	local iTeam = Game.GetActivePlayer();
	for plot, instance in pairs(gTA) do
		for dir, link in pairs(sImageLink) do
--			instance[link]:SetTexture(BeninTT[dir][instance.Var[dir]][1]);
			instance[link]:SetHide(true);
		end
		if plot:IsRevealed(iTeam) then
			if gIYAt[plot] then
				for dir, link in pairs(sImageLink) do
					if gIYAt[plot][dir] then
						if plot:IsVisible(iTeam) then
							gTA[plot][link]:SetTexture(BeninTT[dir][gTA[plot].Var[dir]][2]);
						else
							gTA[plot][link]:SetTexture(BeninTT[dir][gTA[plot].Var[dir]][1]);
						end
						gTA[plot][link]:SetHide(false);
					end
				end
			end
		end
	end
end
Events.GameplaySetActivePlayer.Add(UpdateVisibilityAll)

function GiveTableOfValidImproPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
	end
end

function GetVariationTab(x, y, fPlot)
	local sqrt = math.pow(x * 100 + y + fPlot:GetTerrainType() * 10, 1/2)
	return {[0] = 1 + math.floor(sqrt)% #BeninTT[0], [4] = 1 + math.floor(sqrt*1000)% #BeninTT[4], [5] = 1 + math.floor(sqrt*10000)% #BeninTT[5]}
end

function BuildYield( x, y, i )
	local fPlot = Map.GetPlot(x, y);
	local AnchorInstance = g_AnchorIM:GetInstance();
--	AnchorInstance.Image:SetTexture("BeninTest" .. i .. ".dds");
	local cc1 = HexToWorld(ToHexFromGrid(Vector2(x, y)));
--	AnchorInstance.Anchor:SetWorldPosition( VecAdd( HexToWorld( ToHexFromGrid( Vector2( x, y) ) ), {x = 0, y = 0, z = cc1.z} ) );
	AnchorInstance.Anchor:SetWorldPosition( {["x"] = cc1.x, ["y"] = cc1.y, ["w"] = cc1.w, ["z"] = cc1.z/ 2} );
	AnchorInstance.Var = GetVariationTab(x, y, fPlot);
	AnchorInstance.Anchor:ChangeParent( Controls.YieldStore );
--	AnchorInstance.Stack:SetHide(not fPlot:IsActiveVisible())
	for dir, link in pairs(sImageLink) do
		AnchorInstance[link]:SetTexture(BeninTT[dir][AnchorInstance.Var[dir]][1]);
		AnchorInstance[link]:SetHide(true);
	end
	gTA[fPlot] = AnchorInstance;
end

Events.SequenceGameInitComplete.Add(function()
	Controls.YieldStore:ChangeParent( ContextPtr:LookUpControl("/InGame/YieldIconManager/YieldStore"))
	local mx, my = Map.GetGridSize();
	local gTeam = Game.GetActiveTeam();
	for i = 0, my - 1 do
		for j = 0, mx - 1 do
			local fPlot = Map.GetPlot(j, my - 1 - i );
			if not fPlot:IsWater() then
				if not fPlot:IsMountain() then
					BuildYield( j, my - 1 - i, 1)
					local oIndex = fPlot:GetPlotIndex();
					local numIYa = load(oIndex .. "LSbnNI");
					if numIYa and numIYa > 0 then
						local hTab = GetTabOfIYAData(numIYa)
						gIYAt[fPlot] = {}
						for px, dir in pairs(hTab) do
							gIYAt[fPlot][dir] = load(oIndex .. "LSbnDI" .. dir); 
--							local sPlot = Map.PlotDirection(j, my- 1 -i, dir);
				--			if sImageLink[dir] then
			--					if fPlot:IsRevealed(gTeam) then
		--							gTA[fPlot][sImageLink[dir]]:SetHide(false)
		--							if fPlot:IsVisible(gTeam) then
	--									gTA[fPlot][sImageLink[dir]]:SetTexture(BeninTT[dir][gTA[fPlot].Var[dir]][2]);
--									end
--								end
--							end
						end
						local AIdreamN = load(oIndex .. "LSbnAID");
						if AIdreamN then
							local aiTab = GetTabOfIYAData(AIdreamN)
							AIDream[fPlot] = {}
							for px, dir in pairs(hTab) do
								AIDream[fPlot][dir] = 1;
							end
						end
					end
				end
			end
		end
	end
	afterLoad = true;
	UpdateVisibilityAll()
end)

function OnHexFogEvent( hexPos, fowType, bWholeMap )
	if afterLoad then
		if fowType == 2 or fowType == 1 then
			local gridPosX, gridPosY = ToGridFromHex( hexPos.x, hexPos.y );
			local plot = Map.GetPlot( gridPosX, gridPosY );
			if plot then
				if gIYAt[plot] then
					for dir, link in pairs(sImageLink) do
						if gIYAt[plot][dir] then
							if fowType == 2 then
								gTA[plot][link]:SetTexture(BeninTT[dir][gTA[plot].Var[dir]][2]);
							else
								gTA[plot][link]:SetTexture(BeninTT[dir][gTA[plot].Var[dir]][1]);
							end
							if gTA[plot][link]:IsHidden() then
									gTA[plot][link]:SetHide(false);
							end
						end
					end
				end
			end
		end
	end
end
Events.HexFOWStateChanged.Add( OnHexFogEvent );

function GetNumPlayersIYAs(sPlot, sPlayer)
	local num = 0;
	if gIYAt[sPlot] then
		for dir, indexplot in pairs(gIYAt[sPlot]) do
			if Map.GetPlotByIndex(indexplot):GetOwner() == sPlayer then
				num = num + 1;
			end
		end
	end
	return num;
end

function GetNumHPExtra(sPlot, sPlayer)
	local numIya = GetNumPlayersIYAs(sPlot, sPlayer)
	if numIya > 0 then
		return 2 + numIya * 3;
	else
		return 0;
	end
end

function ValidUnitForIYADefense(sUnit)
	if sUnit:IsCombatUnit() and sUnit:GetDomainType() == dLand then
		return true;
	end
	return false;
end

function DoCheckIyaDefense(sUnit, sPlot)
	if ValidUnitForIYADefense(sUnit) then
		local val = GetNumPlayersIYAs(sPlot, sUnit:GetOwner())
		for i, prom in pairs(defProms) do
			sUnit:SetHasPromotion(prom, i == val)
		end
	end
end

function UpdateAllStuffIya(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		DoCheckIyaDefense(iUnit, iUnit:GetPlot())
	end
end

GameEvents.CityCaptureComplete.Add(function(iPlayer, bCap, x, y, newPlayer)
	local sPlot = Map.GetPlot(x,y);
	if gIYAt[sPlot] then
		for iDir, sth in pairs(gIYAt[sPlot]) do
			local iPlot = Map.PlotDirection(x, y, iDir);
			RemoveAnIyaBetweenPlots(sPlot, iPlot, false)
		end
		UpdateAllStuffIya(iPlayer)
		UpdateAllStuffIya(newPlayer)
	end
end)

GameEvents.PlayerCityFounded.Add(function(iPlayer, x, y)
	local cCity = Map.GetPlot(x, y):GetPlotCity();
	cCity:SetNumRealBuilding(buildingHP, GetNumHPExtra(cCity:Plot(), iPlayer))
end)

function CheckIyaBonusesOnPlot(sPlot)
	if sPlot:IsCity() then
		local cCity = sPlot:GetPlotCity();
		cCity:SetNumRealBuilding(buildingHP, GetNumHPExtra(sPlot, cCity:GetOwner()))
	end
	for i = 0, sPlot:GetNumUnits() - 1 do
		local sUnit = sPlot:GetUnit(i);
		DoCheckIyaDefense(sUnit, sPlot)
	end
end

function RemoveAnIyaBetweenPlots(sPlot, iPlot, bUpdate)
	local iDir= GetDirectionFrom(sPlot, iPlot);
	local revDir = (iDir + 3) % 6;
	gIYAt[sPlot][iDir] = nil;
	gIYAt[iPlot][revDir] = nil;
	save(iPlot:GetPlotIndex() .. "LSbnDI" .. revDir, nil);
	save(sPlot:GetPlotIndex() .. "LSbnDI" .. iDir, nil);
	save(sPlot:GetPlotIndex() .. "LSbnNI", GetDataOfIYA(sPlot));
	save(iPlot:GetPlotIndex() .. "LSbnNI", GetDataOfIYA(iPlot));
	if bUpdate then
		CheckIyaBonusesOnPlot(sPlot)
		CheckIyaBonusesOnPlot(iPlot)
	end
	if not AIDream[sPlot] then
		AIDream[sPlot] = {}
	end
	if not AIDream[iPlot] then
		AIDream[iPlot] = {}
	end
	AIDream[sPlot][iDir] = 1;
	AIDream[iPlot][revDir] = 1;
	save(sPlot:GetPlotIndex() .. "LSbnAID", GetDataOfIYADream(sPlot));
	save(iPlot:GetPlotIndex() .. "LSbnAID", GetDataOfIYADream(iPlot));
	--check if team?
	if sImageLink[iDir] then
		gTA[sPlot][sImageLink[iDir]]:SetHide(true)
	else
		gTA[iPlot][sImageLink[revDir]]:SetHide(true)
	end
end

function GetDataOfIYADream(sPlot)
	local num = 0;
	for i = 0, 5 do
		if AIDream[sPlot][i] then
			num = num + math.pow(2, i);
		end
	end
	return num;
end

function CreateAnIyaBetweenPlots(sPlot, iPlot, iPlayer)
	if not gIYAt[sPlot] then
		gIYAt[sPlot] = {}
	end
	if not gIYAt[iPlot] then
		gIYAt[iPlot] = {}
	end
	local iDir= GetDirectionFrom(sPlot, iPlot);
	local revDir = (iDir + 3) % 6;
	local oIndex = sPlot:GetPlotIndex();
	gIYAt[sPlot][iDir] = oIndex;
	gIYAt[iPlot][revDir] = oIndex;
	save(iPlot:GetPlotIndex() .. "LSbnDI" .. revDir, oIndex);
	save(oIndex .. "LSbnDI" .. iDir, oIndex);
	save(oIndex .. "LSbnNI", GetDataOfIYA(sPlot));
	save(iPlot:GetPlotIndex() .. "LSbnNI", GetDataOfIYA(iPlot));
	CheckIyaBonusesOnPlot(sPlot)
	CheckIyaBonusesOnPlot(iPlot)
	if AIDream[sPlot] then
		AIDream[sPlot][iDir] = nil;
	end
	if AIDream[iPlot] then
		AIDream[iPlot][revDir] = nil;
	end
	if CannotBeLonger(sPlot, iPlot) then
		bCR = 2;
		iDelay = 0;
		cBPL = {}
		IterateRewardGoldenEraPoints(sPlot, iPlot, iPlayer)
	end
	local gTeam = Game.GetActiveTeam()
	if BeninTT[iDir] then
		if sPlot:IsRevealed(gTeam) then
			if sPlot:IsVisible(gTeam) then
				gTA[sPlot][sImageLink[iDir]]:SetTexture(BeninTT[iDir][gTA[sPlot].Var[iDir]][2])
			else
				gTA[sPlot][sImageLink[iDir]]:SetTexture(BeninTT[iDir][gTA[sPlot].Var[iDir]][1])
			end
			gTA[sPlot][sImageLink[iDir]]:SetHide(false)
		end
	else
		if iPlot:IsRevealed(gTeam) then
			if iPlot:IsVisible(gTeam) then
				gTA[iPlot][sImageLink[revDir]]:SetTexture(BeninTT[revDir][gTA[iPlot].Var[revDir]][2])
			else
				gTA[iPlot][sImageLink[revDir]]:SetTexture(BeninTT[revDir][gTA[iPlot].Var[revDir]][1])
			end
			gTA[iPlot][sImageLink[revDir]]:SetHide(false)
		end
	end
end

function IterateRewardGoldenEraPoints(sPlot, iPlot, iPlayer)
	local iDir= GetDirectionFrom(sPlot, iPlot);
	local revDir = (iDir + 3) % 6;
	if cBPL[sPlot:GetPlotIndex() .. "d" .. iDir] then
		return;
	end
	cBPL[sPlot:GetPlotIndex() .. "d" .. iDir] = 1;
	cBPL[iPlot:GetPlotIndex() .. "d" .. revDir] = 1;
	if iPlayer == Map.GetPlotByIndex(gIYAt[sPlot][iDir]):GetOwner() then
		if not load(sPlot:GetPlotIndex() .. "LSbnRC" .. iPlot:GetPlotIndex()) then
			save(sPlot:GetPlotIndex() .. "LSbnRC" .. iPlot:GetPlotIndex(), iPlayer)
			bCR = math.min(30, bCR + 1);
			Players[iPlayer]:ChangeGoldenAgeProgressMeter(math.floor(bCR / 3));
			if iPlayer == Game.GetActivePlayer() then
				local cc1 = HexToWorld(ToHexFromGrid(Vector2(sPlot:GetX(),sPlot:GetY())));
				local cc2 = HexToWorld(ToHexFromGrid(Vector2(iPlot:GetX(),iPlot:GetY())));
				local cc3 = {["x"]= (cc1.x + cc2.x) / 2, ["y"] = (cc1.y + cc2.y) /2, ["w"] = cc1.w, ["z"] = (cc1.z + cc2.z / 2) }
				Events.AddPopupTextEvent(cc3, math.floor(bCR / 3).. "[ICON_GOLDEN_AGE]", iDelay)
				iDelay = iDelay + 0.35;
			end
		end
	end
	local hPlot1 = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), (4 + iDir)%6);
	local hPlot2 = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), (2 + iDir)%6);
	if hPlot1 then
		if gIYAt[iPlot][GetDirectionFrom(iPlot, hPlot1)] then
			IterateRewardGoldenEraPoints(iPlot, hPlot1, iPlayer)
		end
		if gIYAt[sPlot][GetDirectionFrom(sPlot, hPlot1)] then
			IterateRewardGoldenEraPoints(sPlot, hPlot1, iPlayer)
		end
	end
	if hPlot2 then
		if gIYAt[iPlot][GetDirectionFrom(iPlot, hPlot2)] then
			IterateRewardGoldenEraPoints(iPlot, hPlot2, iPlayer)
		end
		if gIYAt[sPlot][GetDirectionFrom(sPlot, hPlot2)] then
			IterateRewardGoldenEraPoints(sPlot, hPlot2, iPlayer)
		end
	end
end

function CannotBeLonger(sPlot, iPlot)
	cBPL = {}
	local iDir= GetDirectionFrom(sPlot, iPlot);
	local revDir = (iDir + 3) % 6;
	bCBPL = false;
	TryToMakeLonger(sPlot, iPlot, iDir, revDir)
	return (not bCBPL);
end

function TryToMakeLonger(sPlot, iPlot, iDir, revDir)
	if bCBPL then
		return;
	end
	if cBPL[sPlot:GetPlotIndex() .. "d" .. iDir] then
		return;
	end
	cBPL[sPlot:GetPlotIndex() .. "d" .. iDir] = 1;
	cBPL[iPlot:GetPlotIndex() .. "d" .. revDir] = 1;
	local hPlot1 = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), (4 + iDir)%6);
	local hPlot2 = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), (2 + iDir)%6);
--		if ValidPlotToHaveAnIya(bPlot, pPlot)
	if hPlot1 then
		if ValidPlotToHaveAnIya(iPlot, hPlot1) or ValidPlotToHaveAnIya(sPlot, hPlot1) then
			bCBPL = true;
			return;
		else
			local newdir = GetDirectionFrom(iPlot, hPlot1);
			if gIYAt[iPlot][newdir] then
				TryToMakeLonger(iPlot, hPlot1, newdir, (newdir+3)%6)
			end
			newdir = GetDirectionFrom(sPlot, hPlot1);
			if gIYAt[sPlot][newdir] then
				TryToMakeLonger(sPlot, hPlot1, newdir, (newdir+3)%6)
			end
		end
	end
	if hPlot2 then
		if ValidPlotToHaveAnIya(iPlot, hPlot2) or ValidPlotToHaveAnIya(sPlot, hPlot2) then
			bCBPL = true;
			return;
		else
			local newdir = GetDirectionFrom(iPlot, hPlot2);
			if gIYAt[iPlot][newdir] then
				TryToMakeLonger(iPlot, hPlot2, newdir, (newdir+3)%6)
			end
			newdir = GetDirectionFrom(sPlot, hPlot2);
			if gIYAt[sPlot][newdir] then
				TryToMakeLonger(sPlot, hPlot2, newdir, (newdir+3)%6)
			end
		end
	end
end

function GetTabOfIYAData(numIYa)
	local num = numIYa;
	local hTab = {}
	for i = 0, 5 do
		local n = math.pow(2, 5 -i);
		if num >= n then
			num = num - n;
			table.insert(hTab, 5-i);
		end
	end
	return hTab;
end

function GetDataOfIYA(sPlot)
	local num = 0;
	for i = 0, 5 do
		if gIYAt[sPlot][i] then
			num = num + math.pow(2, i);
		end
	end
	return num;
end

-- new day
local selUnit;
local isf = true;
local isOn = false;
local MyB = Controls.MyButton64;
local MyI = Controls.MyImage64;
local yve = 54;
if OptionsManager.GetSmallUIAssets() and not UI.IsTouchScreenEnabled() then
	MyB = Controls.MyButton;
	MyI = Controls.MyImage45;
	yve = 38;
end
local luc = nil;
local isstretch = false;
local genericUnitHexBorder = "GUHB";
local vTileImprovementColor = Vector4( 0.5, 0.0, 1.0, 1.0 );
local FakeInterFaceOn = false;
--newstuff
local cWorker = GameInfoTypes.UNIT_WORKER;
local tConstruction = GameInfoTypes.TECH_CONSTRUCTION;

function MyButtonFunction()
	MyB:SetDisabled(true)
	if CheckUI(selUnit) then
		FakeInterFaceOn = true;
		HighlightProperTiles(selUnit)
	end
end

function WalkingHet(player, unit, x, y)
	local cPlot = Map.GetPlot(x,y);
	if cPlot then
		local cUnit = Players[player]:GetUnitByID(unit);
		if cUnit then
			if cUnit == selUnit then
				MyB:SetDisabled(true)
				DoCheckHetman()
			end
			DoCheckIyaDefense(cUnit, cPlot)
			if cUnit:GetDomainType() == dLand then
				if not cUnit:IsTrade() then
					if gIYAt[cPlot] and gMTT[cUnit] then
						if Map.PlotDistance(gMTT[cUnit]:GetX(), gMTT[cUnit]:GetY(), x, y) == 1 then
							local iDir = GetDirectionFrom(cPlot, gMTT[cUnit])
							if gIYAt[cPlot][iDir] then
								local iPlayer = Map.GetPlotByIndex(gIYAt[cPlot][iDir]):GetOwner()
								if iPlayer and Players[iPlayer] and iPlayer ~= player then
									if Teams[Players[iPlayer]:GetTeam()]:IsAtWar(Players[player]:GetTeam()) then
										local moves = cUnit:GetMoves();
										if moves > 0 then
											cUnit:SetMoves(0)
											if not Players[player]:IsBarbarian() then
												if cUnit:IsCombatUnit() then
													if math.random(1,100) <= moves + cUnit:GetBaseCombatStrength() then
														RemoveAnIyaBetweenPlots(gMTT[cUnit], cPlot, true)
													end
												end
											end
										end
									end
								end
							end
						end
					end
					gMTT[cUnit] = cPlot;
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(WalkingHet)

MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "CIV_MOD_ACTION_LS_18_ATLAS", Controls.MyImage45 )
IconHookup(0, 64, "CIV_MOD_ACTION_LS_18_ATLAS", Controls.MyImage64 )
MyI:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Construct a Iya[ENDCOLOR] ... 1 Turn       (Ctrl + W)[NEWLINE][NEWLINE]Iya grants defensive bonus to units (+5/8/11/14/17/20%) and increases hitpoints of cities (+10/16/22/28/34/40 HP). In addition, any enemy land unit crossing the Iya will have its whole movement removed, but may destroy an Iya in the process.")

MyB:SetHide(true)
MyB:EnableToolTip(false)

function ValidUnitTruely(cUnit, cPlayer)
	if ValidPlayerTable[cPlayer] then
		if cUnit:GetUnitType() == cWorker then
			if Teams[Players[cPlayer]:GetTeam()]:IsHasTech(tConstruction) then
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
		if ValidUnitTruely(cUnit, player) then
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
	if ValidPlayerTable[iPlayer] then
		if Players[iPlayer]:IsHuman() then
			if selUnit then
				MakeItOn(selUnit)
			end
		else
			for iUnit in Players[iPlayer]:Units() do
				if ValidUnitTruely(iUnit, iPlayer) then
					if CheckUI(iUnit) then
						--AI stuff
						local cPlot = iUnit:GetPlot();
						local doneany = false;
						if AIDream[cPlot] then
							for dir, sth in pairs(AIDream[cPlot]) do
								local dirPlot = Map.PlotDirection(cPlot:GetX(), cPlot:GetY(), dir);
								if dirPlot then
									if ValidPlotToBuildAnIya(dirPlot, iUnit) then
										Vday(iUnit, iPlayer, dirPlot)
										doneany = true;
										break;
									else
										AIDream[cPlot][dir] = nil;
										AIDream[dirPlot][(dir + 3)%6] = nil;
									end
								end
							end
						end
						if not doneany then
							MakeNewAIDream(cPlot, iPlayer, iUnit);
						end
					end
				end
			end
		end
	end
	UpdateAllStuffIya(iPlayer)
end)

function IsPlotValidForIyaBase(hPlot, hPlayer)
	if not hPlot:IsWater() then
		if not hPlot:IsMountain() then
			if hPlot:GetOwner() == hPlayer then
				return true;
			end
		end
	end
	return false;
end

function CheckUI(iUnit)
	if iUnit then
		local hPlot = iUnit:GetPlot();
		local hPlayer = iUnit:GetOwner();
		if Players[hPlayer]:IsTurnActive() then
			if iUnit:GetMoves() > 0 then
				if IsPlotValidForIyaBase(hPlot, hPlayer) then
					if #GetValidEnemyTargetForBerserk(iUnit) > 0 then
						return true
					end
				end
			end
		end
	end
	return false;
end

function Vday(iUnit, iPlayer, iPlot)
	iUnit:SetMoves(0)
	CreateAnIyaBetweenPlots(iUnit:GetPlot(), iPlot, iPlayer)
end

function GetDirectionFrom(bPlot, pPlot)
	for i = 0, 5 do
		if Map.PlotDirection(bPlot:GetX(), bPlot:GetY(), i) == pPlot then
			return i;
		end
	end
	return -1;
end

function TheDirectionIsOk(bPlot, iPlot, iDir, bDream)
	if iDir == 0 then
		if iPlot:IsNEOfRiver() then
			return false;
		end
		if gIYAt[bPlot] and gIYAt[iPlot] then
			if (gIYAt[bPlot][5] and gIYAt[iPlot][4]) or (gIYAt[bPlot][1] and gIYAt[iPlot][2]) then
				return false;
			end
		end
	elseif iDir == 1 then
		if bPlot:IsWOfRiver() then
			return false;
		end
		if gIYAt[bPlot] and gIYAt[iPlot] then
			if (gIYAt[bPlot][0] and gIYAt[iPlot][5]) or (gIYAt[bPlot][2] and gIYAt[iPlot][3]) then
				return false;
			end
		end
	elseif iDir == 2 then
		if bPlot:IsNWOfRiver() then
			return false;
		end
		if gIYAt[bPlot] and gIYAt[iPlot] then
			if (gIYAt[bPlot][1] and gIYAt[iPlot][0]) or (gIYAt[bPlot][3] and gIYAt[iPlot][4]) then
				return false;
			end
		end
	elseif iDir == 3 then
		if bPlot:IsNEOfRiver() then
			return false;
		end
		if gIYAt[bPlot] and gIYAt[iPlot] then
			if (gIYAt[bPlot][2] and gIYAt[iPlot][1]) or (gIYAt[bPlot][4] and gIYAt[iPlot][5]) then
				return false;
			end
		end
	elseif iDir == 4 then
		if iPlot:IsWOfRiver() then
			return false;
		end
		if gIYAt[bPlot] and gIYAt[iPlot] then
			if (gIYAt[bPlot][3] and gIYAt[iPlot][2]) or (gIYAt[bPlot][5] and gIYAt[iPlot][0]) then
				return false;
			end
		end
	elseif iDir == 5 then
		if iPlot:IsNWOfRiver() then
			return false;
		end
		if gIYAt[bPlot] and gIYAt[iPlot] then
			if (gIYAt[bPlot][4] and gIYAt[iPlot][3]) or (gIYAt[bPlot][0] and gIYAt[iPlot][1]) then
				return false;
			end
		end
	end
	if bDream and AIDream[bPlot] and AIDream[iPlot] then
		if (AIDream[bPlot][(iDir + 5)%6] and AIDream[iPlot][(iDir + 4)%6]) or (AIDream[bPlot][(1 + iDir)%6] and AIDream[iPlot][(iDir + 2)%6]) then
			return false;
		end
	end
	return true;
end

function ValidPlotToHaveAnIya(bPlot, pPlot)
	if pPlot then
		local iDir = GetDirectionFrom(bPlot, pPlot)
		if not pPlot:IsWater() then
			if not pPlot:IsMountain() then
				if not gIYAt[bPlot] or (not gIYAt[bPlot][iDir]) then
					if TheDirectionIsOk(bPlot, pPlot, iDir) then
						return true;
					end
				end
			end
		end
	end
	return false
end

function ValidPlotToBuildAnIya(pPlot, iUnit, bDream)
	if pPlot then
		local iPlayer = iUnit:GetOwner();
		local bPlot = iUnit:GetPlot();
		local iDir = GetDirectionFrom(bPlot, pPlot)
		if not pPlot:IsWater() then
			if not pPlot:IsMountain() then
				if Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), iUnit:GetX(), iUnit:GetY()) == 1 then
					if (not pPlot:IsCity()) or (pPlot:GetOwner() == iPlayer) or bAny then
						if not gIYAt[bPlot] or (not gIYAt[bPlot][iDir]) then
							if TheDirectionIsOk(bPlot, pPlot, iDir, bDream) then
								return true;
							end
						end
					end
				end
			end
		end
	end
	return false
end

function GetValidEnemyTargetForBerserk(iUnit, bDream)
	local hTab = {}
	for i = 0, 5 do
		local nPlot = Map.PlotDirection(iUnit:GetX(), iUnit:GetY(), i);
		if ValidPlotToBuildAnIya(nPlot, iUnit, bDream) then
			table.insert(hTab, nPlot);
		end
	end
	return hTab;
end

function InputHandler( uiMsg, wParam, lParam )
	if FakeInterFaceOn then
		if uiMsg == MouseEvents.LButtonUp or uiMsg == MouseEvents.RButtonUp or uiMsg == MouseEvents.PointerUp then
			local pPlot = Map.GetPlot( UI.GetMouseOverHex() );
			if (pPlot == nil) then
				return;
			end
			if selUnit then
				if ValidPlotToBuildAnIya(pPlot, selUnit) then
					Vday(selUnit, selUnit:GetOwner(), pPlot)
					Game.CycleUnits(true, false, false)
				end
			end
			Events.ClearHexHighlights()
			FakeInterFaceOn = false;
			return true;
		end
	elseif uiMsg == KeyEvents.KeyDown then
		if wParam == Keys.W then
			if UIManager:GetControl() then
				if selUnit then
					MyButtonFunction();
					return true;
				end
			end
		end
	end
end
ContextPtr:SetInputHandler( InputHandler );

function HighlightProperTiles(iUnit)
	local hTab = GetValidEnemyTargetForBerserk(iUnit);
	if #hTab > 0 then
		for i, nPlot in pairs(hTab) do
			local iHexID = ToHexFromGrid( Vector2( nPlot:GetX(), nPlot:GetY()) );
			Events.SerialEventHexHighlight( iHexID, true, vTileImprovementColor, genericUnitHexBorder );
		end
	else
		Events.GameplayAlertMessage("No valid placement nearby.")
	end
end

local NightmareTab = {}
function MakeNewAIDream(cPlot, iPlayer, iUnit)
	-- take all available around
	-- choose random
	-- nigthmare tab to shorten stuff if no valid before
	-- iterate both ends to create a "circle" or finish
	if NightmareTab[cPlot] then
		return
	end
	local hTab = GetValidEnemyTargetForBerserk(iUnit, true);
	if #hTab > 0 then
		StartANewDream(cPlot, hTab[math.random(1,#hTab)], iPlayer)
	else
		NightmareTab[cPlot] = 1;
	end
end

local hAID = {4, 2}
function StartANewDream(sPlot, iPlot, iPlayer)
	if not ValidPlotToHaveAnIyaDream(sPlot, iPlot, iPlayer) then
		return;
	end
	local iDir= GetDirectionFrom(sPlot, iPlot);
	local revDir = (iDir + 3) % 6;
	if not AIDream[sPlot] then
		AIDream[sPlot] = {}
	end
	if not AIDream[iPlot] then
		AIDream[iPlot] = {}
	end
	AIDream[sPlot][iDir] = 1;
	AIDream[iPlot][revDir] = 1;
	save(sPlot:GetPlotIndex() .. "LSbnAID", GetDataOfIYADream(sPlot));
	save(iPlot:GetPlotIndex() .. "LSbnAID", GetDataOfIYADream(iPlot));
	-- now let it go randomly
	local index = math.random(1, 2)
	local hPlot1 = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), (hAID[index] + iDir)%6);
	local hPlot2 = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), (hAID[index%2 + 1] + iDir)%6);
	local hTab = {}
	if hPlot1 then
		table.insert(hTab, {iPlot, hPlot1})
		table.insert(hTab, {sPlot, hPlot1})
	end
	if hPlot2 then
		table.insert(hTab, {iPlot, hPlot2})
		table.insert(hTab, {sPlot, hPlot2})
	end
	if #hTab > 0 then
		local hTab = Shuffle(hTab);
		for i, data in pairs(hTab) do
			StartANewDream(data[1], data[2], iPlayer)
		end
	end
end

function Shuffle(iTable)
	local n, order, oTable = #iTable, {}, {}
	for i=1,n do order[i] = { rnd = math.random(), idx = i } end
	table.sort(order, function(a,b) return a.rnd < b.rnd end)
	for i=1,n do oTable[i] = iTable[order[i].idx] end
	return oTable;
end


function ValidPlotToHaveAnIyaDream(bPlot, pPlot, iPlayer)
	if pPlot then
		local iDir = GetDirectionFrom(bPlot, pPlot)
		if not pPlot:IsWater() then
			if not pPlot:IsMountain() then
				if not gIYAt[bPlot] or (not gIYAt[bPlot][iDir]) then
					if not AIDream[bPlot] or (not AIDream[bPlot][iDir]) then
						if bPlot:GetOwner() == iPlayer or pPlot:GetOwner() == iPlayer then
							if TheDirectionIsOk(bPlot, pPlot, iDir, true) then
								return true;
							end
						end
					end
				end
			end
		end
	end
	return false
end