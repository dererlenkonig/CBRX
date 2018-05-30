print("Thebes - Trait Code")

include( "IconSupport" );
include( "InstanceManager" );
include( "LSSaveUtils" );

local ValidPlayerTable = {}
local bHuman = false;
local globalData = {}
local propheciesTable = {}
local options = nil;
local gInstances = {}
local textTableH = {}
local SpecialUnitTab = {}
local rewardlike = true;

LuaEvents.AdditionalInformationDropdownGatherEntries.Add(function(tab)
	if bHuman then
		table.insert(tab, {text = "Prophecies", call = function() LuaEvents.LSThebesPropheciesCall(); end}); 
	end
end)

function GiveTableOfValidTraitPlayers(tab)
	for i, iPlayer in pairs(tab) do
		ValidPlayerTable[iPlayer] = {[1] = load(iPlayer .. "LS18tbNP") or 0; [2] = load(iPlayer .. "LS18tbLE") or Game.GetStartEra(), [3] = {}};
		local numPS = load(iPlayer .. "LS18tbPSn") or 0;
		for nextID = 1, numPS do
			table.insert(ValidPlayerTable[iPlayer][3], {ID = load(iPlayer .. "LS18tbPS" .. nextID .. "ID"),
			Data1 = load(iPlayer .. "LS18tbPS" .. nextID .. "Data1"),
			Self = load(iPlayer .. "LS18tbPS" .. nextID .. "Self"),
			ChoseableData = load(iPlayer .. "LS18tbPS" .. nextID .. "ChoseableData"),
			Status = load(iPlayer .. "LS18tbPS" .. nextID .. "Status")})
		end
		if Players[iPlayer]:IsHuman() then
			bHuman = true;
		end
	end
	--it is meh in multi... spoiling civ
	if bHuman then
		Events.ActivePlayerTurnStart.Add(DoTurnHumanPlayerCheck)
		LuaEvents.RequestRefreshAdditionalInformationDropdownEntries()
	end
end

LuaEvents.LSThebesPropheciesCall.Add(function()
	local iPlayer = Game.GetActivePlayer();
	if ValidPlayerTable[iPlayer] then
		if #ValidPlayerTable[iPlayer][3] > 0 then
			CallTheUIOptions(true)
		else
			Events.GameplayAlertMessage("You have no Prophecies yet.")
		end
	else
		Events.GameplayAlertMessage("Prophecies are not meant for you.")
	end
end)

--Start Interface

local needConfirm = false;
local isVisible = false;

-- Used for Piano Keys
local ltBlue = {19/255,32/255,46/255,120/255};
local dkBlue = {12/255,22/255,30/255,120/255};

local g_ItemManager = InstanceManager:new( "ItemInstance", "Button", Controls.ItemStack );
local g_ItemManagerUnit = InstanceManager:new( "UniqueUnitIstance", "Button", Controls.ItemStack );
local bHidden = true;

local screenSizeX, screenSizeY = UIManager:GetScreenSizeVal()
local spWidth, spHeight = Controls.ItemScrollPanel:GetSizeVal();

-- Original UI designed at 1050px 
local heightOffset = screenSizeY - 1020;

spHeight = spHeight + heightOffset;
Controls.ItemScrollPanel:SetSizeVal(spWidth, spHeight); 
Controls.ItemScrollPanel:CalculateInternalSize();
Controls.ItemScrollPanel:ReprocessAnchoring();

local bpWidth, bpHeight = Controls.BottomPanel:GetSizeVal();
bpHeight = bpHeight + heightOffset;

Controls.BottomPanel:SetSizeVal(bpWidth, bpHeight);
Controls.BottomPanel:ReprocessAnchoring();

function SetCurrentSelectionPD(i, v1, v2)
	options[i].ChoseableData = v1;
	gInstances[i].PD:GetButton():SetText(textTableH[v2]);
	Controls.CloseButton:SetDisabled(ShouldSealButtonBeDisabled())
end

function ShouldSealButtonBeDisabled()
	if options and #options > 0 then
		for i, data in pairs(options) do
			if not data.Self and not data.ChoseableData and not propheciesTable[data.ID].RewardLike then
				return true;
			end
		end
	end
	return false;
end

