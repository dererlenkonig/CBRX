print ("Poverty Scripts")

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
local uCaravanClass = GameInfoTypes.UNITCLASS_CARAVAN;

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

local sScientist = GameInfo.Specialists.SPECIALIST_ARTIST.ID
local sMerchant = GameInfo.Specialists.SPECIALIST_MUSICIAN.ID
local sEngineer = GameInfo.Specialists.SPECIALIST_WRITER.ID

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
local bFakeHaggia = GameInfoTypes.BUILDING_PROPHET_BONUS_0;

local Suffrage = GameInfoTypes.POLICY_UNIVERSAL_SUFFRAGE;
local pNewDeal = GameInfoTypes.POLICY_NEW_DEAL;

local pCount1 = GameInfoTypes.POLICY_POVERTY_COUNT_1;
local pCount2 = GameInfoTypes.POLICY_POVERTY_COUNT_2;
local pCount3 = GameInfoTypes.POLICY_POVERTY_COUNT_3;
local pCount4 = GameInfoTypes.POLICY_POVERTY_COUNT_4;
local pCount5 = GameInfoTypes.POLICY_POVERTY_COUNT_5;
local pCount6 = GameInfoTypes.POLICY_POVERTY_COUNT_6;
local pCount7 = GameInfoTypes.POLICY_POVERTY_COUNT_7;
local pCount8 = GameInfoTypes.POLICY_POVERTY_COUNT_8;
local pCount9 = GameInfoTypes.POLICY_POVERTY_COUNT_9;

local pFaith1 = GameInfoTypes.POLICY_POVERTY_MOUND_FAITH_1;
local pFaith2 = GameInfoTypes.POLICY_POVERTY_MOUND_FAITH_2;
local pFaith3 = GameInfoTypes.POLICY_POVERTY_MOUND_FAITH_3;
local pScience1 = GameInfoTypes.POLICY_POVERTY_CAMP_SCIENCE_1;
local pBonus8 = GameInfoTypes.POLICY_POVERTY_BONUS_8;
local pBonus9 = GameInfoTypes.POLICY_POVERTY_BONUS_9;

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

function pDecompilePlotID(sKey)
    iBreak = string.find(sKey, "Y")
    iX = tonumber(string.sub(sKey, 1, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1))
    pPlot = Map.GetPlot(iX, iY)
    return pPlot
end

function pCompilePlotID(pPlot)
    iX = pPlot:GetX()
    iY = pPlot:GetY()
    return(iX .. "Y" .. iY)
end

local PovertyTempPlots = {}

function bGetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end

local pCapitalPlots = {}

--Get Original Capital Plots at Game Start or Capital Settle
for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	for oPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local oPlayer = Players[oPlayer];
		if oPlayer:IsAlive() then
			for oCity in oPlayer:Cities() do
				if oCity:IsOriginalCapital() then
					if not Players[oCity:GetOriginalOwner()]:IsMinorCiv() and not Players[oCity:GetOriginalOwner()]:IsBarbarian() then
						local oPlot = oCity:Plot();
						if pPlot == oPlot then
							local sKey = pCompilePlotID(pPlot)
							pCapitalPlots[sKey] = -1
						end
					end
				end
			end
		end
    end
	for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 2 do 
		local mPlayer = Players[i];
		if mPlayer:IsAlive() then
			for mCity in mPlayer:Cities() do
				if mCity:IsOriginalCapital() then
					if not Players[mCity:GetOriginalOwner()]:IsMinorCiv() and not Players[mCity:GetOriginalOwner()]:IsBarbarian() then
						local mPlot = mCity:Plot();
						if pPlot == mPlot then
							local sKey = pCompilePlotID(pPlot)
							pCapitalPlots[sKey] = -1
						end
					end
				end
			end
		end
	end
end

GameEvents.PlayerCityFounded.Add(
function(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer];
	local pPlot = Map.GetPlot(iCityX, iCityY);
	local pCity = pPlot:GetPlotCity();
	if (pPlayer:IsAlive()) then
		if pCity:IsOriginalCapital() then
			if not pPlayer:IsMinorCiv() and not pPlayer:IsBarbarian() then
				local sKey = pCompilePlotID(pPlot)
				pCapitalPlots[sKey] = -1
			end
		end
	end
end)

function GetPlayersOriginalCity(pPlayer)
	local pcCity = pPlayer:GetCapitalCity();
	for sKey, tTable in pairs(pCapitalPlots) do
		local pPlot = pDecompilePlotID(sKey)
		if pPlot:IsCity() then
			local pCity = pPlot:GetPlotCity();
			local iOldOwner = pCity:GetOriginalOwner();
			local oPlayer = Players[iOldOwner];
			if pPlayer == oPlayer then
				pcCity = pCity;
				break;
			end
		end
	end
	return pcCity;
end

local BaseThreshold = 200;
local BaseMultiplier = 100;
if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
	BaseThreshold = 134;
	BaseMultiplier = 67;
elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
	BaseThreshold = 200;
	BaseMultiplier = 100;
elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
	BaseThreshold = 300;
	BaseMultiplier = 150;
elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
	BaseThreshold = 600;
	BaseMultiplier = 300;
else
	BaseThreshold = 600;
	BaseMultiplier = 300;
end

--Get Prophet Threshold
local bProCountMAX = GameInfoTypes.BUILDING_TOMATEKH_PROPHET_PP_DUMMY_MAX;

function GetProphetThreshold(pPlayer)
	pcCity = GetPlayersOriginalCity(pPlayer);
	local ProThreshold = BaseThreshold;
	local ProNum = pcCity:GetNumBuilding(bProCountMAX);
	if ProNum == 0 then 
		ProThreshold = BaseThreshold;
	elseif ProNum >= 1 then 
		local ProSequence = BaseThreshold;
		for num = 1, ProNum do
			ProSequence = (ProSequence + (BaseMultiplier * num));
		end
		ProThreshold = math.floor(ProSequence * 0.9);
	end
	return ProThreshold;
end

--Prophet Names
function ProphetName(pUnit)
	local bRandom = bGetRandom(1, 15)
	if bRandom == 1 then
		pUnit:SetName("Alibama");
	elseif bRandom == 2 then
		pUnit:SetName("Sihkaltini");
	elseif bRandom == 3 then
		pUnit:SetName("Halayihku");
	elseif bRandom == 4 then
		pUnit:SetName("Oskameli");
	elseif bRandom == 5 then
		pUnit:SetName("Cikasa");
	elseif bRandom == 6 then
		pUnit:SetName("Cahta");
	elseif bRandom == 7 then
		pUnit:SetName("Sihtimasu");
	elseif bRandom == 8 then
		pUnit:SetName("Karankawe");
	elseif bRandom == 9 then
		pUnit:SetName("Kusati");
	elseif bRandom == 10 then
		pUnit:SetName("Sihkalpalka");
	elseif bRandom == 11 then
		pUnit:SetName("Uspi");
	elseif bRandom == 12 then
		pUnit:SetName("Lakasmeli");
	elseif bRandom == 13 then
		pUnit:SetName("Paska");
	elseif bRandom == 14 then
		pUnit:SetName("Yoroni");
	elseif bRandom == 15 then
		pUnit:SetName("Huma");
	end
end

--Change Promotions
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

