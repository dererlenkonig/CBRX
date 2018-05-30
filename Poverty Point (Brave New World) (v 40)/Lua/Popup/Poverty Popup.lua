-------------------------------------------------
-- Choose Spirit Guardian
-- JFD
-------------------------------------------------
print ("Poverty Popup")

include("IconSupport");
include("InstanceManager");
include("InfoTooltipInclude");

--SaveUtils
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "Poverty 2";

--Stuff
local speed = Game.GetGameSpeedType();

local Barbarians = Players[63]
local bTeam = Barbarians:GetTeam();

local iMound = GameInfo.Improvements["IMPROVEMENT_CEREMONIAL_MOUND_MOD"].ID

local isEEMod = (GameInfoTypes.TECH_EE_SOVEREIGNTY ~= nil);

local PovertyID = GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD;

--local iPottery = GameInfoTypes.TECH_POTTERY;
local iPottery = GameInfoTypes.TECH_TRAPPING;
--local tTheology = GameInfoTypes.TECH_THEOLOGY;
local tTheology = GameInfoTypes.TECH_ASTRONOMY;

local tAstronomy = GameInfoTypes.TECH_ASTRONOMY;
local tSteam = GameInfoTypes.TECH_STEAM_POWER;
local tConstruction = GameInfoTypes.TECH_IRON_WORKING;
local tChivalary = GameInfoTypes.TECH_CHIVALRY;
local tEconomics = GameInfoTypes.TECH_ECONOMICS;
local tBallistics = GameInfoTypes.TECH_BALLISTICS;
local tComputers = GameInfoTypes.TECH_COMPUTERS;
local tInternet = GameInfoTypes.TECH_INTERNET;

local uCaravan = GameInfoTypes.UNIT_CARAVAN;

local ucArtist = GameInfoTypes.UNITCLASS_ARTIST;
local ucWriter = GameInfoTypes.UNITCLASS_WRITER;
local ucMusician = GameInfoTypes.UNITCLASS_MUSICIAN;
local ucScientist = GameInfoTypes.UNITCLASS_SCIENTIST;
local ucMerchant = GameInfoTypes.UNITCLASS_MERCHANT;
local ucEngineer = GameInfoTypes.UNITCLASS_ENGINEER;
local ucGreatGeneral = GameInfoTypes.UNITCLASS_GREAT_GENERAL;
local ucAdmiral = GameInfoTypes.UNITCLASS_GREAT_ADMIRAL;
local ucProphet = GameInfoTypes.UNITCLASS_PROPHET;

local fForest = GameInfoTypes.FEATURE_FOREST;
local fJungle = GameInfoTypes.FEATURE_JUNGLE;
local fMarsh = GameInfoTypes.FEATURE_MARSH;
local fOasis = GameInfoTypes.FEATURE_OASIS;

local sScientist = GameInfo.Specialists.SPECIALIST_SCIENTIST.ID
local sMerchant = GameInfo.Specialists.SPECIALIST_MERCHANT.ID
local sEngineer = GameInfo.Specialists.SPECIALIST_ENGINEER.ID

local iProphet2 = GameInfoTypes.UNIT_POVERTY_POINT_MOD_DUMMY;

local sUnitType = "UNIT_PROPHET"
local iProphetID = GameInfo.Units.UNIT_PROPHET.ID
local iProphetOverride = GameInfo.Units.UNIT_POVERTY_POINT_MOD.ID
local iCivType = GameInfo.Civilizations["CIVILIZATION_POVERTY_POINT_MOD"].ID

local Prophet = GameInfoTypes.UNIT_POVERTY_POINT_MOD;
local Prophet2 = GameInfoTypes.UNIT_POVERTY_POINT_MOD_DUMMY;

local uSettler = GameInfoTypes.UNIT_SETTLER;
local uWorker = GameInfoTypes.UNIT_WORKER;
local uMissionary = GameInfoTypes.UNIT_MISSIONARY;
local uInquisitor = GameInfoTypes.UNIT_INQUISITOR;
local uArchaeologist = GameInfoTypes.UNIT_ARCHAEOLOGIST;
local uChariot = GameInfoTypes.UNIT_CHARIOT_ARCHER
local uWarChariot = GameInfoTypes.UNIT_EGYPTIAN_WARCHARIOT

