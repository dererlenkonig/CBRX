print ("Philosophy - Athens UA code ")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LS17Athens";
include( "IconSupport" );
include( "InstanceManager" );
include( "FLuaVector" );
include( "TechButtonInclude" );
include( "TechHelpInclude" );

local g_TechInstanceManager;
local d_TechInstanceManager;
local techPortraitSize;
local AtRTT = {}
local ActivePlayer = Game.GetActivePlayer();
local activeTeam = Teams[Game.GetActiveTeam()];
local aPlayer = Players[ActivePlayer];
local hBool = false;
local mBool = false;
local maxSmallButtons = 5;
local ValidPlayerTable = {};
local hConfirmTT = {}
local GRTT = {}
IconHookup(1, 64, "CIV_MOD_LS_17_ATLAS", Controls.MyImage2 )
IconHookup(1, 64, "CIV_MOD_LS_17_ATLAS", Controls.MyImage )
local AIHT = {GameInfoTypes.TECH_WRITING, GameInfoTypes.TECH_PHILOSOPHY, GameInfoTypes.TECH_EDUCATION, GameInfoTypes.TECH_ASTRONOMY, GameInfoTypes.TECH_ACOUSTICS, GameInfoTypes.TECH_SCIENTIFIC_THEORY, GameInfoTypes.TECH_INDUSTRIALIZATION, GameInfoTypes.TECH_ELECTRICITY, GameInfoTypes.TECH_PLASTIC, GameInfoTypes.TECH_PARTICLE_PHYSICS, GameInfoTypes.TECH_NANOTECHNOLOGY}

for row in GameInfo.Technology_PrereqTechs() do
	if not GRTT[GameInfoTypes[row.TechType]] then
		GRTT[GameInfoTypes[row.TechType]] = {}
	end
	table.insert(GRTT[GameInfoTypes[row.TechType]], GameInfoTypes[row.PrereqTech])
end

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = Players[player]:GetTeam();
		AtRTT[player] = load(Players[player], "LS17ath");
		hConfirmTT[Players[player]:GetTeam()] = {}
	end
end

function DoAIStuff(iPlayer)
	local iTeam = Players[iPlayer]:GetTeam();
	local backtech, ftech;
	if not AtRTT[iPlayer] then
		for i, tech in pairs(AIHT) do
			if not Teams[iTeam]:IsHasTech(tech) then
				if not Players[iPlayer]:CanResearch(tech) then
					if CanAthensDoThat(iPlayer, tech) then
						ftech = tech;
					end
				else
					backtech = tech;
				end
			end
		end
	end
	if ftech then
		SetNewTechAt(iPlayer, ftech, "yerer")
	elseif backtech then
		if backtech ~= Players[iPlayer]:GetCurrentResearch() then
			Players[iPlayer]:ClearResearchQueue()
			Players[iPlayer]:PushResearch(backtech)
		end
	end
end

GameEvents.TeamSetHasTech.Add(function(iTeam, iTech)
	if hConfirmTT[iTeam] then
		for iPlayer, team in pairs(ValidPlayerTable) do
			if team == iTeam then
				if AtRTT[iPlayer] then
					if AtRTT[iPlayer] == iTech then
						if iPlayer == Game.GetActivePlayer() then
							Players[iPlayer]:ClearResearchQueue()
							Events.SerialEventGameMessagePopup({Type = ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH})
						end
						SetNewTechAt(iPlayer, nil, "weradsa")
					elseif aPlayer:CanResearch( AtRTT[iPlayer] ) then
						Players[iPlayer]:PushResearch(AtRTT[iPlayer])
						SetNewTechAt(iPlayer, nil, "eada")
					end
				end
			end
		end
	end
end)

function SetNewTechAt(iPlayer, techID, stringH)
	AtRTT[iPlayer] = techID;
	save(Players[iPlayer], "LS17ath", techID)
	if iPlayer == ActivePlayer then
		if techID then
			Controls.MyButton:SetText(Locale.Lookup(GameInfo.Technologies[techID].Description))
			Controls.MyButton:SetToolTipString("Current research is " .. Locale.Lookup(GameInfo.Technologies[techID].Description) .. ". Right-click to remove, left-click to change.")
		else
			Controls.MyButton:SetText("School of Hellas")
			Controls.MyButton:SetToolTipString("You can use your unique ability to research a technologies without their usual prerequisites. Left-Click to set.")
		end
	end