--Prophet Override
function ProphetOverride(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
        if (pPlayer:GetCivilizationType() == iCivType) then
       	    if pPlayer:GetUnitByID(iUnit) ~= nil then
				pUnit = pPlayer:GetUnitByID(iUnit);
                if (pUnit:GetUnitType() == iProphetID) then
                    local newUnit = pPlayer:InitUnit(iProphetOverride, pUnit:GetX(), pUnit:GetY())
                    newUnit:Convert(pUnit);
					if not newUnit:IsHasPromotion(pBlessing) then
						newUnit:SetHasPromotion(pBlessing, true)		
					end
					newUnit:SetName("");
					PovertyAwardPromotions(pPlayer)
                end
				--
				if (pUnit:GetUnitType() == iProphetOverride) then
					pUnit:SetName("");
					PovertyAwardPromotions(pPlayer)
				end
				--
            end
        end
    end
end

Events.SerialEventUnitCreated.Add(ProphetOverride)

--Prophet at Tech
function GetPovertyTeam()	
	local oTeam = 999;
	for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local pPlayer = Players[iPlayer];
		if pPlayer:IsEverAlive() then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then
				oTeam = pPlayer:GetTeam();
				break;
			end
		end
	end
	return oTeam;
end

function GetPovertyPlayer()	
	local pPlayer = 0;
	for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local oPlayer = Players[iPlayer];
		if oPlayer:IsEverAlive() then
			if (oPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then
				pPlayer = oPlayer;
				break;
			end
		end
	end
	return pPlayer;
end

GameEvents.TeamSetHasTech.Add(
function(iTeam, iTech, bAdopted) 
	if (iTech == iPottery) then
		local oTeam = GetPovertyTeam();
		local pPlayer = GetPovertyPlayer();
		if oTeam == iTeam then
			if pPlayer:IsHuman() then
				local pcCity = pPlayer:GetCapitalCity();
				pUnit = pPlayer:InitUnit(iProphet2, pcCity:GetX(), pcCity:GetY(), UNITAI_PROPHET);
				pUnit:JumpToNearestValidPlot()
				if not pUnit:IsHasPromotion(pPRival) then
					pUnit:SetHasPromotion(pPRival, true)		
				end
				if not pUnit:IsHasPromotion(pBlessing) then
					pUnit:SetHasPromotion(pBlessing, true)		
				end
				pUnit:SetName("");
				PovertyAwardPromotions(pPlayer);
			end
		end
	end
	if (iTech == tAstronomy) then
		local oTeam = GetPovertyTeam();
		local pPlayer = GetPovertyPlayer();
		if oTeam == iTeam then
			PovertyAwardPromotions(pPlayer);
		end
	end
	if (iTech == tSteam) then
		local oTeam = GetPovertyTeam();
		local pPlayer = GetPovertyPlayer();
		if oTeam == iTeam then
			PovertyAwardPromotions(pPlayer);
		end
	end
end)

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

--UI Button
local tForest = GameInfoTypes.TECH_MINING;
local tJungle = GameInfoTypes.TECH_BRONZE_WORKING;
local tMarsh = GameInfoTypes.TECH_MASONRY;

function PovertyClearActive(pPlayer)
	if pPlayer:HasPolicy(pCount1) then
		pPlayer:SetHasPolicy(pCount1, false);
		if not pPlayer:HasPolicy(pCount1a) then
			pPlayer:SetHasPolicy(pCount1a, true);
		end
	end	
	if pPlayer:HasPolicy(pCount2) then
		pPlayer:SetHasPolicy(pCount2, false);
		if not pPlayer:HasPolicy(pCount2a) then
			pPlayer:SetHasPolicy(pCount2a, true);
		end
	end	
	if pPlayer:HasPolicy(pCount3) then
		pPlayer:SetHasPolicy(pCount3, false);
		if not pPlayer:HasPolicy(pCount3a) then
			pPlayer:SetHasPolicy(pCount3a, true);
		end
	end	
	if pPlayer:HasPolicy(pCount4) then
		pPlayer:SetHasPolicy(pCount4, false);
		if not pPlayer:HasPolicy(pCount4a) then
			pPlayer:SetHasPolicy(pCount4a, true);
		end
	end	
	if pPlayer:HasPolicy(pCount5) then
		pPlayer:SetHasPolicy(pCount5, false);
		if not pPlayer:HasPolicy(pCount5a) then
			pPlayer:SetHasPolicy(pCount5a, true);
		end
	end	
	if pPlayer:HasPolicy(pCount6) then
		pPlayer:SetHasPolicy(pCount6, false);
		if not pPlayer:HasPolicy(pCount6a) then
			pPlayer:SetHasPolicy(pCount6a, true);
		end
	end	
	if pPlayer:HasPolicy(pCount7) then
		pPlayer:SetHasPolicy(pCount7, false);
		if not pPlayer:HasPolicy(pCount7a) then
			pPlayer:SetHasPolicy(pCount7a, true);
		end
	end	
	if pPlayer:HasPolicy(pCount8) then
		pPlayer:SetHasPolicy(pCount8, false);
		if not pPlayer:HasPolicy(pCount8a) then
			pPlayer:SetHasPolicy(pCount8a, true);
		end
	end	
	if pPlayer:HasPolicy(pCount9) then
		pPlayer:SetHasPolicy(pCount9, false);
		if not pPlayer:HasPolicy(pCount9a) then
			pPlayer:SetHasPolicy(pCount9a, true);
		end
	end	
end

function PovertyClearPromotions(pPlayer)
	for pUnit in pPlayer:Units() do
		if (pUnit:GetUnitType() == Prophet) or (pUnit:GetUnitType() == Prophet2) then
			for _, iPromotion in pairs(BlessingPromotions) do
				if pUnit:IsHasPromotion(iPromotion) then
					pUnit:SetHasPromotion(iPromotion, false)		
				end
			end
			if not pUnit:IsHasPromotion(pBlessing) then
				pUnit:SetHasPromotion(pBlessing, true)	
			end
		end
	end
end

function PovertyClearBonuses(pPlayer)
	local pTeam = pPlayer:GetTeam();
	--Bonus 1
	if pPlayer:HasPolicy(pFaith1) then
		pPlayer:SetHasPolicy(pFaith1, false);
		if not pPlayer:HasPolicy(pFaith1a) then
			pPlayer:SetHasPolicy(pFaith1a, true);
		end
	end	
	if pPlayer:HasPolicy(pFaith2) then
		pPlayer:SetHasPolicy(pFaith2, false);
		if not pPlayer:HasPolicy(pFaith2a) then
			pPlayer:SetHasPolicy(pFaith2a, true);
		end
	end	
	if pPlayer:HasPolicy(pFaith3) then
		pPlayer:SetHasPolicy(pFaith3, false);
		if not pPlayer:HasPolicy(pFaith3a) then
			pPlayer:SetHasPolicy(pFaith3a, true);
		end
	end	
	--Bonus 2
	--Bonus 3
	if not Teams[pTeam]:IsAtWar(bTeam) then
		Teams[pTeam]:DeclareWar(bTeam);
		Teams[pTeam]:SetPermanentWarPeace(bTeam, true);
	end
	for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local mPlayer = Players[mPlayer];
		if mPlayer:IsAlive() then
			for mUnit in mPlayer:Units() do
				if mUnit:IsHasPromotion(pFakeGeneral) then
					mUnit:SetHasPromotion(pFakeGeneral, false)
				end
			end
		end
	end
	--Bonus 4
	for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local mPlayer = Players[mPlayer];
		if mPlayer:IsAlive() then
			for mUnit in mPlayer:Units() do
				if mUnit:IsHasPromotion(pTamaliBonus) then
					mUnit:SetHasPromotion(pTamaliBonus, false)
				end
			end
		end
	end
	if pPlayer:HasPolicy(pScience1) then
		pPlayer:SetHasPolicy(pScience1, false);
		if not pPlayer:HasPolicy(pScience1a) then
			pPlayer:SetHasPolicy(pScience1a, true);
		end
	end	
	--Bonus 5
	for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local mPlayer = Players[mPlayer];
		if mPlayer:IsAlive() then
			for mCity in mPlayer:Cities() do
				if mCity:IsHasBuilding(bTurtleTrade) then
					mCity:SetNumRealBuilding(bTurtleTrade, 0);
				end
				if mCity:IsHasBuilding(bTurtleProduction) then
					mCity:SetNumRealBuilding(bTurtleProduction, 0);
				end
			end
		end
	end
	--Bonus 6
	for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local mPlayer = Players[mPlayer];
		if mPlayer:IsAlive() then
			for mUnit in mPlayer:Units() do
				if mUnit:IsHasPromotion(pDuckStop) then
					mUnit:SetHasPromotion(pDuckStop, false)
				end
				if mUnit:IsHasPromotion(pDuckGo) then
					mUnit:SetHasPromotion(pDuckGo, false)
				end
				if mUnit:IsHasPromotion(pFakeAdmiral) then
					mUnit:SetHasPromotion(pFakeAdmiral, false)
				end
				if (mUnit:GetUnitType() == uChariot) or (mUnit:GetUnitType() == uWarChariot) then
					if not mUnit:IsHasPromotion(pNoMovement) then
						mUnit:SetHasPromotion(pNoMovement, true)
					end
				end
			end
		end
	end
	--Bonus 7
	if pPlayer:HasPolicy(pBonus8) then
		pPlayer:SetHasPolicy(pBonus8, false);
		if not pPlayer:HasPolicy(pBonus8a) then
			pPlayer:SetHasPolicy(pBonus8a, true);
		end
	end
	--Bonus 8
	for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local mPlayer = Players[mPlayer];
		if mPlayer:IsAlive() then
			for mUnit in mPlayer:Units() do
				if mUnit:IsHasPromotion(pHunter) then
					mUnit:SetHasPromotion(pHunter, false)
				end
				if (mUnit:GetUnitType() == uMissionary) then
					if not mUnit:IsHasPromotion(pLimitedSightRU) then
						mUnit:SetHasPromotion(pLimitedSightRU, true)
					end
				end
			end
		end
	end
	--Bonus 9
end

function PovertyTurtleTradeClean(pPlayer)
	for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local mPlayer = Players[mPlayer];
		if mPlayer:IsAlive() then
			for mCity in mPlayer:Cities() do
				if mCity:IsHasBuilding(bTurtleProduction) then
					mCity:SetNumRealBuilding(bTurtleProduction, 0);
				end
			end
		end
	end
end

function PovertySaveEver(pPlayer)
	if (load(pPlayer, "POVERTY_CURRENT_BONUS_1") == true) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_1") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_1", true)
		end
	end
	if (load(pPlayer, "POVERTY_CURRENT_BONUS_2") == true) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_2") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_2", true)
		end
	end
	if (load(pPlayer, "POVERTY_CURRENT_BONUS_3") == true) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_3") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_3", true)
		end
	end
	if (load(pPlayer, "POVERTY_CURRENT_BONUS_4") == true) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_4") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_4", true)
		end
	end
	if (load(pPlayer, "POVERTY_CURRENT_BONUS_5") == true) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_5") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_5", true)
		end
	end
	if (load(pPlayer, "POVERTY_CURRENT_BONUS_6") == true) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_6") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_6", true)
		end
	end
	if (load(pPlayer, "POVERTY_CURRENT_BONUS_7") == true) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_7") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_7", true)
		end
	end
	if (load(pPlayer, "POVERTY_CURRENT_BONUS_8") == true) then
		if (load(pPlayer, "POVERTY_EVER_BONUS_8") ~= true) then
			save(pPlayer, "POVERTY_EVER_BONUS_8", true)
		end
	end
	if (load(pPlayer, "POVERTY_CURRENT_BONUS_9") == true) then
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