function OnRandomize()
	local iPlayer = Game.GetActivePlayer()
	for i, data in pairs(options) do
		if not data.Self and not data.ChoseableData and not propheciesTable[data.ID].RewardLike then
			local hTab = propheciesTable[data.ID].GiveOptions(iPlayer, false, data);
			options[i].ChoseableData = hTab[math.random(1,#hTab)].Index;
		end
	end
	PlayerFinishedSealingProphecies()
	ContextPtr:SetHide(true)
end
Controls.RandomButton:RegisterCallback( Mouse.eLClick, OnRandomize );

function OnClose()
	if options and (#options > 0) then
		PlayerFinishedSealingProphecies()
	end
	ContextPtr:SetHide(true)
end
Controls.CloseButton:RegisterCallback( Mouse.eLClick, OnClose );

function CallTheUIOptions(bView)
	g_ItemManagerUnit:ResetInstances();
	gInstances = {}
	textTableH = {}

	local iPlayer = Game.GetActivePlayer();
	local pPlayer = Players[Game.GetActivePlayer()];
	CivIconHookup( pPlayer:GetID(), 64, Controls.CivIcon, Controls.CivIconBG, Controls.CivIconShadow, false, true );
	IconHookup( 6, 128, "BW_ATLAS_2", Controls.ChooseImage )
	Controls.ChooseImage:SetColor({x=0.9, y=0.5, z=0.9, w=1 })
	if bView then
		Controls.PanelTitle:SetText("Recorded Prophecies")
	else
		Controls.PanelTitle:SetText("Choose your destiny")
	end

	for i, data in pairs(options or ValidPlayerTable[iPlayer][3]) do
--		local itemInstance = g_ItemManagerUnit:GetInstance();
		itemInstance = g_ItemManagerUnit:GetInstance();
		itemInstance.Button:SetAlpha(1)
		if bView then
			itemInstance.Name:SetText(propheciesTable[data.ID].Name);
			if data.Status == 2 then
				itemInstance.Button:SetAlpha(0.75)
				itemInstance.Name:SetText("[COLOR_NEGATIVE_TEXT]" .. propheciesTable[data.ID].Name .. " - Misinterpreted[ENDCOLOR]");
			elseif data.Status == 1 then
				itemInstance.Button:SetAlpha(0.75)
				itemInstance.Name:SetText("[COLOR_POSITIVE_TEXT]" .. propheciesTable[data.ID].Name .. " - Fulfilled[ENDCOLOR]");
			end
		else
			itemInstance.Name:SetText(propheciesTable[data.ID].Name);
		end
	
		if bView or propheciesTable[data.ID].RewardLike then
			itemInstance.Description:SetText("[NEWLINE]" .. propheciesTable[data.ID].GetHelpText(data, iPlayer, false));
		else
			itemInstance.Description:SetText("[NEWLINE][NEWLINE]" .. propheciesTable[data.ID].GetHelpText(data, iPlayer, true));
		end
		itemInstance.ProdImage:SetColor({x=0.9, y=0.5, z=0.9, w=1 })
		IconHookup( propheciesTable[data.ID].PI, 64, propheciesTable[data.ID].IA, itemInstance.ProdImage )		
--		itemInstance.Button:RegisterCallback(Mouse.eLClick, function() SelectTheBonus(dataTable[currentID].BonusType, confirminfo2, social.ID, nil, nil); end);
		if bView then
			itemInstance.PD:SetHide(true)
		else
			if propheciesTable[data.ID].RewardLike then
				itemInstance.PD:SetHide(true)
			else
				itemInstance.PD:SetHide(false)
				if data.Self then
					itemInstance.PD:SetDisabled(true)
					itemInstance.PD:GetButton():SetText(data.Self);
				else
					itemInstance.PD:SetDisabled(false)
					itemInstance.PD:GetButton():SetText("");
					itemInstance.PD:ClearEntries();
					local oTab = propheciesTable[data.ID].GiveOptions(iPlayer, false, data);
					for j, jdata in pairs(oTab) do
						local controlTable = {};
						itemInstance.PD:BuildEntry( "InstanceOne", controlTable );
						table.insert(textTableH, jdata.Text)
						controlTable.Button:SetVoids(jdata.Index, #textTableH);
						controlTable.Button:SetText(jdata.Text);
					end
					itemInstance.PD:RegisterSelectionCallback(function(v1, v2)
						SetCurrentSelectionPD(i, v1, v2);
					end);
					itemInstance.PD:CalculateInternals();
				--	table.insert(hTab, {Index = i, Text = GetPlayerName(i, iTeam)})
				end
			end
		end

		if(bTickTock == false) then
			itemInstance.Box:SetColorVal(unpack(ltBlue));
		else
			itemInstance.Box:SetColorVal(unpack(dkBlue));
		end
		local buttonWidth, buttonHeight = itemInstance.Button:GetSizeVal();
		local descWidth, descHeight = itemInstance.Description:GetSizeVal();
		local newHeight = descHeight + 40;	
		itemInstance.Button:SetSizeVal(buttonWidth, newHeight);
		itemInstance.Box:SetSizeVal(buttonWidth + 20, newHeight);
		itemInstance.BounceAnim:SetSizeVal(buttonWidth + 20, newHeight + 5);
		itemInstance.BounceGrid:SetSizeVal(buttonWidth + 20, newHeight + 5);
		bTickTock = not bTickTock;
		gInstances[i] = itemInstance
	end
	

	Controls.RandomButton:SetHide(bView)
	Controls.RandomButtonLabel:SetText("Randomize")
	Controls.RandomButtonLabel:SetToolTipString("All unassigned prophecies are gonna be randomly chosen, because nobody has time for this.")
	if bView then
		Controls.NextButton:SetText("Back")
	else
		Controls.NextButton:SetText("Seal Prophecies")
	end
	Controls.CloseButton:SetDisabled(ShouldSealButtonBeDisabled())


	Controls.ItemStack:CalculateSize();
	Controls.ItemStack:ReprocessAnchoring();
	Controls.ItemScrollPanel:CalculateInternalSize();
	ContextPtr:SetHide(false)
end

--END of interface

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		if not Players[iPlayer]:IsHuman() then
			if ShouldMakeNewProphecies(iPlayer) then
				AISetNewProphecies(iPlayer)
			end
		end
	end
	CollectDataForProphecyEvents(iPlayer)
end)

Events.SequenceGameInitComplete.Add(function()
	if ValidPlayerTable[Game.GetActivePlayer()] then
		--recall back prophecies if needed
		local iPlayer = Game.GetActivePlayer();
		local numpo = load(iPlayer .. "LS18tbTPn") or 0;
		if numpo > 0 then
			options = {};
			for i = 1, numpo do
				table.insert(options, {ID = load(iPlayer .. "LS18tbTP" .. i .. "ID"),
				Self = load(iPlayer .. "LS18tbTP" .. i .. "Self"),
				Data1 = load(iPlayer .. "LS18tbTP" .. i .. "Data1")})
			end
			CallTheUIOptions()
		end
	end
end)

function DoTurnHumanPlayerCheck()
	local iPlayer = Game.GetActivePlayer();
	if ValidPlayerTable[iPlayer] then
		if ShouldMakeNewProphecies(iPlayer) then
			DoHumanNewSetOfProphecies(iPlayer)
		end
	end
end

function ShouldMakeNewProphecies(iPlayer)
	if ValidPlayerTable[iPlayer][1] < 2 then
		if Players[iPlayer]:GetCurrentEra() ~= ValidPlayerTable[iPlayer][2] then
			if HasMetAtLeastOnceCiv(iPlayer) then
				return true;
			end
		end
	end
	return false;
end

function HasMetAtLeastOnceCiv(iPlayer) 
	local iTeam = Players[iPlayer]:GetTeam();
	for i,v in pairs(Players) do	
		if v:IsEverAlive() then
			if not v:IsMinorCiv() then
				if not v:IsBarbarian() then
					if v:GetTeam() ~= iTeam then
						if Teams[iTeam]:IsHasMet(v:GetTeam()) then
							return true;
						end
					end
				end
			end
		end
	end
	return false;
end

function AISetNewProphecies(iPlayer)
	ValidPlayerTable[iPlayer][1] = ValidPlayerTable[iPlayer][1] + 1;
	ValidPlayerTable[iPlayer][2] = Players[iPlayer]:GetCurrentEra();
	save(iPlayer .. "LS18tbNP", ValidPlayerTable[iPlayer][1]) 
	save(iPlayer .. "LS18tbLE", ValidPlayerTable[iPlayer][2])
	PrepareGlobalDataForProphecies()
	local lTab = {}
	for i = 1, #propheciesTable do
		table.insert(lTab, i)
	end
	lTab = Shuffle(lTab);
	--will be added immediately
	local numPA = 0;
	rewardlike = true;
	local nextID = #ValidPlayerTable[iPlayer][3];
	for i, nextindex in pairs(lTab) do
		local data = propheciesTable[nextindex];
		if numPA >= 10 then
			return;
		end
		if DoesNotHaveYet(iPlayer, data.ID) and data.CanPlayerHave(iPlayer) then
			local hData = data.PrepareProphecy(iPlayer, data.ID, true)
			nextID = nextID + 1;
			save(iPlayer .. "LS18tbPS" .. nextID .. "ID", hData.ID);
			save(iPlayer .. "LS18tbPS" .. nextID .. "Data1", hData.Data1);
			save(iPlayer .. "LS18tbPS" .. nextID .. "Self", hData.Self);
			local chosenOne;
			if (not hData.Self) and (not propheciesTable[hData.ID].RewardLike) then
				chosenOne = data.GiveOptions(iPlayer, true, hData);
				save(iPlayer .. "LS18tbPS" .. nextID .. "ChoseableData", chosenOne);
			end
			table.insert(ValidPlayerTable[iPlayer][3], {ID = hData.ID, Data1 = hData.Data1, Self = hData.Self, ChoseableData = chosenOne})
			if propheciesTable[hData.ID].RewardLike then
				rewardlike = false;
			end
			if propheciesTable[hData.ID].InstantCheck then
				propheciesTable[hData.ID].InstantCheck(iPlayer, hData.ID, nextID)
			end
		end
	end
	save(iPlayer .. "LS18tbPSn", nextID);
end

function DoesNotHaveYet(iPlayer, hid)
	if propheciesTable[hid].RewardLike and (not rewardlike) then
		return false;
	end
	if propheciesTable[hid].Multitimes then
		return true;
	end
	for i, data in pairs(ValidPlayerTable[iPlayer][3]) do
		if (data.ID == hid) and (not propheciesTable[hid].MultitimesIfInActive or not data.Status) then
			return false;
		end
	end
	return true;
end

function DoHumanNewSetOfProphecies(iPlayer)
	ValidPlayerTable[iPlayer][1] = ValidPlayerTable[iPlayer][1] + 1;
	ValidPlayerTable[iPlayer][2] = Players[iPlayer]:GetCurrentEra();
	save(iPlayer .. "LS18tbNP", ValidPlayerTable[iPlayer][1]) 
	save(iPlayer .. "LS18tbLE", ValidPlayerTable[iPlayer][2])
	PrepareGlobalDataForProphecies()
	local lTab = {}
	for i = 1, #propheciesTable do
		table.insert(lTab, i)
	end
	lTab = Shuffle(lTab);
	options = {}
	rewardlike = true;
	for i, nIndex in pairs(lTab) do
		local data = propheciesTable[nIndex];
		--max 10
		if #options >= 10 then
			break;
		end
		if DoesNotHaveYet(iPlayer, data.ID) and data.CanPlayerHave(iPlayer) then
			table.insert(options, data.PrepareProphecy(iPlayer, data.ID))
			if propheciesTable[data.ID].RewardLike then
				rewardlike = false;
			end
		end
	end
	save(iPlayer .. "LS18tbTPn", #options)
	for i, data in pairs(options) do
		save(iPlayer .. "LS18tbTP" .. i .. "ID", data.ID)
		save(iPlayer .. "LS18tbTP" .. i .. "Self", data.Self)
		save(iPlayer .. "LS18tbTP" .. i .. "Data1", data.Data1)
	end
	if #options > 0 then
		CallTheUIOptions()
	else
		options = nil;
	end
end

function PlayerFinishedSealingProphecies()
	local iPlayer = Game.GetActivePlayer();
	save(iPlayer .. "LS18tbTPn", nil)
	local nextID = #ValidPlayerTable[iPlayer][3];
	for i, data in pairs(options) do
		nextID = nextID + 1;
		save(iPlayer .. "LS18tbPS" .. nextID .. "ID", data.ID);
		save(iPlayer .. "LS18tbPS" .. nextID .. "Data1", data.Data1);
		save(iPlayer .. "LS18tbPS" .. nextID .. "Self", data.Self);
		save(iPlayer .. "LS18tbPS" .. nextID .. "ChoseableData", data.ChoseableData);
		table.insert(ValidPlayerTable[iPlayer][3], {ID = data.ID, Data1 = data.Data1, Self = data.Self, ChoseableData = data.ChoseableData})
		if propheciesTable[data.ID].InstantCheck then
			propheciesTable[data.ID].InstantCheck(iPlayer, data.ID, nextID)
		end
	end
	save(iPlayer .. "LS18tbPSn", nextID);
	options = nil;
	Events.AudioPlay2DSound("AS2D_LS_NICE_PROPHECY_SOUND")
end

local VFFJ = { [GameInfoTypes.FEATURE_JUNGLE] = 1, [GameInfoTypes.FEATURE_FOREST] = 1};
function GetNumForestJungle()
	local n = 0
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if VFFJ[fPlot:GetFeatureType()] then
			n = n + 1;
		end
	end
	return n;
end

function PrepareGlobalDataForProphecies()
--globalData
	globalData.TechsKnown = {}
	globalData.TeamsActive = {}
	globalData.ErasActive = {}
	globalData.TeamsActiveCS = {}
	globalData.NumActiveForestJungle = GetNumForestJungle()
	local tTab = {}
	local tmTab = {}
	for i, v in pairs(Players) do
		if not v:IsBarbarian() then
			if v:IsEverAlive() then
				if not v:IsMinorCiv() then
					tTab[v:GetTeam()] = 1;
				else
					tmTab[v:GetTeam()] = 1;
				end
			end
		end
	end
	for i, sth in pairs(tTab) do
		table.insert(globalData.TeamsActive, i)
	end
	for i, sth in pairs(tmTab) do
		table.insert(globalData.TeamsActiveCS, i)
	end
	for row in GameInfo.Technologies() do
		for sth, team in pairs(globalData.TeamsActive) do
			if Teams[team]:IsHasTech(row.ID) then
				globalData.TechsKnown[row.ID] = 1;
				if row.Era then
					globalData.ErasActive[GameInfoTypes[row.Era]] = 1;
				end
				break;
			end
		end
	end
end

-- functions related purely to prophecy table;

function funcCPHNomusic(iPlayer)
	if globalData.ErasActive[GameInfoTypes.ERA_RENAISSANCE] then
		return false;
	end
	if load("LS18ThebesAlreadyMadeMusic") then
		return false;
	end
	return true;
end

function funcCPHPreRenaissanceAera(iPlayer)
	if globalData.ErasActive[GameInfoTypes.ERA_RENAISSANCE] then
		return false;
	end
	return true;
end

function funcCPHJungleForest(iPlayer)
	if globalData.ErasActive[GameInfoTypes.ERA_RENAISSANCE] then
		return false;
	end
	if globalData.NumActiveForestJungle < 10 then
		return false;
	end
	return true;
end

function funcCPHPreModernAera(iPlayer)
	if globalData.ErasActive[GameInfoTypes.ERA_MODERN] then
		return false;
	end
	return true;
end

function funcCPHPreModernAeraCS(iPlayer)
	if #globalData.TeamsActiveCS < 6 then
		return false
	end
	if globalData.ErasActive[GameInfoTypes.ERA_MODERN] then
		return false;
	end
	return true;
end

function funcCPHJustMetCityState(iPlayer)
	local iTeam = Players[iPlayer]:GetTeam();
	for i,v in pairs(Players) do
		if v:GetTeam() ~= iTeam then
			if not v:IsBarbarian() and v:IsMinorCiv() and v:IsAlive() then
				if Teams[iTeam]:IsHasMet(v:GetTeam()) then
					if not Teams[iTeam]:IsAtWar(v:GetTeam()) then
						return true;
					end
				end
			end
		end
	end
	return false;
end

function funcCPHWonderI(iPlayer)
	local bWonders = {}
	for index, sth in pairs(ValidPlayerTable[iPlayer][3]) do
		if sth.ID == 1 then
			bWonders[sth.Data1] = 1;
		end
	end
	for row in GameInfo.BuildingClasses() do
		if row.MaxGlobalInstances == 1 then
			if row.DefaultBuilding then
				local brow = GameInfo.Buildings[row.DefaultBuilding];
				if brow and brow.PrereqTech and GameInfoTypes[brow.PrereqTech] then
					if not globalData.TechsKnown[GameInfoTypes[brow.PrereqTech]] then
						if not bWonders[row.ID] then
							return true;
						end
					end
				end
			end
		end
	end
	return false;
end

function funcCPHNoLeagueYet(iPlayer)
	if Game.GetNumActiveLeagues() > 0 then
		return false
	end
	return true;
end

function funcCPHOneMajorToMeet(iPlayer)
	local iTeam = Players[iPlayer]:GetTeam();
	for i, iteam in pairs(globalData.TeamsActive) do
		if iteam ~= iTeam then
			if not Teams[iTeam]:IsHasMet(iteam) then
				return true;
			end
		end
	end
	return false;
end

function funcCPHAtLeastOneProperReligion(iPlayer)
	for row in GameInfo.Religions() do
		if Game.GetHolyCityForReligion(row.ID, -1) then
			if #Game.GetBeliefsInReligion(row.ID) < 5 then
				if Players[iPlayer]:GetReligionCreatedByPlayer() ~= row.ID then
					return true;
				end
			end
		end
	end
	return false;
end

function funcCPHAtLeastFourPlayers(iPlayer)
	if #globalData.TeamsActive < 4 then
		return false
	end
	return true;
end

function funcCPHDeadalus(iPlayer)
	if globalData.TechsKnown[GameInfoTypes.TECH_FLIGHT] then
		return false;
	end
	return true;
end

function funcCPHCircumnavigate(iPlayer)
	if load("LS18thebAlcircumnavigated") then
		return false;
	end
	return Map.IsWrapX();
end

function funcCPHNoAtomicYet(iPlayer)
	if load("LS18tbAtomicAL") then
		return false;
	end
	return true;
end

function funcCPHAlways(iPlayer)
	return true;
end

function funcCPHDigging(iPlayer)
	if load("LS18tbDigAL") then
		return false;
	end
	return true;
end

function funcCPHMadness(iPlayer)
	local iTeam = Players[iPlayer]:GetTeam();
	for i,v in pairs(Players) do
		if v:GetTeam() ~= iTeam then
			if not v:IsBarbarian() and not v:IsMinorCiv() and v:IsEverAlive() then
				if v:GetLateGamePolicyTree() == -1 and v:IsAlive() then
					if Teams[iTeam]:IsHasMet(v:GetTeam()) then
						return true;
					end
				end
			end
		end
	end
	return false;
end

function funcCPHCuriousCityState(iPlayer)
	local iTeam = Players[iPlayer]:GetTeam();
	for i,v in pairs(Players) do
		if v:GetTeam() ~= iTeam then
			if not v:IsBarbarian() and v:IsMinorCiv() and v:IsAlive() then
				if Teams[iTeam]:IsHasMet(v:GetTeam()) then
					if not Teams[iTeam]:IsAtWar(v:GetTeam()) then
						local cCity = v:GetCapitalCity();
						if cCity then
							if cCity:GetProductionBuilding() ~= -1 then
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

function funcCPHJustMetCiv(iPlayer)
	local iTeam = Players[iPlayer]:GetTeam();
	for i,v in pairs(Players) do
		if v:GetTeam() ~= iTeam then
			if not v:IsBarbarian() and not v:IsMinorCiv() and v:IsAlive() then
				if Teams[iTeam]:IsHasMet(v:GetTeam()) then
					return true;
				end
			end
		end
	end
	return false;
end

function funcPPTargetToMeet(iPlayer, ID)
	local propTab = {}
	local hTab = {}
	local iTeam = Players[iPlayer]:GetTeam();
	for i, iteam in pairs(globalData.TeamsActive) do
		if iteam ~= iTeam then
			if not Teams[iTeam]:IsHasMet(iteam) then
				table.insert(hTab, iteam)
			end
		end
	end
	propTab.ID = ID;
	propTab.Data1 = hTab[math.random(1,#hTab)];
	return propTab;
end

function funcPPPolicyToAdopt(iPlayer, ID)
	local propTab = {}
	local hTab = {}
	for row in GameInfo.Policies() do
		if row.Level == 0 then
			if row.PolicyBranchType then
				if not Players[iPlayer]:HasPolicy(row.ID) then
					table.insert(hTab, row.ID)
				end
			end
		end
	end
	propTab.ID = ID;
	propTab.Data1 = hTab[math.random(1,#hTab)];
	return propTab;
end

function funcPPUnusedEnchantReligions(iPlayer, ID)
	local propTab = {}
	local hTab = {}
	for row in GameInfo.Religions() do
		if Game.GetHolyCityForReligion(row.ID, -1) then
			if #Game.GetBeliefsInReligion(row.ID) < 5 then
				if Players[iPlayer]:GetReligionCreatedByPlayer() ~= row.ID then
					table.insert(hTab, row.ID)
				end
			end
		end
	end
	propTab.ID = ID;
	propTab.Data1 = hTab[math.random(1,#hTab)];
	return propTab;
end


function funcPPTakeAMetTargetCityState(iPlayer, ID)
	local propTab = {}
	local hTab = {}
	local iTeam = Players[iPlayer]:GetTeam();
	for i,v in pairs(Players) do
		if v:GetTeam() ~= iTeam then
			if not v:IsBarbarian() and v:IsMinorCiv() and v:IsAlive() then
				if Teams[iTeam]:IsHasMet(v:GetTeam()) then
					if not Teams[iTeam]:IsAtWar(v:GetTeam()) then
						table.insert(hTab, i)
					end
				end
			end
		end
	end
	propTab.ID = ID;
	propTab.Data1 = hTab[math.random(1,#hTab)];
	if math.random(1, #globalData.TeamsActive) == 1 then
		propTab.Self = "You";
	end
	return propTab;
end

function funcPPTakeAMetTargetCiv(iPlayer, ID)
	local propTab = {}
	local iTeam = Players[iPlayer]:GetTeam();
	local hTab = {}
	for i,v in pairs(Players) do
		if v:GetTeam() ~= iTeam then
			if not v:IsBarbarian() and not v:IsMinorCiv() and v:IsAlive() then
				if Teams[iTeam]:IsHasMet(v:GetTeam()) then
					table.insert(hTab, i)
				end
			end
		end
	end
	propTab.ID = ID;
	propTab.Data1 = hTab[math.random(1,#hTab)];
	return propTab;
end

function funcPPCuriousCityState(iPlayer, ID)
	local propTab = {}
	propTab.ID = ID;
	local hTab = {}
	local iTeam = Players[iPlayer]:GetTeam();
	for i,v in pairs(Players) do
		if v:GetTeam() ~= iTeam then
			if not v:IsBarbarian() and v:IsMinorCiv() and v:IsAlive() then
				if Teams[iTeam]:IsHasMet(v:GetTeam()) then
					if not Teams[iTeam]:IsAtWar(v:GetTeam()) then
						local cCity = v:GetCapitalCity();
						if cCity then
							if cCity:GetProductionBuilding() ~= -1 then
								table.insert(hTab, cCity:Plot():GetPlotIndex())
							end
						end
					end
				end
			end
		end
	end
	propTab.Data1 = hTab[math.random(1,#hTab)];
	return propTab;
end

function funcPPMadness(iPlayer, ID)
	local propTab = {}
	local iTeam = Players[iPlayer]:GetTeam();
	local hTab = {}
	for i,v in pairs(Players) do
		if v:GetTeam() ~= iTeam then
			if not v:IsBarbarian() and not v:IsMinorCiv() and v:IsEverAlive() then
				if v:GetLateGamePolicyTree() == -1 and v:IsAlive() then
					if Teams[iTeam]:IsHasMet(v:GetTeam()) then
						table.insert(hTab, i)
					end
				end
			end
		end
	end
	propTab.ID = ID;
	propTab.Data1 = hTab[math.random(1,#hTab)];
	return propTab;
end

function funcPPForestSimple(iPlayer, ID)
	local propTab = {}
	propTab.ID = ID;
	propTab.Data1 = globalData.NumActiveForestJungle
	return propTab;
end

function funcPPSimple(iPlayer, ID)
	local propTab = {}
	propTab.ID = ID;
	return propTab;
end

function funcPPSimpleAndSelf(iPlayer, ID)
	local propTab = {}
	propTab.ID = ID;
	if math.random(1, #globalData.TeamsActive) == 1 then
		propTab.Self = "You";
	end
	return propTab;
end

function funcPPWonderI(iPlayer, ID)
	local propTab = {}
	local hTab = {}
	local bWonders = {}
	for index, sth in pairs(ValidPlayerTable[iPlayer][3]) do
		if sth.ID == 1 then
			bWonders[sth.Data1] = 1;
		end
	end
	for row in GameInfo.BuildingClasses() do
		if row.MaxGlobalInstances == 1 then
			if row.DefaultBuilding then
				local brow = GameInfo.Buildings[row.DefaultBuilding];
				if brow and brow.PrereqTech and GameInfoTypes[brow.PrereqTech] then
					if not globalData.TechsKnown[GameInfoTypes[brow.PrereqTech]] then
						if not bWonders[row.ID] then
							table.insert(hTab, brow.ID)
						end
					end
				end
			end
		end
	end
	propTab.ID = ID;
	propTab.Data1 = hTab[math.random(1,#hTab)];
	if math.random(1, #globalData.TeamsActive) == 1 then
		propTab.Self = "You";
	end
	return propTab;
end

function GetPlayerName(i, iTeam, var)
	if Teams[iTeam]:IsHasMet(Players[i]:GetTeam()) then
		if var == 1 then
			return Players[i]:GetCivilizationShortDescription() .. " (" .. Players[i]:GetName() .. ")";
		elseif var == 2 then
			return Players[i]:GetName() .. " (" .. Players[i]:GetCivilizationShortDescription() .. ")"
		end
		return Players[i]:GetName() .. " - " .. Players[i]:GetCivilizationShortDescription();
	else
		return "Unknown Player";
	end
end

function funcGOideologies(iPlayer, bAI)
	local hTab = {}
	for row in GameInfo.PolicyBranchTypes() do
		if row.PurchaseByLevel then
			table.insert(hTab, {Index = row.ID, Text = Locale.Lookup(row.Description)});
		end
	end
	if bAI then
		-- order should worthy more;
		if math.random(1,2) == 2 then
			return GameInfoTypes.POLICY_BRANCH_ORDER
		end
		return hTab[math.random(1,#hTab)].Index;
	end
	return hTab;
end

function funcGOallValidBuildings(iPlayer, bAI, data)
	local cCity = Map.GetPlotByIndex(data.Data1):GetPlotCity()
	local hTab = {}
	for row in GameInfo.Buildings() do
		if cCity:CanConstruct(row.ID, 1) then
			table.insert(hTab, {Index = row.ID, Text = Locale.Lookup(row.Description)})
		end
	end
	if bAI then
		return hTab[math.random(1,#hTab)].Index;
	end
	return hTab;
end

function funcGOSoilPlains(iPlayer, bAI)
	local jumps = GetJumpsRazedCities()
	local hTab = {}
	local numrazed = math.ceil((load("LS18ThebesNumRazedCities") or 0)/jumps);
	for i = 0, 9 do
		if i == 9 then
			if jumps > 1 then
				table.insert(hTab, {Index = i + numrazed, Text = i * jumps .. "+"})
			else
				table.insert(hTab, {Index = i + numrazed, Text = i .. "+"})
			end
		else
			if jumps > 1 then
				table.insert(hTab, {Index = i + numrazed, Text = i * jumps .. " - " .. i * jumps + jumps})
			else
				table.insert(hTab, {Index = i + numrazed, Text = i})
			end
		end
	end
	if bAI then
		return hTab[math.random(1,5)].Index;
	end
	return hTab;
end

function funcGOMinorLeft(iPlayer, bAI)
	local hTab = {}
	local numCS = #globalData.TeamsActiveCS;
	local numAlivenow = 0;
	for i, v in pairs(Players) do
		if v:IsMinorCiv() and v:IsAlive() then
			numAlivenow = numAlivenow + 1;
		end
	end
	if numCS < 9 then
		if bAI then
			return math.max(0, numAlivenow - math.random(1,4))
		else
			for i = 0, numCS do
				table.insert(hTab, {Index = i, Text = i})
			end
		end
	elseif numCS < 19 then
		if bAI then
			return math.max(0, math.floor((numAlivenow - math.random(1,5) / 2)))
		else
			for i = 0, math.ceil(numCS/2) do
				table.insert(hTab, {Index = i, Text = i * 2 .. " - " .. i * 2 + 2})
			end
		end
	else
		if bAI then
			return math.max(0, math.floor((numAlivenow - math.random(1,7) / 3)))
		else
			for i = 0, math.ceil(numCS/3) do
				table.insert(hTab, {Index = i, Text = i * 3 .. " - " .. i * 3 + 3})
			end
		end
	end
	return hTab;
end

function funcGOGreatPeopleClasses(iPlayer, bAI)
	local hTab = {}
	for iClass, sth in pairs(SpecialUnitTab) do
		if iClass == GameInfoTypes.UNITCLASS_PROPHET then
			table.insert(hTab, {Index = iClass, Text = "Great Prophet"})
		else
			table.insert(hTab, {Index = iClass, Text = Locale.Lookup(GameInfo.UnitClasses[iClass].Description)})
		end
	end
	if bAI then
		local rTab = {GameInfoTypes.UNITCLASS_PROPHET, GameInfoTypes.UNITCLASS_WRITER, GameInfoTypes.UNITCLASS_MERCHANT, GameInfoTypes.UNITCLASS_GREAT_GENERAL}
		return rTab[math.random(1,#rTab)];
	end
	return hTab;
end

function funcGOUnusedEnchantRel(iPlayer, bAI)
	local hTab = {}
	for i, belief in pairs(Game.GetAvailableEnhancerBeliefs()) do
		table.insert(hTab, {Index = belief, Text = Locale.Lookup(GameInfo.Beliefs[belief].ShortDescription)})
	end
	if bAI then
		return hTab[math.random(1,#hTab)].Index;
	end
	return hTab;
end

function funcGOpercentagesby10(iPlayer, bAI)
	local hTab = {}
	for i = 0, 9 do
		if i == 9 then
			table.insert(hTab, {Index = i, Text = i * 10 .. "%+"})
		else
			table.insert(hTab, {Index = i, Text = i * 10 .. "% - " .. i * 10 + 10 .. "%"})
		end
	end
	if bAI then
		return math.random(5,8);
	end
	return hTab;
end

function funcGOotherMPRevAI(iPlayer, bAI)
	local hTab = {}
	local iTeam = Players[iPlayer]:GetTeam();
	for i,v in pairs(Players) do
		if not v:IsBarbarian() and not v:IsMinorCiv() and v:IsEverAlive() then
			if not bAI or v:IsAlive() then
				if v:GetTeam() ~= iTeam then
					table.insert(hTab, {Index = i, Text = GetPlayerName(i, iTeam)})
				end
			end
		end
	end
	if bAI then
		local handicap = Game.GetHandicapType();
		local minTech, chosen = 999, nil;
		for i, text in pairs(hTab) do
			if i ~= Game.GetActivePlayer() then
				local numTech = Teams[Players[i]:GetTeam()]:GetTeamTechs():GetNumTechsKnown();
				if numTech < minTech then
					chosen = i;
					minTech = numTech;
				end
			end
		end 
		if chosen then
			return chosen;
		end
		return hTab[math.random(1,#hTab)].Index;
	end
	return hTab;
end

function funcGOotherMP(iPlayer, bAI)
	local hTab = {}
	local iTeam = Players[iPlayer]:GetTeam();
	for i,v in pairs(Players) do
		if not v:IsBarbarian() and not v:IsMinorCiv() and v:IsEverAlive() then
			if not bAI or v:IsAlive() then
				if v:GetTeam() ~= iTeam then
					table.insert(hTab, {Index = i, Text = GetPlayerName(i, iTeam)})
				end
			end
		end
	end
	if bAI then
		local handicap = Game.GetHandicapType();
		if handicap < math.random(5, 6) then
			if Game.GetActiveTeam() ~= iTeam then
				return Game.GetActivePlayer();
			end
		end
		local maxTech, chosen = 0, nil;
		for i, text in pairs(hTab) do
			local numTech = Teams[Players[i]:GetTeam()]:GetTeamTechs():GetNumTechsKnown();
			if numTech > maxTech then
				chosen = i;
				maxTech = numTech;
			end
		end 
		if chosen then
			return chosen;
		end
		return hTab[math.random(1,#hTab)].Index;
	end
	return hTab;
end

function funcGHTNewAllyRising(data, iPlayer, bChoose)
	local tString = Players[data.Data1]:GetName()
	if bChoose then
		if data.Self then
			return "You shall become the next ally of " .. tString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +150 [ICON_INFLUENCE] in " .. tString .. ".";
		else
			return "Choose, which civilization will become the next ally of " .. tString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +150 [ICON_INFLUENCE] in " .. tString .. ".";
		end
	else
		if data.Self then
			return "In the city-state of " .. tString .. " a new star is rising. Shall you outshine your competitors?[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +150 [ICON_INFLUENCE] Influence with " .. tString .. ".";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local pString = GetPlayerName(data.ChoseableData, iTeam, 1)
			return "Fame of " .. pString .. " will outshine even the sun in the city-state of " .. tString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +150 [ICON_INFLUENCE] Influence with " .. tString .. ".";
		end
	end
end

function funcGHTMadness(data, iPlayer, bChoose)
	local iString = GetPlayerName(data.Data1, Players[iPlayer]:GetTeam())
	if bChoose then
		return "Choose, which ideology is gonna be adopted by " .. iString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Social Policy.";
	else
		local ideology =  Locale.Lookup(GameInfo.PolicyBranchTypes[data.ChoseableData].Description);
		return "The people of " .. iString .. " will have their mind twisted by an idea of " .. ideology .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Social Policy.";
	end
end

function funcGHTGreatPerson(data, iPlayer, bChoose)
	local pString = GetPlayerName(data.Data1, Players[iPlayer]:GetTeam(), 2)
	if bChoose then
		return "Choose, which Great Person will be acquired by " ..  pString .. " next.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Person.";
	else
		local tString = Locale.Lookup(GameInfo.UnitClasses[data.ChoseableData].Description)
		if data.ChoseableData == GameInfoTypes.UNITCLASS_PROPHET then
			tString = "Great Prophet";
		end
		return "Alls stars on the sky whisper one name, the " .. tString .. " will be born soon in the lands of " .. pString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Person.";
	end
end

function funcGHTMenace(data, iPlayer, bChoose)
	if bChoose then
		return "Choose, which player is the next one to declare war on you.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great General.";
	else
		local iTeam = Players[iPlayer]:GetTeam()
		local tString = GetPlayerName(data.ChoseableData, iTeam, 2)
		return "The " .. tString .. " awaits in shadow, looking forward to grab your lands and enslave your people.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great General.";
	end
end

function funcGHTLongShadow(data, iPlayer, bChoose)
	if bChoose then
		if data.Self then
			return "You shall construct the next Citadel.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +30 XP to all existing units.";
		else
			return "Choose, in which civilization the very next citadel is gonna be constructed.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +30 XP to all existing units.";
		end
	else
		if data.Self then
			return "The shadow of your citadel will make your enemies tremble.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +30 XP to all existing units.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 1)
			return "In the lands of " .. tString .. " Citadel will rise and eclipse sun.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +30 XP to all existing units.";
		end
	end
end

function funcGHEnchantReligion(data, iPlayer, bChoose)
	local rString = GameInfo.Religions[data.Data1].IconString .. " " .. Locale.Lookup(Game.GetReligionName(data.Data1));
	if bChoose then
		return "Predict the enhancer bonus of " .. rString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Temple in all existing cities.";
	else
		local belief = Locale.Lookup(GameInfo.Beliefs[data.ChoseableData].ShortDescription)
		return rString .. " will become bored of its dogma and accept " .. belief .. " as new belief.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Temple in all existing cities.";
	end

end

function funcGHTFallOfAnEmpire(data, iPlayer, bChoose)
	if bChoose then
		return "Predict which civilization will loose their original capital next.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +25% [ICON_STRENGTH] Defense in all Cities.";
	else
		local iTeam = Players[iPlayer]:GetTeam()
		local tString = GetPlayerName(data.ChoseableData, iTeam, 2)
		return "All signs on Earth and Sky lead to once conclusion, capital of " .. tString .. " will fall next.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +25% [ICON_STRENGTH] Defense in all Cities.";
	end
end

function funcGHTCuriousCityState(data, iPlayer, bChoose)
	local iTeam = Players[iPlayer]:GetTeam()
	local tString = GetPlayerName(Map.GetPlotByIndex(data.Data1):GetOwner(), iTeam, 2)
	if bChoose then
		return "Nobles from " .. tString .. ", curious about your infinite powers, decide to test them by asking what building is their city currently constructing.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +150 [ICON_INFLUENCE] Influence with " .. tString .. ".";
	else
		return "Nobles from " .. tString .. " may yet not known that their city is constructing " .. Locale.Lookup(GameInfo.Buildings[data.ChoseableData].Description) .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +150 [ICON_INFLUENCE] Influence with " .. tString .. ".";
	end
end

function funcGHLeagueFounder(data, iPlayer, bChoose)
	if bChoose then
		if data.Self then
			return "You shall be the host of first International League.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Spy.";
		else
			return "Choose, which player is gonna be the host of first International League.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Spy.";
		end
	else
		if data.Self then
			return "The world will be united under one coalition and your host.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Spy.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 1)
			return "The world will be united under one coalition and the host of " .. tString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Spy.";
		end
	end
end

function funcGHTDigging(data, iPlayer, bChoose)
	if bChoose then
		if data.Self then
			return "You shall be the first one to dig out the Archaeological Site.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free 3 Archaeologists.";
		else
			return "Choose, which player is gonna dig out the Archaeological Site first.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free 3 Archaeologists.";
		end
	else
		if data.Self then
			return "You shall be the first one to dig out the past.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free 3 Archaeologists.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 2)
			return "The moment will come, people will start dig for something more worthy than gold and it all will begin with " .. tString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free 3 Archaeologists.";
		end
	end
end

function funcGHTDaedalus(data, iPlayer, bChoose)
	if bChoose then
		if data.Self then
			return "You will stole the sky from the bird kind.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Scientist.";
		else
			return "Choose which player is gonna train an aircraft unit first.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Scientist.";
		end
	else
		if data.Self then
			return "You will be the first one to claim the sky.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Scientist.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 2)
			return tString .. " will claim the primacy of the Daedalus.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Scientist.";
		end
	end
end

function funcGHUnexceptedGuest(data, iPlayer, bChoose)
	return "With an unexcepted guest, comes unexcepted reward.";
end

function funcGHSocialRev(data, iPlayer, bChoose)
	return "Nobody could except that one Social Policy can bring so much Happiness.";
end

function funcGHTrivial(data, iPlayer, bChoose)
	return "Sometimes trivial things lead to the something glorious.";
end

function funcGHConvertedFoe(data, iPlayer, bChoose)
	return "Mercy leads to gratitude. Gratitude leads to action.";
end

function funcGHTheTwins(data, iPlayer, bChoose)
	return "With an extraordinary person comes an extraordinary surprise."
end

function funcGHRebels(data, iPlayer, bChoose)
	if bChoose then
		if data.Self then
			return "You will be betrayed by our own people, facing the rebellion next.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +33% combat bonus against Barbarians.";
		else
			return "Choose which player is gonna face the rebellion next.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +33% combat bonus against Barbarians.";
		end
	else
		if data.Self then
			return "It seems that not everony is happy with you reign, you shall face the rebellion soon.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +33% combat bonus against Barbarians.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 2)
			return tString .. " will face the rebellion, which is doomed to fail.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +33% combat bonus against Barbarians.";
		end
	end
end

function funcGHTAtomicBlast(data, iPlayer, bChoose)
	if bChoose then
		if data.Self then
			return "Your destiny is to become a peaceful leader by force of Atomic Blast.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR]  +3000 [ICON_PEACE] Faith.";
		else
			return "Choose which player is gonna use Nuclear weapon first.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +3000 [ICON_PEACE] Faith.";
		end
	else
		if data.Self then
			return "By divine rights you shall be the first one to use an ultimate, nuclear weapon.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +3000 [ICON_PEACE] Faith.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 2)
			return tString .. " will become destroyer of worlds, the bringer of doom and nuclear explosions.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +3000 [ICON_PEACE] Faith.";
		end
	end
end

function funcGHForestCutting(data, iPlayer, bChoose)
	if bChoose then
		return "Predict how much of current Forest and Jungle will be left by Atomic Era.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Tile improvement construction rate increased by 50%.";
	else
		local iText = data.ChoseableData * 10 .. "% - " .. data.ChoseableData * 10 + 10;
		return "The Forest and Jungle will disappear, replaced and dead, but still " .. iText .. " of it will survive till an era of atom.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Tile improvement construction rate increased by 50%.";
	end
end

function funcGHMusic(data, iPlayer, bChoose)
	if bChoose then
		if data.Self then
			return "The music will be outshined by its creator, and it will happen in your civilization first.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Opera House in all cities.";
		else
			return "Choose which player is gonna create great work of Music first.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Opera House in all cities.";
		end
	else
		if data.Self then
			return "The music will no longer play first fiddle. The musician will become of greater revelance in your civilization.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Opera House in all cities.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 2)
			return "The music will no longer play first fiddle. The musician will become of greater revelance in lands " .. tString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Opera House in all cities.";
		end
	end
end

function funcGHTFirstToIndustrial(data, iPlayer, bChoose)
	if bChoose then
		if data.Self then
			return "You will proudly start an era of smoked sky and healthy lungs. Into Industry you shall trust.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +2000 [ICON_GOLD] Gold.";
		else
			return "Choose which player is gonna enter Industrial era first.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +2000 [ICON_GOLD] Gold.";
		end
	else
		if data.Self then
			return "You will be the first one to enter Industrial era.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +2000 [ICON_GOLD] Gold.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 2)
			return "By expanding industry " .. tString .. " will start an era of great wonders, and great sorrow.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +2000 [ICON_GOLD] Gold.";
		end
	end
end

function funcGHTSoilPlains(data, iPlayer, bChoose)
	if bChoose then
		return "Predict a number of razed cities by Atomic Era.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +2000 [ICON_PEACE] Faith.";
	else
		local numCS = data.ChoseableData * GetJumpsRazedCities();
		return "The fields of neverending despair and sorrow, the number of them will be " .. numCS .. " by the era when humanity split the atom.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +2000 [ICON_PEACE] Faith.";
	end
end

function GetNumCityStatesEverAlive()
	local n = 0;
	for i,v in pairs(Players) do
		if v:IsEverAlive() then
			if v:IsMinorCiv() then
				n = n + 1;
			end
		end
	end
	return n;
end

function funcGHTMinorLeft(data, iPlayer, bChoose)
	if bChoose then
		return "Predict a number of minor civilizations surviving till the Information Era.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +60 [ICON_INFLUENCE] Influence with all City-States.";
	else
		local numCS = data.ChoseableData;
		local numTotal = GetNumCityStatesEverAlive()
		if numTotal > 18 then
			numCS = numCS * 3 .. " - " .. numCS * 3 + 3;
		elseif numTotal > 8 then
			numCS = numCS * 2 .. " - " .. numCS * 2 + 2;
		end
		return numCS .. " minors will enter the era of information and prosperity.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +60 [ICON_INFLUENCE] Influence with all City-States.";
	end
end

function funcGHTCircumnavigate(data, iPlayer, bChoose)
	if bChoose then
		if data.Self then
			return "You will circumnavigate the globe first.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Technology.";
		else
			return "Choose, which player is gonna circumnavigate the globe first.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Technology.";
		end
	else
		if data.Self then
			return "You will be the first one to circumnavigate the globe.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Technology.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 2)
			return tString .. " will prove that the globe is round. Though, we know that the world is cylinder.[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Technology.";
		end
	end
end

function funcGHTWonderI(data, iPlayer, bChoose)
	local wString = Locale.Lookup(GameInfo.Buildings[data.Data1].Description)
	if bChoose then
		if data.Self then
			return "You shall construct " .. wString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Engineer.";
		else
			return "Choose, which player is gonna construct " .. wString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Engineer.";
		end
	else
		if data.Self then
			return "You shall construct the great monument, " .. wString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Engineer.";
		else
			local iTeam = Players[iPlayer]:GetTeam()
			local tString = GetPlayerName(data.ChoseableData, iTeam, 1)
			return "The great monument, " .. wString .. " is gonna be constructed in the far away lands of " .. tString .. ".[NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Engineer.";
		end
	end
end

function funcRINewAllyRising(status)
	if status == 1 then
		return "We have foreseen the next ally of certain city-state.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +150 [ICON_INFLUENCE] Influence.";
	else
		return "We have misinterpreted information about which civilization will become next ally of certain city-state.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] +150 [ICON_INFLUENCE] Influence.";
	end
end

function funcRICircumnavigate(status)
	if status == 1 then
		return "We have foreseen which civilization will circumnavigate the globe first.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Technology.";
	else
		return "We have misinterpreted information about which civilization will circumnavigate the globe first.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] Free Technology.";
	end
end

function funcRIDaedalus(status)
	if status == 1 then
		return "We have foreseen which civilization will construct an aircraft unit first.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Scientist.";
	else
		return "We have misinterpreted information about which civilization will construct an aircraft unit first.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] Free Great Scientist.";
	end
end

function funcRILongShadow(status)
	if status == 1 then
		return "We have foreseen which civilization will construct next citadel.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +30 XP to all existing units.";
	else
		return "We have misinterpreted information about which civilization will construct next citadel.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] +30 XP to all existing units.";
	end
end

function funcRIMenace(status)
	if status == 1 then
		return "We have foreseen which civilization will declare war on us next.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great General.";
	else
		return "We have misinterpreted information about which civilization will declare war on us next.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] Free Great General.";
	end
end

function funcRIDigOut(status)
	if status == 1 then
		return "We have foreseen which civilization will start Archaeological digging.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free 3 Archaeologists.";
	else
		return "We have misinterpreted information about which civilization will start Archaeological digging.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] Free 3 Archaeologists.";
	end
end

function funcRIGreatPerson(status)
	if status == 1 then
		return "We have foreseen which Great Person will be acquired by other civilization.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Person.";
	else
		return "We have misinterpreted information about which Great Person will be acquired by other civilization.[[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] Free Great Person.";
	end
end

function funcRIMadness(status)
	if status == 1 then
		return "We have foreseen the adopting of certain ideology by other civilization.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Social Policy.";
	else
		return "We have misinterpreted words of oracle about ideology adopted by other civilization.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] Free Social Policy.";
	end
end

function funcRICuriousCityState(status)
	if status == 1 then
		return "We have impressed the nobles from city-state by successfully guessing what their city is constructing right now.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +150 [ICON_INFLUENCE] Influence.";
	else
		return "Nobles from city-state misinterpreted the wisdom of our oracle, or were not worthy it. They are leaving unsatisfied.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] +150 [ICON_INFLUENCE] Influence.";
	end
end

function funcRIWonderI(status)
	if status == 1 then
		return "We have foreseen the construction of wonder.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Great Engineer.";
	else
		return "We have misinterpreted words of oracle and mislocated place of wonder construction.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] Free Great Engineer.";
	end
end

function funcRISoilPlains(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen the number of razed cities by Atomic Era.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +2000 [ICON_PEACE] Faith";
	else
		return "We have misinterpreted words of oracle and miscalculated the number of razed cities by Atomic Era.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] +2000 [ICON_PEACE] Faith";
	end
end

function funcRIMinorLeft(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen the number of City-States surviving till Information Era.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +60 [ICON_INFLUENCE] Influence with all City-States.";
	else
		return "We have misinterpreted words of oracle and misjudged the number of City-States surviving till Information Era.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] +60 [ICON_INFLUENCE] Influence with all City-States.";
	end
end

function funcRIAtomicBoomBoom(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen the first usage of Nuclear Weapon.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +2000 [ICON_PEACE] Faith";
	else
		return "We have misinterpreted prophecy about which civilization will use Nuclear Weapon fisrt.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] +2000 [ICON_PEACE] Faith";
	end
end

function funcRIIndustrial(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen which civilization will enter an Industrial Era first.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +2000 [ICON_GOLD] Gold.";
	else
		return "We have misinterpreted information about which civilization will enter an Industrial Era first.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] +2000 [ICON_GOLD] Gold.";
	end
end

function funcRITheTwins(iPlayer, ID, jIndex)
	return "With the acquisition of last Great Person, the twin sibling has joined our cause as well!";
end

function funcRIUnexceptedGuest(iPlayer, ID, jIndex)
	return "Meeting new civilization inspired our scientists to invent something completely new.";
end

function funcRIConvertedFoe(iPlayer, ID, jIndex)
	return "Captured Great General thankful for sparing his life decided to follow our cause.";
end

function funcRISocialPolicy(iPlayer, ID, jIndex)
	return "Our people love the new policy, finding it the biggest social improvement since leaving the caves. Unhappiness is greatly reduced since now.";
end

function funcRITrivial(iPlayer, ID, jIndex)
	return "Recent events unexpectedly lead to the start of Golden Age.";
end

function funcRILostEmpire(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen which civilization will loose their Capital city.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +25% [ICON_STRENGTH] Defense in all Cities.";
	else
		return "We have misinterpreted information about which civilization will loose their Capital city.[NEWLINE][NEWLINE][COLOR_NEGATIVE_TEXT]REWARD LOSS[ENDCOLOR] +25% [ICON_STRENGTH] Defense in all Cities.";
	end
end

function funcICCuriousCityState(iPlayer, ID, jIndex)
	local cCity = Map.GetPlotByIndex(ValidPlayerTable[iPlayer][3][jIndex].Data1):GetPlotCity();
	GrandeRewardFunction(jIndex, ID, cCity:GetProductionBuilding(), iPlayer)
end

function funcRIFounderWC(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen who will be the founder of World Congress.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Spy.";
	else
		return "We have misinterpreted information about who will be the founder of World Congress..[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD LOSS[ENDCOLOR] Free Spy.";
	end
end

function funcRIEnchantReligion(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen which enhancer belief is gonna be chosen by certain religion.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Temple in all existing cities.";
	else
		return "We have misinterpreted information about which enhancer belief is gonna be chosen by certain religion.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD LOSS[ENDCOLOR] Free Temple in all existing cities.";
	end
end

function funcRIForestCut(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen the amount of Jungle and Forest surviving till Atomic Era.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Tile improvement construction rate increased by 50%.";
	else
		return "We have misinterpreted information about the amount of Jungle and Forest surviving till Atomic Era.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD LOSS[ENDCOLOR] Tile improvement construction rate increased by 50%.";
	end
end

function funcRIRebels(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen which civilization will face next rebellion.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] +33% combat bonus against Barbarians.";
	else
		return "We have misinterpreted information about which civilization will face next rebellion.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD LOSS[ENDCOLOR] +33% combat bonus against Barbarians."
	end
end

function funcRIMusic(iPlayer, ID, jIndex)
	if status == 1 then
		return "We have foreseen which civilization will create first Great Work of Music.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD[ENDCOLOR] Free Opera House in all cities."
	else
		return "We have misinterpreted information about which civilization will create first Great Work of Music.[NEWLINE][NEWLINE][COLOR_POSITIVE_TEXT]REWARD LOSS[ENDCOLOR] Free Opera House in all cities."
	end
end

propheciesTable = {
{ID = 1, Name = "Vision of Wonder", CanPlayerHave = funcCPHWonderI, PrepareProphecy = funcPPWonderI, GiveOptions = funcGOotherMP, GetHelpText = funcGHTWonderI, RewardInfo = funcRIWonderI, PI = 2, Multitimes = true, IA = "WONDERS_DLC_ATLAS"},
{ID = 2, Name = "Madness of Nation", CanPlayerHave = funcCPHMadness, PrepareProphecy = funcPPMadness, GiveOptions = funcGOideologies, GetHelpText = funcGHTMadness, RewardInfo = funcRIMadness, PI = 20, Multitimes = true, IA = "BW_ATLAS_2"},
{ID = 3, Name = "Digging Future", CanPlayerHave = funcCPHDigging, PrepareProphecy = funcPPSimpleAndSelf, GiveOptions = funcGOotherMP, GetHelpText = funcGHTDigging, RewardInfo = funcRIDigOut, PI = 3, IA = "RESOURCE_ATLAS_EXP2"},
{ID = 4, Name = "The Menace", CanPlayerHave = funcCPHAtLeastFourPlayers, PrepareProphecy = funcPPSimple, GiveOptions = funcGOotherMP, GetHelpText = funcGHTMenace, RewardInfo = funcRIMenace, MultitimesIfInActive = true, PI = 21, IA = "POLICY_ATLAS"},
{ID = 5, Name = "The Long Shadow", CanPlayerHave = funcCPHAtLeastFourPlayers, PrepareProphecy = funcPPSimpleAndSelf, GiveOptions = funcGOotherMP, GetHelpText = funcGHTLongShadow, RewardInfo = funcRILongShadow, MultitimesIfInActive = true, PI = 35, IA = "TERRAIN_ATLAS"},
{ID = 6, Name = "Dream of Daedalus", CanPlayerHave = funcCPHDeadalus, PrepareProphecy = funcPPSimpleAndSelf, GiveOptions = funcGOotherMP, GetHelpText = funcGHTDaedalus, RewardInfo = funcRIDaedalus, PI = 53, IA = "TECH_ATLAS_1"},
{ID = 7, Name = "Pillars of Hercules", CanPlayerHave = funcCPHCircumnavigate, PrepareProphecy = funcPPSimpleAndSelf, GiveOptions = funcGOotherMP, GetHelpText = funcGHTCircumnavigate, RewardInfo = funcRICircumnavigate, PI = 8, IA = "NW_ATLAS"},
{ID = 8, Name = "Great Apparition", CanPlayerHave = funcCPHJustMetCiv, PrepareProphecy = funcPPTakeAMetTargetCiv, GiveOptions = funcGOGreatPeopleClasses, GetHelpText = funcGHTGreatPerson, RewardInfo = funcRIGreatPerson, MultitimesIfInActive = true, PI = 16, IA = "TECH_ATLAS_1"},
{ID = 9, Name = "Rising Star", CanPlayerHave = funcCPHJustMetCityState, PrepareProphecy = funcPPTakeAMetTargetCityState, GiveOptions = funcGOotherMP, GetHelpText = funcGHTNewAllyRising, RewardInfo = funcRINewAllyRising, Multitimes = true, PI = 9, IA = "TECH_ATLAS_1"},
{ID = 10, Name = "Curiousity of Nobles", CanPlayerHave = funcCPHCuriousCityState, PrepareProphecy = funcPPCuriousCityState, GiveOptions = funcGOallValidBuildings, GetHelpText = funcGHTCuriousCityState, RewardInfo = funcRICuriousCityState, Multitimes = true, InstantCheck = funcICCuriousCityState, PI = 37, IA = "POLICY_ATLAS"},
{ID = 11, Name = "Minor Inconvenience", CanPlayerHave = funcCPHPreModernAeraCS, PrepareProphecy = funcPPSimple, GiveOptions = funcGOMinorLeft, GetHelpText = funcGHTMinorLeft, RewardInfo = funcRIMinorLeft, PI = 38, IA = "POLICY_ATLAS"},
{ID = 12, Name = "Soil Plains", CanPlayerHave = funcCPHPreModernAera, PrepareProphecy = funcPPSimple, GiveOptions = funcGOSoilPlains, GetHelpText = funcGHTSoilPlains, RewardInfo = funcRISoilPlains, PI = 39, IA = "TERRAIN_ATLAS"},
{ID = 13, Name = "Epoque of Smoking Sky", CanPlayerHave = funcCPHPreRenaissanceAera, PrepareProphecy = funcPPSimpleAndSelf, GiveOptions = funcGOotherMP, GetHelpText = funcGHTFirstToIndustrial, RewardInfo = funcRIIndustrial, PI = 5, IA = "EXPANSION_TECH_ATLAS_1"},
{ID = 14, Name = "Destroyer of Worlds", CanPlayerHave = funcCPHNoAtomicYet, PrepareProphecy = funcPPSimpleAndSelf, GiveOptions = funcGOotherMP, GetHelpText = funcGHTAtomicBlast, RewardInfo = funcRIAtomicBoomBoom, PI = 24, IA = "UNIT_ATLAS_2"},
{ID = 15, Name = "Fall of an Empire", CanPlayerHave = funcCPHAtLeastFourPlayers, PrepareProphecy = funcPPSimple, GiveOptions = funcGOotherMPRevAI, GetHelpText = funcGHTFallOfAnEmpire, RewardInfo = funcRILostEmpire, PI = 0, IA = "TERRAIN_IMPROVEMENT_ICON_ATLAS_EXP2"},
{ID = 16, Name = "Divine Inspiriation", CanPlayerHave = funcCPHAtLeastOneProperReligion, PrepareProphecy = funcPPUnusedEnchantReligions, GiveOptions = funcGOUnusedEnchantRel, GetHelpText = funcGHEnchantReligion, RewardInfo = funcRIEnchantReligion, PI = 16, IA = "EXPANSION_UNIT_ATLAS_1"},
{ID = 17, Name = "United World", CanPlayerHave = funcCPHNoLeagueYet, PrepareProphecy = funcPPSimpleAndSelf, GiveOptions = funcGOotherMP, GetHelpText = funcGHLeagueFounder, RewardInfo = funcRIFounderWC, PI = 26, IA = "BW_ATLAS_2"},
{ID = 18, Name = "The World of Tomorrow", CanPlayerHave = funcCPHJungleForest, PrepareProphecy = funcPPForestSimple, GiveOptions = funcGOpercentagesby10, GetHelpText = funcGHForestCutting, RewardInfo = funcRIForestCut, PI = 31, IA = "UNIT_ACTION_ATLAS"},
{ID = 19, Name = "Rebels", CanPlayerHave = funcCPHAlways, PrepareProphecy = funcPPSimpleAndSelf, GiveOptions = funcGOotherMP, GetHelpText = funcGHRebels, RewardInfo = funcRIRebels, PI = 25, IA = "UNIT_ATLAS_1"},
{ID = 20, Name = "Stolen Music", CanPlayerHave = funcCPHNomusic, PrepareProphecy = funcPPSimpleAndSelf, GiveOptions = funcGOotherMP, GetHelpText = funcGHMusic, RewardInfo = funcRIMusic, PI = 7, IA = "EXPANSION2_UNIT_ATLAS"},
{ID = 21, Name = "Twins", CanPlayerHave = funcCPHAlways, PrepareProphecy = funcPPSimple, GetHelpText = funcGHTheTwins, RewardInfo = funcRITheTwins, RewardLike = true, PI = 22, IA = "LEADER_ATLAS"},
{ID = 22, Name = "Converted Foe", CanPlayerHave = funcCPHAlways, PrepareProphecy = funcPPSimple, GetHelpText = funcGHConvertedFoe, RewardInfo = funcRIConvertedFoe, RewardLike = true, PI = 22, IA = "LEADER_ATLAS"},
{ID = 23, Name = "Unexcepted Guest", CanPlayerHave = funcCPHOneMajorToMeet, PrepareProphecy = funcPPTargetToMeet, GetHelpText = funcGHUnexceptedGuest, RewardInfo = funcRIUnexceptedGuest, RewardLike = true, PI = 22, IA = "LEADER_ATLAS"},
{ID = 24, Name = "Social Revolution", CanPlayerHave = funcCPHAlways, PrepareProphecy = funcPPPolicyToAdopt, GetHelpText = funcGHSocialRev, RewardInfo = funcRISocialPolicy, RewardLike = true, PI = 22, IA = "LEADER_ATLAS"},
{ID = 25, Name = "Trivial Event", CanPlayerHave = funcCPHAlways, PrepareProphecy = funcPPSimple, GetHelpText = funcGHTrivial, RewardInfo = funcRITrivial, RewardLike = true, PI = 22, IA = "LEADER_ATLAS"}

--RewardLike = true
--[[
reward like: 1 per roll only !;
on deafeting great general he joins you
on acquiring great person, twin great person // no artists
on meeting civ, free tech
on adopting certain policy, -10% unhappiness
on capturing city, golden age;
]]
}

--help functions

function Shuffle(iTable)
	local n, order, oTable = #iTable, {}, {}
	for i=1,n do order[i] = { rnd = math.random(), idx = i } end
	table.sort(order, function(a,b) return a.rnd < b.rnd end)
	for i=1,n do oTable[i] = iTable[order[i].idx] end
	return oTable;
end

--detect prophecy events

function GrandeRewardFunction(hIndex, propID, reality, iPlayer)
	local sText, sTitle;
	if ValidPlayerTable[iPlayer][3][hIndex].ChoseableData == reality then
		ValidPlayerTable[iPlayer][3][hIndex].Status = 1;
		save(iPlayer .. "LS18tbPS" .. hIndex .. "Status", 1);
		sTitle = "Prophecy fulfilled";
		sText = "[COLOR_POSITIVE_TEXT]" .. propheciesTable[propID].Name .. "[ENDCOLOR][NEWLINE]" .. propheciesTable[propID].RewardInfo(1)
		if Players[iPlayer]:IsAlive() then
		--Rewards here;
			if propID == 1 then
				Players[iPlayer]:AddFreeUnit(GameInfoTypes.UNIT_ENGINEER, GameInfoTypes.UNITAI_ENGINEER)
			elseif propID == 2 then
				Players[iPlayer]:ChangeNumFreePolicies(1)
			elseif propID == 3 then
				Players[iPlayer]:AddFreeUnit(GameInfoTypes.UNIT_ARCHAEOLOGIST)
				Players[iPlayer]:AddFreeUnit(GameInfoTypes.UNIT_ARCHAEOLOGIST)
				Players[iPlayer]:AddFreeUnit(GameInfoTypes.UNIT_ARCHAEOLOGIST)
			elseif propID == 4 then
				Players[iPlayer]:AddFreeUnit(GameInfoTypes.UNIT_GREAT_GENERAL)
			elseif propID == 5 then
				for iUnit in Players[iPlayer]:Units() do
					if iUnit:IsCombatUnit() then
						iUnit:ChangeExperience(30);
					end
				end
			elseif propID == 6 then
				Players[iPlayer]:AddFreeUnit(GameInfoTypes.UNIT_SCIENTIST)
			elseif propID == 7 then
				local cCity = Players[iPlayer]:GetCapitalCity();
				if cCity then
					cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_1, 1);
					cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_1, 0);
				end
			elseif propID == 8 then
				Players[iPlayer]:ChangeNumFreeGreatPeople(1)
			elseif propID == 9 then
				Players[ValidPlayerTable[iPlayer][3][hIndex].Data1]:ChangeMinorCivFriendshipWithMajor(iPlayer, 150);
			elseif propID == 10 then
				Players[Map.GetPlotByIndex(ValidPlayerTable[iPlayer][3][hIndex].Data1):GetOwner()]:ChangeMinorCivFriendshipWithMajor(iPlayer, 150);
			elseif propID == 11 then
				for i, v in pairs(Players) do
					if v:IsMinorCiv() and v:IsAlive() then
						Players[i]:ChangeMinorCivFriendshipWithMajor(iPlayer, 60);
					end
				end
			elseif propID == 12 then
				Players[iPlayer]:ChangeFaith(2000);
			elseif propID == 13 then
				Players[iPlayer]:ChangeGold(2000);
			elseif propID == 14 then
				Players[iPlayer]:ChangeFaith(3000);
			elseif propID == 15 then
				Players[iPlayer]:SetNumFreePolicies(1);
				Players[iPlayer]:SetNumFreePolicies(0);
				Players[iPlayer]:SetHasPolicy(GameInfoTypes.POLICY_LS_THEBES_1, true)
			elseif propID == 16 then
				for iCity in Players[iPlayer]:Cities() do
					iCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_2, 1);
					iCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_2, 0);
				end
			elseif propID == 17 then				
				local cCity = Players[iPlayer]:GetCapitalCity();
				if cCity then
					cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_3, 1);
					cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_3, 0);
				end
			elseif propID == 18 then
				Players[iPlayer]:SetNumFreePolicies(1);
				Players[iPlayer]:SetNumFreePolicies(0);
				Players[iPlayer]:SetHasPolicy(GameInfoTypes.POLICY_LS_THEBES_2, true)
			elseif propID == 19 then
				Players[iPlayer]:ChangeBarbarianCombatBonus(33);
			elseif propID == 20 then
				local cCity = Players[iPlayer]:GetCapitalCity();
				if cCity then
					cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_4, 1);
					cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_4, 0);
				end
			end
		end
	else
		ValidPlayerTable[iPlayer][3][hIndex].Status = 2;
		save(iPlayer .. "LS18tbPS" .. hIndex .. "Status", 2);
		sTitle = "Prophecy misinterpreted";
		sText = "[COLOR_NEGATIVE_TEXT]" .. propheciesTable[propID].Name .. "[ENDCOLOR][NEWLINE]" .. propheciesTable[propID].RewardInfo(2)
	end
	if iPlayer == Game.GetActivePlayer() then
		Players[iPlayer]:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle);
		Events.AudioPlay2DSound("AS2D_LS_NICE_PROPHECY_SOUND")
	end
end

GameEvents.CityConstructed.Add(function(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if GameInfo.BuildingClasses[GameInfo.Buildings[buildingType].BuildingClass].MaxGlobalInstances == 1 then
		for iPlayer, data in pairs(ValidPlayerTable) do
			for jindex, sdata in pairs(data[3]) do
				if not sdata.Status then
					if sdata.ID == 1 then
						if sdata.Data1 == buildingType then
							GrandeRewardFunction(jindex, 1, ownerId, iPlayer)
						end
					end
				end
			end
		end
	end
end)

local lateGamePolicyDone = {}
function CollectDataForProphecyEvents(tPlayer)
	if Players[tPlayer]:GetLateGamePolicyTree() ~= -1 then
		if not lateGamePolicyDone[tPlayer] then
			if not load(tPlayer .. "LS18tbLGPD") then
				save(tPlayer .. "LS18tbLGPD", 1)
				for iPlayer, data in pairs(ValidPlayerTable) do
					for jindex, sdata in pairs(data[3]) do
						if not sdata.Status then
							if sdata.ID == 2 then
								if sdata.Data1 == tPlayer then
									GrandeRewardFunction(jindex, 2, Players[tPlayer]:GetLateGamePolicyTree(), iPlayer)
								end
							end
						end
					end
				end
			end
			lateGamePolicyDone[tPlayer] = 1;
		end
	end
end

local bArchDone;
local arcDig = GameInfoTypes.IMPROVEMENT_ARCHAEOLOGICAL_DIG
local citadel = GameInfoTypes.IMPROVEMENT_CITADEL;
GameEvents.BuildFinished.Add(function(tPlayer, x, y, improID)
	if improID == arcDig then
		if not bArchDone then
			if not load("LS18tbDigAL") then
				save("LS18tbDigAL", 1)
				for iPlayer, data in pairs(ValidPlayerTable) do
					for jindex, sdata in pairs(data[3]) do
						if not sdata.Status then
							if sdata.ID == 3 then
								GrandeRewardFunction(jindex, 3, tPlayer, iPlayer)
							end
						end
					end
				end
			end
			bArchDone = true;
		end
	elseif improID == citadel then
		for iPlayer, data in pairs(ValidPlayerTable) do
			for jindex, sdata in pairs(data[3]) do
				if sdata.ID == 5 and not sdata.Status then
					GrandeRewardFunction(jindex, 5, tPlayer, iPlayer)
				end
			end
		end 
	end
end)

local bAtomicBlast;
GameEvents.NuclearDetonation.Add(function(tPlayer, PlotX, PlotY, bDeclareWar, bBystander)
	if (not bAtomicBlast) then
		bAtomicBlast = true;
		if not load("LS18tbAtomicAL") then
			save("LS18tbAtomicAL", 1)
			for iPlayer, sth in pairs(ValidPlayerTable) do
				for jindex, jdata in pairs(sth[3]) do
					if jdata.ID == 14 and not jdata.Status then
						GrandeRewardFunction(jindex, jdata.ID, tPlayer, iPlayer)
					end
				end
			end
		end
	end
end)

local bAircraft;
GameEvents.CityTrained.Add(function(ownerId, cityId, unitId, bGold, bFaithOrCulture)
	local unit = Players[ownerId]:GetUnitByID(unitId);
	if (not bAircraft) then
		if GameInfo.Units[unit:GetUnitType()].Domain == "DOMAIN_AIR" then
			for iPlayer, sth in pairs(ValidPlayerTable) do
				for jindex, jdata in pairs(sth[3]) do
					if jdata.ID == 6 and not jdata.Status then
						GrandeRewardFunction(jindex, 6, ownerId, iPlayer)
					end
				end
			end
			bAircraft = true;
		end
	end
end)

function IsMinorCivTeam(teamId)
	for i,v in pairs(Players) do
		if v:GetTeam() == teamId then
			if v:IsMinorCiv() then
				return true;
			end
		end
	end
	return false;
end

GameEvents.DeclareWar.Add(function(teamId, otherTeamId)
	if IsMinorCivTeam(teamId) then
		return;
	end
	for iPlayer, sth in pairs(ValidPlayerTable) do
		if Players[iPlayer]:GetTeam() == otherTeamId then
			for jindex, jdata in pairs(sth[3]) do
				if jdata.ID == 4 and not jdata.Status then
					if Players[jdata.ChoseableData]:GetTeam() == teamId then
						GrandeRewardFunction(jindex, 4, jdata.ChoseableData, iPlayer)
					else
						GrandeRewardFunction(jindex, 4, -1, iPlayer)
					end
					break;
				end
			end
		end
	end
end)

GameEvents.CircumnavigatedGlobe.Add(function(teamId)
	if not load("LS18thebAlcircumnavigated") then
		save("LS18thebAlcircumnavigated", 1)
		for iPlayer, sth in pairs(ValidPlayerTable) do
			for jindex, jdata in pairs(sth[3]) do
				if jdata.ID == 7 and not jdata.Status then
					if Players[jdata.ChoseableData]:GetTeam() == teamId then
						GrandeRewardFunction(jindex, 7, jdata.ChoseableData, iPlayer)
					else
						GrandeRewardFunction(jindex, 7, -1, iPlayer)
					end
				end
			end
		end
	end
end)

local hTT = {}
SpecialUnitTab[GameInfoTypes.UNITCLASS_SCIENTIST] = 1
SpecialUnitTab[GameInfoTypes.UNITCLASS_ENGINEER] = 1
SpecialUnitTab[GameInfoTypes.UNITCLASS_PROPHET] = 1
SpecialUnitTab[GameInfoTypes.UNITCLASS_ARTIST] = 1
SpecialUnitTab[GameInfoTypes.UNITCLASS_WRITER] = 1
SpecialUnitTab[GameInfoTypes.UNITCLASS_MUSICIAN] = 1
SpecialUnitTab[GameInfoTypes.UNITCLASS_MERCHANT] = 1
SpecialUnitTab[GameInfoTypes.UNITCLASS_GREAT_GENERAL] = 1
SpecialUnitTab[GameInfoTypes.UNITCLASS_GREAT_ADMIRAL] = 1

local bonusGP = {GameInfoTypes.UNIT_GREAT_GENERAL, GameInfoTypes.UNIT_SCIENTIST, GameInfoTypes.UNIT_ENGINEER, GameInfoTypes.UNIT_PROPHET, GameInfoTypes.UNIT_MERCHANT}

for i,v in pairs(Players) do
	for iUnit in v:Units() do
		hTT[iUnit] = 1;
	end
end

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	local cPlot = Map.GetPlot(x,y);
	if cPlot then
		local cUnit = Players[player]:GetUnitByID(unit);
		if not hTT[cUnit] then
			hTT[cUnit] = 1;
			if SpecialUnitTab[cUnit:GetUnitClassType()] then
				for iPlayer, sth in pairs(ValidPlayerTable) do
					for jindex, jdata in pairs(sth[3]) do
						if jdata.ID == 8 and not jdata.Status then
							if jdata.Data1 == player then
								GrandeRewardFunction(jindex, jdata.ID, cUnit:GetUnitClassType(), iPlayer)
							end
						end
					end
				end
				if ValidPlayerTable[player] then
					if math.random(1,2) then
						for jindex, jdata in pairs(ValidPlayerTable[player][3]) do
							if jdata.ID == 21 and not jdata.Status then
								GrandeRewardFunction(jindex, jdata.ID, nil, player)
								local jUnit = Players[player]:InitUnit(bonusGP[math.random(1, #bonusGP)], x, y);
								jUnit:JumpToNearestValidPlot()
								jUnit:SetName("Twin of " .. cUnit:GetName())
							end
						end
					end
				end
			end
			if Players[player]:IsBarbarian() then
				local iOwner = Map.GetPlot(x,y):GetOwner();
				if iOwner ~= player and iOwner ~= -1 and Players[iOwner]:IsTurnActive() then
					for iPlayer, sth in pairs(ValidPlayerTable) do
						for jindex, jdata in pairs(sth[3]) do
							if jdata.ID == 19 and not jdata.Status then
								GrandeRewardFunction(jindex, jdata.ID, iOwner, iPlayer)
							end
						end
					end
				end
			end
		end
	end
end)

GameEvents.SetAlly.Add(function(cs, op, np)
	if np ~= -1 then
		for iPlayer, sth in pairs(ValidPlayerTable) do
			for jindex, jdata in pairs(sth[3]) do
				if jdata.ID == 9 and not jdata.Status then
					if jdata.Data1 == cs then
						GrandeRewardFunction(jindex, jdata.ID, np, iPlayer)
					end
				end
			end
		end
	end
end)

function CheckIfCityRazedPredictionIsRight(jindex, propID, iPlayer)
	local jumps = GetJumpsRazedCities() - 1;
	local numrazed = load("LS18ThebesNumRazedCities") or 0;
	local prediction = ValidPlayerTable[iPlayer][3][jindex].ChoseableData;
	if numrazed <= prediction and (prediction <= numrazed + jumps or prediction == 9) then
		GrandeRewardFunction(jindex, propID, prediction, iPlayer)
	else
		GrandeRewardFunction(jindex, propID, -1, iPlayer)
	end
end

function CheckIfCityStatePredictionAliveIsRight(jindex, propID, iPlayer)
	local numCS, total = 0, 0;
	for i,v in pairs(Players) do
		if v:IsMinorCiv() and v:IsEverAlive() then
			total = total + 1;
			if v:IsAlive() then
				numCS = numCS + 1;
			end
		end
	end
	local marg = 0;
	if numCS > 18 then
		marg = 2;
	elseif numCS > 8 then
		marg = 1;
	end
	if numCS <= ValidPlayerTable[iPlayer][3][jindex].ChoseableData and ValidPlayerTable[iPlayer][3][jindex].ChoseableData <= numCS + marg then
		GrandeRewardFunction(jindex, propID, ValidPlayerTable[iPlayer][3][jindex].ChoseableData, iPlayer)
	else
		GrandeRewardFunction(jindex, propID, -1, iPlayer)
	end
end

local informEra = GameInfoTypes.ERA_FUTURE;
local atomicEra = GameInfoTypes.ERA_POSTMODERN;
local indEra = GameInfoTypes.ERA_INDUSTRIAL
local alTeamEntered = {}
GameEvents.TeamSetEra.Add(function(teamId, eEra)
	if not alTeamEntered[eEra] then
		alTeamEntered[eEra] = 1;
		if not load("LS18ThebesEraE" .. eEra) then
			if eEra == informEra then
				for iPlayer, sth in pairs(ValidPlayerTable) do
					for jindex, jdata in pairs(sth[3]) do
						if jdata.ID == 11 and not jdata.Status then
							CheckIfCityStatePredictionAliveIsRight(jindex, jdata.ID, iPlayer)
						end
					end
				end
			elseif eEra == atomicEra then
				for iPlayer, sth in pairs(ValidPlayerTable) do
					for jindex, jdata in pairs(sth[3]) do
						if jdata.ID == 12 and not jdata.Status then
							CheckIfCityRazedPredictionIsRight(jindex, jdata.ID, iPlayer)
						end
					end
				end
				local numforest = GetNumForestJungle();
				for iPlayer, sth in pairs(ValidPlayerTable) do
					for jindex, jdata in pairs(sth[3]) do
						if jdata.ID == 18 and not jdata.Status then
							local perc = 10 * numforest / jdata.Data1;
							if perc <= jdata.ChoseableData and (perc + 1) >= jdata.ChoseableData then
								GrandeRewardFunction(jindex, jdata.ID, jdata.ChoseableData, iPlayer)
							else
								GrandeRewardFunction(jindex, jdata.ID, -1, iPlayer)
							end
						end
					end
				end
			elseif eEra == indEra then
				for iPlayer, sth in pairs(ValidPlayerTable) do
					for jindex, jdata in pairs(sth[3]) do
						if jdata.ID == 13 and not jdata.Status then
							if Players[jdata.ChoseableData]:GetTeam() == teamId then
								GrandeRewardFunction(jindex, jdata.ID, jdata.ChoseableData, iPlayer)
							else
								GrandeRewardFunction(jindex, jdata.ID, -1, iPlayer)
							end
						end
					end
				end
			end
		end
	end
end)

function GetJumpsRazedCities()
	local x, y = Map.GetGridSize();
	local total = x * y;
	if total < 1000 then
		return 1;
	elseif total < 2500 then
		return 2;
	elseif total < 5000 then
		return 3;
	elseif total < 10000 then
		return 4;
	else
		return 5;
	end 
end

local numCT = {}

for i,v in pairs(Players) do
	numCT[i] = v:GetNumCities()
end

local bCongress;
GameEvents.PlayerDoTurn.Add(function(iPlayer)	
	if Players[iPlayer]:GetNumCities() < numCT[iPlayer] then
		local numrazed = (load("LS18ThebesNumRazedCities") or 0) + numCT[iPlayer] - Players[iPlayer]:GetNumCities();
		save("LS18ThebesNumRazedCities", numrazed)
		numCT[iPlayer] = Players[iPlayer]:GetNumCities();
	end
	if not bCongress and Game.GetNumActiveLeagues() > 0 then
		bCongress = true;
		local pLeague = Game.GetLeague(Game.GetActiveLeague());
		for sPlayer, sth in pairs(ValidPlayerTable) do
			for jindex, jdata in pairs(sth[3]) do
				if jdata.ID == 17 and not jdata.Status then
					GrandeRewardFunction(jindex, jdata.ID, pLeague:GetHostMember(), sPlayer)
				end
			end
		end
	end
end)

GameEvents.PlayerCityFounded.Add(function(iPlayer, iCityX, iCityY)
	numCT[iPlayer] = Players[iPlayer]:GetNumCities();
	if ValidPlayerTable[iPlayer] then
		if math.random(1,20) == 2 then
			for jindex, jdata in pairs(ValidPlayerTable[iPlayer][3]) do
				if jdata.ID == 25 and not jdata.Status then
					GrandeRewardFunction(jindex, jdata.ID, nil, iPlayer)
					Players[iPlayer]:ChangeGoldenAgeTurns(10);
				end
			end
		end
	end
end)

GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	numCT[iNewOwner] = Players[iNewOwner]:GetNumCities();
	numCT[iOldOwner] = Players[iOldOwner]:GetNumCities();
	if bIsCapital then
		local cCity = Map.GetPlot(iX, iY):GetPlotCity()
		if cCity:GetOriginalOwner() == iOldOwner then
			if cCity:IsOriginalCapital() then
				for iPlayer, sth in pairs(ValidPlayerTable) do
					for jindex, jdata in pairs(sth[3]) do
						if jdata.ID == 15 and not jdata.Status then
							GrandeRewardFunction(jindex, jdata.ID, iOldOwner, iPlayer)
						end
					end
				end
			end
		end
	end
	local iPlayer = iNewOwner;
	if ValidPlayerTable[iPlayer] then
		if math.random(1,2) == 2 then
			for jindex, jdata in pairs(ValidPlayerTable[iPlayer][3]) do
				if jdata.ID == 25 and not jdata.Status then
					GrandeRewardFunction(jindex, jdata.ID, nil, iPlayer)
					Players[iPlayer]:ChangeGoldenAgeTurns(10);
				end
			end
		end
	end
end)

GameEvents.ReligionEnhanced.Add(function(ePlayer, eReligion, eBelief1, eBelief2)
	for iPlayer, sth in pairs(ValidPlayerTable) do
		for jindex, jdata in pairs(sth[3]) do
			if jdata.ID == 16 and not jdata.Status then
				if jdata.Data1 == eReligion then
					if eBelief1 == jdata.ChoseableData then
						GrandeRewardFunction(jindex, jdata.ID, eBelief1, iPlayer)
					else
						GrandeRewardFunction(jindex, jdata.ID, eBelief2, iPlayer)
					end
				end
			end
		end
	end
end)

--

local numGWA = {}
local gMusic = GameInfoTypes.UNITCLASS_MUSICIAN;

for i,v in pairs(Players) do
	numGWA[i] = Players[i]:GetNumGreatWorks();
end

GameEvents.GreatPersonExpended.Add(function(tPlayer, uType)
	if Players[tPlayer]:GetNumGreatWorks() ~= numGWA[tPlayer] then
		numGWA[tPlayer] = Players[tPlayer]:GetNumGreatWorks();
		save("LS18ThebesAlreadyMadeMusic", 1)
		if GameInfoTypes[GameInfo.Units[uType].Class] == gMusic then
			--music created
			for iPlayer, sth in pairs(ValidPlayerTable) do
				for jindex, jdata in pairs(sth[3]) do
					if jdata.ID == 20 and not jdata.Status then
						GrandeRewardFunction(jindex, jdata.ID, tPlayer, iPlayer)
					end
				end
			end
		end
	end
end)

GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	numGWA[iNewOwner] = Players[iNewOwner]:GetNumGreatWorks();
	numGWA[iOldOwner] = Players[iOldOwner]:GetNumGreatWorks();
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	numGWA[iPlayer] = Players[iPlayer]:GetNumGreatWorks();
end)

local GreatPeopleClass = {
[GameInfoTypes.UNITCLASS_GREAT_GENERAL] = GameInfoTypes.UNIT_GREAT_GENERAL
}
local GreatPeopleValidType = {}
for row in GameInfo.Units() do
	if GreatPeopleClass[GameInfoTypes[row.Class]] then
		if not row.Capture then
			GreatPeopleValidType[row.ID] = GreatPeopleClass[GameInfoTypes[row.Class]]
		end
	end
end

GameEvents.UnitPrekill.Add(function(unitOwnerId, unitId, unitType, unitX, unitY, bDelay, eKillingPlayer)
	if not bDelay then
		if GreatPeopleValidType[unitType] then
			if ValidPlayerTable[eKillingPlayer] then
				-- eKillingPlayer is -1 if killed by ranged attack;
				-- this triggers before melee unit appears on plot;
				local kPlot = Map.GetPlot(unitX, unitY);
				if not kPlot:IsWater() then
					for jindex, jdata in pairs(ValidPlayerTable[eKillingPlayer][3]) do
						if jdata.ID == 22 and not jdata.Status then
							GrandeRewardFunction(jindex, jdata.ID, nil, eKillingPlayer)
							local jUnit = Players[eKillingPlayer]:InitUnit(GreatPeopleValidType[unitType], unitX, unitY);
							jUnit:SetMoves(0);
						end
					end
				end
			end
		end
	end
end)

GameEvents.TeamMeet.Add(function( teama, teamb)
	CheckForGuest(teama, teamb)
	CheckForGuest(teamb, teama)
end)

function CheckForGuest(teamb, teama)
	for iPlayer, sth in pairs(ValidPlayerTable) do
		if Players[iPlayer]:GetTeam() == teamb then
			for jindex, jdata in pairs(sth[3]) do
				if jdata.ID == 23 and not jdata.Status then
					if jdata.Data1 == teama then
						GrandeRewardFunction(jindex, jdata.ID, nil, eKillingPlayer)
						local cCity = Players[iPlayer]:GetCapitalCity();
						if cCity then
							cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_1, 1);
							cCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DUMMY_LS_THEBES_DUMMY_1, 0);
						end
					end
				end
			end
			if math.random(1,15) == 2 then
				for jindex, jdata in pairs(sth[3]) do
					if jdata.ID == 25 and not jdata.Status then
						GrandeRewardFunction(jindex, jdata.ID, nil, iPlayer)
						Players[iPlayer]:ChangeGoldenAgeTurns(10);
					end
				end
			end
		end
	end
end

GameEvents.PlayerAdoptPolicy.Add(function(iPlayer, policyID)
	if ValidPlayerTable[iPlayer] then
		for jindex, jdata in pairs(ValidPlayerTable[iPlayer][3]) do
			if jdata.ID == 24 and not jdata.Status then
				if jdata.Data1 == policyID then
					GrandeRewardFunction(jindex, jdata.ID, nil, iPlayer)
					Players[iPlayer]:SetNumFreePolicies(1);
					Players[iPlayer]:SetNumFreePolicies(0);
					Players[iPlayer]:SetHasPolicy(GameInfoTypes.POLICY_LS_THEBES_3, true)
				end
			end
		end
		if math.random(1,10) == 2 then
			for jindex, jdata in pairs(ValidPlayerTable[iPlayer][3]) do
				if jdata.ID == 25 and not jdata.Status then
					GrandeRewardFunction(jindex, jdata.ID, nil, iPlayer)
					Players[iPlayer]:ChangeGoldenAgeTurns(10);
				end
			end
		end
	end
end)

GameEvents.TeamSetHasTech.Add(function(team, tech, adopted)
	for iPlayer, sth in pairs(ValidPlayerTable) do
		if Players[iPlayer]:GetTeam() == team then
			if math.random(1,10) == 2 then
				for jindex, jdata in pairs(sth[3]) do
					if jdata.ID == 25 and not jdata.Status then
						GrandeRewardFunction(jindex, jdata.ID, nil, iPlayer)
						Players[iPlayer]:ChangeGoldenAgeTurns(10);
					end
				end
			end
		end
	end
end)