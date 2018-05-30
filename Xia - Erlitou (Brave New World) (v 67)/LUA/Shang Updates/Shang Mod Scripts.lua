print ("Shang Scripts")

--SaveUtils
WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "Xia";

--Support
include("IconSupport.lua")

--Stuff
local speed = Game.GetGameSpeedType();

local iPasture = GameInfoTypes.IMPROVEMENT_PASTURE
local iHolySite = GameInfoTypes.IMPROVEMENT_HOLY_SITE
local iAcademy = GameInfoTypes.IMPROVEMENT_ACADEMY

local rSheep = GameInfoTypes.RESOURCE_SHEEP;
local rHorse = GameInfoTypes.RESOURCE_HORSE;
local rCow = GameInfoTypes.RESOURCE_COW;
local rDeer = GameInfoTypes.RESOURCE_DEER;

local ucArtist = GameInfoTypes.UNITCLASS_ARTIST;
local ucWriter = GameInfoTypes.UNITCLASS_WRITER;
local ucMusician = GameInfoTypes.UNITCLASS_MUSICIAN;
local ucScientist = GameInfoTypes.UNITCLASS_SCIENTIST;
local ucMerchant = GameInfoTypes.UNITCLASS_MERCHANT;
local ucEngineer = GameInfoTypes.UNITCLASS_ENGINEER;
local ucGreatGeneral = GameInfoTypes.UNITCLASS_GREAT_GENERAL;
local ucAdmiral = GameInfoTypes.UNITCLASS_GREAT_ADMIRAL;
local ucProphet = GameInfoTypes.UNITCLASS_PROPHET;

local uShangChariot = GameInfoTypes.UNIT_SHANG_CHARIOT_MOD;

local bcBarracks = GameInfoTypes.BUILDINGCLASS_BARRACKS;
local bcShang = GameInfoTypes.BUILDINGCLASS_SHANG_DYNASTY_DUMMY;

local bFoundry = GameInfoTypes.BUILDING_XIA_MOD_BRONZE_WOKRSHOP;
local bBarracksPressure = GameInfoTypes.BUILDING_XIA_RITUAL_BRONZE_DUMMY;
local bShangDummyCulture = GameInfoTypes.BUILDING_XIA_SHANG_SWITCH;
local bSong = GameInfoTypes.BUILDING_SONG_DYNASTY_DUMMY;
local bZhou = GameInfoTypes.BUILDING_ZHOU_DYNASTY_DUMMY;

local iTechWheel = GameInfo.Technologies["TECH_THE_WHEEL"].ID
local iTechHorseback = GameInfo.Technologies["TECH_HORSEBACK_RIDING"].ID
local iAnimalHusbandry = GameInfo.Technologies["TECH_ANIMAL_HUSBANDRY"].ID

local pZhou = GameInfoTypes.POLICY_ZHOU_DYNASTY_DUMMY;
local pOracleBone = GameInfoTypes.POLICY_ORACLE_BONE_DUMMY;

local greatWorkSlotArtID = GameInfoTypes["GREAT_WORK_SLOT_ART_ARTIFACT"]
local unitXiaYuID = GameInfoTypes["UNIT_DECISIONS_XIA_YU"]
local unitMissionCreateGreatWorkID = GameInfoTypes["MISSION_CREATE_GREAT_WORK"]
local unitEngineerID = GameInfoTypes["UNIT_ENGINEER"]
local unitMissionRushProductionID = GameInfoTypes["MISSION_HURRY"]

local isEaD = false
local isEaDID = "1f941088-b185-4159-865c-472df81247b2"

for _, mod in pairs(Modding.GetActivatedMods()) do
	if (mod.ID == isEaDID) then
		isEaD = true
		break
	end
end

function ErlitouGetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end

function xDecompilePlotID(sKey)
    iBreak = string.find(sKey, "Y")
    iX = tonumber(string.sub(sKey, 1, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1))
    pPlot = Map.GetPlot(iX, iY)
    return pPlot
