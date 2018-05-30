----------------------------------------------------------------
-- UnitPromotions Compatibility for GPR WORLD SP
----------------------------------------------------------------
--[[ Has been Defined in QinCompatibility.sql
function QinUnitCompatibility (iPlayerID, iUnitID)
	local pPlayer  = Players[iPlayerID];
	if pPlayer == nil then
		return
	end
	local pUnit = pPlayer:GetUnitByID(iUnitID);
	if pUnit == nil then
		return
	end
	
	local PromotionElite = GameInfo.UnitPromotions["PROMOTION_ELITE"];
	if  PromotionElite == nil then
		-- BNW
		if     pUnit:GetUnitType() == GameInfoTypes.UNIT_X_QINNU  then
			pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_ONLY_DEFENSIVE"].ID, true)
			pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_CITY_SIEGE"].ID, true)
		elseif pUnit:GetUnitType() == GameInfoTypes.UNIT_X_RUISHI then
			pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_NO_DEFENSIVE_BONUSES"].ID, true)
			pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_CAN_MOVE_AFTER_ATTACKING"].ID, true)
			pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_CITY_PENALTY"].ID, true)
		end
	else
		-- GPR WORLD SP
		if     pUnit:GetUnitType() == GameInfoTypes.UNIT_X_QINNU  then
			pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_REQUIRE_SUPPLY"].ID, true)
			pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_QINNU_SP"].ID, true)
		elseif pUnit:GetUnitType() == GameInfoTypes.UNIT_X_RUISHI then
			pUnit:SetHasPromotion(GameInfo.UnitPromotions["PROMOTION_RUISHI_SP"].ID, true)
		end
	end
end
Events.SerialEventUnitCreated.Add(QinUnitCompatibility)
]]


----------------------------------------------------------------
-- Qin Traits - Created by CaptainCWB
----------------------------------------------------------------

local g_QinUBCount = 0;
local g_QinUUCount = 0;
local g_QinUICount = 0;


-- Add Action or Build in Unit Panel
local g_UUAction = {};
local g_UIBuild  = {};


local g_QinTraitUCList = {};
local g_QinTraitUC = 
{
    ------------------------------------------------------------------
    -- default values
    ------------------------------------------------------------------
    m_PlayerID = -1,
    m_UC = nil, -- UB, UU or UI
    m_DC = nil, -- the Default Buildings, UnitClasses or UI_UnitBuilt
    
    ------------------------------------------------------------------
    -- constructor
    ------------------------------------------------------------------
    new = function( self, iUCType, iUCCount, playerID, iUnique, iDefault )
	local o = {};
	setmetatable( o, self );
	self.__index = self;
	
	o.m_PlayerID = playerID;
	
	if iUnique  ~= nil then
		o.m_UC = iUnique;
	end
	if iDefault ~= nil then
		o.m_DC = iDefault;
	end
	
	---------------------------------------------------------
	-- build the table for QinTraitUA to store the UB, UU and UI
	local UCTable = g_QinTraitUCList[ iUCType ];
	if UCTable == nil then
		UCTable = {};
		g_QinTraitUCList[ iUCType ] = UCTable;
	end
	g_QinTraitUCList[ iUCType ][ iUCCount ] = o;
	
	return o;
    end,
};

-- Qin UCCaptured IsActive Table
local g_QinTraitUCIsActive = {};


