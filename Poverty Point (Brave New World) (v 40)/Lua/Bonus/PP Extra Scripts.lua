print ("Poverty Scripts 2")

--Stuff
local Itza = GameInfoTypes.BUILDING_CHICHEN_ITZA;
local Suffrage = GameInfoTypes.POLICY_UNIVERSAL_SUFFRAGE;

local ucProphet = GameInfoTypes.UNITCLASS_PROPHET;
local uScientist = GameInfo.Units.UNIT_SCIENTIST.ID ;
local uEngineer = GameInfo.Units.UNIT_ENGINEER.ID;
local uMerchant = GameInfo.Units.UNIT_MERCHANT.ID;
local uGeneral = GameInfo.Units.UNIT_GREAT_GENERAL.ID;
local uAdmiral = GameInfo.Units.UNIT_GREAT_ADMIRAL.ID;

local pBlessing2 = GameInfoTypes.PROMOTION_PP_BLESSING_2;
local pBlessing7e = GameInfoTypes.PROMOTION_PP_BLESSING_7_E;
local pBlessing7m = GameInfoTypes.PROMOTION_PP_BLESSING_7_M;
local pBlessing7s = GameInfoTypes.PROMOTION_PP_BLESSING_7_S;
local pBlessing7g = GameInfoTypes.PROMOTION_PP_BLESSING_7_G;
local pBlessingNull = GameInfoTypes.PROMOTION_PP_BLESSING_NULL;
local pBlessing8 = GameInfoTypes.PROMOTION_PP_BLESSING_5;
local pBlessing9 = GameInfoTypes.PROMOTION_PP_BLESSING_9;

local rAluminum = GameInfoTypes.RESOURCE_ALUMINUM;
local iElectricty = GameInfo.Technologies["TECH_ELECTRICITY"].ID
local rCoal = GameInfoTypes.RESOURCE_COAL;
local iIndustry = GameInfo.Technologies["TECH_INDUSTRIALIZATION"].ID
local rIron = GameInfoTypes.RESOURCE_IRON;
local iBronze = GameInfo.Technologies["TECH_BRONZE_WORKING"].ID
local rOil = GameInfoTypes.RESOURCE_OIL;
local iBio = GameInfo.Technologies["TECH_BIOLOGY"].ID
local rUranium = GameInfoTypes.RESOURCE_URANIUM;
local iAtomic = GameInfo.Technologies["TECH_ATOMIC_THEORY"].ID
local rHorse = GameInfoTypes.RESOURCE_HORSE;
local iAnimalHusbandry = GameInfo.Technologies["TECH_ANIMAL_HUSBANDRY"].ID

