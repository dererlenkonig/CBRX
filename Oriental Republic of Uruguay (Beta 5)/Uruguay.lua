-- Lua Script1
-- Author: Technostar
-- DateCreated: 3/24/2018 5:54:46 PM
--------------------------------------------------------------

-- Save functions brought to you by Sukritact's Save Utils.

--include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "OrientalUruguay";
--include( "Sukritact_ChangeResearchProgress.lua" ); MY_MOD_NAME = "OrientalUruguay";
local MY_MOD_NAME = "OrientalUruguay";

-- I was having difficulty getting SaveUtils to work, so I threw the code right in here.

--=======================================================================================================================
-- Sukritact_SaveUtils
-- Modified from NewSaveUtils.lua
--=======================================================================================================================

print("Uruguay Beta 5 loading");

gbLogSaveData = false;

-- Connection to the Modding save data.  Keep one global connection, rather than opening/closing, to speed up access
g_SaveData = Modding.OpenSaveData();
g_Properties = nil;
-------------------------------------------------------------- 
-- Access the modding database entries through a locally cached table
function GetPersistentProperty(name)
	if(g_Properties == nil) then
		g_Properties = {};
	end
	
	if(g_Properties[name] == nil) then
		g_Properties[name] = g_SaveData.GetValue(name);
	end
	
	return g_Properties[name];
end
print("Loaded method 1");
--------------------------------------------------------------
-- Access the modding database entries through a locally cached table
function SetPersistentProperty(name, value)
	if(g_Properties == nil) then
		g_Properties = {};
	end
	
	if (g_Properties[name] ~= value) then
		g_SaveData.SetValue(name, value);
		g_Properties[name] = value;
	end
end
print("Loaded method 2");
--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
function InitializeInstances()
	--print(Player)
	--print(Player)
	--print(Team)
	--print(Team)
	--print(Plot)
	local pPlot = Map.GetPlotByIndex(0)
	--print(Plot)
	--print(Unit)
	local pPlayer = Players[0]
	for pUnit in pPlayer:Units() do
		break
	end
	--print(Unit)
end
InitializeInstances()
print("Loaded method 3");

function CompileUnitID(pUnit)
	local iOwner = pUnit:GetOwner()
	local iUnit = pUnit:GetID()
	local iTurn = pUnit:GetGameTurnCreated()
    return(iOwner .. "_ID" .. iUnit .. "_T" .. iTurn)
end

function CompilePlotID(pPlot)
    local iX = pPlot:GetX()
    local iY = pPlot:GetY()
    return(iX .. "_Y" .. iY)
end
print("Loaded method 4");
--=======================================================================================================================
-- Save/Load Functions
--=======================================================================================================================
function save(pObject, sKey, Val)
	
	--Booleans must be converted to strings
	if Val == true then
		Val = "bTrue"
	elseif Val == false then
		Val = "bFalse"
	end
	
	local sTrueKey = nil
	--if pObject == "GAME" or variants save without other ID
	if (type(pObject) == "string") then
		if string.upper(pObject) == "GAME" then
			sTrueKey = (MY_MOD_NAME .. "_" .. sKey)
		else
			--print("Error on Save: Invalid type")
			return
		end
	--Else ensure pObject is an Object
	elseif (pObject == nil or type(pObject) ~= "table") then
		--print("Error on Save: Invalid type")
		return
	end
	
	--Player
	if (getmetatable(pObject).__index == Player) then
		sTrueKey = (MY_MOD_NAME .. "_Player" .. pObject:GetID() .. "_" .. sKey)
	--Team
	elseif (getmetatable(pObject).__index == Team) then
		sTrueKey = (MY_MOD_NAME .. "_Team" .. pObject:GetID() .. "_" .. sKey)
	--Unit
	elseif (getmetatable(pObject).__index == Unit) then
		sTrueKey = (MY_MOD_NAME .. "_Unit".. CompileUnitID(pObject) .. "_" .. sKey)
	--Plot
	elseif (getmetatable(pObject).__index == Plot) then
		sTrueKey = (MY_MOD_NAME .. "_Plot".. CompilePlotID(pObject) .. "_" .. sKey)
	end
	
	--Save Data
	if	sTrueKey ~= nil then
		--print("Save", sTrueKey, Val)
		SetPersistentProperty(sTrueKey, Val)
	else
		--print("Error on Save: Key Creation Failed")
	end
end
print("Loaded method 5");
function Load_Booleanfy(Val)
	--Booleans must be converted from strings
	if Val == "bTrue" then
		Val = true
	elseif Val == "bFalse" then
		Val = false
	end
	return Val
end
print("Loaded method 6");
function load(pObject, sKey)
	
	local sTrueKey = nil
	--if pObject == "GAME" or variants save without other ID
	if (type(pObject) == "string") then
		if string.upper(pObject) == "GAME" then
			sTrueKey = (MY_MOD_NAME .. "_" .. sKey)
		else
			--print("Error on Load: Invalid type")
			return
		end
	--Else ensure pObject is an Object
	elseif (pObject == nil or type(pObject) ~= "table") then
		--print("Error on Load: Invalid type")
		return
	end
	
	--Player
	if (getmetatable(pObject).__index == Player) then
		sTrueKey = (MY_MOD_NAME .. "_Player" .. pObject:GetID() .. "_" .. sKey)
	--Team
	elseif (getmetatable(pObject).__index == Team) then
		sTrueKey = (MY_MOD_NAME .. "_Team" .. pObject:GetID() .. "_" .. sKey)
	--Unit
	elseif (getmetatable(pObject).__index == Unit) then
		sTrueKey = (MY_MOD_NAME .. "_Unit".. CompileUnitID(pObject) .. "_" .. sKey)
	--Plot
	elseif (getmetatable(pObject).__index == Plot) then
		sTrueKey = (MY_MOD_NAME .. "_Plot".. CompilePlotID(pObject) .. "_" .. sKey)
	end
	
	--Load Data
	if	sTrueKey ~= nil then
		Val = Load_Booleanfy(GetPersistentProperty(sTrueKey))
		--print("Load", sTrueKey, Val)
		return Val
	else
		--print("Error on Load: Key Creation Failed")
	end
end
print("Loaded method 7");

-- Sukritact_ChangeResearchProgress
-- Author: Sukritact
if not MapModData.Sukritact_ChangeResearchProgress then
	--=======================================================================================================================
	-- Prevent Duplicates
	--=======================================================================================================================
	--if MapModData.Sukritact_ChangeResearchProgress then return end
	MapModData.Sukritact_ChangeResearchProgress = true
	--Events.SequenceGameInitComplete.Add(function() MapModData.Sukritact_ChangeResearchProgress = nil end)
	--=======================================================================================================================

	print("loaded")
	include( "Sukritact_SaveUtils.lua" ); MY_MOD_NAME = "Sukritact_ChangeResearchProgress";

	--=======================================================================================================================
	-- Sukritact_ChangeResearchProgress Pseudo-function
	--=======================================================================================================================
	function ChangeResearchProgress (iPlayer, iDelta)
		local pPlayer = Players[iPlayer]
	
		local iStored = load(pPlayer, "iStored")
		if iStored == nil then iStored = 0 end
	
		save(pPlayer, "iStored", iStored + iDelta)
		ScienceManager(iPlayer)
	end

	LuaEvents.Sukritact_ChangeResearchProgress.Add(ChangeResearchProgress)
	--=======================================================================================================================
	-- Science Manager
	--=======================================================================================================================

	function ScienceManager(iPlayer)
		local pPlayer = Players[iPlayer]
		local iStored = load(pPlayer, "iStored")
		if iStored == nil or iStored == 0 then return end
	
		local iTech = pPlayer:GetCurrentResearch()
	
		if iTech == -1 then return end
	
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		if pTeamTechs:HasTech(iTech) then return end
		local iCanBeAdded = pPlayer:GetResearchCost(iTech) - pPlayer:GetResearchProgress(iTech)
	
		if iStored > iCanBeAdded then
			pTeamTechs:ChangeResearchProgress(iTech, iCanBeAdded, pPlayer:GetID())
			save(pPlayer, "iStored", iStored - iCanBeAdded)
			print("Added: " .. iCanBeAdded .. ", Remaining: " .. iStored - iCanBeAdded)
		else
			pTeamTechs:ChangeResearchProgress(iTech, iStored, pPlayer:GetID())
			save(pPlayer, "iStored", 0)
			print("Added: " .. iStored .. ", Remaining: " .. 0)
		end
	end

	function ScienceManagerTrigger()
		local iPlayer = Game.GetActivePlayer()
		local pPlayer = Players[iPlayer]
		if pPlayer:IsTurnActive() then
			ScienceManager(iPlayer)
		end
	end

	GameEvents.PlayerDoTurn.Add(ScienceManager)
	Events.SerialEventResearchDirty.Add(ScienceManagerTrigger)