local Pyramids = GameInfoTypes.BUILDINGCLASS_PYRAMID;
local Itza = GameInfoTypes.BUILDING_CHICHEN_ITZA;

local bBarracks = GameInfoTypes.BUILDING_BARRACKS;
local bArmory = GameInfoTypes.BUILDING_ARMORY;
local bMilAcademy = GameInfoTypes.BUILDING_MILITARY_ACADEMY;
local bTurtleTrade = GameInfoTypes.BUILDING_POVERTY_TURTLE_BONUS_1;
local bTurtleProduction = GameInfoTypes.BUILDING_POVERTY_TURTLE_BONUS_2;

local Suffrage = GameInfoTypes.POLICY_UNIVERSAL_SUFFRAGE;
local pNewDeal = GameInfoTypes.POLICY_NEW_DEAL;

local pFaith1 = GameInfoTypes.POLICY_POVERTY_MOUND_FAITH_1;
local pFaith2 = GameInfoTypes.POLICY_POVERTY_MOUND_FAITH_2;
local pFaith3 = GameInfoTypes.POLICY_POVERTY_MOUND_FAITH_3;
local pScience1 = GameInfoTypes.POLICY_POVERTY_CAMP_SCIENCE_1;
local pBonus8 = GameInfoTypes.POLICY_POVERTY_BONUS_8;
local pBonus9 = GameInfoTypes.POLICY_POVERTY_BONUS_9;

local pCount1 = GameInfoTypes.POLICY_POVERTY_COUNT_1;
local pCount2 = GameInfoTypes.POLICY_POVERTY_COUNT_2;
local pCount3 = GameInfoTypes.POLICY_POVERTY_COUNT_3;
local pCount4 = GameInfoTypes.POLICY_POVERTY_COUNT_4;
local pCount5 = GameInfoTypes.POLICY_POVERTY_COUNT_5;
local pCount6 = GameInfoTypes.POLICY_POVERTY_COUNT_6;
local pCount7 = GameInfoTypes.POLICY_POVERTY_COUNT_7;
local pCount8 = GameInfoTypes.POLICY_POVERTY_COUNT_8;
local pCount9 = GameInfoTypes.POLICY_POVERTY_COUNT_9;

--
--
local pCount1a = GameInfoTypes.POLICY_POVERTY_COUNT_1_A;
local pCount2a = GameInfoTypes.POLICY_POVERTY_COUNT_2_A;
local pCount3a = GameInfoTypes.POLICY_POVERTY_COUNT_3_A;
local pCount4a = GameInfoTypes.POLICY_POVERTY_COUNT_4_A;
local pCount5a = GameInfoTypes.POLICY_POVERTY_COUNT_5_A;
local pCount6a = GameInfoTypes.POLICY_POVERTY_COUNT_6_A;
local pCount7a = GameInfoTypes.POLICY_POVERTY_COUNT_7_A;
local pCount8a = GameInfoTypes.POLICY_POVERTY_COUNT_8_A;
local pCount9a = GameInfoTypes.POLICY_POVERTY_COUNT_9_A;

local pFaith1a = GameInfoTypes.POLICY_POVERTY_MOUND_FAITH_1_A;
local pFaith2a = GameInfoTypes.POLICY_POVERTY_MOUND_FAITH_2_A;
local pFaith3a = GameInfoTypes.POLICY_POVERTY_MOUND_FAITH_3_A;
local pScience1a = GameInfoTypes.POLICY_POVERTY_CAMP_SCIENCE_1_A;
local pBonus8a = GameInfoTypes.POLICY_POVERTY_BONUS_8_A;
local pBonus9a = GameInfoTypes.POLICY_POVERTY_BONUS_9_A;
--
--