--UI
function MyButtonFunction2()
	local plot = selUnit:GetPlot()
	local playerID = selUnit:GetOwner()
	local player = Players[playerID]
	local pPlayer = player;
	local pTeam = player:GetTeam();
	if selUnit:GetMoves() > 0 then
		if selUnit:IsHasPromotion(pBlessing2) or selUnit:IsHasPromotion(pBlessing7e) or selUnit:IsHasPromotion(pBlessing7m) or selUnit:IsHasPromotion(pBlessing7s) or selUnit:IsHasPromotion(pBlessing7g) or selUnit:IsHasPromotion(pBlessing8) or selUnit:IsHasPromotion(pBlessing9) then

			local EnableButton = 1
			if (selUnit:GetReligion() ~= -1) and (selUnit:GetUnitClassType() == ucProphet) and (selUnit:GetSpreadsLeft() < 4) then
				EnableButton = 0;
			end

			if selUnit:IsHasPromotion(pBlessing8) then

				if (plot:GetResourceType() == -1) then
					EnableButton = 0;
				end
				if (plot:GetResourceType() ~= -1) then
					local plotResource = plot:GetResourceType();
					if ((GameInfo.Resources[plotResource].Happiness == 0) and (GameInfo.Resources[plotResource].AIObjective == 0)) then
						EnableButton = 0;
					end
				end

				if (plot:GetResourceType() == rAluminum) and not (Teams[pTeam]:IsHasTech(iElectricty)) then
					EnableButton = 0;
				end
				if (plot:GetResourceType() == rCoal) and not (Teams[pTeam]:IsHasTech(iIndustry)) then
					EnableButton = 0;
				end
				if (plot:GetResourceType() == rIron) and not (Teams[pTeam]:IsHasTech(iBronze)) then
					EnableButton = 0;
				end
				if (plot:GetResourceType() == rOil) and not (Teams[pTeam]:IsHasTech(iBio)) then
					EnableButton = 0;
				end
				if (plot:GetResourceType() == rUranium) and not (Teams[pTeam]:IsHasTech(iAtomic)) then
					EnableButton = 0;
				end
				if (plot:GetResourceType() == rHorse) and not (Teams[pTeam]:IsHasTech(iAnimalHusbandry)) then
					EnableButton = 0;
				end
			end

			if selUnit:IsHasPromotion(pBlessing8) and (plot:GetOwner() ~= -1) then
				if selUnit:GetOwner() ~= plot:GetOwner() then
					EnableButton = 0;
				end
			end

			if selUnit:IsHasPromotion(pBlessing9) then
				if (plot:GetOwner() == -1) then
					EnableButton = 0;
				end
				if (plot:GetOwner() ~= -1) then
					if selUnit:GetOwner() == plot:GetOwner() then
						EnableButton = 0;
					end
				end
			end

			if EnableButton >= 1 then

				Controls.PovertyButtonB:SetDisabled(true)
				Events.AudioPlay2DSound("AS2D_SOUND_POVERTY_MOD_BUILD")

				local CityID = 0;
				local pNearestCity = nil;
				local iNearestDistance = 1000000;
				for cityIndex = 0, pPlayer:GetNumCities() - 1, 1 do
					local pCity = pPlayer:GetCityByID(cityIndex);
					if (pCity ~= nil) then
						local iDistance = Map.PlotDistance(selUnit:GetX(), selUnit:GetY(), pCity:GetX(), pCity:GetY());
						if (iDistance < iNearestDistance) then
							iNearestDistance = iDistance;
							pNearestCity = pCity;
						end
					end
				end
				if (pNearestCity ~= nil) then
					CityID = pNearestCity:GetID();
				end

				--Bonus 2
				if selUnit:IsHasPromotion(pBlessing2) then
					local uPlot = selUnit:GetPlot();
					local plotX = selUnit:GetX();
					local plotY = selUnit:GetY();
					local iRange = 1;
					for iDX = -iRange, iRange do
						for iDY = -iRange, iRange do
							local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
							if pTargetPlot then			
								local pPlot = pTargetPlot;								
								for iVal = 0,(pPlot:GetNumUnits() - 1) do
									local sUnit = pPlot:GetUnit(iVal)
									if sUnit:GetOwner() == selUnit:GetOwner() then
										if sUnit:IsCombatUnit() then
											if (sUnit:GetDomainType() == DomainTypes.DOMAIN_LAND) and not sUnit:IsEmbarked() then										
												sUnit:ChangeDamage(-1 * math.min(sUnit:GetDamage(), 100));
											end
										end
									end
								end
							end
						end
					end
				end

				--Bonus 7
				if selUnit:IsHasPromotion(pBlessing7e) then
					local uPlot = selUnit:GetPlot();
					local TamaliText = Locale.ConvertTextKey("TXT_KEY_PP_UNIT_MOD")
					pUnit = pPlayer:InitUnit(uEngineer, uPlot:GetX(), uPlot:GetY(), UNITAI_ENGINEER);
					pUnit:SetMoves(0);
					pUnit:SetHasPromotion(pBlessingNull, true);
					pUnit:SetName("" .. TamaliText .. "");
				end
				if selUnit:IsHasPromotion(pBlessing7m) then
					local uPlot = selUnit:GetPlot();
					local TamaliText = Locale.ConvertTextKey("TXT_KEY_PP_UNIT_MOD")
					pUnit = pPlayer:InitUnit(uMerchant, uPlot:GetX(), uPlot:GetY(), UNITAI_MERCHANT);
					pUnit:SetMoves(0);
					pUnit:SetHasPromotion(pBlessingNull, true);
					pUnit:SetName("" .. TamaliText .. "");
				end
				if selUnit:IsHasPromotion(pBlessing7s) then
					local uPlot = selUnit:GetPlot();
					local TamaliText = Locale.ConvertTextKey("TXT_KEY_PP_UNIT_MOD")
					pUnit = pPlayer:InitUnit(uScientist, uPlot:GetX(), uPlot:GetY(), UNITAI_SCIENTIST);
					pUnit:SetMoves(0);
					pUnit:SetHasPromotion(pBlessingNull, true);
					pUnit:SetName("" .. TamaliText .. "");
				end
				if selUnit:IsHasPromotion(pBlessing7g) then
					local uPlot = selUnit:GetPlot();
					local TamaliText = Locale.ConvertTextKey("TXT_KEY_PP_UNIT_MOD")
					pUnit = pPlayer:InitUnit(uGeneral, uPlot:GetX(), uPlot:GetY(), UNITAI_GENERAL);
					pUnit:SetMoves(0);
					pUnit:SetHasPromotion(pBlessingNull, true);
					pUnit:SetName("" .. TamaliText .. "");
				end								
	
				--Bonus 5
				if selUnit:IsHasPromotion(pBlessing8) then
					local plotResource = plot:GetResourceType();
					local rType = GameInfo.Resources[plotResource].ID;
					player:ChangeNumResourceTotal(rType, 2)
				end

				--Bonus 9
				if selUnit:IsHasPromotion(pBlessing9) then

					local speed = Game.GetGameSpeedType();
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
					if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
						GALength = (2 + GALength2);
					elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
						GALength = (3 + GALength2);
					elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
						GALength = (4 + GALength2);
					elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
						GALength = (5 + GALength2);
					else
						GALength = (5 + GALength2);
					end

					local mPlayerID = plot:GetOwner()
					local mPlayer = Players[mPlayerID]
					for mCity in mPlayer:Cities() do
						mCity:ChangeResistanceTurns(GALength);
					end
					
					--Events.GameplayAlertMessage("[COLOR_NEGATIVE_TEXT]The Horned Serpent stalks " .. Locale.ConvertTextKey(mPlayer:GetCivilizationAdjective()) .. " Cities![ENDCOLOR]");	
					Events.GameplayAlertMessage("[COLOR_NEGATIVE_TEXT]The Horned Serpent is causing [ICON_RESISTANCE] Resistance![ENDCOLOR]");	

				end

				selUnit:Kill();

			end
		end
	end