end

function xCompilePlotID(pPlot)
    iX = pPlot:GetX()
    iY = pPlot:GetY()
    return(iX .. "Y" .. iY)
end

local SacrificeResourcePlots = {}

for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	if (pPlot:GetResourceType() == rSheep) or (pPlot:GetResourceType() == rCow) or (pPlot:GetResourceType() == rHorse) then
		local sKey = xCompilePlotID(pPlot)
		SacrificeResourcePlots[sKey] = -1
    end
end

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

--Oracle Bones
function OracleBonesMessage(OracleType, OracleMessage, OracleBonus)
	LuaEvents.ShowShangOraclePopup(OracleType, OracleMessage, OracleBonus)
end

function OracleGiftUnits(pcCity, pPlayer, pPlot)
	for _, iUnit in pairs(LandInfantry) do
		if pcCity:CanTrain(iUnit) then
			pUnit = pPlayer:InitUnit(iUnit, pcCity:GetX(), pcCity:GetY())
			pUnit:JumpToNearestValidPlot()
			break
		end
	end
end

function OracleBonesRandom(pPlayer, pTeam, pPlot, BonusFaith)

	local OracleType = "";
	if (pPlot:GetResourceType() == rSheep) then
		OracleType = Locale.ConvertTextKey("TXT_KEY_SHANG_SACRIFICE_HEADER_TYPE_1");
	elseif (pPlot:GetResourceType() == rCow) then
		OracleType = Locale.ConvertTextKey("TXT_KEY_SHANG_SACRIFICE_HEADER_TYPE_2");
	elseif (pPlot:GetResourceType() == rHorse) then
		OracleType = Locale.ConvertTextKey("TXT_KEY_SHANG_SACRIFICE_HEADER_TYPE_3");
	end
	local OracleMessage = "";
	local OracleBonus = "";

	local pID = pPlayer:GetID();
	local pcCity = pPlayer:GetCapitalCity();
	local EraCount = (Teams[pTeam]:GetCurrentEra());

	for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local mPlayer = Players[mPlayer];
		if (mPlayer:IsAlive()) then
			for mCity in mPlayer:Cities() do
				if (mCity:IsHasBuilding(bShangDummyCulture)) then
					mCity:SetNumRealBuilding(bShangDummyCulture, 0);
				end
			end
		end
	end

	local ShangGABonus = 0;
	local ShangAnarchy = 0;
	local ShangProject = 0;
	local ShangGold = 0;
	local ShangRain = 0;
	if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
		ShangGABonus = 6;
		ShangAnarchy = 1;
		ShangProject = 257;
		ShangGold = math.ceil(((200 + (EraCount * 66))/3)*2);
		ShangRain = 12;
	elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
		ShangGABonus = 8;
		ShangAnarchy = 2;
		ShangProject = 375;
		ShangGold = math.ceil(((300 + (EraCount * 100))/3)*2);
		ShangRain = 16;
	elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
		ShangGABonus = 10;
		ShangAnarchy = 3;
		ShangProject = 563;
		ShangGold = math.ceil(((450 + (EraCount * 150))/3)*2);
		ShangRain = 20;
	elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
		ShangGABonus = 16;
		ShangAnarchy = 3;
		ShangProject = 1125;
		ShangGold = math.ceil(((900 + (EraCount * 300))/3)*2);
		ShangRain = 32;
	else
		ShangGABonus = 16;
		ShangAnarchy = 4;
		ShangProject = 1125;
		ShangGold = math.ceil(((900 + (EraCount * 300))/3)*2);
		ShangRain = 32;
	end

	local eRandom = ErlitouGetRandom(1, 16)
	if eRandom == 1 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_1_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_1_TAG", BonusFaith);
		for pCity in pPlayer:Cities() do
			pCity:ChangePopulation(1, true);
		end
	elseif eRandom == 2 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_2_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_2_TAG", BonusFaith);
		if (pcCity:GetWeLoveTheKingDayCounter() >= 1) then
			pcCity:ChangeWeLoveTheKingDayCounter(20)
		elseif (pcCity:GetWeLoveTheKingDayCounter() <= 0) then
			pcCity:SetWeLoveTheKingDayCounter(20)
		end	
		if (pPlayer:IsHuman()) and (pID == Game.GetActivePlayer()) then
			local CityName = Locale.ConvertTextKey(pcCity:GetName())
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_2_EVENT_TAG", CityName));
		end
	elseif eRandom == 3 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_3_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_3_TAG", BonusFaith);
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				local BaseXP = pUnit:GetExperience()
				local ShangXP = BaseXP + 15;
				pUnit:SetExperience(ShangXP);
			end
		end
	elseif eRandom == 4 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_4_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_4_TAG", BonusFaith);
	elseif eRandom == 5 then
		local NumTroops = 4;
		if (EraCount == 0) then
			NumTroops = 2;
		end
		if (EraCount == 1) or (EraCount == 2) or (EraCount == 3) then
			NumTroops = 3;
		end
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_5_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_5_TAG", BonusFaith, NumTroops);
		if EraCount >= 0 then
			OracleGiftUnits(pcCity, pPlayer, pPlot)
			OracleGiftUnits(pcCity, pPlayer, pPlot)
		end
		if EraCount >= 1 then
			OracleGiftUnits(pcCity, pPlayer, pPlot)
		end
		if EraCount >= 4 then
			OracleGiftUnits(pcCity, pPlayer, pPlot)
		end
	elseif eRandom == 6 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_6_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_6_TAG", BonusFaith);
		pPlot:SetImprovementType(iHolySite);
	elseif eRandom == 7 then
		local NumCulture = 1;
		if (EraCount <= 4) then
			NumCulture = 1;
		end
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_7_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_7_TAG", BonusFaith, NumCulture);
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(bShangDummyCulture, NumCulture);
		end
	elseif eRandom == 8 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_8_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_8_TAG", BonusFaith);
		local gAge = pPlayer:GetNumGoldenAges();
		pPlayer:ChangeGoldenAgeTurns(ShangGABonus);
		pPlayer:SetNumGoldenAges(gAge);	
	elseif eRandom == 9 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_9_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_9_TAG", BonusFaith, ShangAnarchy);
		for mPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
			local mPlayer = Players[mPlayer];
			if (mPlayer:IsAlive()) then
				local mTeam = mPlayer:GetTeam();
				if mTeam ~= pTeam then
					if mPlayer:IsAnarchy() then
						mPlayer:ChangeAnarchyNumTurns(ShangAnarchy);
					else
						mPlayer:SetAnarchyNumTurns(ShangAnarchy);
					end
				end
			end
		end
		Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_9_EVENT_TAG", ShangAnarchy))
	elseif eRandom == 10 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_10_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_10_TAG", BonusFaith);
		pcCity:SetNumRealBuilding(bSong, 1);
		pcCity:SetNumRealBuilding(bSong, 0);
	elseif eRandom == 11 then
		local NumInfluence = 20;
		if (EraCount <= 1) then
			NumInfluence = 15;
		end
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_11_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_11_TAG", BonusFaith, NumInfluence);
		for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 2 do 
			local tPlayer = Players[i];					
			local tTeam = tPlayer:GetTeam();
			if pTeam ~= tTeam then
				if Teams[pTeam]:IsHasMet(tTeam) then
					tPlayer:ChangeMinorCivFriendshipWithMajor(pID, NumInfluence);
				end
			end
		end
	elseif eRandom == 12 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_12_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_12_TAG", BonusFaith);
		if pcCity:GetProductionBuilding() ~= -1 then
			pPlayer:InitUnit(unitEngineerID, pcCity:GetX(), pcCity:GetY()):PushMission(unitMissionRushProductionID);
		elseif pcCity:GetProductionUnit() ~= -1 then
			local Unit = pcCity:GetProductionUnit();
			local hUnit = GameInfo.Units[Unit].Cost
			pcCity:ChangeProduction(hUnit);
		elseif pcCity:GetProductionProject() ~= -1 then
			pcCity:ChangeProduction(ShangProject);
		end
	elseif eRandom == 13 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_13_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_13_TAG", BonusFaith, ShangGold);
		pPlayer:ChangeGold(ShangGold);
	elseif eRandom == 14 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_14_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_14_TAG", BonusFaith);
		pPlot:SetImprovementType(iAcademy);	
	elseif eRandom == 15 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_15_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_15_TAG", BonusFaith);	
		local bDeerCheck = 0;
		local bDeerCount = 1;
		local plotX = pcCity:GetX();
		local plotY = pcCity:GetY();
		for iDX = -3, 3 do
			for iDY = -3, 3 do
				local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, 3);
				if pTargetPlot then
					if (pTargetPlot:GetOwner() == -1) or (pTargetPlot:GetOwner() == pID) then
						if (pTargetPlot:GetResourceType() == -1) then
							if not pTargetPlot:IsCity() and not pTargetPlot:IsMountain() and not pTargetPlot:IsImpassable() and not pTargetPlot:IsWater() then
								if bDeerCount == 1 then 
									pTargetPlot:SetResourceType(rDeer, 1)
									pTargetPlot:SetRevealed(pTeam, true)
									local title = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_15_EVENT_TITLE_TAG");
									local CityName = pcCity:GetName();
									local descr = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_15_EVENT_BODY_TAG", CityName);
									pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, pTargetPlot:GetX(), pTargetPlot:GetY());
									bDeerCount = 0;
									bDeerCheck = 1;
									break	
								end
							end
						end
					end
				end
			end
		end
		hUnit = pPlayer:InitUnit(uShangChariot, pcCity:GetX(), pcCity:GetY(), UNITAI_RANGED);
		hUnit:JumpToNearestValidPlot();
	elseif eRandom == 16 then
		OracleMessage = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_TITLE_16_TAG");
		OracleBonus = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_EVENT_BODY_16_TAG", BonusFaith, ShangRain);	
		pcCity:SetNumRealBuilding(bZhou, ShangRain);
		if not pPlayer:HasPolicy(pOracleBone) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(pOracleBone, true);
		end		
	end
	
	if (pPlayer:IsHuman()) and (pID == Game.GetActivePlayer()) then
		OracleBonesMessage(OracleType, OracleMessage, OracleBonus)
	end

