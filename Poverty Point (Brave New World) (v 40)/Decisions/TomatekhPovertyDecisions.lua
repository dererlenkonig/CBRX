print("Poverty Point Decisions")

--Stuff
local iMound = GameInfo.Improvements["IMPROVEMENT_CEREMONIAL_MOUND_MOD"].ID
--local tTheology = GameInfoTypes.TECH_THEOLOGY;
local tTheology = GameInfoTypes.TECH_ASTRONOMY;

--Place of Rings
local Decisions_PovertyRings = {}
	Decisions_PovertyRings.Name = "TXT_KEY_DECISIONS_TOMATEKH_POVERTY_1"
	Decisions_PovertyRings.Desc = "TXT_KEY_DECISIONS_TOMATEKH_POVERTY_1_DESC"
	HookDecisionCivilizationIcon(Decisions_PovertyRings, "CIVILIZATION_POVERTY_POINT_MOD")
	Decisions_PovertyRings.Weight = nil
	Decisions_PovertyRings.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then return false, false end
		if load(pPlayer, "Decisions_PovertyRings") == true then
			Decisions_PovertyRings.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOMATEKH_POVERTY_1_ENACTED_DESC")
			return false, false, true
		end		
	
		local CityCount = pPlayer:GetNumCities();
		local BaseGold = (CityCount * 50);
		local iCost = math.ceil(BaseGold * iMod);

		Decisions_PovertyRings.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOMATEKH_POVERTY_1_DESC", iCost)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetGold() < iCost) then return true, false end

		local cMound = pPlayer:GetImprovementCount(iMound);
		if cMound < 1 then return true, false end

		local pcCity = pPlayer:GetCapitalCity();
		if pcCity:GetPopulation() < 6 then return true, false end

		return true, true
	end
	)
	
	Decisions_PovertyRings.DoFunc = (
	function(pPlayer)
		
		local CityCount = pPlayer:GetNumCities();
		local BaseGold = (CityCount * 50);
		local iCost = math.ceil(BaseGold * iMod);

		pPlayer:ChangeGold(-iCost);
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2);
		save(pPlayer, "Decisions_PovertyRings", true);

		for pCity in pPlayer:Cities() do
			local cPlot = pCity:Plot();
			local plotX = cPlot:GetX();
			local plotY = cPlot:GetY();
			local iRange = 3;
			for iDX = -iRange, iRange do
				for iDY = -iRange, iRange do
					local pTargetPlot = Map.PlotXYWithRangeCheck(plotX, plotY, iDX, iDY, iRange);
					if pTargetPlot then			
						local pPlot = pTargetPlot;
						local iDistance = Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), cPlot:GetX(), cPlot:GetY());
						if iDistance == 3 then
							if pPlot:GetOwner() == -1 then
								if not pPlot:IsWater() then
									local pID = pPlayer:GetID();
									local CityID = pCity:GetID();
									pPlot:SetOwner(pID, CityID, true, true);
									pPlot:SetRevealed(pTeam, true);
								end
							end
						end
					end
				end
			end
		end

	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"], "Decisions_PovertyRings", Decisions_PovertyRings)

--Stuff
local uProphet = GameInfoTypes.UNITCLASS_PROPHET;
local pFood1 = GameInfoTypes.POLICY_POVERTY_MOUND_FOOD_1;
local pFood2 = GameInfoTypes.POLICY_POVERTY_MOUND_FOOD_2;
local bFaith1 = GameInfoTypes.BUILDING_POVERTY_DECISION_FAITH;

function GetLoveCount(pPlayer)	
	local cWeLove = 0;
	for pCity in pPlayer:Cities() do
		if (pCity:GetWeLoveTheKingDayCounter() >= 1) then
			cWeLove = 1;
			break
		end
	end
	return cWeLove;
end

--Fox and Owl
local Decisions_PovertyFeast = {}
	Decisions_PovertyFeast.Name = "TXT_KEY_DECISIONS_TOMATEKH_POVERTY_2"
	Decisions_PovertyFeast.Desc = "TXT_KEY_DECISIONS_TOMATEKH_POVERTY_2_DESC"
	HookDecisionCivilizationIcon(Decisions_PovertyFeast, "CIVILIZATION_POVERTY_POINT_MOD")
	Decisions_PovertyFeast.Weight = nil
	Decisions_PovertyFeast.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then return false, false end
		if load(pPlayer, "Decisions_PovertyFeast") == true then
			Decisions_PovertyFeast.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOMATEKH_POVERTY_2_ENACTED_DESC")
			return false, false, true
		end		
	
		local iCost = math.ceil(150 * iMod)
		Decisions_PovertyFeast.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOMATEKH_POVERTY_2_DESC", iCost)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		if (pPlayer:GetJONSCulture() < iCost) then return true, false end

		local cMound = pPlayer:GetImprovementCount(iMound);
		if cMound < 2 then return true, false end

		if pPlayer:GetUnitClassCount(uProphet) < 1 then return true, false end

		local cWeLove = GetLoveCount(pPlayer);
		if cWeLove < 1 then return true, false end

		return true, true
	end
	)
	
	Decisions_PovertyFeast.DoFunc = (
	function(pPlayer)

		local iCost = math.ceil(150 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1);
		save(pPlayer, "Decisions_PovertyFeast", true);

		if not pPlayer:HasPolicy(pFood1) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(pFood1, true);
		end

		local pTeam = pPlayer:GetTeam();
		if (Teams[pTeam]:IsHasTech(tTheology)) then 
			if not pPlayer:HasPolicy(pFood2) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pFood2, true);
			end
		end

		for pCity in pPlayer:Cities() do
			if (pCity:GetWeLoveTheKingDayCounter() >= 1) then
				if not (pCity:IsHasBuilding(bFaith1)) then
					pCity:SetNumRealBuilding(bFaith1, 1);
				end
			end
		end

	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"], "Decisions_PovertyFeast", Decisions_PovertyFeast)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_POVERTY_POINT_MOD"]) then
			if load(pPlayer, "Decisions_PovertyFeast") == true then
				local pTeam = pPlayer:GetTeam();
				if (Teams[pTeam]:IsHasTech(tTheology)) then 
					if not pPlayer:HasPolicy(pFood2) then
						pPlayer:SetNumFreePolicies(1)
						pPlayer:SetNumFreePolicies(0)
						pPlayer:SetHasPolicy(pFood2, true);
					end
				end
				for pCity in pPlayer:Cities() do
					if (pCity:IsHasBuilding(bFaith1)) then
						if (pCity:GetWeLoveTheKingDayCounter() <= 0) then
							pCity:SetNumRealBuilding(bFaith1, 0);
						end
					elseif not (pCity:IsHasBuilding(bFaith1)) then
						if (pCity:GetWeLoveTheKingDayCounter() >= 1) then
							pCity:SetNumRealBuilding(bFaith1, 1);
						end
					end
				end
			end
		end
	end
end)