-- Initialize QinTrait UCs Table
for iPlayerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
	if Players[iPlayerID] ~= nil then
		local pPlayer = Players[iPlayerID];
		for iUCType = 0, 2, 1 do
			if (pPlayer:IsEverAlive() and not (pPlayer:IsMinorCiv() or pPlayer:IsBarbarian())) then
				if     iUCType == 0 then
					for overrideBuilding in GameInfo.Civilization_BuildingClassOverrides("CivilizationType = '" .. GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type .. "'") do
						if overrideBuilding.BuildingType and overrideBuilding.BuildingClassType then
							g_QinUBCount = g_QinUBCount + 1;
							local iUniBuilding = GameInfoTypes[overrideBuilding.BuildingType];
							local iDefBuilding = GameInfoTypes[GameInfo.BuildingClasses[overrideBuilding.BuildingClassType].DefaultBuilding];
							
							g_QinTraitUC:new( iUCType, g_QinUBCount, iPlayerID, iUniBuilding, iDefBuilding );
						end
					end
				elseif iUCType == 1 then
					for overrideUnit in GameInfo.Civilization_UnitClassOverrides("CivilizationType = '" .. GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type .. "'") do
						if overrideUnit.UnitType and overrideUnit.UnitClassType then
							g_QinUUCount = g_QinUUCount + 1;
							local iUniUnit = GameInfoTypes[overrideUnit.UnitType];
							local iDefUnitClass = GameInfoTypes[overrideUnit.UnitClassType];
							
							g_QinTraitUC:new( iUCType, g_QinUUCount, iPlayerID, iUniUnit, iDefUnitClass );
						end
					end
				elseif iUCType == 2 then
					for improvement in GameInfo.Improvements("CivilizationType = '" .. GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type .. "'") do
						if improvement.Type then
							g_QinUICount = g_QinUICount + 1;
							local iImprovement = GameInfoTypes[improvement.Type];
							local iBuild = GameInfo.Builds{ImprovementType = improvement.Type}().ID;
							
							g_QinTraitUC:new( iUCType, g_QinUICount, iPlayerID, iImprovement, iBuild );
						end
					end
				end
			end
		end
		
		g_QinTraitUCIsActive[iPlayerID] = false;
		if pPlayer:GetStartingPlot() ~= nil then
			local eCapitalOwner = pPlayer:GetStartingPlot():GetOwner();
			if eCapitalOwner ~= -1 then 
				if eCapitalOwner ~= iPlayerID and Players[eCapitalOwner]:GetCivilizationType() == GameInfoTypes["CIVILIZATION_QIN"] then
					g_QinTraitUCIsActive[iPlayerID] = true;
				end
			end
		end
	end
end



-- UA Active or Deactive
function QinTraitUAActive (iOldPlayerID, iCapital, iX, iY, iNewPlayerID)
	if Players[iOldPlayerID] == nil or Players[iNewPlayerID] == nil or Map.GetPlot(iX, iY) == nil or not Map.GetPlot(iX, iY):IsCity() then
		return;
	end
 	local pOldPlayer = Players[iOldPlayerID];
	local pNewPlayer = Players[iNewPlayerID];
	local iQinPlayer = -1;
	local iQinPlotX = -1;
	local iQinPlotY = -1;
	local pCity = Map.GetPlot(iX, iY):GetPlotCity();
	if Map.GetPlot(iX, iY):IsRevealed(Game.GetActiveTeam(), false) then
		iQinPlotX = iX;
		iQinPlotY = iY;
	end
	
	if pCity == nil or not pCity:IsOriginalMajorCapital() then
		return;
	end
	
	if     pNewPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_QIN"] and pCity:GetOriginalOwner() ~= iNewPlayerID then
		iQinPlayer = iNewPlayerID;
		g_QinTraitUCIsActive[pCity:GetOriginalOwner()] = true;
	elseif pOldPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_QIN"] and pCity:GetOriginalOwner() ~= iOldPlayerID then
		iQinPlayer = iOldPlayerID;
		g_QinTraitUCIsActive[pCity:GetOriginalOwner()] = false;
		
		QinTraitUBRemove(pOldPlayer);
	end
	if iQinPlayer ~= -1 and (Players[iQinPlayer]:GetTeam() == Game.GetActiveTeam() or Teams[Game.GetActiveTeam()]:IsHasMet(Players[iQinPlayer]:GetTeam())) then
		OnUCCNotification(iQinPlayer, pCity:GetOriginalOwner(), iQinPlotX, iQinPlotY, g_QinTraitUCIsActive[pCity:GetOriginalOwner()]);
	end