end

function OracleBonesBonus(player, pTeam, plot)
	local pPlayer = player;
	local pPlot = plot;

	local pcCity = pPlayer:GetCapitalCity();

	local EraCount = ((Teams[pTeam]:GetCurrentEra()) + 1);
	local BaseFaith = 20;
	if (isEaD == true) then
		BaseFaith = 15;
	end
	local iShang = pPlayer:GetBuildingClassCount(bcShang);
	if iShang >= 1 then
		BaseFaith = 30;
	end
	local BonusFaith = (BaseFaith * EraCount);

	OracleBonesRandom(pPlayer, pTeam, pPlot, BonusFaith)

	pPlayer:ChangeFaith(BonusFaith);

	if pPlayer:HasAvailableGreatWorkSlot(greatWorkSlotArtID) then
		dUnit = pPlayer:InitUnit(unitXiaYuID, pcCity:GetX(), pcCity:GetY(), UNITAI_ARTIST);
		if (dUnit:GetName() ~= "Shaman King") then
			dUnit:PushMission(unitMissionCreateGreatWorkID)
		else
			dUnit:Kill();
		end
	end

end

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_ERLITOU_MOD"]) then
			local pcCity = pPlayer:GetCapitalCity();
			local ZhouCount = pcCity:GetNumBuilding(bZhou);
			if ZhouCount <= 0 then
				if pPlayer:HasPolicy(pOracleBone) then
					pPlayer:SetHasPolicy(pOracleBone, false);
				end	
			elseif ZhouCount >= 1 then	
				local ZhouChange = (ZhouCount - 1);
				pcCity:SetNumRealBuilding(bZhou, ZhouChange);
			end

			if not pPlayer:IsHuman() then
				if pPlayer:HasAvailableGreatWorkSlot(greatWorkSlotArtID) then
					for pUnit in pPlayer:Units() do
						if (pUnit:GetUnitClassType() == ucArtist) or (pUnit:GetUnitClassType() == ucWriter) or (pUnit:GetUnitClassType() == ucMusician) or (pUnit:GetUnitClassType() == ucMerchant) then	
							local pID = pPlayer:GetID();
							local UniName = (pUnit:GetName());
							if load(pPlayer, "" .. UniName .. "") ~= true then
								save(pPlayer, "" .. UniName .. "", true)
								if ErlitouGetRandom(1, 10) == 10 then
									local player = Players[iPlayer];
									local pTeam = player:GetTeam();
									local SacRes = 0;
									local plot = 0;
									for sKey, tTable in pairs(SacrificeResourcePlots) do
										local pPlot = xDecompilePlotID(sKey)
										if (pPlot:GetResourceType() == rSheep) or (pPlot:GetResourceType() == rCow) or (pPlot:GetResourceType() == rHorse) then
											if (pPlot:GetOwner() == pID) then
												plot = pPlot;
												SacRes = 1;
												break
											end
										end
									end
									if SacRes >= 1 then
										OracleBonesBonus(player, pTeam, plot)
										if (plot:GetResourceType() == rSheep) or (plot:GetResourceType() == rCow) then
											plot:SetResourceType(-1);
										end
										if (plot:GetResourceType() == rHorse) then
											local HorseCount = (plot:GetNumResource());
											if HorseCount <= 2 then
												plot:SetResourceType(-1);
											elseif HorseCount >= 3 then
												local NewHorse = (HorseCount - 2);
												plot:SetNumResource(NewHorse);
											end
										end
										if (plot:GetImprovementType() == iPasture) and (plot:GetResourceType() == -1) then
											plot:SetImprovementType(-1);
										end										
										pUnit:Kill();
										break
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