end

Controls.PovertyButtonB:RegisterCallback(Mouse.eLClick, MyButtonFunction2 )
IconHookup(0, 45, "POVERTY_POINT_ACTION_ATLAS_2", Controls.PovertyImageB )
Controls.PovertyBackgroundB:SetHide(true)

function Selection2(player, unitID, x, y, a5, bool)
	if bool then
		local cUnit = Players[player]:GetUnitByID(unitID);
		local plot = cUnit:GetPlot()

		if Players[player]:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"] then
			if (cUnit:GetUnitClassType() == ucProphet) then
				if cUnit:IsHasPromotion(pBlessing2) or cUnit:IsHasPromotion(pBlessing7e) or cUnit:IsHasPromotion(pBlessing7m) or cUnit:IsHasPromotion(pBlessing7s) or cUnit:IsHasPromotion(pBlessing7g) or cUnit:IsHasPromotion(pBlessing8) or cUnit:IsHasPromotion(pBlessing9) then			
					Controls.PovertyBackgroundB:SetHide(false)
					selUnit = cUnit;
					Controls.PovertyButtonB:SetDisabled(false)
					local Poverty2ToolTip = 0;
					if cUnit:IsHasPromotion(pBlessing2) then	
						Poverty2ToolTip = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_ACTION_2")
					elseif cUnit:IsHasPromotion(pBlessing7e) or cUnit:IsHasPromotion(pBlessing7m) or cUnit:IsHasPromotion(pBlessing7s) or cUnit:IsHasPromotion(pBlessing7g) then
						Poverty2ToolTip = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_ACTION_7")
					elseif cUnit:IsHasPromotion(pBlessing8) then
						Poverty2ToolTip = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_ACTION_8")
					elseif cUnit:IsHasPromotion(pBlessing9) then
						Poverty2ToolTip = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_ACTION_9")
					else
						Poverty2ToolTip = Locale.ConvertTextKey("TXT_KEY_POVERTY_BONUS_ACTION_NULL")
					end
					Controls.PovertyButtonB:LocalizeAndSetToolTip("" .. Poverty2ToolTip .. "")
				end
			end
		end

	else
		Controls.PovertyBackgroundB:SetHide(true)
		selUnit = nil;
	end
end
Events.UnitSelectionChanged.Add(Selection2);