function PovertyCheckifChosen(pPlayer)	
	local pChosenCheck = 0;
	if pPlayer:HasPolicy(pCount1) then
		pChosenCheck = 1;
	end	
	if pPlayer:HasPolicy(pCount2) then
		pChosenCheck = 1;
	end	
	if pPlayer:HasPolicy(pCount3) then
		pChosenCheck = 1;
	end	
	if pPlayer:HasPolicy(pCount4) then
		pChosenCheck = 1;
	end	
	if pPlayer:HasPolicy(pCount5) then
		pChosenCheck = 1;
	end	
	if pPlayer:HasPolicy(pCount6) then
		pChosenCheck = 1;
	end	
	if pPlayer:HasPolicy(pCount7) then
		pChosenCheck = 1;
	end	
	if pPlayer:HasPolicy(pCount8) then
		pChosenCheck = 1;
	end	
	if pPlayer:HasPolicy(pCount9) then
		pChosenCheck = 1;
	end	
	return pChosenCheck;
end

function MyButtonFunction()
	local plot = selUnit:GetPlot()
	local playerID = selUnit:GetOwner()
	local player = Players[playerID]
	local pPlayer = player;
	local pTeam = player:GetTeam();
	if selUnit:GetMoves() > 0 then
		if (load(pPlayer, "POVERTY_ERA_CHECK") ~= true) then
			if (plot:GetOwner() == playerID) then

				local EnableButton = 0
				if not plot:IsCity() and not plot:IsWater() and not plot:IsMountain() and not plot:IsImpassable() and not plot:IsHills() and (plot:GetFeatureType() ~= fOasis) then
					EnableButton = 1;
				end
				if (plot:GetImprovementType() == iMound) then
					EnableButton = 0;
				end
				if (plot:GetFeatureType() == fForest) and not (Teams[pTeam]:IsHasTech(tForest)) then
					EnableButton = 0;
				end
				if (plot:GetFeatureType() == fJungle) and not (Teams[pTeam]:IsHasTech(tJungle)) then
					EnableButton = 0;
				end
				if (plot:GetFeatureType() == fMarsh) and not (Teams[pTeam]:IsHasTech(tMarsh)) then
					EnableButton = 0;
				end
				if (selUnit:GetReligion() ~= -1) and (selUnit:GetUnitClassType() == ucProphet) and (selUnit:GetSpreadsLeft() < 4) then
					EnableButton = 0;
				end

				if EnableButton >= 1 then

					Controls.PovertyButton:SetDisabled(true)
					save(pPlayer, "POVERTY_ERA_CHECK", true)
					Events.AudioPlay2DSound("AS2D_SOUND_POVERTY_MOD_BUILD")

					PovertyClearActive(pPlayer)
					PovertyClearPromotions(pPlayer)
					PovertyClearBonuses(pPlayer)

---------------------------
---------------------------
---------------------------

					LuaEvents.Tomatekh_ShowSpiritGuardiansPopup()	
					--PovertySaveEver(pPlayer)
					--PovertyAwardPromotions(pPlayer)
					--PovertyAwardBonuses(pPlayer)

---------------------------
---------------------------
---------------------------

					if (plot:GetImprovementType() ~= -1) then
						plot:SetImprovementType(-1);
					end		
					plot:SetImprovementType(iMound);
	
					if (plot:GetFeatureType() == fForest) then

						local Prod1 = 0;
						local Prod2 = 0;
						local Prod3 = 0;
						local Prod4 = 0;

						if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
							Prod1 = 13;
							Prod2 = 10;
							Prod3 = 6;
							Prod4 = 3;
						elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
							Prod1 = 20;
							Prod2 = 15;
							Prod3 = 10;
							Prod4 = 5;
						elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
							Prod1 = 30;
							Prod2 = 22;
							Prod3 = 15;
							Prod4 = 7;
						elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
							Prod1 = 60;
							Prod2 = 45;
							Prod3 = 30;
							Prod4 = 15;
						else
							Prod1 = 60;
							Prod2 = 45;
							Prod3 = 30;
							Prod4 = 15;
						end

						local pNearestCity = nil;
						local iNearestDistance = 1000000;

						for cityIndex = 0, pPlayer:GetNumCities() - 1, 1 do
							local pCity = pPlayer:GetCityByID(cityIndex);
							if (pCity ~= nil) then
								iDistance = Map.PlotDistance(plot:GetX(), plot:GetY(), pCity:GetX(), pCity:GetY());
								if (iDistance < iNearestDistance) then
									iNearestDistance = iDistance;
									pNearestCity = pCity;
								end
							end
						end

						if (pNearestCity ~= nil) then
							local ProdText = 0;
							local iDistance = Map.PlotDistance(plot:GetX(), plot:GetY(), pNearestCity:GetX(), pNearestCity:GetY());
							if (iDistance == 1) or (iDistance == 2) then
								pNearestCity:ChangeProduction(Prod1);
								ProdText = Prod1;
							elseif iDistance == 3 then
								pNearestCity:ChangeProduction(Prod2);
								ProdText = Prod2;
							elseif iDistance == 4 then
								pNearestCity:ChangeProduction(Prod3);
								ProdText = Prod3;
							elseif iDistance == 5 then
								pNearestCity:ChangeProduction(Prod4);
								ProdText = Prod4;
							end
							if ProdText ~= 0 then
								if (pPlayer:IsHuman()) and (playerID == Game.GetActivePlayer()) then	
									Events.GameplayAlertMessage("Clearing a Forest has created " .. ProdText .. " [ICON_PRODUCTION] for " .. Locale.ConvertTextKey(pNearestCity:GetName()) .. ".");	
								end
							end

						end
					end

					if (plot:GetFeatureType() == fForest) or (plot:GetFeatureType() == fJungle) or (plot:GetFeatureType() == fMarsh) then
						plot:SetFeatureType(-1);
					end
								
					selUnit:Kill();

				end
			end
		end
	end
end

local ucDoctor = GameInfoTypes.UNITCLASS_GREAT_GENERAL;
local ucMagistrate = GameInfoTypes.UNITCLASS_GREAT_GENERAL;
local ucDignitary = GameInfoTypes.UNITCLASS_GREAT_GENERAL;
local ucEntertainer = GameInfoTypes.UNITCLASS_GREAT_GENERAL;
local ucGSpy = GameInfoTypes.UNITCLASS_GREAT_GENERAL;

local isDoctor = (GameInfoTypes.UNIT_JFD_GREAT_DOCTOR ~= nil);
local isCities = (GameInfoTypes.UNIT_JFD_GREAT_MAGISTRATE ~= nil);
local isEntertainer = (GameInfoTypes.UNIT_ENTERTAINER ~= nil);
local isGSpy = (GameInfoTypes.UNIT_TOMATEKH_SPY ~= nil);

if isDoctor then
	ucDoctor = GameInfoTypes.UNITCLASS_JFD_GREAT_DOCTOR;
end

if isCities then
	ucMagistrate = GameInfoTypes.UNITCLASS_JFD_GREAT_MAGISTRATE;
	ucDignitary = GameInfoTypes.UNITCLASS_JFD_GREAT_DIGNITARY;
end

if isEntertainer then
	ucEntertainer = GameInfoTypes.UNITCLASS_ENTERTAINER;
end

if isGSpy then
	ucGSpy = GameInfoTypes.UNITCLASS_TOMATEKH_SPY;
end

Controls.PovertyButton:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "POVERTY_POINT_ACTION_ATLAS", Controls.PovertyImage )
Controls.PovertyBackground:SetHide(true)

function Selection(player, unitID, x, y, a5, bool)
	if bool then
		local cUnit = Players[player]:GetUnitByID(unitID);
		local plot = cUnit:GetPlot()

		if Players[player]:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"] then
			if (cUnit:GetUnitClassType() == ucArtist) or (cUnit:GetUnitClassType() == ucWriter) or (cUnit:GetUnitClassType() == ucMusician) or (cUnit:GetUnitClassType() == ucScientist) or (cUnit:GetUnitClassType() == ucMerchant) or (cUnit:GetUnitClassType() == ucEngineer) or (cUnit:GetUnitClassType() == ucGreatGeneral) or (cUnit:GetUnitClassType() == ucProphet) or (cUnit:GetUnitClassType() == ucAdmiral) or (cUnit:GetUnitClassType() == ucDoctor) or (cUnit:GetUnitClassType() == ucMagistrate) or (cUnit:GetUnitClassType() == ucDignitary) or (cUnit:GetUnitClassType() == ucEntertainer) or (cUnit:GetUnitClassType() == ucGSpy) then
				if not cUnit:IsHasPromotion(pBlessingNull) then			
					Controls.PovertyBackground:SetHide(false)
					selUnit = cUnit;
					Controls.PovertyButton:SetDisabled(false)
					local pPlayer = Players[player];
					local pTeam = pPlayer:GetTeam();
					local PovertyToolTip = 0;
					if (Teams[pTeam]:IsHasTech(tTheology)) then
						PovertyToolTip = Locale.ConvertTextKey("TXT_KEY_POVERTY_MOUND_TAG_2")
					elseif not (Teams[pTeam]:IsHasTech(tTheology)) then
						PovertyToolTip = Locale.ConvertTextKey("TXT_KEY_POVERTY_MOUND_TAG_1")
					end
					Controls.PovertyButton:LocalizeAndSetToolTip("" .. PovertyToolTip .. "")
				end
			end
		end

	else
		Controls.PovertyBackground:SetHide(true)
		selUnit = nil;
	end
