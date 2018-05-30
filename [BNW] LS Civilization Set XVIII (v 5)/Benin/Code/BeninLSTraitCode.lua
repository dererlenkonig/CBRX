local BeninLeaderIDTrait = {}
local BeninLSPlayersTrait = {}
local IsStratV = false;

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_BENIN_LS_MOD" then
		BeninLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if BeninLeaderIDTrait[player:GetLeaderType()] then
			table.insert(BeninLSPlayersTrait, i)
		end
	end
end

if #BeninLSPlayersTrait == 0 then
	return
end

print("Benin - Trait Code")

include( "IconSupport" );
include( "InstanceManager" );
include("LSSaveUtils.lua")
include( "FLuaVector" );
--code

local FakeInterFaceOn = false;
local ValidPlayerTable = {}
local turnsWA = 50 -- set to 50!
local LAqT = {}
local citadels = {}
local iCitadel = GameInfoTypes.IMPROVEMENT_CITADEL;
local hIT = {}
local WorldPositionOffset = { x = 0, y = 0, z = 35 };
local g_TeamIM  = InstanceManager:new( "TeamCityBanner",  "Anchor", Controls.CityBanners );
local genericUnitHexBorder = "GUHB";
local vTileImprovementColor = Vector4( 0.5, 0.0, 1.0, 1.0 );
local uDummyAttacker = GameInfoTypes.UNIT_LS_BENIN_DUMMY
local mrangedattack = GameInfoTypes.MISSION_RANGE_ATTACK;
local VIP;

function GiveTableOfValidTraitPlayers(tab)
	local bHuman = false;
	for i, iplayer in pairs(tab) do
		if Players[iplayer]:IsHuman() then
			bHuman = true;
		end
		ValidPlayerTable[iplayer] = 1;
	end
	if bHuman then
		Events.ActivePlayerTurnStart.Add(DoTurnOnInstances)
	end
end

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:GetImprovementType() == iCitadel then
			citadels[fPlot] = 1;
		end
	end
	if ValidPlayerTable[Game.GetActivePlayer()] then
		if Players[Game.GetActivePlayer()]:IsTurnActive() then
			DoTurnOnInstances(true)
		end
	end
end)

GameEvents.BuildFinished.Add(function(iPlayer, x, y, improID)
	if improID == iCitadel then
		citadels[Map.GetPlot(x, y)] = 1;
	end
end)

GameEvents.CityCaptureComplete.Add(function(iPlayer, bCap, x, y, newPlayer)
	if ValidPlayerTable[newPlayer] then
		local sPlot = Map.GetPlot(x,y);
		save(sPlot:GetPlotIndex() .. "LS17bnLA", Game.GetGameTurn())
		LAqT[sPlot:GetPlotIndex()] = Game.GetGameTurn()
	end
end)

