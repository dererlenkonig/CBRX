print("Burma - Improvement Code")

include( "FLuaVector" );
include( "IconSupport" );
include( "InstanceManager" );

-------------------------------------------------
-- Yield Icon Manager
-------------------------------------------------
local g_AnchorIM = InstanceManager:new( "AnchorInstance", "Anchor", Controls.Scrap );
local afterLoad = false;
local ValidPlayerTable = {}
local BeninTT  = {
{"BurmaLSPagodaV1F.dds" , "BurmaLSPagodaV1.dds"},
{"BurmaLSPagodaV5F.dds" , "BurmaLSPagodaV5.dds"},
{"BurmaLSPagodaV13F.dds" , "BurmaLSPagodaV13.dds"},
{"BurmaLSPagodaV6F.dds" , "BurmaLSPagodaV6.dds"},
{"BurmaLSPagodaV2F.dds" , "BurmaLSPagodaV2.dds"},
{"BurmaLSPagodaV10F.dds" , "BurmaLSPagodaV10.dds"},
{"BurmaLSPagodaV14F.dds" , "BurmaLSPagodaV14.dds"},
{"BurmaLSPagodaV7F.dds" , "BurmaLSPagodaV7.dds"},
{"BurmaLSPagodaV8F.dds" , "BurmaLSPagodaV8.dds"},
{"BurmaLSPagodaV4F.dds" , "BurmaLSPagodaV4.dds"},
{"BurmaLSPagodaV12F.dds" , "BurmaLSPagodaV12.dds"},
{"BurmaLSPagodaV9F.dds" , "BurmaLSPagodaV9.dds"},
{"BurmaLSPagodaV3F.dds" , "BurmaLSPagodaV3.dds"},
{"BurmaLSPagodaV11F.dds" , "BurmaLSPagodaV11.dds"},
{"BurmaLSPagodaV15F.dds" , "BurmaLSPagodaV15.dds"},
{"BurmaLSPagodaV16F.dds" , "BurmaLSPagodaV16.dds"},

}

local gTA = {}
local gIYAt = {}
local YieldAIValues ={
[GameInfoTypes.YIELD_FOOD] = -1,
[GameInfoTypes.YIELD_GOLD] = 1,
[GameInfoTypes.YIELD_SCIENCE] = -1,
[GameInfoTypes.YIELD_CULTURE] = -1,
[GameInfoTypes.YIELD_FAITH] = 1
}
local yRandTab = {}
for row in GameInfo.Yields() do
	table.insert(yRandTab, row.ID)
end
local YieldAIValues ={
[GameInfoTypes.YIELD_FOOD] = -1,
[GameInfoTypes.YIELD_GOLD] = 1,
[GameInfoTypes.YIELD_SCIENCE] = -1,
[GameInfoTypes.YIELD_CULTURE] = -1,
[GameInfoTypes.YIELD_FAITH] = 1
}

function GiveTableOfValidImproPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
	end
end

function UpdateVisibilityAll()
	local iTeam = Game.GetActivePlayer();
	for plot, instance in pairs(gTA) do
		instance.Image:SetHide(true);
		if plot:IsRevealed(iTeam) then
			if gIYAt[plot] then
				if plot:IsVisible(iTeam) then
					instance.Image:SetTexture(BeninTT[gTA[plot].Var][2]);
				else
					instance.Image:SetTexture(BeninTT[gTA[plot].Var][1]);
				end
				instance.Image:SetHide(false);
			end
		end
	end
end
Events.GameplaySetActivePlayer.Add(UpdateVisibilityAll)

function GetVariationTab(x, y, fPlot)
	local sqrt = math.pow(x * 100 + y + fPlot:GetTerrainType() * 10, 1/2)
	return 1 + math.floor(sqrt * 1000)% #BeninTT
end

function BuildYield( x, y, i )
	local fPlot = Map.GetPlot(x, y);
	local AnchorInstance = g_AnchorIM:GetInstance();
	local cc1 = HexToWorld(ToHexFromGrid(Vector2(x, y)));
	AnchorInstance.Anchor:SetWorldPosition( {["x"] = cc1.x, ["y"] = cc1.y, ["w"] = cc1.w, ["z"] = cc1.z/ 2} );
	AnchorInstance.Var = GetVariationTab(x, y, fPlot);
	AnchorInstance.Anchor:ChangeParent( Controls.YieldStore );
	AnchorInstance.Image:SetTexture(BeninTT[AnchorInstance.Var][1]);
	AnchorInstance.Image:SetHide(true);
	gTA[fPlot] = AnchorInstance;
end