function MyButtonFunction()
	local plot = selUnit:GetPlot()
	local playerID = selUnit:GetOwner()
	local player = Players[playerID]
	local pTeam = player:GetTeam();

	if selUnit:GetMoves() > 0 then
		if (plot:GetOwner() == playerID) then

			local EnableButton = 0
			if (plot:GetResourceType() == rSheep) or (plot:GetResourceType() == rCow) then
				EnableButton = 1;
			end
			if (plot:GetResourceType() == rHorse) and (Teams[pTeam]:IsHasTech(iAnimalHusbandry)) then
				EnableButton = 1;
			end
			if ((selUnit:GetUnitClassType() == ucProphet) and (selUnit:GetSpreadsLeft() < 4)) then
				EnableButton = 0;
			end
			if EnableButton >= 1 then

				Controls.MyButton:SetDisabled(true)
				Events.AudioPlay2DSound("AS2D_SOUND_XIA_SHANG_SACRIFICE")

				OracleBonesBonus(player, pTeam, plot)

				if (plot:GetResourceType() == rSheep) or (plot:GetResourceType() == rCow) then
					plot:SetResourceType(-1);
				end
				if (plot:GetResourceType() == rHorse) then
					local HorseCount = (plot:GetNumResource());
					if HorseCount <= 2 then
						plot:SetResourceType(-1);
					elseif HorseCount >= 3 then
						local NewHorse = (HorseCount - 2);
						plot:SetNumResource(NewHorse);
					end
				end

				if (plot:GetImprovementType() == iPasture) and (plot:GetResourceType() == -1) then
					plot:SetImprovementType(-1);
				end			
									
				selUnit:Kill();

			end
		end
	end
