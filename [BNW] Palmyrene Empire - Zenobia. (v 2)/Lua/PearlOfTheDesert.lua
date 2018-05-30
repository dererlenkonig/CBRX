-- PearlOfTheDesert
-- Author: Klisz
-- DateCreated: 3/14/2016 11:38:40 AM
--------------------------------------------------------------
include("FLuaVector.lua")
function GetCivilizationByTrait( uType ) -- Divine Yuri's GetCivilizationByTrait, which is used for compatibility with Randomized Unique Components
	local civilization = nil
	for uniqueTrait in GameInfo.Leader_Traits() do
		if ( uniqueTrait.TraitType == uType ) then
			local leader = uniqueTrait.LeaderType
			for uniqueLeader in GameInfo.Civilization_Leaders() do
				if( uniqueLeader.LeaderheadType == leader ) then
					local civilizationTXT = uniqueLeader.CivilizationType
					for uniqueCivilization in GameInfo.Civilizations() do
						if uniqueCivilization.Type == civilizationTXT then
							civilization = uniqueCivilization.ID
							break
						end
					end
				end
			end
		end
	end
	return civilization
end

local iPalmyraID = GetCivilizationByTrait( "TRAIT_CF_PALMYRA" )
local iIndustrialEraID = GameInfoTypes.ERA_INDUSTRIAL
local iCaravanClassID = GameInfoTypes.UNITCLASS_CARAVAN

function GetProductionBoostPerForeignCaravan(iPlayer)
	local iResult = 10
	local pPlayer = Players[iPlayer]
	local pCapital = pPlayer:GetCapitalCity()
	for n, pTradeRoute in ipairs(pPlayer:GetTradeRoutes()) do
		if pTradeRoute["FromCity"] == pCapital then
			iResult = iResult + 5
		end
	end
	if pPlayer:GetCurrentEra() >= iIndustrialEraID then
		iResult = iResult * 2
	end
	return iResult
end

function GiveProductionBoostToPalmyra(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:GetUnitClassType() == iCaravanClassID then
			local pPlot = pUnit:GetPlot()
			local iPlotOwner = pPlot:GetOwner()
			if Players[iPlotOwner] then
				local pPlotOwner = Players[iPlotOwner]
				if pPlotOwner:GetCivilizationType() == iPalmyraID and iPlotOwner ~= iPlayer then
					print("Found a foreign caravan in Palmyrene territory")
					local pCapital = pPlotOwner:GetCapitalCity()
					if pCapital then -- it's unlikely that Palmyra could own plots without having any cities but you never know
						local iBoost = GetProductionBoostPerForeignCaravan(iPlotOwner)
						pCapital:ChangeProduction(iBoost)
						Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))),"[ICON_CAPITAL][COLOR_YIELD_FOOD]+".. iBoost .."[ICON_PRODUCTION][ENDCOLOR]",0)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(GiveProductionBoostToPalmyra)

local iFeatureID = GameInfoTypes.FEATURE_PALMYRA_CITADEL_DUMMY
GameEvents.BuildFinished.Add(function(iPlayerID, iX, iY, iImprovementID)
	local pPlayer = Players[iPlayerID]
	local pPlot = Map.GetPlot(iX, iY)
	if pPlayer:GetCivilizationType() == iPalmyraID and iImprovementID == GameInfoTypes.IMPROVEMENT_CITADEL then 
		pPlot:SetFeatureType(iFeatureID)
 	elseif pPlot:GetFeatureType() == iFeatureID then
		pPlot:SetFeatureType(-1)
	end
end)

print("Pearl of the Desert loaded.")



print("Palmyra lua loaded");

local civID    = GameInfoTypes["CIVILIZATION_FB_PALMYRA"];
local iImprovementFuneraryTowerID = GameInfoTypes.IMPROVEMENT_PALMYRA_FUNERARY_TOWER
local bGreatPerson = false

function PalmyraFTbonus(iPlayer, UnitID, UnitType, iX, iY, bDelay, eByPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civID) then
		local FTcount = 0
		if bGreatPerson then
			print("Great person expended by Palmyra");
			local pPlot = Map.GetPlot(iX,iY)
			if (pPlot:IsCity()) then
				local pCity = pPlot:GetPlotCity()
				print("It's a city")
				FTcount = FuneraryTowerCountPalmyra(pCity, iPlayer)
				print("If section FTcount is " .. FTcount);
				ChangePalmyraCulture(FTcount, iPlayer)
			elseif (pPlot:GetWorkingCity() ~= nil and pPlot:GetOwner() == iPlayer) then
				print("Plot worked by city")
				local FTcount = FuneraryTowerCountPalmyra(pPlot:GetWorkingCity(), iPlayer)
				print("elseif FTcount is " .. FTcount);
				ChangePalmyraCulture(FTcount, iPlayer)
			else				
				print("Looking for the right city")
				local unitDistance = 9999
				local newCity = nil
				for iCity in pPlayer:Cities() do
					local iNewDistance = Map.PlotDistance(iCity:GetX(), iCity:GetY(), iX, iY)
					print("iNewDistance = " .. iNewDistance)
					if (iNewDistance < unitDistance) then
						newCity = iCity
					end
				end
				if (newCity ~= nil) then
					FTcount = FuneraryTowerCountPalmyra(newCity, iPlayer)
					print("else FTcount is " .. FTcount);
					ChangePalmyraCulture(FTcount, iPlayer)
				else
					print("No city found, using capital")
					FTcount = FuneraryTowerCountPalmyra(pPlayer:GetCapitalCity(), iPlayer)
					print("else else FTcount is " .. FTcount);
					ChangePalmyraCulture(FTcount, iPlayer)
				end
			end
		end
		bGreatPerson = false
	end
end

GameEvents.UnitPrekill.Add(PalmyraFTbonus)

function PalmyraGPexpended(playerID, iUnit)
	local pPlayer = Players[playerID]
	if (pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civID) then
		print("GP expended in GreatPersonExpended")
		bGreatPerson = true
	end
end

GameEvents.GreatPersonExpended.Add(PalmyraGPexpended)

function FuneraryTowerCountPalmyra(city, playerID)
	local iFuneraryTowerNum = 0
	for cityPlot = 0, city:GetNumCityPlots() - 1, 1 do
		local plot = city:GetCityIndexPlot(cityPlot)
		if plot and plot:GetOwner() == playerID then
			if city:IsWorkingPlot(plot) then
				if plot:GetImprovementType() == iImprovementFuneraryTowerID then    
					iFuneraryTowerNum = iFuneraryTowerNum + 10
					print("iFuneraryTowerNum is " .. iFuneraryTowerNum)
				end
			end
		end    
	end
	return iFuneraryTowerNum
end

function ChangePalmyraCulture(delta, playerID)
	print("Changing Culture by " .. delta);
	local pPlayer = Players[playerID]
	pPlayer:ChangeJONSCulture(delta)
	if (pPlayer:IsHuman() and delta > 0) then 
		Events.GameplayAlertMessage(Locale.ConvertTextKey("You have gained +{1_Num} Culture from the burial of a great person!", delta)) 		
	end
end