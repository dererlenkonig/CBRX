print("Senshi's Korea Loaded")
include("PlotIterators")
--==========================================================================================================================
-- Mod Checks
--==========================================================================================================================
-- JFD_IsUsingEnlightenmentEra
function JFD_IsUsingEnlightenmentEra()
    local enlightenmentEraModID = "ce8aa614-7ef7-4a45-a179-5329869e8d6d"
    for _, mod in pairs(Modding.GetActivatedMods()) do
        if (mod.ID == enlightenmentEraModID) then
            return true
        end
    end
    return false
end
local isUsingEnlightenmentEra = JFD_IsUsingEnlightenmentEra()
 
-- JFD_IsUsingCPDLL
function JFD_IsUsingCPDLL()
    local cPDLLID = "d1b6328c-ff44-4b0d-aad7-c657f83610cd"
    for _, mod in pairs(Modding.GetActivatedMods()) do
        if (mod.ID == cPDLLID) then
            return true
        end
    end
    return false
end
local isUsingCPDLL = JFD_IsUsingCPDLL()

local tGPImprovements = {}; -- Thanks LeeS :p
for pImprovement in GameInfo.Improvements() do
    if (pImprovement.CreatedByGreatPerson == 1) or (pImprovement.CreatedByGreatPerson == true) or (pImprovement.CreatedByGreatPerson == "true") then
        tGPImprovements[pImprovement.ID] = pImprovement.Type
    end
end

function GetValidPromotionsAndExperienceFromCityBuildings(iUnitType, pPlayer, pCity) -- LeeS
	local tTableOfUnitDataToReturn = { Experience = 0, Promotions = {}}
	local tUnitDetails = GameInfo.Units{ID=iUnitType}()
	local sRequiredCombatClass = tUnitDetails.CombatClass
	local sRequiredUnitDomain = tUnitDetails.Domain
	for Building in GameInfo.Buildings() do
		if pCity:IsHasBuilding(Building.ID) then
			local sPromoString = Building.TrainedFreePromotion
			local sBuildingType = Building.Type
			local iBuildingClass = GameInfoTypes[Building.BuildingClass]
			local iPromotionID = -1
			if (sPromoString ~= "NULL") and (sPromoString ~= nil) then
				for PromotionType in GameInfo.UnitPromotions("Type='" .. sPromoString .. "'") do
					iPromotionID = PromotionType.ID
				end
				if iPromotionID ~= -1 then
					local bWasAPromoMatch = false
					local bWasACombatClassMatch = false
					for UnitCombatPromotion in GameInfo.UnitPromotions_UnitCombats("PromotionType='" .. sPromoString .. "'") do
						bWasAPromoMatch = true
						if UnitCombatPromotion.UnitCombatType == sRequiredCombatClass then
							bWasACombatClassMatch = true
						end
					end
					if bWasAPromoMatch then
						if bWasACombatClassMatch then
							table.insert(tTableOfUnitDataToReturn.Promotions,iPromotionID)
						end
					else
						table.insert(tTableOfUnitDataToReturn.Promotions,iPromotionID)
					end
				end
			end
			tTableOfUnitDataToReturn.Experience = tTableOfUnitDataToReturn.Experience + Building.Experience
			for DomainExperienceBuilding in GameInfo.Building_DomainFreeExperiences("BuildingType='" .. sBuildingType .. "'") do
				if DomainExperienceBuilding.DomainType == sRequiredUnitDomain then
					tTableOfUnitDataToReturn.Experience = tTableOfUnitDataToReturn.Experience + DomainExperienceBuilding.Experience
				end
			end
			for UnitCombatExperienceBuilding in GameInfo.Building_UnitCombatFreeExperiences("BuildingType='" .. sBuildingType .. "'") do
				if UnitCombatExperienceBuilding.UnitCombatType == sRequiredCombatClass then
					tTableOfUnitDataToReturn.Experience = tTableOfUnitDataToReturn.Experience + UnitCombatExperienceBuilding.Experience
				end
			end
			if Building.GreatWorkCount > 0 then
				for GreatWorkExperienceBuilding in GameInfo.Building_DomainFreeExperiencePerGreatWork("BuildingType='" .. sBuildingType .. "'") do
					if GreatWorkExperienceBuilding.DomainType == sRequiredUnitDomain then
						tTableOfUnitDataToReturn.Experience = tTableOfUnitDataToReturn.Experience + (GreatWorkExperienceBuilding.Experience * pCity:GetNumGreatWorksInBuilding(iBuildingClass))
					end
				end
			end
		end
	end
	return tTableOfUnitDataToReturn
end

