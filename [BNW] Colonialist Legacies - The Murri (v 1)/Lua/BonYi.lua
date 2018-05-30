-- BonYi
-- Author: calcul8or
-- DateCreated: 5/7/2016 5:13:53 AM
--------------------------------------------------------------
include( "BonYi_SaveUtils.lua" ); MY_MOD_NAME = "BonYi";
print("Bon Yi functions loaded")

local civID = GameInfoTypes["CIVILIZATION_CL_MURRI"]
local growthBldg = GameInfoTypes["BUILDING_BON_YI_GROWTH_DUMMY"]

--============================================================
-- Is Civ Active?
--============================================================
function IsCivilisationActive(civilizationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == GameInfoTypes["CIVILIZATION_CL_MURRI"] then
				print("Generic Civ is here");
				GameEvents.PlayerDoTurn.Add(FaithBorders)
				GameEvents.CityBoughtPlot.Add(GrowthBonus)
				GameEvents.PlayerDoTurn.Add(GrowthCheck)
			end
		end
	end
end

Events.SequenceGameInitComplete.Add(IsCivilisationActive)

--============================================================
-- Faith Contributes to Border Growth
--============================================================

function FaithBorders(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civID) then
		local capCity = pPlayer:GetCapitalCity();
		for city in pPlayer:Cities() do
			local cityFaith = city:GetFaithPerTurn();
			if (city and cityFaith > 0) then
				print("Producing Faith");
				local cityDistance = Map.PlotDistance(city:GetX(), city:GetY(), capCity:GetX(), capCity:GetY())
				local distMod = math.max((cityDistance / 8), 1)
				local FaithBonus = math.floor(cityFaith * distMod)
				city:ChangeJONSCultureStored(FaithBonus)
				print("Changed stored culture by " .. FaithBonus);
			end
		end
	end
end

--============================================================
-- Border Growth yields extra food
--============================================================

function GrowthBonus(playerID, iCity, iPlotX, iPlotY, bGold, bFaithOrCulture)
	local pPlayer = Players[playerID]
	if (pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civID) then
		-- Add bonus building
		local pCity = pPlayer:GetCityByID(iCity)
		pCity:SetNumRealBuilding(growthBldg, 1)
		-- save city, current turn
		local turn = Game.GetGameTurn()
		save(pPlayer, iCity, turn)
		print("Turn " .. turn .. " saved for  " .. pCity:GetName());
		-- add PlayerDoTurn check for bonus building
		-- load city, applied turn
		-- if current turn - applied turn > 5, remove building
	end
end

function GrowthCheck(playerID)
	local pPlayer = Players[playerID]
	if (pPlayer:IsAlive() and pPlayer:GetCivilizationType() == civID) then
		for city in pPlayer:Cities() do
			print("Checking cities for building");
			if city:IsHasBuilding(growthBldg) then
				print("City has building, check for how long");
				local cityID = city:GetID()
				local startTurn = load(pPlayer, cityID, turn)
				local currentTurn = Game.GetGameTurn()
				print("StartTurn is " .. startTurn .. " and currentTurn is " .. currentTurn);
				if (currentTurn > (startTurn + 3)) then
					print("Removing building");
					city:SetNumRealBuilding(growthBldg, 0)
					save(pPlayer, cityID, nil)
				end
			end
		end
	end
end