end

Controls.MyButton:RegisterCallback(Mouse.eLClick, MyButtonFunction )
IconHookup(0, 45, "XIA_SHANG_ACTION_ATLAS", Controls.MyImage )
Controls.MyBackground:SetHide(true)

function Selection(player, unitID, x, y, a5, bool)
	if bool then
		local cUnit = Players[player]:GetUnitByID(unitID);
		local plot = cUnit:GetPlot()

		if Players[player]:GetCivilizationType() == GameInfoTypes["CIVILIZATION_ERLITOU_MOD"] then
			if (cUnit:GetUnitClassType() == ucArtist) or (cUnit:GetUnitClassType() == ucWriter) or (cUnit:GetUnitClassType() == ucMusician) or (cUnit:GetUnitClassType() == ucScientist) or (cUnit:GetUnitClassType() == ucMerchant) or (cUnit:GetUnitClassType() == ucEngineer) or (cUnit:GetUnitClassType() == ucGreatGeneral) or (cUnit:GetUnitClassType() == ucProphet) or (cUnit:GetUnitClassType() == ucAdmiral) then 
				Controls.MyBackground:SetHide(false)
				selUnit = cUnit;
				Controls.MyButton:SetDisabled(false)
				local SacToolTip = Locale.ConvertTextKey("TXT_KEY_XIA_SHANG_SACRIFICE_TAG")
				Controls.MyButton:LocalizeAndSetToolTip("" .. SacToolTip .. "")
			end
		end

	else
		Controls.MyBackground:SetHide(true)
		selUnit = nil;
	end