local pPRival = GameInfoTypes.PROMOTION_RIVAL_TERRITORY;
local pTamali = GameInfoTypes.PROMOTION_PP_BLESSING_4;
local pTamaliBonus = GameInfoTypes.PROMOTION_PP_BLESSING_4_A;
local pHunter = GameInfoTypes.PROMOTION_PP_HUNTER_BONUS;
local pDuckGo = GameInfoTypes.PROMOTION_PP_DUCK_MOVE;
local pDuckStop = GameInfoTypes.PROMOTION_PP_DUCK_STOP;
local pNoTerrainCost = GameInfoTypes.PROMOTION_IGNORE_TERRAIN_COST;
local pNoMovement = GameInfoTypes.PROMOTION_ROUGH_TERRAIN_ENDS_TURN;
local pWood = GameInfoTypes.PROMOTION_WOODSMAN;
local pFakeGeneral = GameInfoTypes.PROMOTION_PP_BLESSING_3_D;
local pFakeAdmiral = GameInfoTypes.PROMOTION_PP_BLESSING_6_D;
local pLimitedSightRU = GameInfoTypes.PROMOTION_SIGHT_PENALTY;

local pBlessing = GameInfoTypes.PROMOTION_PP_BLESSING;
local pBlessingNull = GameInfoTypes.PROMOTION_PP_BLESSING_NULL;
local pBlessing1 = GameInfoTypes.PROMOTION_PP_BLESSING_1;
local pBlessing2 = GameInfoTypes.PROMOTION_PP_BLESSING_2;
local pBlessing3 = GameInfoTypes.PROMOTION_PP_BLESSING_3;
local pBlessing4 = GameInfoTypes.PROMOTION_PP_BLESSING_4;
local pBlessing5 = GameInfoTypes.PROMOTION_PP_BLESSING_5;
local pBlessing6a = GameInfoTypes.PROMOTION_PP_BLESSING_6_A;
local pBlessing6b = GameInfoTypes.PROMOTION_PP_BLESSING_6_B;
local pBlessing6c = GameInfoTypes.PROMOTION_PP_BLESSING_6_C;
local pBlessing7e = GameInfoTypes.PROMOTION_PP_BLESSING_7_E;
local pBlessing7m = GameInfoTypes.PROMOTION_PP_BLESSING_7_M;
local pBlessing7s = GameInfoTypes.PROMOTION_PP_BLESSING_7_S;
local pBlessing7g = GameInfoTypes.PROMOTION_PP_BLESSING_7_G;
local pBlessing8 = GameInfoTypes.PROMOTION_PP_BLESSING_8;
local pBlessing9 = GameInfoTypes.PROMOTION_PP_BLESSING_9;

local BlessingPromotions = {
	GameInfoTypes.PROMOTION_PP_BLESSING,
	GameInfoTypes.PROMOTION_PP_BLESSING_NULL,
	GameInfoTypes.PROMOTION_PP_BLESSING_1,
	GameInfoTypes.PROMOTION_PP_BLESSING_2,
	GameInfoTypes.PROMOTION_PP_BLESSING_3,
	GameInfoTypes.PROMOTION_PP_BLESSING_4,
	GameInfoTypes.PROMOTION_PP_BLESSING_5,
	GameInfoTypes.PROMOTION_PP_BLESSING_6_A,
	GameInfoTypes.PROMOTION_PP_BLESSING_6_B,
	GameInfoTypes.PROMOTION_PP_BLESSING_6_C,
	GameInfoTypes.PROMOTION_PP_BLESSING_7_E,
	GameInfoTypes.PROMOTION_PP_BLESSING_7_M,
	GameInfoTypes.PROMOTION_PP_BLESSING_7_S,
	GameInfoTypes.PROMOTION_PP_BLESSING_7_G,
	GameInfoTypes.PROMOTION_PP_BLESSING_8,
	GameInfoTypes.PROMOTION_PP_BLESSING_9,
	}