function GetStrongestMilitaryUnit(pPlayer, bIgnoreResources, ...) -- JFD
	local tUnit = {["ID"] = GameInfoTypes.UNIT_WARRIOR, ["Combat"] = -1}
	for iKey, sCombatType in pairs({...}) do
		for row in GameInfo.Units("CombatClass = \'" .. sCombatType .. "\'") do
			if pPlayer:CanTrain(row.ID, bIgnoreResources) and row.Combat > tUnit.Combat then
				tUnit = row
			end
		end
	end
	--[[print("tUnit = ", tUnit)
	print("tUnit.ID = ", tUnit.ID)
	print("GameInfoTypes.tUnit = ", GameInfoTypes[tUnit])]]
	--print("GameInfoTypes.tUnit.ID = ", GameInfoTypes[tUnit].ID)
	return tUnit.ID
end

--==========================================================================================================================
-- SCHOLARS OF THE JADE HALL
--==========================================================================================================================
-- GPuz_Korea_GoldenAgeSpecialists
----------------------------------------
function GPuz_Korea_GoldenAgeSpecialists(playerID)
    local player = Players[playerID]
    if player:IsAlive() and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOREA"] then
		local specialistSejong = 0
        for city in player:Cities() do
            --specialistSejong = specialistSejong + city:GetSpecialistCount()
			for row in GameInfo.Specialists() do
				local specialistID = row.ID
				if specialistID ~= sCitizen then
					specialistSejong = specialistSejong + (city:GetSpecialistCount( specialistID ))
				end
			end
        end
		if specialistSejong ~= 0 and player:GetGoldenAgeTurns() == 0 then
			player:ChangeGoldenAgeProgressMeter(specialistSejong)
			if player:IsHuman() then
				local alertmessage = Locale.ConvertTextKey("TXT_KEY_SENSHI_GAP_SPECIALISTS", specialistSejong)
				Events.GameplayAlertMessage(alertmessage)
			end
		end
		local iGoldenAgeThreshold = player:GetGoldenAgeProgressThreshold()
		local iGoldAgeProg = player:GetGoldenAgeProgressMeter()
		if iGoldAgeProg >= iGoldenAgeThreshold then
			player:ChangeGoldenAgeProgressMeter(-iGoldenAgeThreshold)
			player:ChangeGoldenAgeTurns(player:GetGoldenAgeLength())
		end
    end
end
 