Events.SequenceGameInitComplete.Add(function()
	Controls.YieldStore:ChangeParent( ContextPtr:LookUpControl("/InGame/YieldIconManager/YieldStore"))
	local mx, my = Map.GetGridSize();
	local gTeam = Game.GetActiveTeam();
	for i = 0, my - 1 do
		for j = 0, mx - 1 do
			local fPlot = Map.GetPlot(j, my - 1 - i );
			if IsKindaPlotValidForPagoda(fPlot) then
				BuildYield( j, my - 1 - i, 1)
				local iIndex = fPlot:GetPlotIndex();
				local eRaMade = load(iIndex .. "LS18brmNI");
				if eRaMade  then
					gIYAt[fPlot] = {}
					gIYAt[fPlot].EraMade = eRaMade
					gIYAt[fPlot].AmountExtra = load(iIndex .. "LS18brmAY")
					gIYAt[fPlot].YieldExtra = {}
					for i = 1, gIYAt[fPlot].AmountExtra do
						gIYAt[fPlot].YieldExtra[i] = load(iIndex .. "LS18brmYT" .. i)
					end
					gIYAt[fPlot].YieldRemoved = {}
					gIYAt[fPlot].ChangeValue = load(iIndex .. "LS18brmCV")
					for row in GameInfo.Yields() do
						local val = load(iIndex .. "LS18brmYR" .. row.ID)
						if val then
							gIYAt[fPlot].YieldRemoved[row.ID] = val;
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
					if fowType == 2 then
						gTA[plot].Image:SetTexture(BeninTT[gTA[plot].Var][2]);
					else
						gTA[plot].Image:SetTexture(BeninTT[gTA[plot].Var][1]);
					end
					if gTA[plot].Image:IsHidden() then
						gTA[plot].Image:SetHide(false);
					end
				end
			end
		end
	end
end
Events.HexFOWStateChanged.Add( OnHexFogEvent );

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
local tConstruction = GameInfoTypes.TECH_THEOLOGY;

function MyButtonFunction()
	MyB:SetDisabled(true)
	if CheckUI(selUnit) then
		FakeInterFaceOn = true;
		Vday(selUnit)
		Game.CycleUnits(true, false, false)
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
		end
	end
end
GameEvents.UnitSetXY.Add(WalkingHet)

MyB:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(1, 45, "CIV_MOD_ACTION_LS_18_ATLAS", Controls.MyImage45 )
IconHookup(1, 64, "CIV_MOD_ACTION_LS_18_ATLAS", Controls.MyImage64 )
MyI:LocalizeAndSetToolTip("[COLOR_POSITIVE_TEXT]Construct a Stupa[ENDCOLOR] ... 1 Turn       (Ctrl + W)[NEWLINE][NEWLINE]Rerolls the base yields of a tile. If plot with Stupa is not worked for 15 turns, the yields are rerolled again.")
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
						if AIShouldDoPagoda(iUnit:GetPlot(), Players[iPlayer]:GetTeam()) then
							Vday(iUnit)
						end
					end
				end
			end
		end
	end
	if Players[iPlayer]:IsBarbarian() then
		UpdateAllStuffStupa()
	end
end)

function CheckUI(iUnit)
	if iUnit then
		local hPlot = iUnit:GetPlot();
		local hPlayer = iUnit:GetOwner();
		if Players[hPlayer]:IsTurnActive() then
			if iUnit:GetMoves() > 0 then
				if IsKindaPlotValidForPagoda(hPlot) then
					if IsKindaPlotValidForPlayer(hPlot, hPlayer) then
						if IsHasAtLeastOneNatureYield(hPlot) then
							return true
						end
					end
				end
			end
		end
	end
	return false;
end

function Vday(iUnit)
	local iPlot = iUnit:GetPlot()
	iUnit:SetMoves(0)
	CreateAStupaOnPlot(iPlot)
end

function InputHandler( uiMsg, wParam, lParam )
	if uiMsg == KeyEvents.KeyDown then
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

function IsKindaPlotValidForPagoda(hPlot)
	if not hPlot:IsMountain() then
		if not hPlot:IsWater() then
			return true;
		end
	end
	return false;
end

function IsKindaPlotValidForPlayer(hPlot, hPlayer) 
	if hPlot:GetOwner() == hPlayer then
		if not gIYAt[hPlot] then
			if hPlot:IsCity() or hPlot:GetImprovementType() ~= -1 then
				return true;
			end
		end
	end
	return false;
end

function IsHasAtLeastOneNatureYield(iPlot)
	for row in GameInfo.Yields() do
		if iPlot:CalculateNatureYield(row.ID, -1, true) > 0 then
			return true;
		end
	end
	return false
end