end
Events.UnitSelectionChanged.Add(Selection);

--UI Era
function PovertyUIReset(iTeam, iEra)
	for pPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local pPlayer = Players[pPlayer];
		local pTeam = pPlayer:GetTeam();
		if pTeam == iTeam then
			save(pPlayer, "POVERTY_ERA_CHECK", false)
		end
	end
end
GameEvents.TeamSetEra.Add(PovertyUIReset)

--Poverty Turn Bonus
function PovertyTurnBonus(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
			--Bonus 1
			if pPlayer:HasPolicy(pCount1) then
				local pTeam = pPlayer:GetTeam();
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
				local pTeam = pPlayer:GetTeam();
				local pcCity = pPlayer:GetCapitalCity();
				local iCurrentTurn = Game.GetGameTurn();
				local AwardTurn = 1;
				if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
					AwardTurn = 12;
				elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
					AwardTurn = 15;
				elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
					AwardTurn = 18;
				elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
					AwardTurn = 30;
				else
					AwardTurn = 30;
				end
				if ( iCurrentTurn % AwardTurn ) == 0 then
					for _, iUnit in pairs(LandInfantry) do
						if pcCity:CanTrain(iUnit) then
						
							local pcXP = 0;
							if pcCity:IsHasBuilding(bBarracks) then
								pcXP = pcXP + 15;
							end
							if pcCity:IsHasBuilding(bArmory) then
								pcXP = pcXP + 15;
							end
							if pcCity:IsHasBuilding(bMilAcademy) then
								pcXP = pcXP + 15;
							end
							
							pUnit = pPlayer:InitUnit(iUnit, pcCity:GetX(), pcCity:GetY())	
												
							local BaseXP = pUnit:GetExperience()
							local BuildingXP = BaseXP + pcXP;
							pUnit:SetExperience(BuildingXP);

							pUnit:JumpToNearestValidPlot();								
							break;
						end
					end
				end
			--Bonus 4
			--Bonus 5
			elseif pPlayer:HasPolicy(pCount5) then
				PovertyTurtleTradeClean(pPlayer)
				PovertyTurtleTrade(pPlayer)
			--Bonus 7
			elseif pPlayer:HasPolicy(pCount7) then
				for pCity in pPlayer:Cities() do
					local Scientist = ((pCity:GetSpecialistCount(sScientist)) * 100);
					local Merchant = ((pCity:GetSpecialistCount(sMerchant)) * 100);
					local Engineer = ((pCity:GetSpecialistCount(sEngineer)) * 100);				
					pCity:ChangeSpecialistGreatPersonProgressTimes100(sScientist, Scientist);
					pCity:ChangeSpecialistGreatPersonProgressTimes100(sMerchant, Merchant);
					pCity:ChangeSpecialistGreatPersonProgressTimes100(sEngineer, Engineer);
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
			end
		end
	end
end

---
---
---
function PovertyOldManWork(iPlayer)
	local pPlayer = Players[iPlayer];
	local pTeam = pPlayer:GetTeam();
	if (pPlayer:IsAlive()) then
		if pPlayer:HasPolicy(pCount8) then
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(pBlessing8) then
					local WorkBonus = 100;
					if pPlayer:GetBuildingClassCount(Pyramids) >= 1 then
						--WorkBonus = 125;
						WorkBonus = 100;
					end
					local uPlot = pUnit:GetPlot();
					local plotX = pUnit:GetX();
					local plotY = pUnit:GetY();
					local iRange = 2;
					for iDX = -iRange, iRange do
						for iDY = -iRange, iRange do
							local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
							if pTargetPlot then			
								local pPlot = pTargetPlot;
								if pPlot:GetOwner() == iPlayer then 
									for pBuildInfo in GameInfo.Builds() do
										local BuildTurns = pPlot:GetBuildTurnsLeft(pBuildInfo.ID, 0, 0);
										local BuildProgress = pPlot:GetBuildProgress(pBuildInfo.ID)
										if (BuildTurns >= 2) and (BuildProgress > WorkBonus) then
											local BlessedWorkerCheck = 0;					
											for iVal = 0,(pPlot:GetNumUnits() - 1) do
												local sUnit = pPlot:GetUnit(iVal)
												if (sUnit:GetUnitType() == uWorker) then
													BlessedWorkerCheck = 1;
													break	
												end		
											end								
											local BlessedCheck = 0;
											for sKey, tTable in pairs(PovertyTempPlots) do
												local vPlot = pDecompilePlotID(sKey)
												if pPlot == vPlot then
													BlessedCheck = 1;
													break
												end
											end
											if BlessedCheck <= 0 then
												if BlessedWorkerCheck >= 1 then
													pPlot:ChangeBuildProgress(pBuildInfo.ID, WorkBonus, pTeam)
													local sKey = pCompilePlotID(pPlot)
													PovertyTempPlots[sKey] = -1
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
---

function PovertyPlotClean(iPlayer)
	local isPoverty = 0;
	for i, player in pairs(Players) do
		if player:IsEverAlive() then
			if player:GetCivilizationType() == PovertyID then
				isPoverty = 1;
				break;
			end
		end
	end
	if isPoverty == 1 then
		local pPlayer = Players[iPlayer];
		local pTeam = pPlayer:GetTeam();
		if (pPlayer:IsAlive()) then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then
				for pCity in pPlayer:Cities() do
					local iName = Locale.ConvertTextKey(pCity:GetName());			
					save(pPlayer, "" .. iName .. " bool", false)
				end
				for sKey, tTable in pairs(PovertyTempPlots) do
					PovertyTempPlots[sKey] = nil
				end
			end
		end
	elseif isPoverty ~= 1 then
		if iPlayer == 63 then
			for sKey, tTable in pairs(PovertyTempPlots) do
				PovertyTempPlots[sKey] = nil
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(PovertyTurnBonus)
GameEvents.PlayerDoTurn.Add(PovertyOldManWork)
GameEvents.PlayerDoTurn.Add(PovertyRiverTrade)
GameEvents.PlayerDoTurn.Add(PovertyPlotClean)

--Old Man Bonus
function PovertyOldManBonusOther(playerID)
	local pPlayer = Players[playerID];
	if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
		if pPlayer:HasPolicy(pCount1) then		
			--if pPlayer:IsHuman() then
				local eIndustrial = GameInfoTypes.ERA_INDUSTRIAL;
				local pTeam = pPlayer:GetTeam();
				local pFaith = pPlayer:GetFaith();
				local pcCity = pPlayer:GetCapitalCity();
				local ProphetFaith = pPlayer:GetMinimumFaithNextGreatProphet();
				local ProphetDiff = math.ceil(ProphetFaith / 10);
				local ProphetMin = (ProphetFaith - ProphetDiff);
				--
				--
				if (Game.GetNumReligionsStillToFound() >= 1) or pPlayer:HasCreatedReligion() then
					if (pPlayer:HasCreatedPantheon()) and (Teams[pTeam]:GetCurrentEra() < eIndustrial) then
						if (pFaith >= ProphetMin) and (pFaith < ProphetFaith) then
							local tRandom = bGetRandom(1, 3)
							if tRandom == 1 then		
								pcCity:SetNumRealBuilding(bFakeHaggia, 1);	
								pcCity:SetNumRealBuilding(bFakeHaggia, 0);		
								pPlayer:SetFaith(0);
							end
						end
					end
				end			
				--
				--
				if (Game.GetNumReligionsStillToFound() <= 0) then
					local religionID = pPlayer:GetReligionCreatedByPlayer()
					if religionID <= 0 then 
						local tRandom = bGetRandom(1, 2)
						if tRandom == 1 then																		
							local iMod = ((GameInfo.GameSpeeds[Game.GetGameSpeedType()].BuildPercent)/100);
							local title = "Great Person born";
							local descr = "A Great Person has been born in your civilization!";					
							local PPUUID = GameInfo.Units["UNIT_POVERTY_POINT_MOD"].ID;

							--
							--

							local pcoCity = GetPlayersOriginalCity(pPlayer);
							local ProThreshold = GetProphetThreshold(pPlayer);
							if pFaith >= ProThreshold then
								pUnit = pPlayer:InitUnit(PPUUID, pcCity:GetX(), pcCity:GetY(), UNITAI_PROPHET);
								pUnit:JumpToNearestValidPlot()
								local TotalProCount = pcoCity:GetNumBuilding(bProCountMAX);
								pcoCity:SetNumRealBuilding(bProCountMAX, 0);
								pcoCity:SetNumRealBuilding(bProCountMAX, (TotalProCount + 1));
								if (Teams[pTeam]:GetCurrentEra() < eIndustrial) then
									pPlayer:ChangeFaith(-pFaith);
								else
									pPlayer:ChangeFaith(-ProThreshold);
								end
								pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, descr, title, pcCity:GetX(), pcCity:GetY(), PPUUID, -1);
							end

							--
							--

						end
					end												
				end
			--end
		end
	end
end

--GameEvents.CityTrained.Add(PovertyOldManBonus)
GameEvents.PlayerDoTurn.Add(PovertyOldManBonusOther)