end
GameEvents.CityCaptureComplete.Add(QinTraitUAActive)



function OnUCCNotification(iQinPlayer, iPlayer, iPlotX, iPlotY, bIsUCActive)
	local heading = "";
	local text = "";
	
	local sCivName = Players[iPlayer]:GetCivilizationShortDescriptionKey();
	local iCivType = Players[iPlayer]:GetCivilizationType();
	local sLeader;
	if     iQinPlayer ==  0 then
		sLeader = Locale.ConvertTextKey("TXT_KEY_YOU");
	elseif iQinPlayer ~= -1 then
		sLeader = GameInfo.Leaders[Players[iQinPlayer]:GetLeaderType()].Description;
	end
	if bIsUCActive then
		heading = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_QIN_SEIZED_CIVILIZATION", sCivName);
		text = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_QIN_SEIZED_CIVILIZATION_TEXT", sCivName, sLeader) .. Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_QIN_CONQUEROR_CIVILIZATION_TEXT");
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes.NOTIFICATION_PEACE_ACTIVE_PLAYER, text, heading, iPlotX, iPlotY, iQinPlayer, iCivType);
	else
		heading = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_QIN_LOST_CIVILIZATION", sCivName);
		text = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_QIN_LOST_CIVILIZATION_TEXT", sCivName, sLeader);
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes.NOTIFICATION_WAR_ACTIVE_PLAYER,   text, heading, iPlotX, iPlotY, iQinPlayer, iCivType);
	end
end



---------------------------------------------------------
-- QinTrait UA - UB Removed or Added
-- UB Removed
function QinTraitUBRemove (pQin)
	if not pQin:IsAlive() or pQin:GetNumCities() == 0 then
		return;
	end
	for pCity in pQin:Cities() do
		for iUBID,pUBTable in pairs( g_QinTraitUCList[0] ) do
			if pUBTable and pUBTable.m_PlayerID and pUBTable.m_UC and pCity:IsHasBuilding(pUBTable.m_UC) and not g_QinTraitUCIsActive[pUBTable.m_PlayerID] then
				pCity:SetNumRealBuilding(pUBTable.m_UC, 0)
			end
		end
	end
end

-- UB Added
function QinTraitUB( iPlayerID )
	local pPlayer = Players[iPlayerID];
	if pPlayer == nil or pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_QIN"] then
		return
	end
	
	for pCity in pPlayer:Cities() do
		for iUBID,pUBTable in pairs( g_QinTraitUCList[0] ) do
			if pUBTable and pUBTable.m_PlayerID and pUBTable.m_UC and pUBTable.m_DC and pCity:IsHasBuilding(pUBTable.m_DC) and g_QinTraitUCIsActive[pUBTable.m_PlayerID] then
				pCity:SetNumRealBuilding(pUBTable.m_UC, 1)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(QinTraitUB)