function UpdateAllStuffStupa()
	for iPlot, data in pairs(gIYAt) do
		local amount = 0;
		local iIndex = iPlot:GetPlotIndex();
		for row in GameInfo.Yields() do
			local val = iPlot:CalculateNatureYield(row.ID, -1, true)
			if val > 0 then
				amount = amount + val;
			end
			if val ~= (data.YieldRemoved[row.ID] or 0) then
				Game.SetPlotExtraYield(iPlot:GetX(), iPlot:GetY(), row.ID, (data.YieldRemoved[row.ID] or 0) - val)
				gIYAt[iPlot].YieldRemoved[row.ID] = val;
				save(iIndex .. "LS18brmYR" .. row.ID, val);
			end
		end
		if amount < data.AmountExtra then
			for i = amount + 1, data.AmountExtra do
				Game.SetPlotExtraYield(iPlot:GetX(), iPlot:GetY(), data.YieldExtra[i], -1)
				save(iIndex .. "LS18brmYT" .. i, nil)
				gIYAt[iPlot].YieldExtra[i] = nil;
			end
			gIYAt[iPlot].AmountExtra = amount;
			save(iIndex .. "LS18brmAY", amount)
		elseif amount > data.AmountExtra then
			for i = data.AmountExtra + 1, amount do
				local lYield = yRandTab[math.random(1,#yRandTab)];
				save(iIndex .. "LS18brmYT" .. i, lYield)
				gIYAt[iPlot].YieldExtra[i] = lYield;
				Game.SetPlotExtraYield(iPlot:GetX(), iPlot:GetY(), lYield, 1)
			end
			gIYAt[iPlot].AmountExtra = amount;
			save(iIndex .. "LS18brmAY", amount)
		end
		if iPlot:IsBeingWorked() then
			if data.ChangeValue ~= 0 then
				gIYAt[iPlot].ChangeValue = 0;
				save(iIndex .. "LS18brmCV", 0)
			end
		elseif data.ChangeValue >= 14 then
			for i = 1, data.AmountExtra do
				local lYield = GetRandomYieldWithNoYield(data.YieldExtra[i])
				Game.SetPlotExtraYield(iPlot:GetX(), iPlot:GetY(), data.YieldExtra[i], -1)
				save(iIndex .. "LS18brmYT" .. i, lYield)
				gIYAt[iPlot].YieldExtra[i] = lYield;
				Game.SetPlotExtraYield(iPlot:GetX(), iPlot:GetY(), lYield, 1)
			end
			gIYAt[iPlot].ChangeValue = 0;
			save(iIndex .. "LS18brmCV", 0)
		else
			gIYAt[iPlot].ChangeValue = 1 + data.ChangeValue;
			save(iIndex .. "LS18brmCV", gIYAt[iPlot].ChangeValue)
		end
	end
end

function GetRandomYieldWithNoYield(bYield)
	local hTab = {}
	for i, yield in pairs(yRandTab) do
		if yield ~= bYield then
			table.insert(hTab, yield)
		end
	end
	return hTab[math.random(1,#hTab)];
end

function CreateAStupaOnPlot(iPlot)
	local iEra = Players[iPlot:GetOwner()]:GetCurrentEra();
	local iIndex = iPlot:GetPlotIndex();
	save(iIndex .. "LS18brmNI", iEra)
	gIYAt[iPlot] = {}
	gIYAt[iPlot].EraMade = iEra;
--Game.SetPlotExtraYield(32, 29, 0, -50)
--i = 1; iPlot = Map.GetPlot(33, 29); print(GameInfo.Terrains[iPlot:GetTerrainType()].Description, iPlot:GetFeatureType(), iPlot:CalculateNatureYield(i, 0), iPlot:CalculateNatureYield(i, 0, true) , iPlot:CalculateYield(0))
--nature yield unchanged by plotextrayield; use the one with feature;
	local iTeam = Players[iPlot:GetOwner()]:GetTeam();
	local hTab = {}
	local amount = 0;
	for row in GameInfo.Yields() do
		local val = iPlot:CalculateNatureYield(row.ID, -1, true)
		if val > 0 then
			amount = amount + val;
			table.insert(hTab, {row.ID, val})
		end
	end
	gIYAt[iPlot].ChangeValue = 0;
	save(iIndex .. "LS18brmCV", 0)
	gIYAt[iPlot].AmountExtra = amount;
	gIYAt[iPlot].YieldExtra = {}
	save(iIndex .. "LS18brmAY", amount)
	for i = 1, amount do
		local lYield = yRandTab[math.random(1,#yRandTab)];
		save(iIndex .. "LS18brmYT" .. i, lYield)
		gIYAt[iPlot].YieldExtra[i] = lYield;
		Game.SetPlotExtraYield(iPlot:GetX(), iPlot:GetY(), lYield, 1)
	end
	gIYAt[iPlot].YieldRemoved = {}
	for i, data in pairs(hTab) do
		gIYAt[iPlot].YieldRemoved[data[1]] = data[2];
		save(iIndex .. "LS18brmYR" .. data[1], data[2]);
		Game.SetPlotExtraYield(iPlot:GetX(), iPlot:GetY(), data[1], -1 * data[2])
	end
	local gTeam = Game.GetActiveTeam()
	if iPlot:IsRevealed(gTeam) then
		if iPlot:IsVisible(gTeam) then
			gTA[iPlot].Image:SetTexture(BeninTT[gTA[iPlot].Var][2])
		else
			gTA[iPlot].Image:SetTexture(BeninTT[gTA[iPlot].Var][1])
		end
		gTA[iPlot].Image:SetHide(false)
	end
end

function AIShouldDoPagoda(iPlot, iTeam)
	local iValue = math.random(0,21)/10 - 0.5;
	for iYield, hValue in pairs(YieldAIValues) do
		iValue = iValue + iPlot:CalculateNatureYield(iYield, -1, true) * hValue
	end
	return iValue >= 1;
end