function PovertyWomanBonus(iX, iY, iOldPop, iNewPop)
	local pPlot = Map.GetPlot(iX, iY);
	local pCity = pPlot:GetPlotCity();
	local pPlayer = Players[pCity:GetOwner()];
	if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
		if pPlayer:HasPolicy(pCount2) then
			local iName = Locale.ConvertTextKey(pCity:GetName());
			if load(pPlayer, "" .. iName .. " bool") ~= true then
				if iNewPop > iOldPop then	
					if iNewPop < 6 then
						save(pPlayer, "" .. iName .. " bool", true)
						pCity:ChangePopulation(1, true);		
					end		
				end
			end
		end
	end
end

GameEvents.SetPopulation.Add(PovertyWomanBonus)

local Lang = Locale.GetCurrentLanguage().Type;

for pPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
	local pPlayer = Players[pPlayer];
	if pPlayer:IsEverAlive() then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then			
			local AwardTurn = 1;
			if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
				AwardTurn = 12;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
				AwardTurn = 15;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
				AwardTurn = 18;
			elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
				AwardTurn = 30;
			else
				AwardTurn = 30;
			end
			local NameAccent = Locale.ConvertTextKey("TXT_KEY_PP_UNIT_MOD")

			if Lang == "en_US" then
				local tquery = {"UPDATE Language_en_US SET Text = 'Receive an infantry Unit near your [ICON_CAPITAL] Capital every ".. AwardTurn .." turns. Peace with Barbarians.[NEWLINE][NEWLINE]Fox-Men improve the combat effectiveness of nearby land Units (this effect will stack with the Great General''s [COLOR_PLAYER_LIGHT_GREEN]Leadership[ENDCOLOR] bonus).' WHERE Tag = 'TXT_KEY_POVERTY_BONUS_BODY_3'"}
				for i,iQuery in pairs(tquery) do
					for result in DB.Query(iQuery) do
					end
				end
				Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
				local tquery = {"UPDATE Language_en_US SET Text = '[COLOR_POSITIVE_TEXT]Red Fox[ENDCOLOR][NEWLINE]Receive an infantry Unit near your [ICON_CAPITAL] Capital every ".. AwardTurn .." turns. Peace with Barbarians.[NEWLINE][NEWLINE]Fox-Men improve the combat effectiveness of nearby land Units (this effect will stack with the Great General''s [COLOR_PLAYER_LIGHT_GREEN]Leadership[ENDCOLOR] bonus).' WHERE Tag = 'TXT_KEY_POVERTY_BONUS_TOOLTIP_3'"}
				for i,iQuery in pairs(tquery) do
					for result in DB.Query(iQuery) do
					end
				end
				Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
			end
		end
	end
end

function CheckTamali(pPlayer)
	local TamaliCheck = 0;
	for pUnit in pPlayer:Units() do
		if pUnit:GetUnitClassType() == ucProphet then
			TamaliCheck = 1;
			break;
		end
	end
	return TamaliCheck;
end

function PovertyLongTail(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
		if pPlayer:HasPolicy(pCount4) then
			local TamaliCheck = CheckTamali(pPlayer)
			if TamaliCheck == 1 then
				for pUnit in pPlayer:Units() do
					local Patronage = 0;
					if (pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND) and pUnit:IsCombatUnit() and not pUnit:IsEmbarked() then 
						for sUnit in pPlayer:Units() do
							if sUnit:IsHasPromotion(pTamali) then
								if Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), sUnit:GetX(), sUnit:GetY()) < 3 then
									Patronage = 1;
								end
							end
						end			
						if Patronage == 1 then
							if not pUnit:IsHasPromotion(pTamaliBonus) then
								pUnit:SetHasPromotion(pTamaliBonus, true)
							end
						else
							if pUnit:IsHasPromotion(pTamaliBonus) then
								pUnit:SetHasPromotion(pTamaliBonus, false)
							end
						end		
					else
						if pUnit:IsHasPromotion(pTamaliBonus) then
							pUnit:SetHasPromotion(pTamaliBonus, false)
						end
					end
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(PovertyLongTail) 
GameEvents.PlayerDoTurn.Add(PovertyLongTail)

local AllTechs2 = {}

for tRow in GameInfo.Technologies() do
	AllTechs2[GameInfoTypes[tRow.Type]] = {}
end

for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
	local pPlayer = Players[iPlayer];
	if pPlayer:IsEverAlive() then
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then
			if not pPlayer:IsMinorCiv() then
				local pTeam = pPlayer:GetTeam();
				if (pTeam ~= bTeam) then
					local oTeam = GetPovertyTeam();
					local oPlayer = GetPovertyPlayer();
					if oPlayer ~= 0 then
						if (pTeam ~= oTeam) then
							for iTech, tTable in pairs(AllTechs2) do
								if (Teams[pTeam]:IsHasTech(iTech)) then
									if (load(oPlayer, "PovertyTechs" .. iTech .. "bool 2") ~= true) then
										save(oPlayer, "PovertyTechs" .. iTech .. "bool 2", true);
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

GameEvents.TeamSetHasTech.Add(
function(iTeam, iTech, bAdopted) 
	if (iTeam ~= bTeam) then
		if not Teams[iTeam]:IsMinorCiv() then
			local oTeam = GetPovertyTeam();
			local oPlayer = GetPovertyPlayer();
			if oPlayer ~= 0 then
				if (iTeam ~= oTeam) then
					if (load(oPlayer, "PovertyTechs" .. iTech .. "bool 2") ~= true) then
						save(oPlayer, "PovertyTechs" .. iTech .. "bool 2", true)
					end
				end
			end
		end
	end
end)

function LongTailBarb(popupInfo)
	if popupInfo.Type ~= ButtonPopupTypes.BUTTONPOPUP_BARBARIAN_CAMP_REWARD then return end
	local pPlayer = Players[Game.GetActivePlayer()];
	if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
		if pPlayer:HasPolicy(pCount4) then
			local oTeam = GetPovertyTeam();
			local oPlayer = GetPovertyPlayer();
			local iNum = 0;
			for iTech, tTable in pairs(AllTechs2) do
				if (load(oPlayer, "PovertyTechs" .. iTech .. "bool 2") == true) then
					if not (Teams[oTeam]:IsHasTech(iTech)) then
						iNum = iNum + 1;
					end
				end
			end
			if iNum >= 1 then
				local iCount = 0
				for iTech, tTable in pairs(AllTechs2) do
					if (load(oPlayer, "PovertyTechs" .. iTech .. "bool 2") == true) then
						if not (Teams[oTeam]:IsHasTech(iTech)) then
							if (load(oPlayer, "Save" .. iTech .. "bool 3") ~= true) then
								local iCost = math.floor(oPlayer:GetResearchCost(iTech) / 5);
								local pTeamTechs = Teams[oTeam]:GetTeamTechs();
								pTeamTechs:ChangeResearchProgress(iTech, iCost, oPlayer:GetID());
								save(oPlayer, "Save" .. iTech .. "bool 3", true)
								local iName = GameInfo.Technologies[iTech].Description;
								local TechName = Locale.ConvertTextKey("".. iName .."");
								if oPlayer:IsHuman() then
									Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Long Tail teaches his children, providing " .. iCost .. " [ICON_RESEARCH] Science toward " .. TechName .. "![ENDCOLOR]")
								end
								iCount = iCount + 1;
								break;
							end
						end
					end
				end

				--if iCount <= 0 then 
				--	for iTech, tTable in pairs(AllTechs2) do
				--		if (load(oPlayer, "PovertyTechs" .. iTech .. "bool 2") == true) then
				--			if not (Teams[oTeam]:IsHasTech(iTech)) then								
				--				local iCost = math.floor(oPlayer:GetResearchCost(iTech) / 5);
				--				local pTeamTechs = Teams[oTeam]:GetTeamTechs();
				--				pTeamTechs:ChangeResearchProgress(iTech, iCost, oPlayer:GetID());
				--				save(oPlayer, "Save" .. iTech .. "bool 3", true)
				--				local iName = GameInfo.Technologies[iTech].Description;
				--				local TechName = Locale.ConvertTextKey("".. iName .."");
				--				if oPlayer:IsHuman() then
				--					Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Long Tail teaches his children, providing " .. iCost .. " [ICON_RESEARCH] Science toward " .. TechName .. "![ENDCOLOR]")
				--				end	
				--				break;
				--			end
				--		end
				--	end
				--end

			end
		end
	end
end

Events.SerialEventGameMessagePopup.Add(LongTailBarb)

function PovertyLongTailUnit(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
		if pPlayer:HasPolicy(pCount8) then
       	    if pPlayer:GetUnitByID(iUnit) ~= nil then

				pUnit = pPlayer:GetUnitByID(iUnit);
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
        end
    end
end

Events.SerialEventUnitCreated.Add(PovertyLongTailUnit)

function ReturnPovertyUnit(pUnit, iPlayer)
	local pNearestCity = nil;
	local iNearestDistance = 1000000;
	local pPlayer = Players[pUnit:GetOwner()];
	for cityIndex = 0, pPlayer:GetNumCities() - 1, 1 do
		local pCity = pPlayer:GetCityByID(cityIndex);
		if (pCity ~= nil) then
			local iDistance = Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), pCity:GetX(), pCity:GetY());
			if (iDistance < iNearestDistance) then
				iNearestDistance = iDistance;
				pNearestCity = pCity;
			end
		end
	end
	if (pNearestCity ~= nil) then
		pUnit:SetXY(pNearestCity:GetX(), pNearestCity:GetY());
		if (pPlayer:IsHuman()) and (iPlayer == Game.GetActivePlayer()) then
			local CivType = "Settler";
			if (pUnit:GetUnitType() == uWorker) then
				CivType = "Worker";
			elseif (pUnit:GetUnitType() == uMissionary) then
				CivType = "Missionary";
			elseif (pUnit:GetUnitType() == uInquisitor) then
				CivType = "Inquisitor";
			elseif (pUnit:GetUnitType() == uArchaeologist) then
				CivType = "Archaeologist";		
			end
			Events.GameplayAlertMessage("Your " .. CivType .. " has escaped to the city of " .. Locale.ConvertTextKey(pNearestCity:GetName()) .. "!");
		end
		return true;
	end
	return false;