---------------------------------------------------------
-- QinTrait UA - Convert UU for AI
function QinTraitUAConUUAI(iPlayerID, iUnitID)
	local pPlayer = Players[iPlayerID];
	if pPlayer == nil or pPlayer:IsHuman() or not pPlayer:IsAlive() or pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_QIN"] then
		return;
	end
	local pUnit = pPlayer:GetUnitByID(iUnitID);
	if pUnit == nil then
		return;
	end
	local iUnitType = GameInfoTypes[GameInfo.UnitClasses[pUnit:GetUnitClassType()].DefaultUnit];
	local overrideUnit = GameInfo.Civilization_UnitClassOverrides{ UnitClassType = GameInfo.UnitClasses[pUnit:GetUnitClassType()].Type, CivilizationType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type }();
	if overrideUnit and overrideUnit.UnitType then
		iUnitType = GameInfoTypes[overrideUnit.UnitType];
	end
	local pPlot = pUnit:GetPlot();
	if   pUnit:HasMoved() or iUnitType ~= pUnit:GetUnitType() or not pPlot:IsFriendlyTerritory(iPlayerID)
	or ( pUnit:GetSpreadsLeft() > 0 and (pUnit:GetSpreadsLeft() < GameInfo.Units[pUnit:GetUnitType()].ReligionSpreads or not pPlot:IsCity() or (pPlot:IsCity() and pPlot:GetPlotCity():GetReligiousMajority() <= 0)) )
	then
		return;
	end
	
	local controlTable = {};
	local sameClassCount = 0;
	for iUUID,pUUTable in pairs( g_QinTraitUCList[1] ) do
		if pUUTable and pUUTable.m_PlayerID and pUUTable.m_UC and pUUTable.m_DC and g_QinTraitUCIsActive[pUUTable.m_PlayerID] and pUnit:GetUnitClassType() == pUUTable.m_DC and pUnit:GetUnitType() ~= pUUTable.m_UC then
			sameClassCount = sameClassCount + 1;
			controlTable[sameClassCount] = pUUTable.m_UC
		end
	end
	
	if sameClassCount > 0 then
		local iCount = math.random( 0, sameClassCount );
		if iCount > 0 then
			if pUnit:IsGreatPerson() then
				G_Changed_GP = { iPlayerID, iUnitID };
			end
			
			if pUnit:GetSpreadsLeft() > 0 and not pPlot:IsCity() and pPlot:GetWorkingCity() and pPlot:GetWorkingCity():GetReligiousMajority() > 0 then
				pPlot = pPlot:GetWorkingCity():Plot();
			end
			local pNewUnit = pPlayer:InitUnit(controlTable[iCount], pPlot:GetX(), pPlot:GetY());
			if pPlot ~= pUnit:GetPlot() then
				pNewUnit:SetXY(pUnit:GetPlot():GetX(), pUnit:GetPlot():GetY())
			end
			pUnit:Kill();
		end
	end
end
Events.SerialEventUnitCreated.Add(QinTraitUAConUUAI)



---------------------------------------------------------
-- QinTrait UA - Convert UU for Human
if g_QinUUCount > 2 then
	for iUUID,pUUTable in pairs( g_QinTraitUCList[1] ) do
	    if pUUTable and pUUTable.m_PlayerID and pUUTable.m_UC and pUUTable.m_DC then
		g_UUAction[iUUID] = {
		  Name = GameInfo.Units[pUUTable.m_UC].Description,
		  Title = Locale.ConvertTextKey("TXT_KEY_QIN_UNIT_CONVERT", GameInfo.Units[pUUTable.m_UC].Description), -- or a TXT_KEY
		  OrderPriority = 1500, -- default is 200
		  IconAtlas = GameInfo.Units[pUUTable.m_UC].IconAtlas, -- 45 and 64 variations required
		  PortraitIndex = GameInfo.Units[pUUTable.m_UC].PortraitIndex,
		  ToolTip = function(action, unit) -- or a TXT_KEY_ or a function
		    if unit:GetSpreadsLeft() > 0 then
		      return Locale.ConvertTextKey("TXT_KEY_QIN_UNIT_CONVERT_RELIGION_TT", GameInfo.Units[pUUTable.m_UC].Description);
		    else
		      return Locale.ConvertTextKey("TXT_KEY_QIN_UNIT_CONVERT_TT", GameInfo.Units[pUUTable.m_UC].Description);
		    end
		  end,
		  
		  Condition = function(action, unit)
		    local player = Players[unit:GetOwner()];
		    local isCanTrained = true;
		    if unit:GetUnitType() ~= GameInfoTypes[GameInfo.UnitClasses[unit:GetUnitClassType()].DefaultUnit] then
		      for _, pUniqueUnit in pairs( g_QinTraitUCList[1] ) do
		        if unit:GetUnitType() == pUniqueUnit.m_UC and unit:GetOwner() ~= pUniqueUnit.m_PlayerID then
		          isCanTrained = false;
		          break;
		        end
		      end
		    end
		    return unit:CanMove() and isCanTrained and g_QinTraitUCIsActive[pUUTable.m_PlayerID] and unit:GetUnitClassType() == pUUTable.m_DC and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_QIN"];
		  end, -- or nil or a boolean, default is true
		  
		  Disabled = function(action, unit)
		    local plot = unit:GetPlot();
		    local reli = 0;
		    if unit:GetSpreadsLeft() <= 0 or (unit:GetSpreadsLeft() >= GameInfo.Units[unit:GetUnitType()].ReligionSpreads
		    and ( (plot:IsCity() and plot:GetPlotCity():GetReligiousMajority() > 0) or (plot:GetWorkingCity() and plot:GetWorkingCity():GetReligiousMajority() > 0) ))
		    then
		    else
		      reli = 1;
		    end
		    return not plot:IsFriendlyTerritory(unit:GetOwner()) or reli == 1;
		  end, -- or nil or a boolean, default is false
		  
		  Action = function(action, unit, eClick)
		    local plot = unit:GetPlot();
		    local player = Players[unit:GetOwner()];
		    if unit:IsGreatPerson() then
		      G_Changed_GP = { unit:GetOwner(), unit:GetID() };
		    end
		    
		    if unit:GetSpreadsLeft() > 0 and not plot:IsCity() and plot:GetWorkingCity() and plot:GetWorkingCity():GetReligiousMajority() > 0 then
		      plot = plot:GetWorkingCity():Plot();
		    end
		    local newUnit = player:InitUnit(pUUTable.m_UC, plot:GetX(), plot:GetY());
		    if plot ~= unit:GetPlot() then
		      newUnit:SetXY(unit:GetPlot():GetX(), unit:GetPlot():GetY())
		    end
		    unit:Kill();
		    newUnit:SetMoves(0);
		  end
		};
		LuaEvents.UnitPanelActionAddin(g_UUAction[iUUID]);
	    end
	end