GameEvents.PlayerDoTurn.Add(GPuz_Korea_GoldenAgeSpecialists)
----------------------------------------
-- GPuz_Korea_GoldenAgeImprovements
----------------------------------------
function GPuz_Korea_GoldenAgeImprovements(playerID)
    local player = Players[playerID]
    if player:IsAlive() and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOREA"] then
        local numWorkedGreatWorkImprovements = 0
        for city in player:Cities() do
            local plot = city:Plot()
            --for loopPlot in PlotAreaSweepIterator(plot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
			for i = 0, city:GetNumCityPlots()-1, 1 do
				local loopPlot = city:GetCityIndexPlot(i)
                if loopPlot and city:IsWorkingPlot(loopPlot) then
					print("plot is being worked")
                   --[[ if loopPlot:GetImprovementType() == GameInfoTypes["IMPROVEMENT_ACADEMY"] then
                        numWorkedGreatWorkImprovements = numWorkedGreatWorkImprovements + 1
                    elseif loopPlot:GetImprovementType() == GameInfoTypes["IMPROVEMENT_CUSTOMS_HOUSE"] then
                        numWorkedGreatWorkImprovements = numWorkedGreatWorkImprovements + 1
                    elseif loopPlot:GetImprovementType() == GameInfoTypes["IMPROVEMENT_MANUFACTORY"] then
                        numWorkedGreatWorkImprovements = numWorkedGreatWorkImprovements + 1
                    elseif loopPlot:GetImprovementType() == GameInfoTypes["IMPROVEMENT_CITADEL"] then
                        numWorkedGreatWorkImprovements = numWorkedGreatWorkImprovements + 1
                    end]]
					local iImprovement = loopPlot:GetImprovementType()
					if tGPImprovements[iImprovement] then
						--print("Is on list")
						numWorkedGreatWorkImprovements = numWorkedGreatWorkImprovements + 1
					end
                end
            end
        end
		--print("numWorkedGreatWorkImprovements = ", numWorkedGreatWorkImprovements)
		if numWorkedGreatWorkImprovements ~= 0 and player:GetGoldenAgeTurns() == 0 then
			player:ChangeGoldenAgeProgressMeter(numWorkedGreatWorkImprovements)
			if player:IsHuman() then
				local alertmessage = Locale.ConvertTextKey("TXT_KEY_SENSHI_GAP_GPI", numWorkedGreatWorkImprovements)
				Events.GameplayAlertMessage(alertmessage)
			end
		end
		local iGoldenAgeThreshold = player:GetGoldenAgeProgressThreshold()
		local iGoldAgeProg = player:GetGoldenAgeProgressMeter()
		if iGoldAgeProg >= iGoldenAgeThreshold then
			player:ChangeGoldenAgeProgressMeter(-iGoldenAgeThreshold)
			player:ChangeGoldenAgeTurns(player:GetGoldenAgeLength())
		end
    end
end

GameEvents.PlayerDoTurn.Add(GPuz_Korea_GoldenAgeImprovements) -- Guys, plz - you were adding the wrong function :p

-- Pikeying code off Jifford 4 dayz
local realPolicy = GameInfoTypes["POLICY_GPUZ_KOREA"]
local dummyPolicy = GameInfoTypes["POLICY_C15_DUMMY"]

function C15_Korea_Init(playerID, isStart, turns)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local pPlayer = Players[playerID]
		if pPlayer:IsAlive() and pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOREA"] then
			if ((not pPlayer:HasPolicy(dummyPolicy)) and (not pPlayer:HasPolicy(realPolicy))) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(dummyPolicy, true)
			end
		end
	end
end

Events.LoadScreenClose.Add(C15_Korea_Init)

----------------------------------------
-- GPuz_Korea_ScienceSpecialists
----------------------------------------
function GPuz_Korea_ScienceSpecialists(playerID)
    local player = Players[playerID]
    if player:IsAlive() and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_KOREA"] then
        if player:IsGoldenAge() then
			print("G O L D E N  A G E")
			if SwapPolicy then
				if player:HasPolicy(dummyPolicy) and not player:HasPolicy(realPolicy) then
					print("Protocol 1")
					player:SwapPolicy(dummyPolicy, realPolicy)
				elseif not player:HasPolicy(dummyPolicy) and not player:HasPolicy(realPolicy) then
					print("Protocol 2")
					player:GrantPolicy(realPolicy, true)
				end
			else
				if player:HasPolicy(dummyPolicy) then
					player:SetHasPolicy(dummyPolicy, false)
				end
				if not player:HasPolicy(realPolicy) then
					player:SetHasPolicy(realPolicy, true)
				end
			end
        else
			if SwapPolicy then
				if player:HasPolicy(realPolicy) and not player:HasPolicy(dummyPolicy) then
					player:SwapPolicy(realPolicy, dummyPolicy)
				end
			else
				if player:HasPolicy(realPolicy) then
					player:SetHasPolicy(realPolicy, false)
				end
				if not player:HasPolicy(dummyPolicy) then
					player:SetHasPolicy(dummyPolicy, true)
				end
			end
        end
    end
end
 
if isUsingCPDLL then
	GameEvents.PlayerGoldenAge.Add(GPuz_Korea_ScienceSpecialists)
else
	GameEvents.PlayerDoTurn.Add(GPuz_Korea_ScienceSpecialists)
end

--==========================================================================================================================
-- IMJIN WAR
--==========================================================================================================================
--GPuz_Korea_CoastalCities
----------------------------------------
function GPuz_Korea_CoastalCitiesConquest(oldOwnerID, bCapital, cityX, cityY, newOwnerID)
    local player = Players[newOwnerID]
    if (player:IsAlive() and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_SENSHI_KOREA"]) then
        local city = Map.GetPlot(cityX, cityY):GetPlotCity()
        if city:IsCoastal() then
			local capital = player:GetCapitalCity()
            local capitalPopulation = capital:GetPopulation()*10
            if capitalPopulation < 10 then
                capitalPopulation = 10
            end
            local cultureBoost = math.ceil(capitalPopulation / 2)
            if bCapital then
                cultureBoost = math.ceil(capitalPopulation)
            end
            if player:IsHuman() and cultureBoost > 0 then
                local alertmessage = Locale.ConvertTextKey("+{1_Num} [ICON_CULTURE] [COLOR_POSITIVE_TEXT]Culture[ENDCOLOR] from conquering a Coastal City!", cultureBoost)
                Events.GameplayAlertMessage(alertmessage)
            end
            player:ChangeJONSCulture(cultureBoost)
        end
    end
end
 
function GPuz_Korea_CoastalCitiesSettled(playerID, cityX, cityY)
    local player = Players[playerID]
    if (player:IsAlive() and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_SENSHI_KOREA"]) then
        local city = Map.GetPlot(cityX, cityY):GetPlotCity()
        local capital = player:GetCapitalCity()
        if city:IsCoastal() then
            local capitalPopulation = capital:GetPopulation()*10
            local cultureBoost = math.ceil(capitalPopulation/2)
            if capitalPopulation < 10 then
                capitalPopulation = 10
            end
            if capital then
                cultureBoost = math.ceil(capitalPopulation)
            end
           
            if player:IsHuman() and cultureBoost > 0 then
                local alertmessage = Locale.ConvertTextKey("+{1_Num} [ICON_CULTURE] [COLOR_POSITIVE_TEXT]Culture[ENDCOLOR] from settling a Coastal City!", cultureBoost)
                Events.GameplayAlertMessage(alertmessage)
            end
            player:ChangeJONSCulture(cultureBoost)
        end
    end
end
 
GameEvents.CityCaptureComplete.Add(GPuz_Korea_CoastalCitiesConquest)  
GameEvents.PlayerCityFounded.Add(GPuz_Korea_CoastalCitiesSettled)
----------------------------------------
-- GPuz_Korea_NavyRallied
----------------------------------------
--[[local militarySupport = {}
    militarySupport["ERA_ANCIENT"]          = "UNIT_TRIREME"
    militarySupport["ERA_CLASSICAL"]        = "UNIT_TRIREME"
    militarySupport["ERA_MEDIEVAL"]         = "UNIT_GALLEASS"
    if isUsingEnlightenmentEra then
        militarySupport["ERA_MEDIEVAL"]     = "UNIT_EE_CARRACK"
    end
    militarySupport["ERA_RENAISSANCE"]      = "UNIT_KOREAN_TURTLE_SHIP"
    militarySupport["ERA_ENLIGHTENMENT"]    = "UNIT_EE_GALLEON"
    militarySupport["ERA_INDUSTRIAL"]       = "UNIT_IRONCLAD"
    militarySupport["ERA_MODERN"]           = "UNIT_DESTROYER"
    militarySupport["ERA_POSTMODERN"]       = "UNIT_DESTROYER"
    militarySupport["ERA_FUTURE"]           = "UNIT_DESTROYER"]]
   
-- GPuz_Korea_NavyRalliedSummon
function GPuz_Korea_NavyRalliedSummon(teamID, otherTeamID)
    local team = Teams[teamID]
    local otherTeam = Teams[otherTeamID]
    local attackingPlayerID = team:GetLeaderID()
    local attackingPlayer = Players[attackingPlayerID]
    local playerID = otherTeam:GetLeaderID()
    local player = Players[playerID]
    if (player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_SENSHI_KOREA"]) and (not attackingPlayer:IsMinorCiv()) and (Teams[player:GetTeam()]:IsHasTech(GameInfoTypes["TECH_SAILING"])) then
        local numCoastalCities = 0
        for city in player:Cities() do
            if city:IsCoastal() then
                --numCoastalCities = numCoastalCities + 1
				local unitID = GetStrongestMilitaryUnit(player, false, "UNITCOMBAT_NAVALMELEE")
				local pNewUnit = player:InitUnit(unitID, city:GetX(), city:GetY())
				local tUnitData = GetValidPromotionsAndExperienceFromCityBuildings(unitID, player, city)
				pNewUnit:ChangeExperience(tUnitData.Experience)
				for key, iPromoID in pairs(tUnitData.Promotions) do
					pNewUnit:SetHasPromotion(iPromoID, true)
				end
				pNewUnit:JumpToNearestValidPlot()
            end
        end
        --[[for loopCount =1,numCoastalCities do
            local currentEra = GameInfo.Eras[player:GetCurrentEra()]
            local unitID = militarySupport[currentEra.Type]
            player:InitUnit(unitID, capital:GetX(), capital:GetY())
        end]]
        if player:IsHuman() then
            Events.GameplayAlertMessage(Locale.ConvertTextKey("Your people have rallied to the defence of the kingdom by joining the navy!"))
        end
    end
end
 
GameEvents.DeclareWar.Add(GPuz_Korea_NavyRalliedSummon)
--==========================================================================================================================
-- TURTLE SHIP
--==========================================================================================================================
-- GPuz_TurtleShip_Admirals
----------------------------------------
 
function GPuz_TurtleShip_Admirals(playerID, unitID)
    local player = Players[playerID]
    if player:IsAlive() and player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_SENSHI_KOREA"] then
        local unit = player:GetUnitByID(unitID)
        if unit:GetUnitType() == GameInfoTypes["UNIT_KOREAN_TURTLE_SHIP"] then -- Jesus Senshi, you could've told him you changed the unit!
        local unitExperience = unit:GetExperience()
            if unitExperience > 0 then
                player:ChangeNavalCombatExperience(unitExperience)
                if player:IsHuman() then
                    Events.GameplayAlertMessage(Locale.ConvertTextKey("+{1_Num} [ICON_GREAT_PEOPLE] [COLOR_POSITIVE_TEXT]Great Admiral[ENDCOLOR] points from building a Turtle Ship", unitExperience))
                end
            end
        end
    end
end

LuaEvents.SerialEventUnitCreatedGood.Add(GPuz_TurtleShip_Admirals)