end

function SavePovertyUnit(iPlayer, iUnitID) 
	local pPlayer = Players[iPlayer];
	local pUnit = pPlayer:GetUnitByID(iUnitID);
	if (pUnit == nil) then
	    return false;
	end
	if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
		if pPlayer:HasPolicy(pCount8) then
			if (pUnit:GetUnitType() == uSettler) or (pUnit:GetUnitType() == uWorker) or (pUnit:GetUnitType() == uMissionary) or (pUnit:GetUnitType() == uInquisitor) or (pUnit:GetUnitType() == uArchaeologist) then
				ReturnPovertyUnit(pUnit, iPlayer);
				return true;
			end
		end
	end
	return false;
end
GameEvents.CanDisplaceCivilian.Add(SavePovertyUnit);

GameEvents.UnitSetXY.Add( 
function(iPlayerID, iUnitID, iX, iY)
	local pPlot = Map.GetPlot(iX, iY)
	local pPlayer = Players[iPlayerID]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
	if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
		if pPlayer:HasPolicy(pCount6) then
			if pPlot then
				if (pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND) and pUnit:IsCombatUnit() then 
					if pPlot:IsRiver() or pPlot:IsCoastalLand() then
						if pUnit:IsHasPromotion(pDuckStop) then
							pUnit:SetHasPromotion(pDuckStop, false)
							pUnit:SetHasPromotion(pDuckGo, true)		
						end
						if not pUnit:IsHasPromotion(pDuckGo) then
							pUnit:SetHasPromotion(pDuckGo, true)
						end
						if (pUnit:GetUnitType() == uChariot) or (pUnit:GetUnitType() == uWarChariot) then
							if pUnit:IsHasPromotion(pNoMovement) then
								pUnit:SetHasPromotion(pNoMovement, false)
							end
						end						
					elseif not pPlot:IsRiver() or pPlot:IsCoastalLand() then
						if pUnit:IsHasPromotion(pDuckGo) then
							pUnit:SetHasPromotion(pDuckGo, false)
							pUnit:SetHasPromotion(pDuckStop, true)
							if pPlot:IsRoughGround() and not pPlot:IsRoute() then
								if not pUnit:IsHasPromotion(pWood) then
									pUnit:ChangeMoves(-60)
								elseif pUnit:IsHasPromotion(pWood) then
									if (pPlot:GetFeatureType() ~= fForest) and (pPlot:GetFeatureType() ~= fJungle) then
										pUnit:ChangeMoves(-60)
									end
								end
							end
						end
						if not pUnit:IsHasPromotion(pDuckStop) then
							pUnit:SetHasPromotion(pDuckStop, true)
						end
						if (pUnit:GetUnitType() == uChariot) or (pUnit:GetUnitType() == uWarChariot) then
							if not pUnit:IsHasPromotion(pNoMovement) then
								pUnit:SetHasPromotion(pNoMovement, true)
								if pPlot:IsRoughGround() and not pPlot:IsRoute() then
									local MovesLeft = pUnit:GetMoves();
									pUnit:ChangeMoves(-MovesLeft)
								end
							end
						end
					end
				end
			end
		end
	end
end)

function PovertyFakeAdmiral(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
		if pPlayer:HasPolicy(pCount6) then
			local TamaliCheck = CheckTamali(pPlayer)
			if TamaliCheck == 1 then
				for pUnit in pPlayer:Units() do
					local Patronage = 0;
					if (pUnit:GetDomainType() == DomainTypes.DOMAIN_SEA) and pUnit:IsCombatUnit() then 
						for sUnit in pPlayer:Units() do
							if sUnit:IsHasPromotion(pBlessing6a) or sUnit:IsHasPromotion(pBlessing6b) or sUnit:IsHasPromotion(pBlessing6c) then
								if Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), sUnit:GetX(), sUnit:GetY()) < 3 then
									Patronage = 1;
								end
							end
						end			
						if Patronage == 1 then
							if not pUnit:IsHasPromotion(pFakeAdmiral) then
								pUnit:SetHasPromotion(pFakeAdmiral, true)
							end
						else
							if pUnit:IsHasPromotion(pFakeAdmiral) then
								pUnit:SetHasPromotion(pFakeAdmiral, false)
							end
						end		
					else
						if pUnit:IsHasPromotion(pFakeAdmiral) then
							pUnit:SetHasPromotion(pFakeAdmiral, false)
						end
					end
				end
			end
		end
		if pPlayer:HasPolicy(pCount3) then
			local TamaliCheck = CheckTamali(pPlayer)
			if TamaliCheck == 1 then
				for pUnit in pPlayer:Units() do
					local Patronage = 0;
					if (pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND) and pUnit:IsCombatUnit() then 
						for sUnit in pPlayer:Units() do
							if sUnit:IsHasPromotion(pBlessing3) then
								if Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), sUnit:GetX(), sUnit:GetY()) < 3 then
									Patronage = 1;
								end
							end
						end			
						if Patronage == 1 then
							if not pUnit:IsHasPromotion(pFakeGeneral) then
								pUnit:SetHasPromotion(pFakeGeneral, true)
							end
						else
							if pUnit:IsHasPromotion(pFakeGeneral) then
								pUnit:SetHasPromotion(pFakeGeneral, false)
							end
						end		
					else
						if pUnit:IsHasPromotion(pFakeGeneral) then
							pUnit:SetHasPromotion(pFakeGeneral, false)
						end
					end
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(PovertyFakeAdmiral) 
GameEvents.PlayerDoTurn.Add(PovertyFakeAdmiral)