local LandInfantry = { 
	GameInfo.Units.UNIT_MECHANIZED_INFANTRY.ID, 
	GameInfo.Units.UNIT_INFANTRY.ID, 
	GameInfo.Units.UNIT_GREAT_WAR_INFANTRY.ID, 
	GameInfo.Units.UNIT_RIFLEMAN.ID, 
	GameInfo.Units.UNIT_MUSKETMAN.ID, 
	GameInfo.Units.UNIT_PIKEMAN.ID, 
	GameInfo.Units.UNIT_SPEARMAN.ID, 
	GameInfo.Units.UNIT_WARRIOR.ID
	}

function bGetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end

function PovertyAwardPromotions(pPlayer)
	for pUnit in pPlayer:Units() do
		if (pUnit:GetUnitType() == Prophet) or (pUnit:GetUnitType() == Prophet2) then
			for _, iPromotion in pairs(BlessingPromotions) do
				if pUnit:IsHasPromotion(iPromotion) then
					pUnit:SetHasPromotion(iPromotion, false);	
				end
			end
			--Bonus 1
			if pPlayer:HasPolicy(pCount1) then
				if not pUnit:IsHasPromotion(pBlessing1) then
					pUnit:SetHasPromotion(pBlessing1, true);	
				end
			--Bonus 2
			elseif pPlayer:HasPolicy(pCount2) then
				if not pUnit:IsHasPromotion(pBlessing2) then
					pUnit:SetHasPromotion(pBlessing2, true);	
				end
			--Bonus 3
			elseif pPlayer:HasPolicy(pCount3) then
				if not pUnit:IsHasPromotion(pBlessing3) then
					pUnit:SetHasPromotion(pBlessing3, true);	
				end
			--Bonus 4
			elseif pPlayer:HasPolicy(pCount4) then
				if not pUnit:IsHasPromotion(pBlessing4) then
					pUnit:SetHasPromotion(pBlessing4, true);	
				end
			--Bonus 5
			elseif pPlayer:HasPolicy(pCount5) then
				if not pUnit:IsHasPromotion(pBlessing5) then
					pUnit:SetHasPromotion(pBlessing5, true);	
				end
			--Bonus 6
			elseif pPlayer:HasPolicy(pCount6) then
				if not pUnit:IsHasPromotion(pBlessing6a) and not pUnit:IsHasPromotion(pBlessing6b) and not pUnit:IsHasPromotion(pBlessing6c) then
					local pTeam = pPlayer:GetTeam();
					local TechCheck = 0;
					if (Teams[pTeam]:IsHasTech(tAstronomy)) then
						TechCheck = 1;
					end
					if (Teams[pTeam]:IsHasTech(tSteam)) then
						TechCheck = 2;
					end
					if TechCheck == 0 then
						pUnit:SetHasPromotion(pBlessing6a, true);
					elseif TechCheck == 2 then
						pUnit:SetHasPromotion(pBlessing6c, true);
					elseif TechCheck == 1 then
						pUnit:SetHasPromotion(pBlessing6b, true);
					end
				end
			--Bonus 7
			elseif pPlayer:HasPolicy(pCount7) then
				if not pUnit:IsHasPromotion(pBlessing7e) and not pUnit:IsHasPromotion(pBlessing7m) and not pUnit:IsHasPromotion(pBlessing7s) and not pUnit:IsHasPromotion(pBlessing7g) then
					local bRandom = bGetRandom(1, 4)
					if bRandom == 1 then
						pUnit:SetHasPromotion(pBlessing7e, true);
					elseif bRandom == 2 then
						pUnit:SetHasPromotion(pBlessing7m, true);
					elseif bRandom == 3 then
						pUnit:SetHasPromotion(pBlessing7s, true);
					elseif bRandom == 4 then
						pUnit:SetHasPromotion(pBlessing7g, true);
					end
				end
			--Bonus 8
			elseif pPlayer:HasPolicy(pCount8) then
				if not pUnit:IsHasPromotion(pBlessing8) then
					pUnit:SetHasPromotion(pBlessing8, true);	
				end
			--Bonus 9
			elseif pPlayer:HasPolicy(pCount9) then
				if not pUnit:IsHasPromotion(pBlessing9) then
					pUnit:SetHasPromotion(pBlessing9, true);	
				end
			--Bonus 0
			else
				if not pUnit:IsHasPromotion(pBlessing) then
					pUnit:SetHasPromotion(pBlessing, true)		
				end
			end
		end	
	end