end

GameEvents.PlayerCanResearch.Add(function(player, techtype)
	local iteam = Players[player]:GetTeam();
	if hConfirmTT[iteam] then
		return HasPrereqPrereq(iteam, techtype);
	end
	return true;
end)

function HasPrereqPrereq(iTeam, techID)
	for i, tech in pairs(GRTT[techID] or {}) do
		if not HasAllPrereqs(iTeam, tech) then
			return false;
		end
	end
	return true;
end

function HasAllPrereqs(iTeam, techID)
	if hConfirmTT[iTeam][techID] then
		return true;
	end
	for i, tech in pairs(GRTT[techID] or {}) do
		if Teams[iTeam]:IsHasTech(tech) then
			if not HasAllPrereqs(iTeam, tech) then
				return false;
			end
		else
			return false;
		end
	end
	hConfirmTT[iTeam][techID] = 1;
	return true;
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		if AtRTT[iPlayer] then
			local eRes = Players[iPlayer]:GetCurrentResearch();
			if eRes ~= -1 then
				local teamtechs = Teams[Players[iPlayer]:GetTeam()]:GetTeamTechs();
				local numRes = math.min(Players[iPlayer]:GetScience(), teamtechs:GetResearchProgress(eRes));
				teamtechs:ChangeResearchProgress(eRes, -1 * numRes, iPlayer);
				teamtechs:ChangeResearchProgress(AtRTT[iPlayer], numRes, iPlayer);
			end
		end
		if not Players[iPlayer]:IsHuman() then
			DoAIStuff(iPlayer)
		end
	end
	if Players[iPlayer]:IsBarbarian() then
		for h, v in pairs(ValidPlayerTable) do
			if Players[h]:GetCurrentResearch() == -1 then
				if AtRTT[h] then		
					Players[h]:PushResearch(FirstGoodTech())
				else
					if not Players[h]:IsHuman() then
						DoAIStuff(h)
					end
				end
			end
		end
	end
end)

function CanAthensDoThat(iPlayer, techID)
	local iTeam = Players[iPlayer]:GetTeam();
	if not Teams[iTeam]:IsHasTech(techID) then
		return HasPrereqPrereq(iTeam, techID);
	end
	return false;
end

function LClickButton()
--	Events.SerialEventGameMessagePopup({Type = ButtonPopupTypes.BUTTONPOPUP_TECH_TREE, Data1 = 1})
--	Events.SerialEventGameMessagePopup({Type = ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH})
	OpenDummyButtons()
end

function RClickButton()
	if AtRTT[ActivePlayer] then
		SetNewTechAt(ActivePlayer, nil, "Wedada")
		Events.SerialEventGameDataDirty()
	end
end