end
--Uruguay_LoadResearch();
--=======================================================================================================================


-- Now onto my stuff


-- Los Orientales
local plotDirectionTypes = {};
plotDirectionTypes[0] = DirectionTypes.DIRECTION_SOUTHEAST;
plotDirectionTypes[1] = DirectionTypes.DIRECTION_SOUTHWEST;
plotDirectionTypes[2] = DirectionTypes.DIRECTION_WEST;
plotDirectionTypes[3] = DirectionTypes.DIRECTION_NORTHWEST;
plotDirectionTypes[4] = DirectionTypes.DIRECTION_NORTHEAST;
plotDirectionTypes[5] = DirectionTypes.DIRECTION_EAST;



-- Will do fFunction(pPlot) to all plots surrounding pPlot between iStartingRadius and iEndingRadius
--[[function PlotSpiralIterator(fFunction, pPlot, iStartingRadius, iEndingRadius) 
	plotDirectionTypes[0] = DirectionTypes.DIRECTION_SOUTHEAST;
	plotDirectionTypes[1] = DirectionTypes.DIRECTION_SOUTHWEST;
	plotDirectionTypes[2] = DirectionTypes.DIRECTION_WEST;
	plotDirectionTypes[3] = DirectionTypes.DIRECTION_NORTHWEST;
	plotDirectionTypes[4] = DirectionTypes.DIRECTION_NORTHEAST;
	plotDirectionTypes[5] = DirectionTypes.DIRECTION_EAST;
	if pPlot ~= nil then
		local pTempPlot = pPlot;
		for i = 1, iStartingRadius do
			pTempPlot = Map.PlotDirection(pTempPlot:GetX(), pTempPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
		end
		for i = iStartingRadius, iEndingRadius do 
			pIteratorPlot = pTempPlot;

			for j = 0, 5 do
				for k = 1, i do

					local pTargetPlot = Map.PlotDirection(pIteratorPlot:GetX(), pIteratorPlot:GetY(), plotDirectionTypes[j]);
					pIteratorPlot = pTargetPlot;
					print("Checking plot at " .. pTargetPlot:GetX() .. ", " .. pTargetPlot:GetY());
					fFunction(pTargetPlot);
				end
			end

			pTempPlot = Map.PlotDirection(pTempPlot:GetX(), pTempPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
		end
	end
end]]


-- Apply Orientales bonus to all valid units
local iOrientalesPromotion = GameInfoTypes.PROMOTION_ORIENTALES;
local iOrientalesPromotionCheck = GameInfoTypes.PROMOTION_ORIENTALES_BASE;

--Function that should not break near map edges
function CheckIsValidCityInLine(iPlayer, pPlot, iLeft, iRight)
	local pPlayer = Players[iPlayer];
	local pCheckPlot = pPlot;
	local bIsValidCity = false;
	if pCheckPlot ~= nil then
		local pCity = pCheckPlot:GetPlotCity();
		if pCheckPlot:IsCity() then
			--print("Found city");
			if pCity:GetOwner() ~= iPlayer and (pCity:GetPreviousOwner() == iPlayer or pCity:GetOriginalOwner() == iPlayer) then
				--print("City was formerly owned by unit owner");
				return true;
			end
		end
	end
	for i = 1, iLeft do
		if pCheckPlot ~= nil then
			pCheckPlot = Map.PlotDirection(pCheckPlot:GetX(), pCheckPlot:GetY(), DirectionTypes.DIRECTION_WEST);
			if pCheckPlot ~= nil then
				local pCity = pCheckPlot:GetPlotCity();
				if pCheckPlot:IsCity() then
					--print("Found city");
					if pCity:GetOwner() ~= iPlayer and (pCity:GetPreviousOwner() == iPlayer or pCity:GetOriginalOwner() == iPlayer) then
						--print("City was formerly owned by unit owner");
						return true;
					end
				end
			end
		end
	end
	pCheckPlot = pPlot;
	for i = 1, iRight do
		if pCheckPlot ~= nil then
			pCheckPlot = Map.PlotDirection(pCheckPlot:GetX(), pCheckPlot:GetY(), DirectionTypes.DIRECTION_EAST);
			if pCheckPlot ~= nil then
				local pCity = pCheckPlot:GetPlotCity();
				if pCheckPlot:IsCity() then
					--print("Found city");
					if pCity:GetOwner() ~= iPlayer and (pCity:GetPreviousOwner() == iPlayer or pCity:GetOriginalOwner() == iPlayer) then
						--print("City was formerly owned by unit owner");
						return true;
					end
				end
			end
		end
	end
	return false;
end


function OrientalesBonus(iPlayer, iUnit, iX, iY)
	local pPlayer = Players[iPlayer];
	local pUnit = pPlayer:GetUnitByID(iUnit);
	if pUnit ~= nil and pUnit:IsHasPromotion(iOrientalesPromotionCheck) then
		local pPlot = Map.GetPlot(iX, iY);
		local bApplyPromotion = false;
		--local iStartingRadius = 1;
		--local iEndingRadius = 3;

		if pPlot ~= nil then
			if CheckIsValidCityInLine(iPlayer, pPlot, 3, 3) then
				bApplyPromotion = true;
			end
			local pNWPlot = pPlot;
			local pNEPlot = pPlot;
			local pSEPlot = pPlot;
			local pSWPlot = pPlot;
			for k = 1, 3 do
				if k % 2 == 0 then
					if pNWPlot ~= nil then
						pNWPlot = Map.PlotDirection(pNWPlot:GetX(), pNWPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					end
					if pNEPlot ~= nil then
						pNEPlot = Map.PlotDirection(pNEPlot:GetX(), pNEPlot:GetY(), DirectionTypes.DIRECTION_NORTHWEST);
					end
					if pSWPlot ~= nil then
						pSWPlot = Map.PlotDirection(pSWPlot:GetX(), pSWPlot:GetY(), DirectionTypes.DIRECTION_SOUTHEAST);
					end
					if pSEPlot ~= nil then
						pSEPlot = Map.PlotDirection(pSEPlot:GetX(), pSEPlot:GetY(), DirectionTypes.DIRECTION_SOUTHWEST);
					end
				else
					if pNWPlot ~= nil then
						pNWPlot = Map.PlotDirection(pNWPlot:GetX(), pNWPlot:GetY(), DirectionTypes.DIRECTION_NORTHWEST);
					end
					if pNEPlot ~= nil then
						pNEPlot = Map.PlotDirection(pNEPlot:GetX(), pNEPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
					end
					if pSWPlot ~= nil then
						pSWPlot = Map.PlotDirection(pSWPlot:GetX(), pSWPlot:GetY(), DirectionTypes.DIRECTION_SOUTHWEST);
					end
					if pSEPlot ~= nil then
						pSEPlot = Map.PlotDirection(pSEPlot:GetX(), pSEPlot:GetY(), DirectionTypes.DIRECTION_SOUTHEAST);
					end
				end
				if pNWPlot ~= nil then
					if k % 2 == 0 then
						if CheckIsValidCityInLine(iPlayer, pNWPlot, 3 - (k / 2), 3 - (k / 2)) then
							bApplyPromotion = true;
						end
					else
						if CheckIsValidCityInLine(iPlayer, pNWPlot, 2 - ((k - 1) / 2), 3 - ((k - 1) / 2)) then
							bApplyPromotion = true;
						end
					end
				end
				if pNEPlot ~= nil then
					if k % 2 == 0 then
						if CheckIsValidCityInLine(iPlayer, pNEPlot, 3 - (k / 2), 3 - (k / 2)) then
							bApplyPromotion = true;
						end
					else
						if CheckIsValidCityInLine(iPlayer, pNEPlot, 3 - ((k - 1) / 2), 2 - ((k - 1) / 2)) then
							bApplyPromotion = true;
						end
					end
				end
				if pSWPlot ~= nil then
					if k % 2 == 0 then
						if CheckIsValidCityInLine(iPlayer, pSWPlot, 3 - (k / 2), 3 - (k / 2)) then
							bApplyPromotion = true;
						end
					else
						if CheckIsValidCityInLine(iPlayer, pSWPlot, 2 - ((k - 1) / 2), 3 - ((k - 1) / 2)) then
							bApplyPromotion = true;
						end
					end
				end
				if pSEPlot ~= nil then
					if k % 2 == 0 then
						if CheckIsValidCityInLine(iPlayer, pSEPlot, 3 - (k / 2), 3 - (k / 2)) then
							bApplyPromotion = true;
						end
					else
						if CheckIsValidCityInLine(iPlayer, pSEPlot, 3 - ((k - 1) / 2), 2 - ((k - 1) / 2)) then
							bApplyPromotion = true;
						end
					end
				end
			end


		end
		
		--Causes error when near map edge, reworking. 
		--[[if pPlot ~= nil then
			local pTempPlot = pPlot;
			for i = 1, iStartingRadius do
				pTempPlot = Map.PlotDirection(pTempPlot:GetX(), pTempPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
			end
			for i = iStartingRadius, iEndingRadius do 
				pIteratorPlot = pTempPlot;

				for j = 0, 5 do
					for k = 1, i do
						local pTargetPlot = Map.PlotDirection(pIteratorPlot:GetX(), pIteratorPlot:GetY(), plotDirectionTypes[j]);
						if pTargetPlot ~= nil then
							pIteratorPlot = pTargetPlot;
							--print("Checking plot at " .. pTargetPlot:GetX() .. ", " .. pTargetPlot:GetY());

							local pCity = pTargetPlot:GetPlotCity();
							if pTargetPlot:IsCity() then
								--print("Found city");
								if pCity:GetOwner() ~= iPlayer and (pCity:GetPreviousOwner() == iPlayer or pCity:GetOriginalOwner() == iPlayer) then
									--print("City was formerly owned by unit owner");
									bApplyPromotion = true;
								end
							end
						end
						--fFunction(pTargetPlot);
					end
				end

				pTempPlot = Map.PlotDirection(pTempPlot:GetX(), pTempPlot:GetY(), DirectionTypes.DIRECTION_NORTHEAST);
			end
		end]]
		--[[PlotSpiralIterator(
		function(pCheckPlot)
			local pCity = pCheckPlot:GetPlotCity();
			if pCity ~= nil then
				print("Found city");
				if pCity:GetOwner() ~= iPlayer and (pCity:GetPreviousOwner() == iPlayer or pCity:GetOriginalOwner() == iPlayer) then
					print("City was formerly owned by 
					bApplyPromotion = true;
				end
			end
		end,
		pPlot, 1, 3);]]
		if bApplyPromotion then
			--print("adding orientales bonus");
			if not pUnit:IsHasPromotion(iOrientalesPromotion) then
				pUnit:SetHasPromotion(iOrientalesPromotion, true);
			end
		else
			--print("removing orientales bonus");
			if pUnit:IsHasPromotion(iOrientalesPromotion) then
				pUnit:SetHasPromotion(iOrientalesPromotion, false);
			end
		end
	end
end


GameEvents.UnitSetXY.Add(OrientalesBonus);

--Recheck Orientales bonus on city capture
function OrientalesCityCapture(oldOwnerID, capital, x, y, newOwnerID)
	--print("City capture detected at " .. x .. ", " .. y);
	local pPlot = Map.GetPlot(x, y);
	local pCity = pPlot:GetPlotCity();
	for i = 0, 36 do
		local pTilePlot = pCity:GetCityIndexPlot(i);
		--print("Checking plot for unit at " .. pTilePlot:GetX() .. ", ".. pTilePlot:GetY());
		if pTilePlot ~= nil then
			for j = 0, 5 do
				local pUnit = pTilePlot:GetUnit(j);
				if pUnit ~= nil and pUnit:IsHasPromotion(iOrientalesPromotionCheck) then
					--print("Checking unit at " .. pTilePlot:GetX() .. ", ".. pTilePlot:GetY());
					local iPlayer = pUnit:GetOwner();
					local bApplyPromotion = false;
					if pCity:GetOwner() ~= iPlayer and (pCity:GetPreviousOwner() == iPlayer or pCity:GetOriginalOwner() == iPlayer) then
						--print("City was formerly owned by unit owner");
						bApplyPromotion = true;
					end
					if bApplyPromotion then
						--print("adding orientales bonus");
						if not pUnit:IsHasPromotion(iOrientalesPromotion) then
							pUnit:SetHasPromotion(iOrientalesPromotion, true);
						end
					else
						--print("removing orientales bonus");
						if pUnit:IsHasPromotion(iOrientalesPromotion) then
							pUnit:SetHasPromotion(iOrientalesPromotion, false);
						end
					end
				end
			end
		end
	end
end
GameEvents.CityCaptureComplete.Add(OrientalesCityCapture);



-- Los Cascos Azules
local iCascosUnit = GameInfoTypes.UNIT_URUGUAY_CASCOS_AZULES;
local iBuildingCascos = GameInfoTypes.BUILDING_URUGUAY_CASCOS_BONUS;
local iUruguayCiv = GameInfoTypes.CIVILIZATION_URUGUAY;

function CascosProduction(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iUruguayCiv then
		--print("Checking Uruguay cascos");
		local iForeignUnits = 0;
		for pUnit in pPlayer:Units() do
			local pPlot = pUnit:GetPlot();
			if pPlot ~= nil then
				local iOwner = pPlot:GetOwner();
			
				if iPlayer ~= iOwner and iOwner ~= -1 then
					local pOwner = Players[iOwner];
					local pTeam = Teams[pPlayer:GetTeam()];
					local pOwnerTeam = Teams[pOwner:GetTeam()];
					--print("Checking war between " .. pPlayer:GetTeam() .. " and " .. pOwner:GetTeam());
					local bWar = pTeam:IsAtWar(pOwner:GetTeam());
					--print(bWar);
					if not bWar then
						iForeignUnits = iForeignUnits + 1;
					
					end
				end
			end
		end

		--print(iForeignUnits .. " foreign units detected");

		if iForeignUnits > 40 then
			iForeignUnits = 40;
		end

		for pCity in pPlayer:Cities() do
			local iUnitProduction = pCity:GetProductionUnit();
			if iUnitProduction == iCascosUnit then
				--print("Cascos detected; granting bonus production");
				pCity:SetNumRealBuilding(iBuildingCascos, iForeignUnits);
			else
				pCity:SetNumRealBuilding(iBuildingCascos, 0);
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(CascosProduction);
GameEvents.UnitSetXY.Add(function(iPlayer) 
	local pPlayer = Players[iPlayer];
	--ONLY URUGUAY HUMAN
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iUruguayCiv and pPlayer:IsHuman() then
		--print("Human move detected");
		CascosProduction(iPlayer);
	end
end);

-- Treinta y Tres
local sThingToProduce = "ThingToProduce";
local sTimer = "Timer";
local sParty = "Party";
local iBuildingBlancosBonus = GameInfoTypes.BUILDING_URUGUAY_BLANCOS_BONUS;
local iBuildingFarmBonus = GameInfoTypes.BUILDING_URUGUAY_FARM_BONUS;
local iBuildingColoradosCulture = GameInfoTypes.BUILDING_URUGUAY_COLORADOS_BONUS_CULTURE;
local iBuildingColoradosPolicies = GameInfoTypes.BUILDING_URUGUAY_COLORADOS_BONUS_POLICIES;
local vSpeed = {};
vSpeed[0] = 90;
vSpeed[1] = 45;
vSpeed[2] = 30;
vSpeed[3] = 20;



--Iterate turn
function PartiesProcessTurn(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iUruguayCiv then
		local iTimer = load(pPlayer, sTimer);
		if iTimer == nil then 
			iTimer = 0;
		end
		local iParty = load(pPlayer, sParty);
		if iParty == nil then 
			iParty = 0; 
		end
		if iParty == 0 then
			print("B5: Party: Colorados, Turns in power: " .. iTimer);
		else 
			print("B5: Party: Blancos, Turns in power: " .. iTimer);
		end
		iTimer = iTimer + 1;
		local iTurns = 30;
		if Game.GetGameSpeedType() < 4 then 
			iTurns = vSpeed[Game.GetGameSpeedType()];
		end

		if iTimer > iTurns then
			print("Should the parties switch?");
			local iRand = Game.Rand(5, "Should the parties switch?");
			local iThreshold = 1;
			if pPlayer:IsEmpireUnhappy() then 
				iThreshold = 2;
			end
			if pPlayer:IsGoldenAge() then 
				iThreshold = 0; 
			end
			if iRand < iThreshold then
				print("Switching parties");
				if iParty == 0 then
					iParty = 1;
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "After " .. iTimer .. " turns of Colorados rule, the Blancos have gained power.", "Ruling party switches!");
					for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
						local pPlayer = Players[i];
						if i ~= iPlayer then
							pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "After " .. iTimer .. " turns of Colorados rule, the Blancos have gained power in Uruguay.", "Ruling party switches!");
						end
					end
					for pCity in pPlayer:Cities() do
						iCity = pCity:GetID();
						local iThingToProduce = load(pPlayer, sThingToProduce .. iCity);
						if iThingToProduce == nil then 
							iThingToProduce = -1; 
						end

						if iThingToProduce == -1 then 
							iThingToProduce = -2; 
						end
						print("Ordering unit production");
						save(pPlayer, sThingToProduce .. iCity, iThingToProduce);
					end
				else
					iParty = 0;
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "After " .. iTimer .. " turns of Blancos rule, the Colorados have gained power.", "Ruling party switches!");
					for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
						local pPlayer = Players[i];
						if i ~= iPlayer then
							pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, "After " .. iTimer .. " turns of Blancos rule, the Colorados have gained power in Uruguay.", "Ruling party switches!");
						end
					end
				end
				
				iTimer = 0;
			end

		end
		save(pPlayer, sTimer, iTimer);
		save(pPlayer, sParty, iParty);
		
	end

end

GameEvents.PlayerDoTurn.Add(PartiesProcessTurn);

--Apply bonus
function ApplyPartyBonus(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iUruguayCiv then
		local iTimer = load(pPlayer, sTimer);
		if iTimer == nil then 
			iTimer = 0;
		end
		local iParty = load(pPlayer, sParty);
		if iParty == nil then 
			iParty = 0; 
		end

		if iParty == 0 then
			--print("Party: Colorados, Turns in power: " .. iTimer);
		else 
			--print("Party: Blancos, Turns in power: " .. iTimer);
		end

		if iParty == 0 then
			local iEra = pPlayer:GetCurrentEra();
			local pCapital = pPlayer:GetCapitalCity();
			
			if pCapital ~= null then
				iCaptial = pCapital:GetID();
				pCapital:SetNumRealBuilding(iBuildingColoradosPolicies, 1);
				--print("Adding policy building");
				for pCity in pPlayer:Cities() do
				
					--[[if pCity:GetID() == iCapital then
						pCity:SetNumRealBuilding(iBuildingColoradosPolicies, 1);
						print("Adding policy building");
					else
						pCity:SetNumRealBuilding(iBuildingColoradosPolicies, 0);
						print("Removing policy building");
					end]]

					if iEra > 0 then
						pCity:SetNumRealBuilding(iBuildingColoradosCulture, 1);
						--print("Adding culture building");
					else
						pCity:SetNumRealBuilding(iBuildingColoradosCulture, 0);
						--print("Removing culture building");
					end

					pCity:SetNumRealBuilding(iBuildingBlancosBonus, 0);
					pCity:SetNumRealBuilding(iBuildingFarmBonus, 0);
				end
			end


		else
			for pCity in pPlayer:Cities() do
				local iCity = pCity:GetID();

				--print("Adding production building");
				pCity:SetNumRealBuilding(iBuildingBlancosBonus, 1);
				local iFarmCount = 0;
				
				for i = 1, 36 do
					local pTilePlot = pCity:GetCityIndexPlot(i);
					if pTilePlot ~= nil and pTilePlot:GetWorkingCity() ~= nil and pTilePlot:GetWorkingCity():GetID() == iCity then
						--print("Tile worked by city " .. iCity);
						if pTilePlot:IsBeingWorked() and pTilePlot:GetYield(0) > 2 then
							--print("Found farm");
							iFarmCount = iFarmCount + 1;
						end
					end
				end

				--print("Farms: " .. iFarmCount);
				if iFarmCount > 2 then
				
					pCity:SetNumRealBuilding(iBuildingFarmBonus, 1);
				else
					pCity:SetNumRealBuilding(iBuildingFarmBonus, 0);
				end

				pCity:SetNumRealBuilding(iBuildingColoradosCulture, 0);
				pCity:SetNumRealBuilding(iBuildingColoradosPolicies, 0);
			end
		end

	end

end

GameEvents.PlayerDoTurn.Add(ApplyPartyBonus);
GameEvents.PlayerCityFounded.Add(ApplyPartyBonus);
GameEvents.CityCaptureComplete.Add(
function(iPlayer1, iCaptial, x, y, iPlayer2)
	ApplyPartyBonus(iPlayer1);
	ApplyPartyBonus(iPlayer2);
end);


--Grant production and science on adopting policy
local bSpeed = {};
bSpeed[0] = 9;
bSpeed[1] = 4.5;
bSpeed[2] = 3;
bSpeed[3] = 2;

function ColoradosPolicy(iPlayer) 
	local pPlayer = Players[iPlayer];
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iUruguayCiv then
		print("Uruguay adopted policy");
		local iParty = load(pPlayer, sParty);
		if iParty == nil then 
			iParty = 0; 
		end
		if iParty == 0 then
			print("Colorado policy bonus!");
			
			local iTech = pPlayer:GetCurrentResearch();
			local iBonus = 0
			if iTech > 0 then
				 iBonus = pPlayer:GetResearchCost(iTech) / 8;
			else
				local iCheapestTechIndex = -1;
				local iCheapestTechCost = 0;
				for i = 0, Game.GetMaxTech() do
					local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
					if not pTeamTechs:HasTech(i) then
						if (pPlayer:GetResearchCost(i) < iCheapestTechCost and pPlayer:GetResearchCost(i) > 0) or iCheapestTechCost < 0 then
							iCheapestTechCost = pPlayer:GetResearchCost(i);
							iCheapestTechIndex = i;
						end
					end
				end 
				iBonus = iCheapestTechCost / 8;
			end
			print("Adding " .. iBonus .. " Science as bonus");
			LuaEvents.Sukritact_ChangeResearchProgress(iPlayer, iBonus);
		
			local iProductionBonusMultiplier = 3;
			if Game.GetGameSpeedType() < 4 then 
				iProductionBonusMultiplier = bSpeed[Game.GetGameSpeedType()];
			end
			local iBonusProduction = 30;
			if Game.GetGameSpeedType() < 4 then 
				iBonusProduction = vSpeed[Game.GetGameSpeedType()];
			end
			local iEra = pPlayer:GetCurrentEra();

			--iBonusProduction = (iBonusProduction / 2) * (iEra + 1);
			iBonusProduction = (iBonusProduction / 30) * (5 + iEra) * (2 / 3);
			print("Adding " .. iBonusProduction .. " Production as bonus per population");
			for pCity in pPlayer:Cities() do
				--[[local iBonusProduction = pCity:GetProduction() * iProductionBonusMultiplier;
				if iBonusProduction == 0 then
					for i = 0, 36 do
					local pTilePlot = pCity:GetCityIndexPlot(i);
					if pTilePlot:GetWorkingCity() ~= nil and pTilePlot:GetWorkingCity():GetID() == iCity then
						--print("Tile worked by city " .. iCity);
						if pTilePlot:IsBeingWorked() and pTilePlot:GetYield(1) > 0 then
							
							iBonusProduction = iBonusProduction + pTilePlot:GetYield(1);
						end
					end
					iBonusProduction = iBonusProduction * iProductionBonusMultiplier;
				end
				end
				print("Adding " .. iBonusProduction .. " Production as bonus");
				pCity:SetOverflowProduction(pCity:GetOverflowProduction() + iBonusProduction);]]

				local iPop = pCity:GetPopulation();

				
				
				
				pCity:SetOverflowProduction(pCity:GetOverflowProduction() + (iBonusProduction * iPop));
			end
			Events.GameplayAlertMessage("The Colorado party has adopted a new [ICON_CULTURE] Social Policy, earning a bonus of " .. iBonus .. " [ICON_RESEARCH] Science and a [ICON_PRODUCTION] Production bonus in all cities!");
		end
	end
end

GameEvents.PlayerAdoptPolicy.Add(ColoradosPolicy);
GameEvents.PlayerAdoptPolicyBranch.Add(ColoradosPolicy)
print("Loaded more Uruguay");

-- Override civ AI to make better use of abilities

-- Limits AI to a gold stash of 5000 before purchasing relevant stuff until gold stores are once again below 5K.
-- When not over 5K, will attempt to force 3 purchases per party cycle (every 10 turns on standard) if there is enough gold.
local iFrequency = {};
iFrequency[0] = 30;
iFrequency[1] = 15;
iFrequency[2] = 10;
iFrequency[3] = 7;
	-- Construct useful tables of all units
	--print("Constructing reference tables");
	--print("Constructing table 1 ");
	local i1 = 0;
	local unitsIDTable = {};
	local unitsTable = {};
	--print("step 1");
	
	for i = 0, 1000 do
		if GameInfo.Units[i] ~= nil then
			--print("iterating " .. i1);
			unitsIDTable[i1] = GameInfo.Units[i].ID;
			unitsTable[i1] = GameInfo.Units[GameInfo.Units[i].ID];
			i1 = i1 + 1;
		end
	end
	local iUnitsSize = i1;

	--print("Constructing table 2 ");
	-- Construct useful tables of all buildings
	local i2 = 0;
	local BuildingsIDTable = {};
	local BuildingsTable = {};
	for i = 0, 1000 do
		if GameInfo.Buildings[i] ~= nil then
			BuildingsIDTable[i2] = GameInfo.Buildings[i].ID;
			BuildingsTable[i2] = GameInfo.Buildings[GameInfo.Buildings[i].ID];
			i2 = i2 + 1;
		end
	end
	local iBuildingsSize = i2;


function GoldBuyDown(iPlayer, iParty, iGoldThreshold)
	local pPlayer = Players[iPlayer];
	local iInitialGold = pPlayer:GetGold();
	local iGold = iInitialGold;
	print("Buying down");
	

	for pCity in pPlayer:Cities() do
		--print("City");
		local iRand = Game.Rand(6, "What to buy?");
		local iThreshold = 2;
		if iParty == 1 then
			iThreshold = 4;
		end
		if pPlayer:GetCurrentEra() < 2 then
			iThreshold = 6;
		end


		if iRand < iThreshold then
			--print("Attempt to buy unit");
			validUnits = {};
			unitFlavor = {};
			--local iBestUnit = -1;
			local iUnitOptions = 0;
			local i4 = 0;
			for i = 0, iUnitsSize do
				local pUnit = unitsTable[i];
				local iUnit = unitsIDTable[i]
				
				
				if pUnit ~= nil and pCity:IsCanPurchase(true, true, iUnit, -1, -1, YieldTypes.YIELD_GOLD) then
					if (iUnit == GameInfoTypes.UNIT_SETTLER and pPlayer:GetCurrentEra() < 3) or iUnit == iCascosUnit then
						--print(iUnit .. " valid * 5!");
						validUnits[i4] = pUnit;
						i4 = i4 + 1;
						validUnits[i4] = pUnit;
						i4 = i4 + 1;
						validUnits[i4] = pUnit;
						i4 = i4 + 1;
						validUnits[i4] = pUnit;
						i4 = i4 + 1;
						validUnits[i4] = pUnit;
						i4 = i4 + 1;
					elseif iUnit ~= GameInfoTypes.UNIT_SETTLER and iUnit ~= GameInfoTypes.UNIT_WORKER and iUnit ~= GameInfoTypes.UNIT_CARAVAN and iUnit ~= GameInfoTypes.UNIT_CARGO_SHIP and iUnit ~= GameInfoTypes.UNIT_WORKBOAT and pPlayer:GetCurrentEra() >= 2 then
						--print(iUnit .. " valid");
						validUnits[i4] = pUnit;
						i4 = i4 + 1;
					end
				end
				

				
			end
			iUnitOptions = i4;
			if iUnitOptions > 0 then
				-- Pick at random from valid units, weighted by flavor
				local iRandB = Game.Rand(iUnitOptions, "Randomly selecting unit");
			

				--Game.CityPurchaseUnit(pCity, validUnits[iRandB].ID, -1, -1);
				local iCost = pCity:GetUnitPurchaseCost(validUnits[iRandB].ID);
				
				if iGold - iCost > 0 and iCost >= 0 then
					pPlayer:InitUnit(validUnits[iRandB].ID, pCity:GetX(), pCity:GetY());
					pPlayer:SetGold(iGold - iCost);
					print("Purchasing unit " .. validUnits[iRandB].ID);
				end

			end



		else
			--print("Attempt to buy building");
			
			-- Attempt to buy unit
			validBuildings = {};
			
			--local iBestBuilding = -1;
			local iBuildingsOptions = 0;
			local i4 = 0;
			for i = 0, iBuildingsSize do
				local pBuilding = BuildingsTable[i];
				local iBuilding = BuildingsIDTable[i]
				
				
				if pBuilding ~= nil and pCity:IsCanPurchase(true, true, -1, iBuilding, -1, YieldTypes.YIELD_GOLD) then
					--print(iBuilding .. " valid");
					validBuildings[i4] = pBuilding;
					i4 = i4 + 1;
				end
				

				
			end
			iBuildingsOptions = i4;
			if iBuildingsOptions > 0 then
				-- Pick at random from valid Buildings, weighted by flavor
				local iRandB = Game.Rand(iBuildingsOptions, "Randomly selecting Building");
				

				--Game.CityPurchaseBuilding(pCity, validBuildings[iRandB].ID, -1, -1);

				local iCost = pCity:GetBuildingPurchaseCost(validBuildings[iRandB].ID);
				if iGold - iCost > 0 and iCost >= 0 then
					pCity:SetNumRealBuilding(validBuildings[iRandB].ID, 1);
					pPlayer:SetGold(iGold - iCost);
					print("Purchasing Building " .. validBuildings[iRandB].ID);
				end
			end

		end

		iGold = pPlayer:GetGold();
		if iGold < iGoldThreshold then
			return;
		end
	end
end

function UruguayPurchaseOverride(iPlayer) 
	local pPlayer = Players[iPlayer];
	--ONLY URUGUAY AI
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iUruguayCiv and not pPlayer:IsHuman() then
		--print("Checking for gold");
		local iGold = pPlayer:GetGold();
		--print("found " .. iGold .. " gold");

		local iParty = load(pPlayer, sParty);
		if iParty == nil then 
			iParty = 0; 
		end

		--local bCanContinue = true;
		if iGold > 5000 then
			print("Calling GoldBuyDown");
			GoldBuyDown(iPlayer, iParty, 5000);
		end


	end


end


local sProd = "Production store";
local sSettlers = "Settlers built";
function UruguayPurchaseAuto(iPlayer)
	
	local frequency = 10;
	if Game.GetGameSpeedType() < 4 then 
		frequency = iFrequency[Game.GetGameSpeedType()];
	end
	local pPlayer = Players[iPlayer];
	--ONLY URUGUAY AI
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iUruguayCiv and not pPlayer:IsHuman() then
		
		local iGold = pPlayer:GetGold();
		--print("found " .. iGold .. " gold");

		local iParty = load(pPlayer, sParty);
		if iParty == nil then 
			iParty = 0; 
		end
		if Game.GetElapsedGameTurns() % frequency == 0 then
			--print("Calling GoldBuyDown from autopurchase");
			--[[if Game.GetElapsedGameTurns() < frequency * 10 and iGold >= 30 then
				local pCity = pPlayer:GetCapitalCity();
				--print("Buying a hill plot");
				for i = 7, 18 do
					local pTilePlot = pCity:GetCityIndexPlot(i);
					if pTilePlot:GetTerrainType() == 8 then
						if pTilePlot:GetOwner() < 0 then 
							pPlayer:SetGold(iGold - 30);
							pTilePlot:SetOwner(iPlayer, pCity:GetID());
						end
						break;
					end
				end
			end]]
			GoldBuyDown(iPlayer, iParty, 100);
		end

		
	end


end




GameEvents.PlayerDoTurn.Add(UruguayPurchaseOverride);
GameEvents.PlayerDoTurn.Add(UruguayPurchaseAuto);



local sPoliciesAdopted = "PoliciesAdopted";
local sCultureStored = "Culture Store";
local pPreferredPolicies = {};
pPreferredPolicies[0] = GameInfoTypes.POLICY_LIBERTY; 
pPreferredPolicies[1] = GameInfoTypes.POLICY_COLLECTIVE_RULE; 
pPreferredPolicies[2] = GameInfoTypes.POLICY_REPUBLIC;
pPreferredPolicies[3] = GameInfoTypes.POLICY_TRADITION;
pPreferredPolicies[4] = GameInfoTypes.POLICY_CITIZENSHIP;
pPreferredPolicies[5] = GameInfoTypes.POLICY_MERITOCRACY;
pPreferredPolicies[6] = GameInfoTypes.POLICY_REPRESENTATION;
pPreferredPolicies[7] = GameInfoTypes.POLICY_RATIONALISM;
pPreferredPolicies[8] = GameInfoTypes.POLICY_SECULARISM;
pPreferredPolicies[9] = GameInfoTypes.POLICY_HUMANISM;
pPreferredPolicies[10] = GameInfoTypes.POLICY_FREE_THOUGHT;
pPreferredPolicies[11] = GameInfoTypes.POLICY_SOVEREIGNTY;
pPreferredPolicies[12] = GameInfoTypes.POLICY_SCIENTIFIC_REVOLUTION;
local iPreferredPolicies = 13;
local pPolicyBranchID = {};
pPolicyBranchID[0] = GameInfo.Policies[GameInfoTypes.POLICY_COLLECTIVE_RULE].PolicyBranchType;
pPolicyBranchID[3] = GameInfo.Policies[GameInfoTypes.POLICY_OLIGARCHY].PolicyBranchType;
pPolicyBranchID[7] = GameInfo.Policies[GameInfoTypes.POLICY_HUMANISM].PolicyBranchType;

function UruguayBuildOverride(iPlayer)
	
	local frequency = 10;
	if Game.GetGameSpeedType() < 4 then 
		frequency = iFrequency[Game.GetGameSpeedType()];
	end
	local pPlayer = Players[iPlayer];
	

	--ONLY URUGUAY AI
	if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == iUruguayCiv and not pPlayer:IsHuman() then
		
		local iParty = load(pPlayer, sParty);
		if iParty == nil then 
			iParty = 0; 
		end


		-- Make Uruguay adopt policies that suit it well (didn't work well)
		--[[local iCultureStored = load(pPlayer, sCultureStored);
		if iCultureStored == nil then 
			iCultureStored = 0; 
		end

		iCultureStored = iCultureStored + pPlayer:GetJONSCulture();
		pPlayer:SetJONSCulture(iCultureStored);
		print("Found " .. iCultureStored .. " culture");
		local bHasPolicies = true;
		for i = 0, iPreferredPolicies - 1 do
			iPolicy = pPreferredPolicies[i];
			print("Checking policy " .. iPolicy);
			if pPlayer:CanAdoptPolicy(iPolicy) and iCultureStored >= pPlayer:GetNextPolicyCost() then
				--iCultureStored = iCultureStored - pPlayer:
				print("Adopting policy " .. iPolicy);
				pPlayer:DoAdoptPolicy(iPolicy);
				
			elseif GameInfo.Policies[iPolicy].PolicyBranchType == nil and pPlayer:CanUnlockPolicyBranch(pPolicyBranchID[i]) and iCultureStored >= pPlayer:GetNextPolicyCost() then
				print("Adopting branch " .. pPolicyBranchID[i] .. " for policy " .. iPolicy);
				pPlayer:SetPolicyBranchUnlocked(pPolicyBranchID[i], true);
			end
			if not pPlayer:HasPolicy(iPolicy) and not (GameInfo.Policies[iPolicy].PolicyBranchType == nil and pPlayer:IsPolicyBranchUnlocked(pPolicyBranchID[i])) then
				bHasPolicies = false;
			end
		end
		if bHasPolicies then
			iCultureStored = 0;
		else
			iCultureStored = pPlayer:GetJONSCulture();
			pPlayer:SetJONSCulture(0);
		end



		print("After trying for policies, culture: " .. iCultureStored);
		
		save(pPlayer, sCultureStored, iCultureStored);]]

		--Custom early game
		if Game.GetElapsedGameTurns() < frequency * 10 then
			--print("running Uruguay early game");
			if pPlayer:CanResearch(GameInfoTypes.TECH_MATHEMATICS) then
				--print("Setting research to maths");
				pPlayer:PushResearch(GameInfoTypes.TECH_MATHEMATICS, false);
			elseif pPlayer:CanResearch(GameInfoTypes.TECH_MASONRY) then
				--print("Setting research to masonry");
				pPlayer:PushResearch(GameInfoTypes.TECH_MASONRY, false);
			elseif pPlayer:CanResearch(GameInfoTypes.TECH_WRITING) then
				--print("Setting research to writing");
				pPlayer:PushResearch(GameInfoTypes.TECH_WRITING, false);
			end





			local iCityCount = 0;
			for pCity in pPlayer:Cities() do
				local iCity = pCity:GetID();
				local iProd = load(pPlayer, sProd .. iCity);
				if iProd == nil then 
					iProd = 0;
				end
				local iSettlers = load(pPlayer, sSettlers .. iCity);
				if iSettlers == nil then 
					iSettlers = 0; 
				end
				--print(iSettlers .. " settlers built");
				--print(iProd .. " production, adding " .. (pCity:GetOverflowProduction()  + pCity:GetProduction()) .. " production");
				
				iProd = iProd + pCity:GetOverflowProduction() + pCity:GetProduction();
				--print(iProd .. " production after addition");
				pCity:SetProduction(0);

				if pCity:CanConstruct(GameInfoTypes.BUILDING_GRANARY) and iCityCount < 14 then
					--print("Checking if can build BUILDING_GRANARY");
					if iProd >= pPlayer:GetBuildingProductionNeeded(GameInfoTypes.BUILDING_GRANARY) / (1 + pCity:GetBuildingProductionModifier(GameInfoTypes.BUILDING_GRANARY) / 100) then
						pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_GRANARY, 1);
						iProd = iProd - pPlayer:GetBuildingProductionNeeded(GameInfoTypes.BUILDING_GRANARY) / (1 + pCity:GetBuildingProductionModifier(GameInfoTypes.BUILDING_GRANARY) / 100);
					end
				elseif pCity:CanConstruct(GameInfoTypes.BUILDING_MONUMENT) and iCityCount < 14 then
					--print("Checking if can build BUILDING_MONUMENT");
					if iProd >= pPlayer:GetBuildingProductionNeeded(GameInfoTypes.BUILDING_MONUMENT) / (1 + pCity:GetBuildingProductionModifier(GameInfoTypes.BUILDING_MONUMENT) / 100) then
						pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_MONUMENT, 1);
						iProd = iProd - pPlayer:GetBuildingProductionNeeded(GameInfoTypes.BUILDING_MONUMENT) / (1 + pCity:GetBuildingProductionModifier(GameInfoTypes.BUILDING_MONUMENT) / 100);
					end
				elseif pCity:CanTrain(GameInfoTypes.UNIT_SETTLER) and ((iSettlers < 1 and iCityCount < 6) or (Game.GetElapsedGameTurns() > frequency * 5 and iSettlers < 2 and iCityCount < 3)) then
					--print("Checking if can build UNIT_SETTLER");
					if iProd >= pPlayer:GetUnitProductionNeeded(GameInfoTypes.UNIT_SETTLER) / (1 + pCity:GetUnitProductionModifier(GameInfoTypes.UNIT_SETTLER) / 100) then
						pPlayer:InitUnit(GameInfoTypes.UNIT_SETTLER, pCity:GetX(), pCity:GetY());
						iSettlers = iSettlers + 1;
						iProd = iProd - (pPlayer:GetUnitProductionNeeded(GameInfoTypes.UNIT_SETTLER) / (1 + pCity:GetUnitProductionModifier(GameInfoTypes.UNIT_SETTLER) / 100));
					end
				elseif pCity:CanConstruct(GameInfoTypes.BUILDING_LIBRARY) and iCityCount < 10 then
					--print("Checking if can build BUILDING_LIBRARY");
					if iProd >= pPlayer:GetBuildingProductionNeeded(GameInfoTypes.BUILDING_LIBRARY) / (1 + pCity:GetBuildingProductionModifier(GameInfoTypes.BUILDING_LIBRARY) / 100) then
						pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_LIBRARY, 1);
						iProd = iProd - pPlayer:GetBuildingProductionNeeded(GameInfoTypes.BUILDING_LIBRARY) / (1 + pCity:GetBuildingProductionModifier(GameInfoTypes.BUILDING_LIBRARY) / 100);
					end
				else
					--print("Nothing to build, returning production");
					pCity:SetOverflowProduction(pCity:GetOverflowProduction() + iProd);
					iProd = 0;
				end

				--print(iProd .. " production for city");

				iCityCount = iCityCount + 1;
				save(pPlayer, sProd .. iCity, iProd);
				save(pPlayer, sSettlers .. iCity, iSettlers);
			end

		elseif Game.GetElapsedGameTurns() == frequency * 10 then
			for pCity in pPlayer:Cities() do
				local iCity = pCity:GetID();
				local iProd = load(pPlayer, sProd .. iCity);
				if iProd == nil then 
					iProd = 0;
				end
				--print("Nothing to build, returning production");
				pCity:SetOverflowProduction(pCity:GetOverflowProduction() + iProd);
				iProd = 0;
				save(pPlayer, sProd .. iCity, iProd);
			end
		else
			-- If the turn is over 10xfrequency and the parties have recently switched, build some extra units if the Blancos are in power.


			for pCity in pPlayer:Cities() do
				
				local iCity = pCity:GetID();
				local iProd = load(pPlayer, sProd .. iCity);
				if iProd == nil then 
					iProd = 0;
				end
				local iThingToProduce = load(pPlayer, sThingToProduce .. iCity);
				if iThingToProduce == nil then 
					iThingToProduce = -1; 
				end
				--print(iProd .. " production, adding " .. (pCity:GetOverflowProduction()  + pCity:GetProduction()) .. " production");
				
				iProd = iProd + pCity:GetOverflowProduction() + pCity:GetProduction();
				--print(iProd .. " production after addition");
				pCity:SetProduction(0);


				if iThingToProduce > -1 or iThingToProduce == -2 then
				-- Create table of buildable units
					
					if iThingToProduce == -2 or not pCity:CanTrain(iThingToProduce) then
						--print("Selecting new target unit");
						--Update target unit
						local pWeights = {};
						local iWeightsSize = 0;
						local iTotalWeight = 0;
						for i = 0, iUnitsSize do
							pWeights[i] = 0;
							iWeightsSize = iWeightsSize + 1;
							local pUnit = unitsTable[i];
							local iUnit = unitsIDTable[i];
							if pUnit ~= nil and pCity:CanTrain(iUnit) then
								local iWeight = GameInfo.Units[iUnit].Combat;
								if GameInfo.Units[iUnit].RangedCombat > 0 then
									iWeight = (iWeight + GameInfo.Units[iUnit].RangedCombat) / 2;
								end
								if iUnit == iCascosUnit then
									iWeight = iWeight * 3;
								end
								pWeights[i] = iWeight;
								iTotalWeight = iTotalWeight + iWeight;
								--print("Unit " .. iUnit .. " given weight of " .. iWeight .. " for a total of " .. iTotalWeight);

							end
						end

						if iTotalWeight > 0 then
							local iRandB = Game.Rand(iTotalWeight, "Randomly selecting unit");


						
							local iRandLeft = iRandB;
							for i = 0, iUnitsSize do
								iRandLeft = iRandLeft - pWeights[i];
								if iRandLeft < 0 then
									iThingToProduce = i;
									break;
								end
							end
						else
							iThingToProduce = -1;
						end

						--print("Selected unit " .. iThingToProduce);

					end

					if iThingToProduce >= 0 then
						--print("Checking if can build unit " .. iThingToProduce);
						if pCity:CanTrain(iThingToProduce) and iProd >= pPlayer:GetUnitProductionNeeded(iThingToProduce) / (1 + pCity:GetUnitProductionModifier(iThingToProduce) / 100) then
							pPlayer:InitUnit(iThingToProduce, pCity:GetX(), pCity:GetY());
							print("Initializing unit " .. iThingToProduce);
							--iSettlers = iSettlers + 1;
							iProd = iProd - (pPlayer:GetUnitProductionNeeded(iThingToProduce) / (1 + pCity:GetUnitProductionModifier(iThingToProduce) / 100));
							iThingToProduce = -1;
						end
					else
						--print("Nothing to build, returning production");
						pCity:SetOverflowProduction(pCity:GetOverflowProduction() + iProd);
						iProd = 0;
					end
					

				else 
					--print("Nothing to build, returning production");
					pCity:SetOverflowProduction(pCity:GetOverflowProduction() + iProd);
					iProd = 0;
				end
				save(pPlayer, sProd .. iCity, iProd);
				save(pPlayer, sThingToProduce .. iCity, iThingToProduce);


			end


		end

		
	end

end

GameEvents.PlayerDoTurn.Add(UruguayBuildOverride);

-- Make Uruguay be intelligent with its production and adjust what it builds depending on the ruling party.




--- Stuff I may get to later


	--[[Construct useful tables of all units
	print("Constructing reference tables");
	print("Constructing table 1 ");
	local i1 = 0;
	local unitsIDTable = {};
	local unitsTable = {};
	print("step 1");
	
	for i = 0, 1000 do
		if GameInfo.Units[i] ~= nil then
			print("iterating " .. i1);
			unitsIDTable[i1] = GameInfo.Units[i].ID;
			unitsTable[i1] = GameInfo.Units[GameInfo.Units[i].ID];
			i1 = i1 + 1;
		end
	end
	local iUnitsSize = i1;

	print("Constructing table 2 ");
	-- Construct useful tables of all buildings
	local i2 = 0;
	local BuildingsIDTable = {};
	local BuildingsTable = {};
	for i = 0, 1000 do
		if GameInfo.Buildings[i] ~= nil then
			BuildingsIDTable[i2] = GameInfo.Buildings[i].ID;
			BuildingsTable[i2] = GameInfo.Buildings[GameInfo.Buildings[i].ID];
			i2 = i2 + 1;
		end
	end
	local iBuildingsSize = i2;
	
	print("Constructing table 3 ");
	-- Get Lavalleja flavors
	local i3 = 0;
	local flavorsTable = {};
	local flavorsValueTable = {};
	--for pFlavor in GameInfo.Leader_Flavors.LEADER_LAVALLEJA do
		flavorsTable[i3] = pFlavor;
		flavorsValueTable[pFlavor.FlavorType .. ""] = pFlavor.Flavor;
		i3 = i3 + 1;
	end
	flavorsTable[0] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_OFFENSE;
	flavorsValueTable["FLAVOR_OFFENSE"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_OFFENSE.Flavor;
	flavorsTable[1] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_DEFENSE;
	flavorsValueTable["FLAVOR_DEFENSE"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_DEFENSE.Flavor;
	flavorsTable[2] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_CITY_DEFENSE;
	flavorsValueTable["FLAVOR_CITY_DEFENSE"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_CITY_DEFENSE.Flavor;
	flavorsTable[3] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_RECON;
	flavorsValueTable["FLAVOR_RECON"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_RECON.Flavor;
	flavorsTable[4] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_RANGED;
	flavorsValueTable["FLAVOR_RANGED"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_RANGED.Flavor;
	flavorsTable[5] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_MOBILE;
	flavorsValueTable["FLAVOR_MOBILE"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_MOBILE.Flavor;
	flavorsTable[6] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_NAVAL;
	flavorsValueTable["FLAVOR_NAVAL"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_NAVAL.Flavor;
	flavorsTable[7] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_NAVAL_RECON;
	flavorsValueTable["FLAVOR_NAVAL_RECON"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_NAVAL_RECON.Flavor;
	flavorsTable[8] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_AIR;
	flavorsValueTable["FLAVOR_AIR"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_AIR.Flavor;
	flavorsTable[9] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_GROWTH;
	flavorsValueTable["FLAVOR_GROWTH"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_GROWTH.Flavor;
	flavorsTable[10] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_PRODUCTION;
	flavorsValueTable["FLAVOR_PRODUCTION"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_PRODUCTION.Flavor;
	flavorsTable[11] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_GOLD;
	flavorsValueTable["FLAVOR_GOLD"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_GOLD.Flavor;
	flavorsTable[12] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_SCIENCE;
	flavorsValueTable["FLAVOR_SCIENCE"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_SCIENCE.Flavor;
	flavorsTable[13] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_CULTURE;
	flavorsValueTable["FLAVOR_CULTURE"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_CULTURE.Flavor;
	flavorsTable[14] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_NUKE;
	flavorsValueTable["FLAVOR_NUKE"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_NUKE.Flavor;
	flavorsTable[15] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_RELIGION;
	flavorsValueTable["FLAVOR_RELIGION"] = GameInfo.Leader_Flavors.LEADER_LAVALLEJA.FLAVOR_RELIGION.Flavor;
	
	-- Override certain flavor types for smarter buys
	flavorsValueTable["FLAVOR_SCIENCE"] = 12;
	flavorsValueTable["FLAVOR_PRODUCTION"] = 11;
	flavorsValueTable["FLAVOR_CULTURE"] = 8;

	local iFlavorsSize = i3;

function GoldBuyDown(pPlayer, iParty, iGoldThreshold)
	local iInitialGold = pPlayer:GetGold();
	local iGold = iInitialGold;



	for pCity in pPlayer:Cities() do
		local iRand = Game.Rand(6, "What to buy?");
		local iThreshold = 2;
		if iParty == 1 then
			iThreshold = 4;
		end


		if iRand < iThreshold then
			-- Attempt to buy unit
			validUnits = {};
			unitFlavor = {};
			--local iBestUnit = -1;
			local iUnitsFlavor = 0;
			for i = 0, iUnitsSize do
				local pUnit = unitsTable[i];
				local iUnit = unitsIDTable[i]
				
				if pUnit ~= nil and pCity:IsCanPurchase(iUnit, -1, -1) then
					local iTotalFlavor = 0;
					for pFlavor in GameInfo.Unit_Flavors[iUnit] do
						iTotalFlavor = iTotalFlavor + pFlavor.Flavor * flavorsValueTable[pFlavor.FlavorType .. ""];
					end

					for 

					-- Build more cascos!
					if iUnit == iCascosUnit then
						iTotalFlavor = iTotalFlavor + 400;
					end
					validUnits[i] = pUnit;
					unitFlavor[i] = iTotalFlavor;
					iUnitsFlavor = iUnitsFlavor + iTotalFlavor;
				end

				
			end

			if iUnitsFlavor > 0 then
				-- Pick at random from valid units, weighted by flavor
				local iRandB = Game.Rand(iUnitsFlavor, "Randomly selecting unit");
				for i = 0, iUnitsSize do
					local iFlavor = unitFlavor[i];
					local bContinue = true;
					iRandB = iRandB - iFlavor;
					if iRandB <= 0 and bContinue then
						Game.CityPurchaseUnit(pCity, unitsIDTable[i], -1, -1);
						print("Purchasing unit " .. unitsIDTable[i]);
						bContinue = false;
					end
				end

			end



		else
			-- Attempt to buy building
			
			-- Attempt to buy unit
			validBuildings = {};
			BuildingFlavor = {};
			--local iBestBuilding = -1;
			local iBuildingsFlavor = 0;
			for i = 0, iBuildingsSize do
				local pBuilding = BuildingsTable[i];
				local iBuilding = BuildingsIDTable[i]
				
				if pBuilding ~= nil and pCity:IsCanPurchase(iBuilding, -1, -1) then
					local iTotalFlavor = 0;
					for pFlavor in GameInfo.Building_Flavors[iBuilding] do
						iTotalFlavor = iTotalFlavor + pFlavor.Flavor * flavorsValueTable[pFlavor.FlavorType .. ""];
					end

					validBuildings[i] = pBuilding;
					BuildingFlavor[i] = iTotalFlavor;
					iBuildingsFlavor = iBuildingsFlavor + iTotalFlavor;
				end

				
			end

			if iBuildingsFlavor > 0 then
				-- Pick at random from valid Buildings, weighted by flavor
				local iRandB = Game.Rand(iBuildingsFlavor, "Randomly selecting Building");
				for i = 0, iBuildingsSize do
					local iFlavor = BuildingFlavor[i];
					local bContinue = true;
					iRandB = iRandB - iFlavor;
					if iRandB <= 0 and bContinue then
						Game.CityPurchaseBuilding(pCity, BuildingsIDTable[i], -1, -1);
						print("Purchasing Building " .. BuildingsIDTable[i]);
						bContinue = false;
					end
				end

			end

		end

		iGold = pPlayer:GetGold();
		if iGold < iGoldThreshold then
			return;
		end
	end
end


GameEvents.PlayerDoTurn.Add(UruguayPurchaseOverride);]]