end

function PovertySaveEver(pPlayer)
	if pPlayer:HasPolicy(pCount1) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_1") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_1", true)
		end
	end
	if pPlayer:HasPolicy(pCount2) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_2") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_2", true)
		end
	end
	if pPlayer:HasPolicy(pCount3) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_3") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_3", true)
		end
	end
	if pPlayer:HasPolicy(pCount4) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_4") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_4", true)
		end
	end
	if pPlayer:HasPolicy(pCount5) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_5") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_5", true)
		end
	end
	if pPlayer:HasPolicy(pCount6) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_6") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_6", true)
		end
	end
	if pPlayer:HasPolicy(pCount7) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_7") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_7", true)
		end
	end
	if pPlayer:HasPolicy(pCount8) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_8") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_8", true)
		end
	end
	if pPlayer:HasPolicy(pCount9) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_9") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_9", true)
		end
	end
end

function PovertyTurtleTrade(pPlayer)
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
			if pPlayer:HasPolicy(pCount5) then
				for pCity in pPlayer:Cities() do
					local pPlot = pCity:Plot();
					if not pPlot:IsRiver() then
						if pCity:IsHasBuilding(bTurtleTrade) then
							pCity:SetNumRealBuilding(bTurtleTrade, 0);
						end
					elseif pPlot:IsRiver() then
						if not pCity:IsHasBuilding(bTurtleTrade) then
							pCity:SetNumRealBuilding(bTurtleTrade, 1);
						end
						local pID = pPlayer:GetID()
						local tTradeRoutes = pPlayer:GetTradeRoutes()
						for iKey, tRoute in ipairs(tTradeRoutes) do
							if (tRoute.FromCity == pCity) and (tRoute.FromID == pID) then
								local pToCity = tRoute.ToCity;
								if not pToCity:IsHasBuilding(bTurtleProduction) then
									pToCity:SetNumRealBuilding(bTurtleProduction, 1);
								end
							end
						end
					end
				end
			end
		end
	end
end

