-- Leugi Latin American Event
-- Author: Leugi
--=======================================================================================================================
print("Leugi's Latin American Event: loaded for Haiti")
--=======================================================================================================================
-- PurchaseHoungan
iRitualGiftUnit = GameInfoTypes.UNIT_LEUGI_HOUNGAN
iRitualMissionaryUnit = GameInfoTypes.UNIT_MISSIONARY

function PurchaseHoungan(pPlayer)
	local faith = pPlayer:GetFaith();
	local movedUnits = nil;
	for city in pPlayer:Cities() do
			if (city:IsCapital()) then
			-- Add cost
			local faithCost = city:GetUnitFaithPurchaseCost(iRitualGiftUnit, true);
			pPlayer:SetFaith(faith + faithCost);
			-- Move city units
			movedUnits = {};
			local cityPlot = city:Plot();
			-- Do it backward because some units are actually not moved and would cause an infinite loop. Fuck Civ5.
			for i = cityPlot:GetNumUnits() - 1, 0, -1 do
				local movedUnit = cityPlot:GetUnit(i);
				table.insert(movedUnits, movedUnit);
				movedUnit:JumpToNearestValidPlot();
			end
			-- Try purchase
			-- Sucess can sometimes be true while it should be false. Does not happen in the production popup, only here. Most puzzling civ5 bug ever. Fuck civ5.
			local success = city:IsCanPurchase(false, false, iRitualGiftUnit, -1, -1, YieldTypes.YIELD_FAITH) and city:IsCanPurchase(true, true, iRitualGiftUnit, -1, -1, YieldTypes.YIELD_FAITH);
			if success then
				print("purchasing unit");
				Game.CityPurchaseUnit(city, iRitualGiftUnit, YieldTypes.YIELD_FAITH);
			end

			-- try again for missionary if no Whoward's DLL is there

			-- Add cost
			local faithCost = city:GetUnitFaithPurchaseCost(iRitualMissionaryUnit, true);
			pPlayer:SetFaith(faith + faithCost);
			-- Move city units
			movedUnits = {};
			local cityPlot = city:Plot();
			-- Do it backward because some units are actually not moved and would cause an infinite loop. Fuck Civ5.
			for i = cityPlot:GetNumUnits() - 1, 0, -1 do
				local movedUnit = cityPlot:GetUnit(i);
				table.insert(movedUnits, movedUnit);
				movedUnit:JumpToNearestValidPlot()
			end
			-- Try purchase
			-- Sucess can sometimes be true while it should be false. Does not happen in the production popup, only here. Most puzzling civ5 bug ever. Fuck civ5.
			local success = city:IsCanPurchase(false, false, iRitualMissionaryUnit, -1, -1, YieldTypes.YIELD_FAITH) and city:IsCanPurchase(true, true, iRitualMissionaryUnit, -1, -1, YieldTypes.YIELD_FAITH);
			if success then
				print("purchasing unit");
				Game.CityPurchaseUnit(city, iRitualMissionaryUnit, YieldTypes.YIELD_FAITH);
			end
			end
		end
end

--------------------------------------------------------------------------------------------------------------------------
local Event_Leugi_Haiti_Independence = {}
	Event_Leugi_Haiti_Independence.Name = "TXT_KEY_EVENT_LATIN_AMERICAN_INDEPENDENCE"
	Event_Leugi_Haiti_Independence.Desc = "TXT_KEY_EVENT_LATIN_AMERICAN_INDEPENDENCE_HAITI_DESC"
	Event_Leugi_Haiti_Independence.Weight = 0
	Event_Leugi_Haiti_Independence.CanFunc = (
		function(pPlayer)
			--
			-- Check if the event fired before			
			if load(pPlayer, "Event_LatinAmericanIndie") == true then return false end
			--
			-- Check the Civ
			if pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_LEUGI_HAITI"] then return false end
			--
			-- Fire the Event!
			Event_Leugi_Haiti_Independence.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_LATIN_AMERICAN_INDEPENDENCE_HAITI_DESC")
		
			return true
		end
		)
	Event_Leugi_Haiti_Independence.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Leugi_Haiti_Independence.Outcomes[1] = {}
	Event_Leugi_Haiti_Independence.Outcomes[1].Name = "TXT_KEY_EVENT_LATIN_AMERICAN_INDEPENDENCE_HAITI_OUTCOME_1"
	Event_Leugi_Haiti_Independence.Outcomes[1].Desc = "TXT_KEY_EVENT_LATIN_AMERICAN_INDEPENDENCE_OUTCOME_HAITI_RESULT_1"
	Event_Leugi_Haiti_Independence.Outcomes[1].Weight = 1
	Event_Leugi_Haiti_Independence.Outcomes[1].CanFunc = (
		function(pPlayer)			
			Event_Leugi_Haiti_Independence.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_LATIN_AMERICAN_INDEPENDENCE_OUTCOME_HAITI_RESULT_1")
			return true
		end
		)
	Event_Leugi_Haiti_Independence.Outcomes[1].DoFunc = (
		function(pPlayer) 
			pPlayer:ChangeGoldenAgeTurns(30)
			InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_HOUNGAN, 4)		
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_LATINAMERICAN_INDEPENDENCE, true);
		

			save(pPlayer, "Event_LatinAmericanIndie", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_LATIN_AMERICAN_INDEPENDENCE_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_LATIN_AMERICAN_INDEPENDENCE"))
		end)