--Prophet Backup
function PovertyReplaceDummyGP2(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then
		for pUnit in pPlayer:Units() do
			if (pUnit:GetUnitType() == iProphet2) then
				if not pUnit:IsHasPromotion(pPRival) then
					local newUnit = pPlayer:InitUnit(Prophet, pUnit:GetX(), pUnit:GetY())
					newUnit:Convert(pUnit);
					if not newUnit:IsHasPromotion(pPRival) then
						newUnit:SetHasPromotion(pPRival, true)		
					end
					if not newUnit:IsHasPromotion(pBlessing) then
						newUnit:SetHasPromotion(pBlessing, true)		
					end
					PovertyAwardPromotions(pPlayer)
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(PovertyReplaceDummyGP2)

--AI
function GetAIHighestPop(pPlayer)
	local AIHighPop = nil;
	local BasePop = 0;
	for cityIndex = 0, pPlayer:GetNumCities() - 1, 1 do
		local pCity = pPlayer:GetCityByID(cityIndex);
		if (pCity ~= nil) then
			local CityPop = pCity:GetPopulation();
			if (CityPop > BasePop) then
				BasePop = CityPop;
				AIHighPop = pCity;
			end
		end
	end
	return AIHighPop;
end

function PlaceAIMound(pPlayer)
	local AIMoundCheck = 0;
	local AIHighPop = GetAIHighestPop(pPlayer)
	if (AIHighPop ~= nil) then
		local pPlot = AIHighPop:Plot();
		local plotX = pPlot:GetX();
		local plotY = pPlot:GetY();
		local iRange = 3;
		for iDX = -iRange, iRange do
			for iDY = -iRange, iRange do
				local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
				if pTargetPlot then					
					if not pTargetPlot:IsCity() and not pTargetPlot:IsWater() and not pTargetPlot:IsMountain() and not pTargetPlot:IsImpassable() and not pTargetPlot:IsHills() then
						local pID = pPlayer:GetID()
						if (pTargetPlot:GetOwner() == pID) then
							if AIMoundCheck < 1 then
								if (pTargetPlot:GetResourceType() == -1) and (pTargetPlot:GetImprovementType() == -1) then
									pTargetPlot:SetImprovementType(iMound);
									if (pTargetPlot:GetFeatureType() == fForest) or (pTargetPlot:GetFeatureType() == fJungle) or (pTargetPlot:GetFeatureType() == fMarsh) then
										pTargetPlot:SetFeatureType(-1);
									end
									AIMoundCheck = 1;
									break;
								end
							end
						end
					end
				end
			end
		end
		if AIMoundCheck < 1 then
			for pCity in pPlayer:Cities() do
				local pPlot = pCity:Plot();
				local plotX = pPlot:GetX();
				local plotY = pPlot:GetY();
				local iRange = 3;
				for iDX = -iRange, iRange do
					for iDY = -iRange, iRange do
						local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
						if pTargetPlot then					
							if not pTargetPlot:IsCity() and not pTargetPlot:IsWater() and not pTargetPlot:IsMountain() and not pTargetPlot:IsImpassable() and not pTargetPlot:IsHills() then
								local pID = pPlayer:GetID()
								if (pTargetPlot:GetOwner() == pID) then
									if AIMoundCheck < 1 then
										if (pTargetPlot:GetResourceType() == -1) and (pTargetPlot:GetImprovementType() == -1) then
											pTargetPlot:SetImprovementType(iMound);
											if (pTargetPlot:GetFeatureType() == fForest) or (pTargetPlot:GetFeatureType() == fJungle) or (pTargetPlot:GetFeatureType() == fMarsh) then
												pTargetPlot:SetFeatureType(-1);
											end
											AIMoundCheck = 1;
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
		if AIMoundCheck < 1 then
			for pCity in pPlayer:Cities() do
				local MoundPlot = 0;
				local pPlot = pCity:Plot();
				local plotX = pPlot:GetX();
				local plotY = pPlot:GetY();
				local iRange = 3;
				for iDX = -iRange, iRange do
					for iDY = -iRange, iRange do
						local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
						if pTargetPlot then	
							if (pTargetPlot:GetImprovementType() == iMound) then
								MoundPlot = 1;
							end
						end
					end
				end
				if MoundPlot < 1 then								
					for iDX = -iRange, iRange do
						for iDY = -iRange, iRange do
							local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
							if pTargetPlot then					
								if not pTargetPlot:IsCity() and not pTargetPlot:IsWater() and not pTargetPlot:IsMountain() and not pTargetPlot:IsImpassable() and not pTargetPlot:IsHills() then
									local pID = pPlayer:GetID()
									if (pTargetPlot:GetOwner() == pID) then
										if AIMoundCheck < 1 then
											if (pTargetPlot:GetResourceType() == -1) and (pTargetPlot:GetImprovementType() ~= iMound) then
												if (pTargetPlot:GetImprovementType() >= 1) then
													pTargetPlot:SetImprovementType(-1);
												end
												pTargetPlot:SetImprovementType(iMound);
												if (pTargetPlot:GetFeatureType() == fForest) or (pTargetPlot:GetFeatureType() == fJungle) or (pTargetPlot:GetFeatureType() == fMarsh) then
													pTargetPlot:SetFeatureType(-1);
												end
												AIMoundCheck = 1;
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
		end
		if AIMoundCheck < 1 then
			for pCity in pPlayer:Cities() do
				local pPlot = pCity:Plot();
				local plotX = pPlot:GetX();
				local plotY = pPlot:GetY();
				local iRange = 3;
				for iDX = -iRange, iRange do
					for iDY = -iRange, iRange do
						local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
						if pTargetPlot then					
							if not pTargetPlot:IsCity() and not pTargetPlot:IsWater() and not pTargetPlot:IsMountain() and not pTargetPlot:IsImpassable() and not pTargetPlot:IsHills() then
								local pID = pPlayer:GetID()
								if (pTargetPlot:GetOwner() == pID) then
									if AIMoundCheck < 1 then
										if (pTargetPlot:GetResourceType() == -1) and (pTargetPlot:GetImprovementType() ~= iMound) then
											if (pTargetPlot:GetImprovementType() >= 1) then
												pTargetPlot:SetImprovementType(-1);
											end
											pTargetPlot:SetImprovementType(iMound);
											if (pTargetPlot:GetFeatureType() == fForest) or (pTargetPlot:GetFeatureType() == fJungle) or (pTargetPlot:GetFeatureType() == fMarsh) then
												pTargetPlot:SetFeatureType(-1);
											end
											AIMoundCheck = 1;
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
	end
	return AIMoundCheck;
end

function KillAIPerson(pPlayer)
	for pUnit in pPlayer:Units() do
		if (pUnit:GetUnitClassType() == ucArtist) or (pUnit:GetUnitClassType() == ucWriter) or (pUnit:GetUnitClassType() == ucMusician) or (pUnit:GetUnitClassType() == ucScientist) or (pUnit:GetUnitClassType() == ucMerchant) or (pUnit:GetUnitClassType() == ucEngineer) or (pUnit:GetUnitClassType() == ucGreatGeneral) or (pUnit:GetUnitClassType() == ucAdmiral) or (pUnit:GetUnitClassType() == ucDoctor) or (pUnit:GetUnitClassType() == ucMagistrate) or (pUnit:GetUnitClassType() == ucDignitary) then
			pUnit:Kill();
			break;
		end
	end
end

GameEvents.TeamSetHasTech.Add(
function(iTeam, iTech, bAdopted) 
	local oTeam = GetPovertyTeam();
	local pPlayer = GetPovertyPlayer();
	if oTeam == iTeam then
		if not pPlayer:IsHuman() then
			if (load(pPlayer, "POVERTY_ERA_CHECK") ~= true) then

				if (iTech == iPottery) then		
					local AIMoundCheck = PlaceAIMound(pPlayer)
					if AIMoundCheck == 1 then

						save(pPlayer, "POVERTY_ERA_CHECK", true)

						PovertyClearActive(pPlayer)
						PovertyClearPromotions(pPlayer)
						PovertyClearBonuses(pPlayer)

						if not pPlayer:HasPolicy(pCount1) then
							pPlayer:SetNumFreePolicies(1)
							pPlayer:SetNumFreePolicies(0)
							pPlayer:SetHasPolicy(pCount1, true);
						end

						PovertySaveEver(pPlayer)
						PovertyAwardPromotions(pPlayer)
						PovertyAwardBonuses(pPlayer)

						--PovertyEventMessage(pPlayer)
						
					end		
				end

				if (iTech == tConstruction) then
					local AIMoundCheck = PlaceAIMound(pPlayer)
					if AIMoundCheck == 1 then

						save(pPlayer, "POVERTY_ERA_CHECK", true)

						PovertyClearActive(pPlayer)
						PovertyClearPromotions(pPlayer)
						PovertyClearBonuses(pPlayer)

						local tRandom = bGetRandom(1, 2)
						if tRandom == 1 then

							if not pPlayer:HasPolicy(pCount3) then
								pPlayer:SetNumFreePolicies(1)
								pPlayer:SetNumFreePolicies(0)
								pPlayer:SetHasPolicy(pCount3, true);
							end

						elseif tRandom == 2 then

							if not pPlayer:HasPolicy(pCount4) then
								pPlayer:SetNumFreePolicies(1)
								pPlayer:SetNumFreePolicies(0)
								pPlayer:SetHasPolicy(pCount4, true);
							end

						end

						PovertySaveEver(pPlayer)
						PovertyAwardPromotions(pPlayer)
						PovertyAwardBonuses(pPlayer)

						--PovertyEventMessage(pPlayer)

						local pcCity = pPlayer:GetCapitalCity();
						pUnit = pPlayer:InitUnit(iProphet2, pcCity:GetX(), pcCity:GetY(), UNITAI_GENERAL);
						pUnit:JumpToNearestValidPlot()
						if not pUnit:IsHasPromotion(pPRival) then
							pUnit:SetHasPromotion(pPRival, true)		
						end
						if not pUnit:IsHasPromotion(pBlessing) then
							pUnit:SetHasPromotion(pBlessing, true)		
						end
						pUnit:SetName("");
						PovertyAwardPromotions(pPlayer);

					end			
				end
				if (iTech == tChivalary) then
					local tRandom = bGetRandom(1, 2)
					if tRandom == 1 then
						local AIMoundCheck = PlaceAIMound(pPlayer)
						if AIMoundCheck == 1 then

							--KillAIPerson(pPlayer)

							save(pPlayer, "POVERTY_ERA_CHECK", true)

							PovertyClearActive(pPlayer)
							PovertyClearPromotions(pPlayer)
							PovertyClearBonuses(pPlayer)

							if not pPlayer:HasPolicy(pCount2) then
								pPlayer:SetNumFreePolicies(1)
								pPlayer:SetNumFreePolicies(0)
								pPlayer:SetHasPolicy(pCount2, true);
							end

							PovertySaveEver(pPlayer)
							PovertyAwardPromotions(pPlayer)
							PovertyAwardBonuses(pPlayer)

							--PovertyEventMessage(pPlayer)

							for xUnit in pPlayer:Units() do
								if (xUnit:GetUnitType() == iProphet2) then
									xUnit:Kill();
								end
							end

						end	
					end
				end
				if (iTech == tEconomics) then
					local AIMoundCheck = PlaceAIMound(pPlayer)
					if AIMoundCheck == 1 then

						save(pPlayer, "POVERTY_ERA_CHECK", true)

						PovertyClearActive(pPlayer)
						PovertyClearPromotions(pPlayer)
						PovertyClearBonuses(pPlayer)

						if not pPlayer:HasPolicy(pCount8) then
							pPlayer:SetNumFreePolicies(1)
							pPlayer:SetNumFreePolicies(0)
							pPlayer:SetHasPolicy(pCount8, true);
						end

						PovertySaveEver(pPlayer)
						PovertyAwardPromotions(pPlayer)
						PovertyAwardBonuses(pPlayer)

						--PovertyEventMessage(pPlayer)

						for xUnit in pPlayer:Units() do
							if (xUnit:GetUnitType() == iProphet2) then
								xUnit:Kill();
							end
						end

						local pcCity = pPlayer:GetCapitalCity();

						pUnit = pPlayer:InitUnit(iProphet2, pcCity:GetX(), pcCity:GetY(), UNITAI_INQUISITOR);
						pUnit:JumpToNearestValidPlot()
						if not pUnit:IsHasPromotion(pPRival) then
							pUnit:SetHasPromotion(pPRival, true)		
						end
						if not pUnit:IsHasPromotion(pBlessing) then
							pUnit:SetHasPromotion(pBlessing, true)		
						end
						pUnit:SetName("");

						qUnit = pPlayer:InitUnit(iProphet2, pcCity:GetX(), pcCity:GetY(), UNITAI_INQUISITOR);
						qUnit:JumpToNearestValidPlot()
						if not qUnit:IsHasPromotion(pPRival) then
							qUnit:SetHasPromotion(pPRival, true)		
						end
						if not qUnit:IsHasPromotion(pBlessing) then
							qUnit:SetHasPromotion(pBlessing, true)		
						end
						qUnit:SetName("");

						PovertyAwardPromotions(pPlayer);

					end				
				end
				if (iTech == tSteam) then
					local tRandom = bGetRandom(1, 2)
					--if tRandom == 1 then
					if (tRandom == 1) or (tRandom == 2) then
						local AIMoundCheck = PlaceAIMound(pPlayer)
						if AIMoundCheck == 1 then

							save(pPlayer, "POVERTY_ERA_CHECK", true)

							PovertyClearActive(pPlayer)
							PovertyClearPromotions(pPlayer)
							PovertyClearBonuses(pPlayer)

							if not pPlayer:HasPolicy(pCount6) then
								pPlayer:SetNumFreePolicies(1)
								pPlayer:SetNumFreePolicies(0)
								pPlayer:SetHasPolicy(pCount6, true);
							end

							PovertySaveEver(pPlayer)
							PovertyAwardPromotions(pPlayer)
							PovertyAwardBonuses(pPlayer)

							--PovertyEventMessage(pPlayer)

							for xUnit in pPlayer:Units() do
								if (xUnit:GetUnitType() == iProphet2) then
									xUnit:Kill();
								end
							end

							local pcCity = pPlayer:GetCapitalCity();

							pUnit = pPlayer:InitUnit(iProphet2, pcCity:GetX(), pcCity:GetY(), UNITAI_ADMIRAL);
							pUnit:JumpToNearestValidPlot()
							if not pUnit:IsHasPromotion(pPRival) then
								pUnit:SetHasPromotion(pPRival, true)		
							end
							if not pUnit:IsHasPromotion(pBlessing) then
								pUnit:SetHasPromotion(pBlessing, true)		
							end
							pUnit:SetName("");

							qUnit = pPlayer:InitUnit(iProphet2, pcCity:GetX(), pcCity:GetY(), UNITAI_ADMIRAL);
							qUnit:JumpToNearestValidPlot()
							if not qUnit:IsHasPromotion(pPRival) then
								qUnit:SetHasPromotion(pPRival, true)		
							end
							if not qUnit:IsHasPromotion(pBlessing) then
								qUnit:SetHasPromotion(pBlessing, true)		
							end
							qUnit:SetName("");

							PovertyAwardPromotions(pPlayer);

						end						
					end
				end
				if (iTech == tBallistics) then
					local AIMoundCheck = PlaceAIMound(pPlayer)
					if AIMoundCheck == 1 then

						save(pPlayer, "POVERTY_ERA_CHECK", true)

						PovertyClearActive(pPlayer)
						PovertyClearPromotions(pPlayer)
						PovertyClearBonuses(pPlayer)

						local tRandom = bGetRandom(1, 2)
						if tRandom == 1 then
							if not pPlayer:HasPolicy(pCount5) then
								pPlayer:SetNumFreePolicies(1)
								pPlayer:SetNumFreePolicies(0)
								pPlayer:SetHasPolicy(pCount5, true);
							end
						elseif tRandom == 2 then
							if not pPlayer:HasPolicy(pCount7) then
								pPlayer:SetNumFreePolicies(1)
								pPlayer:SetNumFreePolicies(0)
								pPlayer:SetHasPolicy(pCount7, true);
							end
						end
				
						PovertySaveEver(pPlayer)
						PovertyAwardPromotions(pPlayer)
						PovertyAwardBonuses(pPlayer)

						--PovertyEventMessage(pPlayer)

						for xUnit in pPlayer:Units() do
							if (xUnit:GetUnitType() == iProphet2) then
								xUnit:Kill();
							end
						end

					end			
				end

				if (iTech == tComputers) then
					local tRandom = bGetRandom(1, 2)
					if tRandom == 1 then		

						local AIMoundCheck = PlaceAIMound(pPlayer)
						if AIMoundCheck == 1 then

							save(pPlayer, "POVERTY_ERA_CHECK", true)

							PovertyClearActive(pPlayer)
							PovertyClearPromotions(pPlayer)
							PovertyClearBonuses(pPlayer)

							if not pPlayer:HasPolicy(pCount9) then
								pPlayer:SetNumFreePolicies(1)
								pPlayer:SetNumFreePolicies(0)
								pPlayer:SetHasPolicy(pCount9, true);
							end

							PovertySaveEver(pPlayer)
							PovertyAwardPromotions(pPlayer)
							PovertyAwardBonuses(pPlayer)

							--PovertyEventMessage(pPlayer)

							for xUnit in pPlayer:Units() do
								if (xUnit:GetUnitType() == iProphet2) then
									xUnit:Kill();
								end
							end

						end

					end				
				end
			end
		end
	end
end)

--Human AI Event Messages
function PovertyHumanAI(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:IsHuman()) then
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then		
				for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
					local mPlayer = Players[mPlayer];
					if (mPlayer:IsAlive()) then
						if not (mPlayer:IsHuman()) then
							if (mPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) then	
								local pTeam = pPlayer:GetTeam();
								local mTeam = mPlayer:GetTeam();
								if pTeam ~= mTeam then
									if Teams[pTeam]:IsHasMet(mTeam) then
										if mPlayer:HasPolicy(pCount1) then
											if (load(pPlayer, "Poverty Human AI 1") ~= true) then
												Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Old Man Above watches over the Poverty Point civilization![ENDCOLOR]");
												save(pPlayer, "Poverty Human AI 1", true)
												break;
											end
										elseif mPlayer:HasPolicy(pCount2) then
											if (load(pPlayer, "Poverty Human AI 2") ~= true) then
												Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Kneeling Woman watches over the Poverty Point civilization![ENDCOLOR]");
												save(pPlayer, "Poverty Human AI 2", true)
												break;
											end
										elseif mPlayer:HasPolicy(pCount3) then
											if (load(pPlayer, "Poverty Human AI 3") ~= true) then
												Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Red Fox watches over the Poverty Point civilization![ENDCOLOR]");
												save(pPlayer, "Poverty Human AI 3", true)
												break;
											end
										elseif mPlayer:HasPolicy(pCount4) then
											if (load(pPlayer, "Poverty Human AI 4") ~= true) then
												Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Long Tail watches over the Poverty Point civilization![ENDCOLOR]");
												save(pPlayer, "Poverty Human AI 4", true)
												break;
											end
										elseif mPlayer:HasPolicy(pCount5) then
											if (load(pPlayer, "Poverty Human AI 5") ~= true) then
												Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Stone Turtle watches over the Poverty Point civilization![ENDCOLOR]");
												save(pPlayer, "Poverty Human AI 5", true)
												break;
											end
										elseif mPlayer:HasPolicy(pCount6) then
											if (load(pPlayer, "Poverty Human AI 6") ~= true) then
												Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Duck Foot watches over the Poverty Point civilization![ENDCOLOR]");
												save(pPlayer, "Poverty Human AI 6", true)
												break;
											end
										elseif mPlayer:HasPolicy(pCount7) then
											if (load(pPlayer, "Poverty Human AI 7") ~= true) then
												Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Beaded Locust watches over the Poverty Point civilization![ENDCOLOR]");
												save(pPlayer, "Poverty Human AI 7", true)
												break;
											end														
										elseif mPlayer:HasPolicy(pCount8) then
											if (load(pPlayer, "Poverty Human AI 8") ~= true) then
												Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Potbellied Owl watches over the Poverty Point civilization![ENDCOLOR]");
												save(pPlayer, "Poverty Human AI 8", true)
												break;
											end
										elseif mPlayer:HasPolicy(pCount9) then
											if (load(pPlayer, "Poverty Human AI 9") ~= true) then
												Events.GameplayAlertMessage("[COLOR_POSITIVE_TEXT]The Horned Serpent watches over the Poverty Point civilization![ENDCOLOR]");
												Events.GameplayAlertMessage("[COLOR_NEGATIVE_TEXT]The Horned Serpent is causing [ICON_RESISTANCE] Anarchy![ENDCOLOR]");
												save(pPlayer, "Poverty Human AI 9", true)
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
		end
	end
end
GameEvents.PlayerDoTurn.Add(PovertyHumanAI)

--Extra
for pPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
	local pPlayer = Players[pPlayer];
	if pPlayer:IsEverAlive() then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_POVERTY_POINT_MOD) and pPlayer:IsHuman() then
			local tquery = {"UPDATE Language_en_US SET Text = 'Requires Autocracy. In addition to the +2 [ICON_HAPPINESS_1] Happiness, the Prora Resort also provides +1 more [ICON_HAPPINESS_1] Happiness for every 2 Policies you have adopted. (If playing as Poverty Point, each Spirit Guardian chosen will also count towards your total Policy count). 1 Free Social Policy. Must be constructed in a coastal city.' WHERE Tag = 'TXT_KEY_WONDER_PRORA_RESORT_HELP'"}
			for i, iQuery in pairs(tquery) do
				for result in DB.Query(iQuery) do
				end
			end
			Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
		end
	end
end