function StartFunction()
	local bHuman = false;
	for iPlayer, sth in pairs(ValidPlayerTable) do
		if Players[iPlayer]:IsHuman() then
			bHuman = true;
		end
	end
	if bHuman then
		techPortraitSize = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechIcon"):GetSize().x;
		g_TechInstanceManager = InstanceManager:new( "TechButtonInstance", "TechButtonContainer", ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup/ButtonStack"))
		d_TechInstanceManager = InstanceManager:new( "TechButtonInstance", "TechButtonContainer", Controls.ButtonStack)
		Events.SerialEventGameDataDirty.Add(FreePhilosophy);
		Events.SerialEventGameMessagePopupProcessed.Add(TechEndFunction)
		Events.SerialEventGameMessagePopup.Add(OnDisplay)
		Controls.MyBackground:ChangeParent(ContextPtr:LookUpControl("/InGame/TechTree"));
		Controls.TechTreeBackground:ChangeParent(ContextPtr:LookUpControl("/InGame/TechTree"));
		Controls.MyButton:RegisterCallback( Mouse.eLClick, LClickButton );
		Controls.MyButton:RegisterCallback( Mouse.eRClick, RClickButton );
	end
end
Events.SequenceGameInitComplete.Add(StartFunction)

function NewActivePlayerUpdateData()
	if ValidPlayerTable[ActivePlayer] then
		Controls.MyBackground:SetHide(false);
		GatherInfoAboutUniqueStuff( GameInfo.Civilizations[aPlayer:GetCivilizationType()].Type )
		FreePhilosophy()
		if AtRTT[ActivePlayer] then
			Controls.MyButton:SetText(Locale.Lookup(GameInfo.Technologies[AtRTT[ActivePlayer]].Description))
			Controls.MyButton:SetToolTipString("Current research is " .. Locale.Lookup(GameInfo.Technologies[AtRTT[ActivePlayer]].Description) .. ". Right-click to remove, left-click to change.")
		else
			Controls.MyButton:SetText("School of Hellas")
			Controls.MyButton:SetToolTipString("You can use your unique ability to research a technologies without their usual prerequisites. Left-Click to set.")
		end
	else
		Controls.MyBackground:SetHide(true);
	end
end

function OnTechPanelActivePlayerChanged( iActivePlayer, iPrevActivePlayer )
	ActivePlayer = iActivePlayer;
	aPlayer = Players[iActivePlayer];
	NewActivePlayerUpdateData()
end
Events.GameplaySetActivePlayer.Add(OnTechPanelActivePlayerChanged);

function FirstGoodTech()
 	for tech in GameInfo.Technologies() do
 		local techID = tech.ID;
 		if aPlayer:CanResearch( techID ) then
			return techID;
		end
	end
end

function TechSelected( eTech, iValue)
	if iValue > 0 then
		Teams[Game.GetActiveTeam()]:SetHasTech(eTech, true)
		aPlayer:SetNumFreeTechs(iValue - 1);
	else
		SetNewTechAt(ActivePlayer, eTech, "bdada")
	   	Network.SendResearch(FirstGoodTech(), 0, -1, false);
	end
	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup"):SetHide( true );
	hBool = true;
	Events.SerialEventGameMessagePopupProcessed(ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH, 0);
end

function TechEndFunction(type)
	if ValidPlayerTable[ActivePlayer] then
		if type == ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH then
			g_TechInstanceManager:ResetInstances()
			if hBool then
				hBool = false;
				mBool = false;
			else
				mBool = true;
			end
		end
	end
end

function AddTechButton( tech, turnsLeft, iDiscover, manager, lClickFunction)
	
	local thisTechButtonInstance = manager:GetInstance();
	thisTechButtonInstance.TechButton:SetVoid1( tech.ID ); -- indicates type
	local buttonVoid2Value = iDiscover;
	thisTechButtonInstance.TechButton:SetVoid2(buttonVoid2Value);
	
	thisTechButtonInstance.TechButton:RegisterCallback( Mouse.eLClick, lClickFunction );
--	techPediaSearchStrings[tostring(thisTechButtonInstance.TechButton)] = Locale.ConvertTextKey(tech.Description);
	thisTechButtonInstance.TechButton:RegisterCallback( Mouse.eRClick, GetTechPedia );
	
	local techName = Locale.ConvertTextKey( tech.Description );
	techName = Locale.TruncateString(techName, 20, true);
	thisTechButtonInstance.CurrentlyResearchingTechName:SetText( techName );
	thisTechButtonInstance.AvailableTechName:SetText( techName );
	thisTechButtonInstance.FreeTechName:SetText( techName );

  	local researchTurnsLeft = aPlayer:GetResearchTurnsLeft( tech.ID, true );
 	local turnText = tostring( researchTurnsLeft ).." "..turnsString;

	if AtRTT[ActivePlayer] == tech.ID then -- the player is currently researching this one
 		thisTechButtonInstance.Available:SetHide( true );
		-- deal with free tech
		if iDiscover > 0 then
 			thisTechButtonInstance.CurrentlyResearching:SetHide( true );
  			thisTechButtonInstance.FreeTech:SetHide( false );
			-- update number of turns to research
 			if 	aPlayer:GetScience() > 0 then
  				thisTechButtonInstance.FreeTurns:SetText( turnText );
  				thisTechButtonInstance.FreeTurns:SetHide( false );
  			else
  				thisTechButtonInstance.FreeTurns:SetHide( true );
  			end
			thisTechButtonInstance.TechQueueLabel:SetText( freeString );
 			thisTechButtonInstance.TechQueue:SetHide( false );
		else
 			thisTechButtonInstance.CurrentlyResearching:SetHide( false );
  			thisTechButtonInstance.FreeTech:SetHide( true );
			-- update number of turns to research
 			if 	aPlayer:GetScience() > 0 then
  				thisTechButtonInstance.CurrentlyResearchingTurns:SetText( turnText );
  				thisTechButtonInstance.CurrentlyResearchingTurns:SetHide( false );
  			else
  				thisTechButtonInstance.CurrentlyResearchingTurns:SetHide( true );
  			end
 			thisTechButtonInstance.TechQueue:SetHide( true );
 		end
 		-- turn on the meter
		local teamTechs = activeTeam:GetTeamTechs();
		local researchProgressPercent = 0;
		local researchProgressPlusThisTurnPercent = 0;
		local researchTurnsLeft = aPlayer:GetResearchTurnsLeft(techID, true);
		local currentResearchProgress = teamTechs:GetResearchProgress(techID);
		local researchNeeded = teamTechs:GetResearchCost(techID);
		local researchPerTurn = aPlayer:GetScience();
		local currentResearchPlusThisTurn = currentResearchProgress + researchPerTurn;		
		researchProgressPercent = currentResearchProgress / researchNeeded;
		researchProgressPlusThisTurnPercent = currentResearchPlusThisTurn / researchNeeded;		
		if (researchProgressPlusThisTurnPercent > 1) then
			researchProgressPlusThisTurnPercent = 1
		end
 		thisTechButtonInstance.ProgressMeter:SetHide( false );
 		thisTechButtonInstance.ProgressMeterInternal:SetPercents( researchProgressPercent, researchProgressPlusThisTurnPercent );
 	else
 		thisTechButtonInstance.CurrentlyResearching:SetHide( true );
 		-- deal with free tech
		if iDiscover > 0 then
 			thisTechButtonInstance.Available:SetHide( true );
  			thisTechButtonInstance.FreeTech:SetHide( false );
			-- update number of turns to research
 			if 	aPlayer:GetScience() > 0 then
  				thisTechButtonInstance.FreeTurns:SetText( turnText );
  				thisTechButtonInstance.FreeTurns:SetHide( false );
  			else
  				thisTechButtonInstance.FreeTurns:SetHide( true );
  			end
			-- update queue number
			thisTechButtonInstance.TechQueueLabel:SetText( freeString );
 			thisTechButtonInstance.TechQueue:SetHide( false );
		else
 			thisTechButtonInstance.Available:SetHide( false );
  			thisTechButtonInstance.FreeTech:SetHide( true );
			-- update number of turns to research
 			if 	aPlayer:GetScience() > 0 then
  				thisTechButtonInstance.AvailableTurns:SetText( turnText );
  				thisTechButtonInstance.AvailableTurns:SetHide( false );
  			else
  				thisTechButtonInstance.AvailableTurns:SetHide( true );
  			end
			-- update queue number if needed
			local queuePosition = aPlayer:GetQueuePosition( tech.ID );
			if queuePosition == -1 then
				thisTechButtonInstance.TechQueue:SetHide( true );
			else
				thisTechButtonInstance.TechQueueLabel:SetText( tostring( queuePosition-1 ) );
				thisTechButtonInstance.TechQueue:SetHide( false );
			end
		end
		-- turn off the meter
 		thisTechButtonInstance.ProgressMeter:SetHide( true );
 		-- update advisor icon if needed
	end
	
	thisTechButtonInstance.TechButton:SetToolTipString( GetHelpTextForTech(tech.ID) );
		
	-- update the picture
	if IconHookup( tech.PortraitIndex, 64, tech.IconAtlas, thisTechButtonInstance.TechPortrait ) then
		thisTechButtonInstance.TechPortrait:SetHide( false );
	else
		thisTechButtonInstance.TechPortrait:SetHide( true );
	end
	for iAdvisorLoop = 0, AdvisorTypes.NUM_ADVISOR_TYPES - 1, 1 do
		thisTechButtonInstance.EconomicRecommendation:SetHide(true);
		thisTechButtonInstance.MilitaryRecommendation:SetHide(true);
		thisTechButtonInstance.ScienceRecommendation:SetHide(true);
		thisTechButtonInstance.ForeignRecommendation:SetHide(true);
    end
	thisTechButtonInstance.AdvisorStack:CalculateSize();
	thisTechButtonInstance.AdvisorStack:ReprocessAnchoring();
	-- add the small pictures and their tooltips
	AddSmallButtonsToTechButton( thisTechButtonInstance, tech, maxSmallButtons, 45 );
	AddCallbackToSmallButtons( thisTechButtonInstance, maxSmallButtons, tech.ID, buttonVoid2Value, Mouse.eLClick, lClickFunction );
end

function OnTechnologyButtonClicked()
    if( ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup"):IsHidden() == true ) then
    	Events.SerialEventGameMessagePopup( { Type = ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH,
                                              Data1 = Game.GetActivePlayer(),
                                              Data3 = -1 -- this is to tell it that a tech was not just finished
                                            } );
    else
       ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup"):SetHide( true );
    end
end

function FreePhilosophy()
	if not ValidPlayerTable[ActivePlayer] then
		return
	end
	--if( (popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH or popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CHOOSE_TECH_TO_STEAL) and ContextPtr:IsHidden() == true ) then
		local pPlayer = Players[Game.GetActivePlayer()];
		local pTeam = Teams[pPlayer:GetTeam()];
		local pTeamTechs = pTeam:GetTeamTechs();
		if mBool then
			mBool = false;
			if pPlayer:GetCurrentResearch() ~= -1 then
				SetNewTechAt(ActivePlayer, nil, "hhhe")
			else
	   			Network.SendResearch(FirstGoodTech(), 0, -1, false);
			end
		end
		eCurrentTech = AtRTT[ActivePlayer] or pPlayer:GetCurrentResearch();

		eRecentTech = pTeamTechs:GetLastTechAcquired();
	
		local fResearchProgressPercent = 0;
		local fResearchProgressPlusThisTurnPercent = 0;
	
		local researchStatus = "";
		local szText = "";

		if ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel") then
			-- Are we researching something right now?
			if (eCurrentTech ~= -1) then
		
				local iResearchTurnsLeft = pPlayer:GetResearchTurnsLeft(eCurrentTech, true);
				local iCurrentResearchProgress = pPlayer:GetResearchProgress(eCurrentTech);
				local iResearchNeeded = pPlayer:GetResearchCost(eCurrentTech);
				local iResearchPerTurn = pPlayer:GetScience();
				local iCurrentResearchPlusThisTurn = iCurrentResearchProgress + iResearchPerTurn;
		
				fResearchProgressPercent = iCurrentResearchProgress / iResearchNeeded;
				fResearchProgressPlusThisTurnPercent = iCurrentResearchPlusThisTurn / iResearchNeeded;
		
				if (fResearchProgressPlusThisTurnPercent > 1) then
					fResearchProgressPlusThisTurnPercent = 1
				end
		
				
				local pTechInfo = GameInfo.Technologies[eCurrentTech];
				if pTechInfo then
					szText = Locale.ConvertTextKey( pTechInfo.Description );
					if iResearchPerTurn > 0 then
						szText = szText .. " (" .. tostring(iResearchTurnsLeft) .. ")";
					end		
					local customHelpString = GetHelpTextForTech(eCurrentTech);
					ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetToolTipString( customHelpString );
					ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechButton"):SetToolTipString( customHelpString );
					ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/BigTechButton"):SetToolTipString( customHelpString );
					-- if we have one, update the tech picture
					if IconHookup( pTechInfo.PortraitIndex, techPortraitSize, pTechInfo.IconAtlas, ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechIcon") ) then
						ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechIcon"):SetHide( false );
					else
						ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechIcon"):SetHide( true );
					end

					-- Update the little icons
					local numButtonsAdded = AddSmallButtonsToTechButton( {B1 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B1"),
B2 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B2"),
B3 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B3"),
B4 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B4"),
B5 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B5")}, pTechInfo, maxSmallButtons, 64 );
					numButtonsAdded = math.max( 0, numButtonsAdded );
	
					AddCallbackToSmallButtons( {B1 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B1"),
B2 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B2"),
B3 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B3"),
B4 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B4"),
B5 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B5")}, maxSmallButtons, -1, -1, Mouse.eLClick, OnTechnologyButtonClicked );
					
					if numButtonsAdded > 0 then
						if OptionsManager.GetSmallUIAssets() then		
							ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetSizeVal( numButtonsAdded*56 + 76, 126 );
						else
							ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetSizeVal( numButtonsAdded*56 + 130, 126 );
						end
						ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetHide( false );
					else
						ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetHide( true );
					end
			
				end
			elseif (eRecentTech ~= -1) then -- maybe we just finished something
				
				local pTechInfo = GameInfo.Technologies[eRecentTech];
				if pTechInfo then
					szText = Locale.ConvertTextKey( pTechInfo.Description );
					-- if we have one, update the tech picture
					if IconHookup( pTechInfo.PortraitIndex, techPortraitSize, pTechInfo.IconAtlas, ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechIcon") ) then
						ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechIcon"):SetHide( false );
					else
						ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechIcon"):SetHide( true );
					end

					-- Update the little icons
					local numButtonsAdded = AddSmallButtonsToTechButton( {B1 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B1"),
B2 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B2"),
B3 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B3"),
B4 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B4"),
B5 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B5")}, pTechInfo, maxSmallButtons, 64 );
					numButtonsAdded = math.max( 0, numButtonsAdded );
			
					AddCallbackToSmallButtons( {B1 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B1"),
B2 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B2"),
B3 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B3"),
B4 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B4"),
B5 = ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/B5")}, maxSmallButtons, -1, -1, Mouse.eLClick, OnTechnologyButtonClicked );
					local numButtonsAdded = 0;
					if numButtonsAdded > 0 then
						ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetSizeVal( numButtonsAdded*56 + 130, 126 );
						ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetHide( false );
					else
						ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetHide( true );
					end
			
				end
				researchStatus = Locale.ConvertTextKey("TXT_KEY_RESEARCH_FINISHED");
				--ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ResearchLabel:SetText( Locale.ConvertTextKey( "TXT_KEY_RESEARCH_FINISHED" ) );
				ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetToolTipString( helpTT );
				ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechButton"):SetToolTipString( helpTT );
				ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/BigTechButton"):SetToolTipString( helpTT );
				--ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechText:SetHide( true );
				--ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/FinishedTechText:SetHide( false );
			else
				researchStatus = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_SUMMARY_NEW_RESEARCH");
		
				ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetHide( true );
				--ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ResearchLabel:SetText( Locale.ConvertTextKey( "TXT_KEY_NOTIFICATION_SUMMARY_NEW_RESEARCH" )  );
				ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ActiveStyle"):SetToolTipString( helpTT );
				ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechButton"):SetToolTipString( helpTT );
				ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/BigTechButton"):SetToolTipString( helpTT );
				--ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechText:SetHide( false );
				--ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/FinishedTechText:SetHide( true );
			end
	
			-- Research Meter
  			local research = AtRTT[Game.GetActivePlayer()] or pPlayer:GetCurrentResearch();
  			if( research ~= -1 ) then
    			ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ResearchMeter"):SetPercents( fResearchProgressPercent, fResearchProgressPlusThisTurnPercent );
			else
    			ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/ResearchMeter"):SetPercents( 1, 0 );
			end
	
			-- Tech Text
			ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechText"):SetText(researchStatus .. " " .. szText);
			ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/FinishedTechText"):SetText(researchStatus .. " " .. szText)
		end
--	end
end

function OnDisplay(popupInfo)
	if ValidPlayerTable[ActivePlayer] then
		if popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_CHOOSETECH then
			OnTechPanelUpdated()
		end
	end
end

function OnTechPanelUpdated()
    if( ContextPtr:IsHidden() == true ) then
        return;
    end
	
  	local iDiscover = aPlayer:GetNumFreeTechs();
  	
    -- Clear buttons
    g_TechInstanceManager:ResetInstances();
    if AtRTT[ActivePlayer] then
		Players[ActivePlayer]:ClearResearchQueue()
	--	Network.SendResearch(-1, 0, -1, false);
	end
	
    local thisTechInfo = nil;
    if (not Game.IsOption(GameOptionTypes.GAMEOPTION_NO_SCIENCE)) then
 		for tech in GameInfo.Technologies() do
 			local techID = tech.ID;
 			if not aPlayer:CanResearch( techID ) and CanAthensDoThat(ActivePlayer, techID) then
 				-- Free tech (from Wonder etc.) - extra conditions may apply
 				if (iDiscover > 0) then
 					AddTechButton(tech, aPlayer:GetResearchTurnsLeft(techID, true), iDiscover, g_TechInstanceManager, TechSelected);
 				else
 					AddTechButton( tech, aPlayer:GetResearchTurnsLeft( techID, true ), iDiscover, g_TechInstanceManager, TechSelected);
 				end
			end
		end
	end
	
--//done
	local screenX, screenY = UIManager:GetScreenSizeVal();
	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup/ScrollPanelBlackFrame"):SetSizeY( screenY );
	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup/ScrollPanelFrame"):SetSizeY( screenY );
	if( OptionsManager.GetSmallUIAssets() ) then
    	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup/ScrollPanel"):SetSizeY( screenY - 244 );
	else
    	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup/ScrollPanel"):SetSizeY( screenY - 300 );
	end
	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup/ButtonStack"):CalculateSize();
	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup/ButtonStack"):ReprocessAnchoring();
	ContextPtr:LookUpControl("/InGame/WorldView/InfoCorner/TechPanel/TechPopup/ScrollPanel"):CalculateInternalSize();
end

--newcodeforeui

function HereTechSelected( eTech, iValue)
	if iValue > 0 then
		Teams[Game.GetActiveTeam()]:SetHasTech(eTech, true)
		aPlayer:SetNumFreeTechs(iValue - 1);
	else
		SetNewTechAt(ActivePlayer, eTech, "dasda")
	   	Network.SendResearch(FirstGoodTech(), 0, -1, false);
	end
	Controls.TechTreeBackground:SetHide(true);
	hBool = true;
end

function OpenDummyButtons()
  	local iDiscover = aPlayer:GetNumFreeTechs();
  	Controls.TechTreeBackground:SetHide(false);
    -- Clear buttons
    d_TechInstanceManager:ResetInstances();
	
    local thisTechInfo = nil;
    if (not Game.IsOption(GameOptionTypes.GAMEOPTION_NO_SCIENCE)) then
 		for tech in GameInfo.Technologies() do
 			local techID = tech.ID;
 			if not aPlayer:CanResearch( techID ) and CanAthensDoThat(ActivePlayer, techID) then
 				-- Free tech (from Wonder etc.) - extra conditions may apply
 				if (iDiscover > 0) then
 					AddTechButton(tech, aPlayer:GetResearchTurnsLeft(techID, true), iDiscover, d_TechInstanceManager, HereTechSelected);
 				else
 					AddTechButton( tech, aPlayer:GetResearchTurnsLeft( techID, true ), iDiscover, d_TechInstanceManager, HereTechSelected);
 				end
			end
		end
	end
	
--//done
	local screenX, screenY = UIManager:GetScreenSizeVal();
	Controls.ScrollPanelBlackFrame:SetSizeY( screenY );
	Controls.ScrollPanelFrame:SetSizeY( screenY );
	Controls.ScrollPanel:SetSizeY( screenY );
	if( OptionsManager.GetSmallUIAssets() ) then
--    	Controls.ScrollPanel:SetSizeY( screenY - 244 );
	else
--    	Controls.ScrollPanel:SetSizeY( screenY - 300 );
	end
	Controls.ButtonStack:CalculateSize();
	Controls.ButtonStack:ReprocessAnchoring();
	Controls.ScrollPanel:CalculateInternalSize();
end