end



---------------------------------------------------------
-- QinTrait UA - UI Added for Qin Workers
--[[
if g_QinUICount > 0 then
	for iUIID,pUITable in pairs( g_QinTraitUCList[2] ) do
	    if pUITable and pUITable.m_PlayerID and pUITable.m_UC and pUITable.m_DC then
		local function pTDSynthesize(iPlayerID, iUnitID)
		  if (Players[ iPlayerID ] == nil or not Players[ iPlayerID ]:IsAlive()
		  or  Players[ iPlayerID ]:GetUnitByID( iUnitID ) == nil
		  or  Players[ iPlayerID ]:GetUnitByID( iUnitID ):IsDead()
		  or  Players[ iPlayerID ]:GetUnitByID( iUnitID ):IsDelayedDeath()
		  or  Players[ iPlayerID ]:GetUnitByID( iUnitID ):GetPlot() == nil)
		  then
		    return;
		  end
		  local unit = Players[ iPlayerID ]:GetUnitByID( iUnitID );
		  local plot = unit:GetPlot();
		  local pTeam = Teams[unit:GetTeam()];
		  local pImprovement = "ImprovementType = '" .. GameInfo.Improvements[pUITable.m_UC].Type .. "'";
		  local pBuild = "BuildType = '" .. GameInfo.Builds[pUITable.m_DC].Type .. "'";
		  local pDirection_types = {
		    DirectionTypes.DIRECTION_NORTHEAST,
		    DirectionTypes.DIRECTION_EAST,
		    DirectionTypes.DIRECTION_SOUTHEAST,
		    DirectionTypes.DIRECTION_SOUTHWEST,
		    DirectionTypes.DIRECTION_WEST,
		    DirectionTypes.DIRECTION_NORTHWEST
		  };
		  local sToolTip = Locale.ConvertTextKey(GameInfo.Builds[pUITable.m_DC].Help or GameInfo.Improvements[pUITable.m_UC].Help or "");
		  local bIsDisabled = false;
		  -- Do have a Improvement to convert or not?
		  if plot:GetImprovementType() ~= -1 then
		    sToolTip = sToolTip .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_QIN_UI_TT", GameInfo.Improvements[pUITable.m_UC].Description);
		  else
		    sToolTip = sToolTip .. "[NEWLINE][NEWLINE]" .. Locale.ConvertTextKey("TXT_KEY_QIN_UI_DISABLED_TT", GameInfo.Improvements[pUITable.m_UC].Description);
		    bIsDisabled = true;
		  end
		  -- Don't have Tech for Build?
		  if not bIsDisabled and GameInfo.Builds[pUITable.m_DC].PrereqTech ~= nil 
		  and not pTeam:IsHasTech(GameInfoTypes[GameInfo.Builds[pUITable.m_DC].PrereqTech])
		  then
		    sToolTip = sToolTip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_PREREQ_TECH", GameInfo.Technologies[GameInfo.Builds[pUITable.m_DC].PrereqTech].Description, GameInfo.Improvements[pUITable.m_UC].Description) .. "[ENDCOLOR]";
		    bIsDisabled = true;
		  end
		  -- Trying to build something and are not adjacent to our territory?
		  if not bIsDisabled and GameInfo.Improvements[pUITable.m_UC].InAdjacentFriendly
		  and plot:GetTeam() ~= unit:GetTeam() and not plot:IsAdjacentTeam(unit:GetTeam(), true)
		  then
		    sToolTip = sToolTip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_NOT_IN_ADJACENT_TERRITORY", GameInfo.Improvements[pUITable.m_UC].Description) .. "[ENDCOLOR]";
		    bIsDisabled = true;
		  end
		  -- Trying to build something in a City-State's territory?
		  if not bIsDisabled and GameInfo.Improvements[pUITable.m_UC].OnlyCityStateTerritory
		  and (plot:GetOwner() == -1 or not Players[plot:GetOwner()]:IsMinorCiv())
		  then
		    sToolTip = sToolTip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_NOT_IN_CITY_STATE_TERRITORY", GameInfo.Improvements[pUITable.m_UC].Description) .. "[ENDCOLOR]";
		    bIsDisabled = true;
		  end
		  -- Trying to build something outside of our territory?
		  if not bIsDisabled and plot:GetTeam() ~= unit:GetTeam() and not GameInfo.Improvements[pUITable.m_UC].IgnoreOwnership
		  and not (GameInfo.Improvements[pUITable.m_UC].OutsideBorders and (plot:GetTeam() == -1 or Teams[plot:GetTeam()]:IsAtWar(unit:GetTeam())))
		  and not  GameInfo.Improvements[pUITable.m_UC].InAdjacentFriendly and not GameInfo.Improvements[pUITable.m_UC].OnlyCityStateTerritory
		  then
		    sToolTip = sToolTip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_OUTSIDE_TERRITORY", GameInfo.Improvements[pUITable.m_UC].Description) .. "[ENDCOLOR]";
		    bIsDisabled = true;
		  end
		  -- Build blocked by a feature here?
		  if not bIsDisabled and plot:GetFeatureType() ~= -1 then
		    for pBuildFeature in GameInfo.BuildFeatures( pBuild ) do
		      if plot:GetFeatureType() == FeatureTypes[pBuildFeature.FeatureType] and not pTeam:IsHasTech(GameInfoTypes[pBuildFeature.PrereqTech]) then
		        sToolTip = sToolTip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_BY_FEATURE", GameInfo.Technologies[pBuildFeature.PrereqTech].Description, GameInfo.Features[pBuildFeature.FeatureType].Description) .. "[ENDCOLOR]";
		        bIsDisabled = true;
		        break;
		      end
		    end
		  end
		  -- Trying to build something that requires an adjacent luxury?
		  if not bIsDisabled and GameInfo.Improvements[pUITable.m_UC].AdjacentLuxury then
		    bIsDisabled = true;
		    for loop, direction in ipairs(pDirection_types) do
		      local pAdjacentPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction);
		      if (pAdjacentPlot ~= nil) then
		        local eResourceType = pAdjacentPlot:GetResourceType();
		        if (eResourceType ~= -1 and Game.GetResourceUsageType(eResourceType) == ResourceUsageTypes.RESOURCEUSAGE_LUXURY) then
		          bIsDisabled = false;
		          break;
		        end
		      end
		    end
		    if bIsDisabled then
		      sToolTip = sToolTip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_NO_ADJACENT_LUXURY", GameInfo.Improvements[pUITable.m_UC].Description) .. "[ENDCOLOR]";
		    end
		  end
		  -- Trying to build something where we can't have two adjacent?
		  if not bIsDisabled and GameInfo.Improvements[pUITable.m_UC].NoTwoAdjacent then
		    for loop, direction in ipairs(pDirection_types) do
		      local pAdjacentPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction);
		      if (pAdjacentPlot ~= nil) then
		        local eImprovementType = pAdjacentPlot:GetImprovementType();
		          if (eImprovementType ~= -1 and eImprovementType == pUITable.m_UC) then
		            bIsDisabled = true;
		            break;
		          end
		          local iBuildProgress = pAdjacentPlot:GetBuildProgress(pUITable.m_DC);
		          if (iBuildProgress > 0) then
		            bIsDisabled = true;
		            break;
		        end
		      end
		    end
		    if bIsDisabled then
		      sToolTip = sToolTip .. "[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]" .. Locale.ConvertTextKey("TXT_KEY_BUILD_BLOCKED_CANNOT_BE_ADJACENT", GameInfo.Improvements[pUITable.m_UC].Description) .. "[ENDCOLOR]";
		    end
		  end
		  -- Trying to build something that requires enough adjacent lands?
		  if not bIsDisabled and GameInfo.Improvements[pUITable.m_UC].RequiresXAdjacentLand > 0 then
		    local pAdjacentLand = 0;
		    for loop, direction in ipairs(pDirection_types) do
		      local pAdjacentPlot = Map.PlotDirection(plot:GetX(), plot:GetY(), direction);
		      if (pAdjacentPlot ~= nil) then
		        if not pAdjacentPlot:IsWater() then
		          pAdjacentLand = pAdjacentLand + 1;
		          if pAdjacentLand == GameInfo.Improvements[pUITable.m_UC].RequiresXAdjacentLand then
		            break;
		          end
		        end
		      end
		    end
		    if pAdjacentLand < GameInfo.Improvements[pUITable.m_UC].RequiresXAdjacentLand then
		      bIsDisabled = true;
		    end
		  end
		  return {sToolTip, bIsDisabled}
		end
		g_UIBuild[iUIID] = {
		  Name =  GameInfo.Improvements[pUITable.m_UC].Description,
		  Title = GameInfo.Builds[pUITable.m_DC].Description,
		  IconAtlas = GameInfo.Builds[pUITable.m_DC].IconAtlas,
		  PortraitIndex = GameInfo.Builds[pUITable.m_DC].IconIndex,
		  ToolTip = function(build, unit)
		    local playerid = unit and unit:GetOwner() or -1;
		    local unitid = unit and unit:GetID() or -1;
		    return pTDSynthesize(playerid, unitid)[1] or "";
		  end,
		  
		  Condition = function(build, unit)
		    local player  = Players[unit:GetOwner()];
		    local plot    = unit:GetPlot();
		    local iTeam   = unit:GetTeam();
		    local feature = GameInfo.Features[plot:GetFeatureType()];
		    local pImprovement = "ImprovementType = '" .. GameInfo.Improvements[pUITable.m_UC].Type .. "'";
		    local pBuild = "BuildType = '" .. GameInfo.Builds[pUITable.m_DC].Type .. "'";
		    local bIsCondition = false;
		    if unit:GetUnitClassType() == GameInfoTypes["UNITCLASS_WORKER"]
		    and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_QIN"]
		    then
		      bIsCondition = true;
		    end
		    if not bIsCondition then
		    elseif (feature and feature.NoImprovement)
		    or     (plot:GetPlotCity() or plot:GetImprovementType() == pUITable.m_UC)
		    or     (plot:IsWater() and not GameInfo.Improvements[pUITable.m_UC].Water)
		    or     (not plot:IsWater() and GameInfo.Improvements[pUITable.m_UC].Water)
		    or     (not plot:IsCoastalLand() and GameInfo.Improvements[pUITable.m_UC].Coastal)
		    then
		      bIsCondition = false;
		    else
		      bIsCondition = false;
		      if GameInfo.Improvement_ValidTerrains( pImprovement ) ~= nil then
		        for pTerrainType in GameInfo.Improvement_ValidTerrains( pImprovement ) do
		          if (plot:GetTerrainType() == TerrainTypes[pTerrainType.TerrainType])
		          or (plot:IsMountain() and pTerrainType.TerrainType == "TERRAIN_MOUNTAIN")
		          or (plot:IsHills()    and pTerrainType.TerrainType == "TERRAIN_HILL")
		          then
		            bIsCondition = true;
		            break;
		          end;
		        end
		      end
		      if plot:GetFeatureType() ~= -1 and GameInfo.Improvements[pUITable.m_UC].RequiresFeature
		      and GameInfo.Improvement_ValidFeatures( pImprovement ) ~= nil
		      then
		        bIsCondition = false;
		        for pFeatureType in GameInfo.Improvement_ValidFeatures( pImprovement ) do
		          if plot:GetFeatureType() == FeatureTypes[pFeatureType.FeatureType] then
		            bIsCondition = true;
		            break;
		          end
		        end
		      end
		      if plot:GetResourceType(iTeam) ~= -1 then
		        bIsCondition = false;
		        if     GameInfo.Improvements[pUITable.m_UC].BuildableOnResources then
		          bIsCondition = true;
		        elseif GameInfo.Improvement_ResourceTypes( pImprovement ) ~= nil then
		          for pResourceType in GameInfo.Improvement_ResourceTypes( pImprovement ) do
		            if plot:GetResourceType(iTeam) == GameInfoTypes[pResourceType.ResourceType] then
		              bIsCondition = true;
		              break;
		            end
		          end
		        end
		      end
		    end
		    return bIsCondition and unit:CanMove() and g_QinTraitUCIsActive[pUITable.m_PlayerID];
		  end, -- or nil or a boolean, default is true
		  
		  Disabled = function(build, unit)
		    local playerid = unit and unit:GetOwner() or -1;
		    local unitid = unit and unit:GetID() or -1;
		    return pTDSynthesize(playerid, unitid)[2] or false;
		  end, -- or nil or a boolean, default is false
		  
		  Build = function(build, unit, eClick)
		    local plot = unit:GetPlot();
		    local pBuild = "BuildType = '" .. GameInfo.Builds[pUITable.m_DC].Type .. "'";
		    -- local iTeam = unit:GetTeam();
		    -- plot:ChangeBuildProgress(pUITable.m_DC, 100, iTeam);
		    plot:SetImprovementType(pUITable.m_UC);
		    if plot:GetImprovementType() == pUITable.m_UC then
		      if GameInfo.Builds[pUITable.m_DC].Kill then
		        unit:Kill();
		      end
		      if plot:GetFeatureType() ~= -1 then
		        for pBuildFeature in GameInfo.BuildFeatures( pBuild ) do
		          if plot:GetFeatureType() == GameInfoTypes[pBuildFeature.FeatureType] and pBuildFeature.Remove then
		            plot:SetFeatureType(FeatureTypes.NO_FEATURE, -1);
		            break;
		          end
		        end
		      end
		    end
		    if unit and not unit:IsDead() and not unit:IsDelayedDeath() then
		      unit:SetMoves(0);
		    end
		  end,
		  
		  Recommended = function(build, unit, eClick) end,
		};
		LuaEvents.UnitPanelBuildAddin(g_UIBuild[iUIID]);
	    end
	end
end
]]