function PovertyAwardBonuses(pPlayer)
	local pTeam = pPlayer:GetTeam();
	--Bonus 1
	if pPlayer:HasPolicy(pCount1) then
		if not pPlayer:HasPolicy(pFaith1) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(pFaith1, true);
		end		
		if (Teams[pTeam]:IsHasTech(tTheology)) then 
			if not pPlayer:HasPolicy(pFaith2) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pFaith2, true);
			end
		end
		if pPlayer:HasPolicy(pNewDeal) then 
			if not pPlayer:HasPolicy(pFaith3) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pFaith3, true);
			end
		end
	--Bonus 2
	--Bonus 3
	elseif pPlayer:HasPolicy(pCount3) then
		Teams[pTeam]:MakePeace(bTeam)
		Teams[pTeam]:SetPermanentWarPeace(bTeam, true)
	--Bonus 4
	elseif pPlayer:HasPolicy(pCount4) then
		if not pPlayer:HasPolicy(pScience1) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(pScience1, true);
		end	
	--Bonus 5
	elseif pPlayer:HasPolicy(pCount5) then
		PovertyTurtleTrade(pPlayer)
	--Bonus 6
	elseif pPlayer:HasPolicy(pCount6) then
		for pUnit in pPlayer:Units() do
			if (pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND) and pUnit:IsCombatUnit() then 
				if not pUnit:IsHasPromotion(pDuckStop) then
					pUnit:SetHasPromotion(pDuckStop, true)
				end
			end
		end
	--Bonus 7
	elseif pPlayer:HasPolicy(pCount7) then
		if not pPlayer:HasPolicy(pBonus8) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(pBonus8, true);
		end	
	--Bonus 8
	elseif pPlayer:HasPolicy(pCount8) then
		for pUnit in pPlayer:Units() do
			if (pUnit:GetUnitType() == uSettler) or (pUnit:GetUnitType() == uWorker) or (pUnit:GetUnitType() == uInquisitor) or (pUnit:GetUnitType() == uArchaeologist) then
				if not pUnit:IsHasPromotion(pHunter) then
					pUnit:SetHasPromotion(pHunter, true)
				end
			end
			if (pUnit:GetUnitType() == uMissionary) then
				if pUnit:IsHasPromotion(pLimitedSightRU) then
					pUnit:SetHasPromotion(pLimitedSightRU, false)
				end
			end
		end
	--Bonus 9
	elseif pPlayer:HasPolicy(pCount9) then

		local gAge = pPlayer:GetNumGoldenAges()
		local GABonus = 0;	
		local GABonus2 = 0;
		local GALength = 0;
		local GALength2 = 0;
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(Itza) then
				GALength2 = 1;
				break;
			end
		end
		if pPlayer:HasPolicy(Suffrage) then
			GALength2 = 1;
		end
		local speed = Game.GetGameSpeedType();
		if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
			GABonus = 6;
			GABonus2 = 3;
			GALength = (2 + GALength2);
		elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
			GABonus = 8;
			GABonus2 = 4;
			GALength = (3 + GALength2);
		elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
			GABonus = 10;
			GABonus2 = 5;
			GALength = (4 + GALength2);
		elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
			GABonus = 16;
			GABonus2 = 8;
			GALength = (5 + GALength2);
		else
			GABonus = 16;
			GABonus2 = 8;
			GALength = (5 + GALength2);
		end
		pPlayer:ChangeGoldenAgeTurns(GABonus)
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(Itza) then
				pPlayer:ChangeGoldenAgeTurns(GABonus2);
				break;
			end
		end
		if pPlayer:HasPolicy(Suffrage) then
			pPlayer:ChangeGoldenAgeTurns(GABonus2);
		end
		pPlayer:SetNumGoldenAges(gAge)
		for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
			local mPlayer = Players[mPlayer];
			if (mPlayer:IsAlive()) then
				local mTeam = mPlayer:GetTeam();
				if mTeam ~= pTeam then
					if mPlayer:IsAnarchy() then
						mPlayer:ChangeAnarchyNumTurns(GALength);
					else
						mPlayer:SetAnarchyNumTurns(GALength);
					end
				end
			end
		end

		if (pPlayer:IsHuman()) then
			Events.GameplayAlertMessage("[COLOR_NEGATIVE_TEXT]The Horned Serpent is causing [ICON_RESISTANCE] Anarchy![ENDCOLOR]");	
		end

	end
end

--Event Message
function GetPovertyHuman()	
	local hPlayer = 0;
	for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local oPlayer = Players[iPlayer];
		if oPlayer:IsEverAlive() then
			if oPlayer:IsHuman() then
				hPlayer = oPlayer;
				break;
			end
		end
	end
	return hPlayer;
end