Events_AddCivilisationSpecificScheduled(GameInfoTypes["CIVILIZATION_LEUGI_HAITI"], "Event_Leugi_Haiti_Independence", Event_Leugi_Haiti_Independence, 1804, true)


--=======================================================================================================================
--=======================================================================================================================


-- IndependenceScripts
--------------------------------------------------------------

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LatinAmericanIndependence";


function RemoveIndependence(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		PlayerInTurn = pPlayer
		if (pPlayer:GetGoldenAgeTurns() < 1) then
			if (pPlayer:HasPolicy(GameInfo.Policies["POLICY_LATINAMERICAN_INDEPENDENCE"].ID)) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(GameInfoTypes.POLICY_LATINAMERICAN_INDEPENDENCE, false);
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(RemoveIndependence);

--

function UnitKilledIndependence(iKiller, iPlayer, iUnitType)
	local pPlayer = Players[iKiller]
	if (pPlayer:IsAlive()) then
		if (pPlayer:HasPolicy(GameInfo.Policies["POLICY_LATINAMERICAN_INDEPENDENCE"].ID)) then
			InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_KILLING_TOURISM, 1)
			pPlayer:ChangeGoldenAgeTurns(1)
		end
	end
end



GameEvents.UnitKilledInCombat.Add(UnitKilledIndependence)


local iTourismKillID = GameInfo.Units.UNIT_KILLING_TOURISM.ID
local iTourismConquerID = GameInfo.Units.UNIT_CONQUER_TOURISM.ID

function KillTourism(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
        if pPlayer:GetUnitByID(iUnit) ~= nil then
			pUnit = pPlayer:GetUnitByID(iUnit);
            if (pUnit:GetUnitType() == iTourismKillID)  or (pUnit:GetUnitType() == iTourismConquerID) then
				Events.SerialEventUnitCreated.Remove(KillTourism)
				pUnit:Kill();
				Events.SerialEventUnitCreated.Add(KillTourism)
            end
        end
    end
end

Events.SerialEventUnitCreated.Add(KillTourism)

function OnCityCaptureComplete(iOldOwner, bIsCapital, iCityX, iCityY, iNewOwner, iPop, bConquest)
  --print("A city has been acquired by someone ...")
	local pNewOwner = Players[iNewOwner]
	local pPlayer = pNewOwner
	local plotCity = Map.GetPlot(iCityX, iCityY):GetPlotCity()
	pCity = plotCity:GetID()
	if (pPlayer:HasPolicy(GameInfo.Policies["POLICY_LATINAMERICAN_INDEPENDENCE"].ID)) then
	
			WasCapturedBefore = load ( pPlayer, "LatinAmericanCapture" .. iCityX .. iCityY .. "")
			if (WasCapturedBefore ~= true) or (pCity:GetOriginalOwner() ~= pPlayer) then
				local ResourceDesc = nil
				save ( pPlayer, "LatinAmericanCapture" .. iCityX .. iCityY .. "", true)
				pPlayer:ChangeGoldenAgeTurns(1)
				InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_CONQUER_TOURISM, 1)
			end	
		end
end

GameEvents.CityCaptureComplete.Add(OnCityCaptureComplete)