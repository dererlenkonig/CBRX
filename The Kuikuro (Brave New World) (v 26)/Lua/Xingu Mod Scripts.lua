print ("Xingu Scripts")

-- Stuff
local uWorker = GameInfoTypes.UNIT_WORKER;
local uXinguWorker = GameInfoTypes.UNIT_XINGU_WORKER;
local uXinguWorkerAI = GameInfoTypes.UNIT_XINGU_AI_WORKER;
local uHukaHuka = GameInfoTypes.UNIT_XINGU_MOD;
local uSettler = GameInfoTypes.UNITCLASS_SETTLER;
local tJungle = GameInfoTypes.FEATURE_JUNGLE;
local tPlains = GameInfoTypes.TERRAIN_PLAINS;
local pWoodsman = GameInfoTypes.PROMOTION_WOODSMAN;
local bHouseGarden = GameInfoTypes.BUILDING_XINGU;
local isExCE = (GameInfoTypes.PROMOTION_JFD_JUNGLE_IMMUNITY ~= nil)

directions = {DirectionTypes.DIRECTION_NORTHEAST, DirectionTypes.DIRECTION_EAST, DirectionTypes.DIRECTION_SOUTHEAST,
              DirectionTypes.DIRECTION_SOUTHWEST, DirectionTypes.DIRECTION_WEST, DirectionTypes.DIRECTION_NORTHWEST}

--Switch Xingu Workers & Woodsman
function XinguCivilianWoods(playerID, cityID, unitID)
	local pPlayer = Players[playerID];
	if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then
		local pCity = pPlayer:GetCityByID(cityID);
		if pCity:IsHasBuilding(bHouseGarden) then	
			local pUnit = pPlayer:GetUnitByID(unitID)
			if (pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND) and not pUnit:IsCombatUnit() then
				if not (pUnit:IsHasPromotion(pWoodsman)) then
					pUnit:SetHasPromotion(pWoodsman,true);
				end			
			end
		end
	end
end

function XinguWorkerSwitch(playerID, cityID, unitID)
	local pPlayer = Players[playerID];
	if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then
		local pUnit = pPlayer:GetUnitByID(unitID)
		if (pUnit:GetUnitType() == uWorker) then
			if pPlayer:IsHuman() then
				local UnitMoves = pUnit:GetMoves()
				pUnit:SetMoves(0);
				local newUnit = pPlayer:InitUnit(uXinguWorker, pUnit:GetX(), pUnit:GetY(), UNITAI_WORKER)
				newUnit:Convert(pUnit);
				newUnit:SetMoves(0);
				newUnit:SetMoves(UnitMoves);
			elseif not pPlayer:IsHuman() then
				local UnitMoves = pUnit:GetMoves()
				pUnit:SetMoves(0);
				local newUnit = pPlayer:InitUnit(uXinguWorkerAI, pUnit:GetX(), pUnit:GetY(), UNITAI_WORKER)
				newUnit:Convert(pUnit);
				newUnit:SetMoves(0);
				newUnit:SetMoves(UnitMoves);
			end
		end
	end
end
GameEvents.CityTrained.Add(XinguCivilianWoods)
--GameEvents.CityTrained.Add(XinguWorkerSwitch)

function XinguTurnCivilianWoods(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then	
			local iCurrentTurn = Game.GetGameTurn()
			for pUnit in pPlayer:Units() do
				if (pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND) and not pUnit:IsCombatUnit() then
					if pUnit:GetGameTurnCreated() == iCurrentTurn then
						local pPlot = pUnit:GetPlot();
						if pPlot:IsCity() then
							local pCity = pPlot:GetPlotCity();
							if pCity:IsHasBuilding(bHouseGarden) then	
								if not (pUnit:IsHasPromotion(pWoodsman)) then
									pUnit:SetHasPromotion(pWoodsman,true);
								end	
							end
						elseif not pPlot:IsCity() then
							for loop, direction in ipairs(directions) do
								local adjPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction);
								if adjPlot:IsCity() then
									local adjCity = adjPlot:GetPlotCity();
									if adjCity:IsHasBuilding(bHouseGarden) then	
										if not (pUnit:IsHasPromotion(pWoodsman)) then
											pUnit:SetHasPromotion(pWoodsman,true);
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