--Event Message
function PovertyEventMessage(pPlayer)
	local DoMessage = 0;
	if pPlayer:IsHuman() and (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then
		DoMessage = 1;
	end
	if not pPlayer:IsHuman() and (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then
		local pTeam = pPlayer:GetTeam();
		local hPlayer = GetPovertyHuman();
		if hPlayer ~= 0 then
			local hTeam = hPlayer:GetTeam();
			if hPlayer ~= pPlayer then
				if Teams[pTeam]:IsHasMet(hTeam) then
					DoMessage = 1;
				end
			end
		end
	end
	if DoMessage >= 1 then
		if pPlayer:HasPolicy(pCount1) then
			Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Old Man Above watches over the Poverty Point civilization![ENDCOLOR]")
		elseif pPlayer:HasPolicy(pCount2) then
			Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Kneeling Woman watches over the Poverty Point civilization![ENDCOLOR]")
		elseif pPlayer:HasPolicy(pCount3) then
			Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Red Fox watches over the Poverty Point civilization![ENDCOLOR]")
		elseif pPlayer:HasPolicy(pCount4) then
			Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Long Tail watches over the Poverty Point civilization![ENDCOLOR]")
		elseif pPlayer:HasPolicy(pCount5) then
			Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Stone Turtle watches over the Poverty Point civilization![ENDCOLOR]")
		elseif pPlayer:HasPolicy(pCount6) then
			Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Duck Foot watches over the Poverty Point civilization![ENDCOLOR]")
		elseif pPlayer:HasPolicy(pCount7) then
			Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Beaded Locust watches over the Poverty Point civilization![ENDCOLOR]")		
		elseif pPlayer:HasPolicy(pCount8) then
			Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Potbellied Owl watches over the Poverty Point civilization![ENDCOLOR]")
		elseif pPlayer:HasPolicy(pCount9) then
			Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Horned Serpent watches over the Poverty Point civilization![ENDCOLOR]")
		end	
	end
end

--Popup
local m_PopupInfo = nil;

local activePlayerID = Game.GetActivePlayer()
local activePlayer = Players[activePlayerID]
local numSpiritGuardians = 9

local g_PopupInfo = nil;

ButtonPopupTypes.BUTTONPOPUP_TOMATEKH_CHOOSE_SPIRIT_GUARDIAN = "BUTTONPOPUP_TOMATEKH_CHOOSE_SPIRIT_GUARDIAN"
g_PopupInfo = {["Type"] = ButtonPopupTypes.BUTTONPOPUP_TOMATEKH_CHOOSE_SPIRIT_GUARDIAN}
 
local g_ItemManager = InstanceManager:new( "ItemInstance", "Button", Controls.ItemStack );
local g_SelectedGuardian = nil
function DisplayPopup()
	g_ItemManager:ResetInstances();
	for num = 1, numSpiritGuardians do
		local controlTable = g_ItemManager:GetInstance();
		local portraitAtlas = "POVERTY_POINT_SPIRIT_GUARDIAN_ATLAS"
		IconHookup( num, 64, portraitAtlas, controlTable.Icon64 );
		controlTable.Name:LocalizeAndSetText("TXT_KEY_POVERTY_BONUS_TITLE_" .. num);
		controlTable.Button:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_" .. num));
		local pPlayer = activePlayer;
		if (load(pPlayer, "POVERTY_EVER_BONUS_" .. num) == true) then
			controlTable.Name:LocalizeAndSetText("[COLOR_NEGATIVE_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_TITLE_" .. num) .. "[ENDCOLOR]");
			controlTable.Button:SetToolTipString(Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_BODY_" .. num) .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_CURRENT"));
			controlTable.Button:SetDisabled(true)
		else
			controlTable.Button:SetDisabled(false)
		end
		local selectionAnim = controlTable.SelectionAnim;
		controlTable.Button:SetVoid1(num)
		controlTable.Button:RegisterCallback(Mouse.eLClick, function()  
			g_SelectedGuardian = num
			DisplayPopup()
		end);
		if g_SelectedGuardian then
			if g_SelectedGuardian == num then
				controlTable.SelectionAnim:SetHide(false)
			else
				controlTable.SelectionAnim:SetHide(true)
			end
		else
			controlTable.SelectionAnim:SetHide(true)
		end
	end
	Controls.ItemStack:CalculateSize();
	Controls.ItemStack:ReprocessAnchoring();
	Controls.ItemScrollPanel:CalculateInternalSize();
	Controls.ConfirmButton:SetDisabled(true);
	ContextPtr:SetHide(false); 
	if g_SelectedGuardian then
		Controls.ConfirmButton:SetDisabled(false);
	end	
end