GameEvents.PlayerCityFounded.Add(function(iPlayer, x, y)
	if ValidPlayerTable[iPlayer] then
		local sPlot = Map.GetPlot(x,y);
		save(sPlot:GetPlotIndex() .. "LS17bnLA", Game.GetGameTurn())
		LAqT[sPlot:GetPlotIndex()] = Game.GetGameTurn()
	end
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		local gTurn = Game.GetGameTurn();
		for iCity in Players[iPlayer]:Cities() do
			if iCity:CanRangeStrikeNow() then
				save(iCity:Plot():GetPlotIndex() .. "LS17bnLA", gTurn)
				LAqT[iCity:Plot():GetPlotIndex()] = gTurn;
			end
		end
		if not Players[iPlayer]:IsHuman() then
			for iCity in Players[iPlayer]:Cities() do
				local sPlot = iCity:Plot();
				local sIndex = sPlot:GetPlotIndex();
				if not LAqT[sIndex] then
					LAqT[sIndex] = load(sIndex .. "LS17bnLA") or gTurn;
				end
				if LAqT[sIndex] + turnsWA <= gTurn then
					if IsKindValid(sPlot, iPlayer, sIndex) then
						local hTab = GetValidBerserkPlots(sPlot, iPlayer, sIndex, true)
						if #hTab > 0 then
							DoAnAbilityAttack(sPlot, sIndex, iPlayer, hTab[math.random(1,#hTab)])
						end
					end
				end
			end
			for sPlot, sth in pairs(citadels) do
				if sPlot:GetImprovementType() == iCitadel then
					if not sPlot:IsCity() then
						if sPlot:GetOwner() == iPlayer then
							local sIndex = sPlot:GetPlotIndex()
							if IsKindValid(sPlot, iPlayer, sIndex) then
								local hTab = GetValidBerserkPlots(sPlot, iPlayer, sIndex, false)
								if #hTab > 0 then
									DoAnAbilityAttack(sPlot, sIndex, iPlayer, hTab[math.random(1,#hTab)])
								end
							end
						end
					end
				else
					citadels[sPlot] = nil
				end
			end
		end
	end
end)

function OnCityRangeStrikeButtonClick(void1)
	local sPlot = Map.GetPlotByIndex(void1)
	local gPlayer = Game.GetActivePlayer();
	if FakeInterFaceOn then
		local hTab = GetValidBerserkPlots(sPlot, gPlayer, void1, sPlot:IsCity());
		if #hTab > 0 then
			DoAnAbilityAttack(sPlot, void1, Game.GetActivePlayer(), hTab[math.random(1,#hTab)])
			FakeInterFaceOn = false;
		end
	else
		if IsKindValid(sPlot, gPlayer, void1) then
			if sPlot:IsCity() then
				local sCity = sPlot:GetPlotCity();
				if sCity:CanRangeStrikeNow() then
					Events.GameplayAlertMessage("Cannot be used if there is enemy nearby.")
					return;
				end
			end
			local hTab = GetValidBerserkPlots(sPlot, gPlayer, void1, sPlot:IsCity())
			if #hTab == 0 then
				Events.GameplayAlertMessage("There is no valid target right now.")
			else
				for i, nPlot in pairs(hTab) do
					local iHexID = ToHexFromGrid( Vector2( nPlot:GetX(), nPlot:GetY()) );
					Events.SerialEventHexHighlight( iHexID, true, vTileImprovementColor, genericUnitHexBorder );
				end
				VIP = sPlot;
				FakeInterFaceOn = true;
			end
		else
			hIT[void1].CityRangeStrikeButton:SetHide(true)
		end
	end
end

function ValidPlotForAbilityAttack(sPlot, pPlot)
	local sIndex = sPlot:GetPlotIndex();
	local iTeam = Game.GetActivePlayer();
	local pTeam = Teams[iTeam];
	local dis = Map.PlotDistance(sPlot:GetX(), sPlot:GetY(), pPlot:GetX(), pPlot:GetY());
	if pPlot:IsVisible(iTeam) then
		local iDis                                  
		if sPlot:IsCity() then
			if not pPlot:IsCity() then
				return false;
			end
			if dis > 10 then
				return false;
			end
			if not pTeam:IsAtWar(Players[pPlot:GetOwner()]:GetTeam()) then
				return false;
			end
		else
			if pPlot:IsCity() then
				if dis > 3 then
					return false;
				end
				if not pTeam:IsAtWar(Players[pPlot:GetOwner()]:GetTeam()) then
					return false;
				end
			else
				if dis > 2 or dis == 0 then
					return false;
				end
				local isValidUnit = false;
				for i = 0, pPlot:GetNumUnits() -1 do
					local jUnit = pPlot:GetUnit(i);
					if not jUnit:IsTrade() then -- shouldnt happen at all
						if pTeam:IsAtWar(Players[jUnit:GetOwner()]:GetTeam()) then
							isValidUnit = true;
							break;
						end
					end
				end
				if not isValidUnit then
					return false;
				end
			end
		end
	else
		return false;
	end
	return true;
end

function InputHandler( uiMsg, wParam, lParam )
	if FakeInterFaceOn then
		if uiMsg == MouseEvents.LButtonUp or uiMsg == MouseEvents.RButtonUp or uiMsg == MouseEvents.PointerUp then
			local pPlot = Map.GetPlot( UI.GetMouseOverHex() );
			if (pPlot == nil) then
				return;
			end
			if ValidPlotForAbilityAttack(VIP, pPlot) then
				DoAnAbilityAttack(VIP, VIP:GetPlotIndex(), Game.GetActivePlayer(), pPlot)
			end
			Events.ClearHexHighlights()
			FakeInterFaceOn = false;
			return true;
		end
	end
end
ContextPtr:SetInputHandler( InputHandler );

function GetValidBerserkPlots(sPlot, gPlayer, sIndex, bCity)
	local hTab = {}
	local iTeam = Players[gPlayer]:GetTeam();
	local pTeam = Teams[iTeam]
	if bCity then
		for i, v in pairs(Players) do
			if v:IsAlive() then
				if pTeam:IsAtWar(v:GetTeam()) then
					for iCity in v:Cities() do
						if iCity:Plot():IsVisible(iTeam) then
							if iCity:GetDamage() < iCity:GetMaxHitPoints() then
								if Map.PlotDistance(sPlot:GetX(), sPlot:GetY(), iCity:GetX(), iCity:GetY()) <= 10 then
									table.insert(hTab, iCity:Plot())
								end
							end
						end
					end
				end	
			end
		end
	else
		for ix = -3, 3 do
			for iy = -3, 3 do
				local nPlot = Map.GetPlotXY(sPlot:GetX(), sPlot:GetY(), ix, iy);
				if nPlot then
					if nPlot:IsVisible(iTeam) then
						local dis = Map.PlotDistance(nPlot:GetX(), nPlot:GetY(), sPlot:GetX(), sPlot:GetY())
						if dis < 4 then
							if nPlot:IsCity() then
								local iCity = nPlot:GetPlotCity()
								if iCity:GetDamage() < iCity:GetMaxHitPoints() then
									local nOwner = nPlot:GetOwner();
									if pTeam:IsAtWar(Players[nOwner]:GetTeam()) then
										table.insert(hTab, nPlot)
									end
								end
							elseif dis < 3 and dis > 0 then
								for jt = 0, nPlot:GetNumUnits() - 1 do
									local jUnit = nPlot:GetUnit(0);
									if not jUnit:IsTrade() then
										local nOwner = jUnit:GetOwner()
										if pTeam:IsAtWar(Players[nOwner]:GetTeam()) then
											table.insert(hTab, nPlot)
										end
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
	return hTab;
end

function IsKindValid(sPlot, gPlayer, sIndex)
	local gTurn = Game.GetGameTurn();
	if sPlot:GetOwner() == gPlayer then
		if Players[gPlayer]:IsTurnActive() then
			if (load(sIndex .. "LS17bnJA") ~= gTurn) then
				if (not sPlot:IsCity()) or (not sPlot:GetPlotCity():HasPerformedRangedStrikeThisTurn()) then
					if not sPlot:IsVisibleEnemyUnit() then
						if sPlot:IsCity() or (sPlot:GetImprovementType() == iCitadel and not sPlot:IsImprovementPillaged()) then
							return true;
						end
					end
				end
			end
		end
	end
	return false
end

local yz = 64;
function SetYZ(int)
	yz = int;
	for plotindex, instance in pairs(hIT) do
		instance.CityRangeStrikeButton:SetOffsetVal(0, yz);
	end
end

function DoTurnOnInstances(bInit)
	local iPlayer = Game.GetActivePlayer();
	if ValidPlayerTable[iPlayer] then
		local gTurn = Game.GetGameTurn();
		for iCity in Players[iPlayer]:Cities() do
			local sIndex = iCity:Plot():GetPlotIndex();
			if not LAqT[sIndex] then
				LAqT[sIndex] = load(sIndex .. "LS17bnLA") or gTurn;
			end
			if LAqT[sIndex] + turnsWA <= gTurn then
				if (not bInit) or (load(sIndex .. "LS17bnJA") ~= gTurn) then
					if not hIT[sIndex] then
						local controlTable = {}
						controlTable = g_TeamIM:GetInstance();
						controlTable.CityRangeStrikeButton:SetVoid1( sIndex );
						controlTable.CityRangeStrikeButton:RegisterCallback( Mouse.eLClick, OnCityRangeStrikeButtonClick );
						hIT[sIndex] = controlTable;
						if IsStratV then
							controlTable.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/StrategicViewStrikeButtons"))
						else
							controlTable.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/CityBanners"))
						end
					end
					hIT[sIndex].CityRangeStrikeButton:SetHide(false)
					local HexPos = HexToWorld( ToHexFromGrid( Vector2(iCity:GetX(), iCity:GetY() ) ) );
					hIT[sIndex].Anchor:SetWorldPosition( VecAdd( HexPos, WorldPositionOffset ) );
					hIT[sIndex].CityRangeStrikeButton:SetOffsetVal(48, 32);
				end
			end
		end
		for plot, sth in pairs(citadels) do
			if plot:GetImprovementType() == iCitadel then
				if not plot:IsCity() then
					if plot:GetOwner() == iPlayer then
						if not plot:IsImprovementPillaged() then
							if not plot:IsVisibleEnemyUnit(iPlayer) then
								local sIndex = plot:GetPlotIndex();
								if (not bInit) or (load(sIndex .. "LS17bnJA") ~= gTurn) then
									if not hIT[sIndex] then
										local controlTable = {}
										controlTable = g_TeamIM:GetInstance();
										controlTable.CityRangeStrikeButton:SetVoid1( sIndex );
										controlTable.CityRangeStrikeButton:RegisterCallback( Mouse.eLClick, OnCityRangeStrikeButtonClick );
										if IsStratV then
											controlTable.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/StrategicViewStrikeButtons"))
										else
											controlTable.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/CityBanners"))
										end
										hIT[sIndex] = controlTable;
									end
									hIT[sIndex].CityRangeStrikeButton:SetHide(false)
									hIT[sIndex].CityRangeStrikeButton:SetOffsetVal(0, 32);
									local HexPos = HexToWorld( ToHexFromGrid( Vector2(plot:GetX(), plot:GetY() ) ) );
									hIT[sIndex].Anchor:SetWorldPosition( VecAdd( HexPos, WorldPositionOffset ) );
								end
							end
						end
					end
				end
			else
				citadels[plot] = nil;
			end
		end
	end
end

local bSP = {}
for i = 1, 8 do
	table.insert(bSP, GameInfoTypes["PROMOTION_LS_BENIN_" .. i])
end

function GetDistanceReduction(sPlot, tPlot)
	local dis = Map.PlotDistance(sPlot:GetX(), sPlot:GetY(), tPlot:GetX(), tPlot:GetY())
	if dis <= 5 then
		return 17;
	elseif dis >= 10 then
		return 12;
	else
		return 22 - dis;
	end
end

function GetValidStrengthFromPlot(sPlot, iPlayer, tPlot)
	local value = 0;
	if sPlot:GetOwner() == iPlayer then
		if Players[iPlayer]:GetNumCities() > 0 then
			local cCity = Players[iPlayer]:GetCityByID(sPlot:GetCityPurchaseID()) or Players[iPlayer]:GetCapitalCity();
			if cCity then
				value = cCity:GetStrengthValue() / 2000 * GetDistanceReduction(sPlot, tPlot);
			else
				print("LS18Bn Logic error 124152")
			end
		end
	else
		print("LS18Bn Logic error 195125")
	end
	return value;
end

function DoAdjustStrengthOfUnit(jUnit, sPlot, iPlayer, tPlot)
	local gStr = GetValidStrengthFromPlot(sPlot, iPlayer, tPlot) - 1;
	for i = 1, 8 do
		local mp = math.pow(2, 8 - i);
		if gStr >= mp then
			gStr = gStr - mp;
			jUnit:SetHasPromotion(bSP[9 - i], true)
		end
	end
end

function DoAnAbilityAttack(sPlot, sIndex, iPlayer, tPlot)
	save(sIndex .. "LS17bnJA", Game.GetGameTurn())
	local jUnit = Players[iPlayer]:InitUnit(uDummyAttacker, sPlot:GetX(), sPlot:GetY());
	DoAdjustStrengthOfUnit(jUnit, sPlot, iPlayer, tPlot)
	jUnit:PushMission(mrangedattack, tPlot:GetX(), tPlot:GetY());
	jUnit:Kill();
	if hIT[sIndex] then
		hIT[sIndex].CityRangeStrikeButton:SetHide(true)
	end
end

Events.ActivePlayerTurnEnd.Add(function()
	for plotindex, instance in pairs(hIT) do
		instance.CityRangeStrikeButton:SetHide(true)
	end
end)

function OnStrategicViewStateChanged(bStrategicView, bCityBanners)
	IsStratV = bStrategicView
	for plot, instance in pairs(hIT) do
		if bStrategicView then
			instance.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/StrategicViewStrikeButtons"))
		else
			instance.Anchor:ChangeParent(ContextPtr:LookUpControl("/InGame/CityBannerManager/CityBanners"))
		end
	end
end
Events.StrategicViewStateChanged.Add(OnStrategicViewStateChanged);

GiveTableOfValidTraitPlayers(BeninLSPlayersTrait)