function XinguTurnWorkerSwitch(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then			
			for pUnit in pPlayer:Units() do
				if (pUnit:GetUnitType() == uWorker) then
					if pPlayer:IsHuman() then
						local UnitMoves = pUnit:GetMoves()
						pUnit:SetMoves(0);
						local newUnit = pPlayer:InitUnit(uXinguWorker, pUnit:GetX(), pUnit:GetY(), UNITAI_WORKER)
						newUnit:Convert(pUnit);
						newUnit:SetMoves(0);
						newUnit:SetMoves(UnitMoves);
					elseif not pPlayer:IsHuman() then
						local UnitMoves = pUnit:GetMoves()
						pUnit:SetMoves(0);
						local newUnit = pPlayer:InitUnit(uXinguWorkerAI, pUnit:GetX(), pUnit:GetY(), UNITAI_WORKER)
						newUnit:Convert(pUnit);
						newUnit:SetMoves(0);
						newUnit:SetMoves(UnitMoves);
					end
				end
			end
		elseif (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_XINGU_MOD) then	
			for pUnit in pPlayer:Units() do
				if (pUnit:GetUnitType() == uXinguWorker) or (pUnit:GetUnitType() == uXinguWorkerAI) then
					local UnitMoves = pUnit:GetMoves()
					pUnit:SetMoves(0);
					local newUnit = pPlayer:InitUnit(uWorker, pUnit:GetX(), pUnit:GetY(), UNITAI_WORKER)
					newUnit:Convert(pUnit);
					newUnit:SetMoves(0);
					newUnit:SetMoves(UnitMoves);
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(XinguTurnCivilianWoods)
GameEvents.PlayerDoTurn.Add(XinguTurnWorkerSwitch)

--AI
local iTechIron = GameInfo.Technologies["TECH_IRON_WORKING"].ID
local iTechSteel = GameInfo.Technologies["TECH_STEEL"].ID
local iTechGuns = GameInfo.Technologies["TECH_GUNPOWDER"].ID
local iTechRifles = GameInfo.Technologies["TECH_RIFLING"].ID
--local iTechReplace = GameInfo.Technologies["TECH_REPLACEABLE_PARTS"].ID

local uHukaAI = GameInfo.Units.UNIT_XINGU_MOD.ID ;

function XinguAIWarrior(iTeam)
	local gPlayer = 0;
	local pTeam = 999;
	for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local pPlayer = Players[iPlayer]
		if (pPlayer:IsAlive()) then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then
				gPlayer = pPlayer;
				pTeam = pPlayer:GetTeam();
			end
		end
	end
	if gPlayer ~= 0 then
		if pTeam == iTeam then
			if not (gPlayer:IsHuman()) then			
				local gcCity = gPlayer:GetCapitalCity();
				pUnit = gPlayer:InitUnit(uHukaAI, gcCity:GetX(), gcCity:GetY(), UNITAI_ATTACK);
				pUnit:JumpToNearestValidPlot()
			end
		end
	end
end

function XinguAIKing(iTeam)
	local gPlayer = 0;
	local pTeam = 999;
	for iPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local pPlayer = Players[iPlayer]
		if (pPlayer:IsAlive()) then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then
				gPlayer = pPlayer;
				pTeam = pPlayer:GetTeam();
			end
		end
	end
	if gPlayer ~= 0 then
		if pTeam == iTeam then
			if not (gPlayer:IsHuman()) then			
				local gcCity = gPlayer:GetCapitalCity();
				if (gcCity:GetWeLoveTheKingDayCounter() >= 1) then
					gcCity:ChangeWeLoveTheKingDayCounter(10)
				elseif (gcCity:GetWeLoveTheKingDayCounter() <= 0) then
					gcCity:SetWeLoveTheKingDayCounter(10)
				end
			end
		end
	end
end

GameEvents.TeamSetHasTech.Add(
function(iTeam, iTech, bAdopted) 

	if (iTech == iTechIron) then
		XinguAIWarrior(iTeam)
		XinguAIKing(iTeam)
	end
	if (iTech == iTechSteel) then
		XinguAIWarrior(iTeam)
	end
	if (iTech == iTechGuns) then
		XinguAIWarrior(iTeam)
		XinguAIKing(iTeam)
	end
	if (iTech == iTechRifles) then
		XinguAIWarrior(iTeam)
	end
	--if (iTech == iTechReplace) then
	--	XinguAIWarrior(iTeam)
	--end

end)

--ExCE
function XinguExCEBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	if isExCE then
		local pExCE = GameInfoTypes.PROMOTION_JFD_JUNGLE_IMMUNITY;
		if (pPlayer:IsAlive()) then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then			
				for pUnit in pPlayer:Units() do
					if (pUnit:GetUnitType() == uWorker) or (pUnit:GetUnitType() == uXinguWorker) or (pUnit:GetUnitType() == uXinguWorkerAI) then
						if not (pUnit:IsHasPromotion(pExCE)) then
							pUnit:SetHasPromotion(pExCE,true);
						end	
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(XinguExCEBonus)

--CiD
local isCiD = false
local CiDID = "10e9728f-d61c-4317-be4f-7d52d6bae6f4"

for _, mod in pairs(Modding.GetActivatedMods()) do
	if (mod.ID == CiDID) then
		isCiD = true
		break
	end
end

function XinguCiDBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	if isCiD then
		local uWorker2 = GameInfoTypes.UNIT_JFD_WORKER;
		local uXinguWorker2 = GameInfoTypes.UNIT_JFD_WORKER_XINGU;
		if (pPlayer:IsAlive()) then
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then					
				for pUnit in pPlayer:Units() do
					if (pUnit:GetUnitType() == uWorker2) then
						local UnitMoves = pUnit:GetMoves()
						pUnit:SetMoves(0);
						local newUnit = pPlayer:InitUnit(uXinguWorker2, pUnit:GetX(), pUnit:GetY(), UNITAI_WORKER)
						newUnit:Convert(pUnit);
						newUnit:SetMoves(0);
						newUnit:SetMoves(UnitMoves);
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(XinguCiDBonus)

-- Extra
local tJungle = GameInfoTypes.FEATURE_JUNGLE;
local tForest = GameInfoTypes.FEATURE_FOREST;
local tGrass = GameInfoTypes.TERRAIN_GRASS;
local tPlains = GameInfoTypes.TERRAIN_PLAINS;
local tMining = GameInfoTypes.TECH_MINING;
local tCalender = GameInfoTypes.TECH_CALENDAR;
local tOptics= GameInfoTypes.TECH_OPTICS;
local iFarm = GameInfoTypes.IMPROVEMENT_FARM;
local iMine = GameInfoTypes.IMPROVEMENT_MINE;
local iPlantation = GameInfoTypes.IMPROVEMENT_PLANTATION;

local uClassKWorker = GameInfoTypes.UNITCLASS_XINGU_WORKER;
local uClassKWorkerAI = GameInfoTypes.UNITCLASS_XINGU_AI_WORKER;

function KGetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end

local tMineResources = {}
local tPlantResources = {}
for tRow in GameInfo.Improvement_ResourceTypes() do
	if (tRow.ImprovementType == "IMPROVEMENT_MINE") then
		tMineResources[GameInfoTypes[tRow.ResourceType]] = {}
	end
	if (tRow.ImprovementType == "IMPROVEMENT_PLANTATION") then
		tPlantResources[GameInfoTypes[tRow.ResourceType]] = {}
	end
end

local speed = Game.GetGameSpeedType();
local chance = 20;
if speed == GameInfo.GameSpeeds['GAMESPEED_QUICK'].ID then
	chance = 15;
elseif speed == GameInfo.GameSpeeds['GAMESPEED_STANDARD'].ID then
	chance = 20;
elseif speed == GameInfo.GameSpeeds['GAMESPEED_EPIC'].ID then
	chance = 25;
elseif speed == GameInfo.GameSpeeds['GAMESPEED_MARATHON'].ID then
	chance = 40;
else
	chance = 40;
end

function XinguBuildAI(pPlayer)
	if (pPlayer:GetNumCities() >= 1) then
		local Random = KGetRandom(1, chance)
		if Random == chance then
			local pID = pPlayer:GetID()
			local pTeam = pPlayer:GetTeam();
			if (pPlayer:GetUnitClassCount(uClassKWorker) >= 1) or (pPlayer:GetUnitClassCount(uClassKWorkerAI) >= 1) then
				local TurnLimit = 1;
				for pCity in pPlayer:Cities() do
					local pCityPlot = pCity:Plot()
					local plotX = pCityPlot:GetX();
					local plotY = pCityPlot:GetY();
					local iRange = 3;
					for iDX = -iRange, iRange do
						for iDY = -iRange, iRange do
							local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
							if pTargetPlot then
								if TurnLimit == 1 then
									if pTargetPlot:GetOwner() == pID then
										if not pTargetPlot:IsUnit() and not pTargetPlot:IsCity() and not pTargetPlot:IsMountain() and not pTargetPlot:IsImpassable() and not pTargetPlot:IsWater() then
											if (pTargetPlot:GetImprovementType() == -1) then
												if (pTargetPlot:GetFeatureType() == tJungle) or (pTargetPlot:GetFeatureType() == tForest) then
													local plotFeature = pTargetPlot:GetFeatureType();
													if (pTargetPlot:GetResourceType() == -1) then
														if isExCE and not (Teams[pTeam]:IsHasTech(tOptics)) then
															if (pTargetPlot:IsHills()) then 
																if (Teams[pTeam]:IsHasTech(tMining)) then
																	pTargetPlot:SetImprovementType(iMine);
																	pTargetPlot:SetFeatureType(-1);
																	pTargetPlot:SetFeatureType(plotFeature);
																	TurnLimit = TurnLimit - 1;
																end
															elseif not (pTargetPlot:IsHills()) then 
																if (pTargetPlot:GetTerrainType() == tGrass) or (pTargetPlot:GetTerrainType() == tPlains) then
																	pTargetPlot:SetImprovementType(iFarm);
																	pTargetPlot:SetFeatureType(-1);
																	pTargetPlot:SetFeatureType(plotFeature);
																	TurnLimit = TurnLimit - 1;
																end
															end
														end
													elseif (pTargetPlot:GetResourceType() ~= -1) then
														local plotResource = pTargetPlot:GetResourceType();
														local rReq = GameInfo.Resources[plotResource].TechCityTrade;
														local rReqID = GameInfo.Technologies["" .. rReq .. ""].ID;
														if (Teams[pTeam]:IsHasTech(rReqID)) then
															for iResource, tTable in pairs(tMineResources) do
																if iResource == plotResource then
																	pTargetPlot:SetImprovementType(iMine);
																	pTargetPlot:SetFeatureType(-1);
																	pTargetPlot:SetFeatureType(plotFeature);
																	TurnLimit = TurnLimit - 1;
																	break;
																end
															end
															for iResource, tTable in pairs(tPlantResources) do
																if iResource == plotResource then
																	pTargetPlot:SetImprovementType(iPlantation);
																	pTargetPlot:SetFeatureType(-1);
																	pTargetPlot:SetFeatureType(plotFeature);
																	TurnLimit = TurnLimit - 1;
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
				end
			end
		end
	end
end

function XinguBuildAITurn(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if not (pPlayer:IsHuman()) then	
			if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then	
				XinguBuildAI(pPlayer)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(XinguBuildAITurn)