function OnConfirm()
    ContextPtr:SetHide(true); 

	local pPlayer = activePlayer;
	local RepeatCheck = 0

	if g_SelectedGuardian == 1 then
		if (load(pPlayer, "POVERTY_EVER_BONUS_1") ~= true) then
			if not pPlayer:HasPolicy(pCount1) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pCount1, true);
			end
		elseif (load(pPlayer, "POVERTY_EVER_BONUS_1") == true) then
			RepeatCheck = 1;
		end
	elseif g_SelectedGuardian == 2 then
		if (load(pPlayer, "POVERTY_EVER_BONUS_2") ~= true) then
			if not pPlayer:HasPolicy(pCount2) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pCount2, true);
			end
		elseif (load(pPlayer, "POVERTY_EVER_BONUS_2") == true) then
			RepeatCheck = 1;
		end
	elseif g_SelectedGuardian == 3 then
		if (load(pPlayer, "POVERTY_EVER_BONUS_3") ~= true) then
			if not pPlayer:HasPolicy(pCount3) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pCount3, true);
			end
		elseif (load(pPlayer, "POVERTY_EVER_BONUS_3") == true) then
			RepeatCheck = 1;
		end
	elseif g_SelectedGuardian == 4 then
		if (load(pPlayer, "POVERTY_EVER_BONUS_4") ~= true) then
			if not pPlayer:HasPolicy(pCount4) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pCount4, true);
			end
		elseif (load(pPlayer, "POVERTY_EVER_BONUS_4") == true) then
			RepeatCheck = 1;
		end
	elseif g_SelectedGuardian == 5 then
		if (load(pPlayer, "POVERTY_EVER_BONUS_5") ~= true) then
			if not pPlayer:HasPolicy(pCount5) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pCount5, true);
			end
		elseif (load(pPlayer, "POVERTY_EVER_BONUS_5") == true) then
			RepeatCheck = 1;
		end
	elseif g_SelectedGuardian == 6 then
		if (load(pPlayer, "POVERTY_EVER_BONUS_6") ~= true) then
			if not pPlayer:HasPolicy(pCount6) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pCount6, true);
			end
		elseif (load(pPlayer, "POVERTY_EVER_BONUS_6") == true) then
			RepeatCheck = 1;
		end
	elseif g_SelectedGuardian == 7 then
		if (load(pPlayer, "POVERTY_EVER_BONUS_7") ~= true) then
			if not pPlayer:HasPolicy(pCount7) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pCount7, true);
			end
		elseif (load(pPlayer, "POVERTY_EVER_BONUS_7") == true) then
			RepeatCheck = 1;
		end
	elseif g_SelectedGuardian == 8 then
		if (load(pPlayer, "POVERTY_EVER_BONUS_8") ~= true) then
			if not pPlayer:HasPolicy(pCount8) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pCount8, true);
			end
		elseif (load(pPlayer, "POVERTY_EVER_BONUS_8") == true) then
			RepeatCheck = 1;
		end
	elseif g_SelectedGuardian == 9 then
		if (load(pPlayer, "POVERTY_EVER_BONUS_9") ~= true) then
			if not pPlayer:HasPolicy(pCount9) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pCount9, true);
			end
		elseif (load(pPlayer, "POVERTY_EVER_BONUS_9") == true) then
			RepeatCheck = 1;
		end
	end

	if RepeatCheck == 0 then
		PovertySaveEver(pPlayer)
		PovertyAwardPromotions(pPlayer)
		PovertyAwardBonuses(pPlayer)
		PovertyEventMessage(pPlayer)
	elseif RepeatCheck >= 1 then
		DisplayPopup()
	end

end
Controls.ConfirmButton:RegisterCallback( Mouse.eLClick, OnConfirm );
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
function ShowSpiritGuardiansPopup()
	DisplayPopup()
end 
LuaEvents.Tomatekh_ShowSpiritGuardiansPopup.Add(ShowSpiritGuardiansPopup)

----------------------------------------------------------------
-- 'Active' (local human) player has changed
----------------------------------------------------------------
function OnActivePlayerChanged( iActivePlayer, iPrevActivePlayer )
	if (not ContextPtr:IsHidden()) then
		ContextPtr:SetHide(true);
	end
end
Events.GameplaySetActivePlayer.Add(OnActivePlayerChanged);

UIManager:QueuePopup(ContextPtr, PopupPriority.SocialPolicy)
UIManager:DequeuePopup(ContextPtr)