end
Events.UnitSelectionChanged.Add(Selection);

--Foundry Pressure
GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_ERLITOU_MOD"]) then
			local pcCity = pPlayer:GetCapitalCity();
			local pTeam = pPlayer:GetTeam();
			local EraCount = (Teams[pTeam]:GetCurrentEra());
			for pCity in pPlayer:Cities() do
				if (pCity:IsHasBuilding(bBarracksPressure)) then
					pCity:SetNumRealBuilding(bBarracksPressure, 0);
				end
				if pCity:GetNumGreatWorksInBuilding(bcBarracks) >= 1 then
					pCity:SetNumRealBuilding(bBarracksPressure, 1);
					if not (pPlayer:IsHuman()) then
						if pCity == pcCity then 
							if EraCount ~= 0 then
								if (pCity:IsHasBuilding(bFoundry)) then
									if pCity:GetNumGreatWorksInBuilding(bcBarracks) <= 0 then
										pCity:SetNumRealBuilding(bBarracksPressure, 1);
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

--AI
GameEvents.TeamSetHasTech.Add(
function(iTeam, iTech, bAdopted) 
	if (iTech == iTechWheel) or (iTech == iTechHorseback) then
		local gPlayer = 0;
		local pTeam = 0;
		for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
			local pPlayer = Players[iPlayer]
			if (pPlayer:IsAlive()) and not (pPlayer:IsHuman()) then
				if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_ERLITOU_MOD) then
					gPlayer = pPlayer;
					pTeam = pPlayer:GetTeam();
				end
			end
		end
		if pTeam == iTeam then
			local pcCity = gPlayer:GetCapitalCity();
			pUnit = gPlayer:InitUnit(uShangChariot, pcCity:GetX(), pcCity:GetY(), UNITAI_RANGED);
			pUnit:JumpToNearestValidPlot();
		end
	end
end)

GameEvents.PlayerCityFounded.Add(
function(iPlayer, iCityX, iCityY)
	local pPlayer = Players[iPlayer];
	local pPlot = Map.GetPlot(iCityX, iCityY);
	local pCity = pPlot:GetPlotCity();
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_ERLITOU_MOD"]) then
			if not pPlayer:IsHuman() then
				if pCity:IsCapital() then
					if not pPlayer:HasPolicy(pZhou) then
						pPlayer:SetNumFreePolicies(1)
						pPlayer:SetNumFreePolicies(0)
						pPlayer:SetHasPolicy(pZhou, true);
					end
				end
			end
		end
	end
end)











