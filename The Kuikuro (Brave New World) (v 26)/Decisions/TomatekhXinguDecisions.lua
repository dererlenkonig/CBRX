print("Xingu Decisions")

local bXingu = GameInfoTypes.BUILDING_XINGU_POLICY_DUMMY;

local uArchaeologist = GameInfoTypes.UNIT_ARCHAEOLOGIST;
local cRecon = GameInfoTypes.UNITCOMBAT_RECON;
local eIndustrial = GameInfoTypes.ERA_INDUSTRIAL;

local pExpOpener = GameInfoTypes.POLICY_EXPLORATION;
local pExploration = GameInfoTypes.POLICY_BRANCH_EXPLORATION;
local pExpFinisher = GameInfoTypes.POLICY_EXPLORATION_FINISHER;

local pExpFinisherDummy = GameInfoTypes.POLICY_EXPLORATION_FINISHER_DUMMY;
local pXingu = GameInfoTypes.POLICY_XINGU_LOST_CITY;

local pExp1 = GameInfoTypes.POLICY_MARITIME_INFRASTRUCTURE;
local pExp2 = GameInfoTypes.POLICY_MERCHANT_NAVY;
local pExp3 = GameInfoTypes.POLICY_NAVAL_TRADITION;
local pExp4 = GameInfoTypes.POLICY_NAVIGATION_SCHOOL;
local pExp5 = GameInfoTypes.POLICY_TREASURE_FLEETS;

function GetWeLoveCount(pPlayer)	
	local cWeLove = 0;
	for pCity in pPlayer:Cities() do
		if (pCity:GetWeLoveTheKingDayCounter() >= 1) then
			cWeLove = 1;
			break
		end
	end
	return cWeLove;
end

--Lost City
local Decisions_XinguLostCity = {}
	Decisions_XinguLostCity.Name = "TXT_KEY_DECISIONS_TOMATEKH_LOST_CITY"
	Decisions_XinguLostCity.Desc = "TXT_KEY_DECISIONS_TOMATEKH_LOST_CITY_DESC"
	HookDecisionCivilizationIcon(Decisions_XinguLostCity, "CIVILIZATION_XINGU_MOD")
	Decisions_XinguLostCity.Weight = nil
	Decisions_XinguLostCity.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_XINGU_MOD"]) then return false, false end
		if load(pPlayer, "Decisions_XinguLostCity") == true then
			Decisions_XinguLostCity.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOMATEKH_LOST_CITY_ENACTED_DESC")
			return false, false, true
		end		

		local iCost = math.ceil(800 * iMod);
		local cMagistrate = 2;
		if pPlayer:HasPolicy(pExpFinisher) then
			iCost = math.ceil(100 * iMod);
			cMagistrate = 1;
		end

		Decisions_XinguLostCity.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOMATEKH_LOST_CITY_DESC", iCost, cMagistrate)

		if (pPlayer:GetGold() < iCost) then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < cMagistrate) then return true, false end

		local aCount = 0;
		local rCount = 0;
		for pUnit in pPlayer:Units() do
			if (pUnit:GetUnitType() == uArchaeologist) then
				aCount = aCount + 1;
			end
			if (pUnit:GetUnitCombatType() == cRecon) then
				rCount = rCount + 1;
			end
		end
		if aCount < 2 then return true, false end
		if rCount < 2 then return true, false end

		--if not pPlayer:IsPolicyBranchUnlocked(pExploration) then return true, false end

		local pTeam = pPlayer:GetTeam();
		if (Teams[pTeam]:GetCurrentEra() < eIndustrial) then return true, false end

		return true, true
	end
	)
	
	Decisions_XinguLostCity.DoFunc = (
	function(pPlayer)

		local iCost = math.ceil(800 * iMod);
		local cMagistrate = 2;
		if pPlayer:HasPolicy(pExpFinisher) then
			iCost = math.ceil(100 * iMod);
			cMagistrate = 1;
		end

		pPlayer:ChangeNumResourceTotal(iMagistrate, -cMagistrate)
		pPlayer:ChangeGold(-iCost);

		if not pPlayer:HasPolicy(pExpFinisherDummy) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(pExpFinisherDummy, true);
		end

		if (pPlayer:HasPolicy(pExp1)) and (pPlayer:HasPolicy(pExp2)) and (pPlayer:HasPolicy(pExp3)) and (pPlayer:HasPolicy(pExp4)) and (pPlayer:HasPolicy(pExp5)) then
			if not pPlayer:HasPolicy(pXingu) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(pXingu, true);
			end
			for pCity in pPlayer:Cities() do
				if not (pCity:IsHasBuilding(bXingu)) then
					pCity:SetNumRealBuilding(bXingu, 1);
				end
			end
		end

		save(pPlayer, "Decisions_XinguLostCity", true)

	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_XINGU_MOD"], "Decisions_XinguLostCity", Decisions_XinguLostCity)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes["CIVILIZATION_XINGU_MOD"]) then
			if load(pPlayer, "Decisions_XinguLostCity") == true then
				if (pPlayer:HasPolicy(pExp1)) and (pPlayer:HasPolicy(pExp2)) and (pPlayer:HasPolicy(pExp3)) and (pPlayer:HasPolicy(pExp4)) and (pPlayer:HasPolicy(pExp5)) then
					if not pPlayer:HasPolicy(pXingu) then
						pPlayer:SetNumFreePolicies(1)
						pPlayer:SetNumFreePolicies(0)
						pPlayer:SetHasPolicy(pXingu, true);
					end
					for pCity in pPlayer:Cities() do
						if not (pCity:IsHasBuilding(bXingu)) then
							pCity:SetNumRealBuilding(bXingu, 1);
						end
					end
				end
			end
		end
	end
end)

--Quarup Festival
local Decisions_XinguQuarup = {}
	Decisions_XinguQuarup.Name = "TXT_KEY_DECISIONS_TOMATEKH_QUARUP"
	Decisions_XinguQuarup.Desc = "TXT_KEY_DECISIONS_TOMATEKH_QUARUP_DESC"
	HookDecisionCivilizationIcon(Decisions_XinguQuarup, "CIVILIZATION_XINGU_MOD")
	Decisions_XinguQuarup.Weight = nil
	Decisions_XinguQuarup.CanFunc = (
	function(pPlayer)		
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_XINGU_MOD"]) then return false, false end
		if load(pPlayer, "Decisions_XinguQuarup") == true then
			Decisions_XinguQuarup.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOMATEKH_QUARUP_ENACTED_DESC")
			return false, false, true
		end		

		local iCost = math.ceil(50 * iMod)
		Decisions_XinguQuarup.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TOMATEKH_QUARUP_DESC", iCost)

		if (pPlayer:GetJONSCulture() < iCost) then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local cUnitCount = 0;
		for pUnit in pPlayer:Units() do
			if (pUnit:IsCombatUnit()) then
				cUnitCount = cUnitCount + 1;
			end
		end
		if cUnitCount < 4 then return true, false end

		local cWeLove = GetWeLoveCount(pPlayer);
		if cWeLove < 1 then return true, false end

		return true, true
	end
	)
	
	Decisions_XinguQuarup.DoFunc = (
	function(pPlayer)

		local iCost = math.ceil(50 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		for pCity in pPlayer:Cities() do
			local iName = Locale.ConvertTextKey(pCity:GetName());
			if (pCity:GetWeLoveTheKingDayCounter() >= 1) then
				if (pCity:GetWeLoveTheKingDayCounter() < 19) then
					if (pCity:GetWeLoveTheKingDayCounter() > 1) then
						save(pPlayer, "Festival " .. iName .. " bool", true)
					elseif (pCity:GetWeLoveTheKingDayCounter() == 1) then
						pCity:ChangeWeLoveTheKingDayCounter(10)
					end
				end
			end
		end

		save(pPlayer, "Decisions_XinguQuarup", true)

	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_XINGU_MOD"], "Decisions_XinguQuarup", Decisions_XinguQuarup)

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_XINGU_MOD) then
			if load(pPlayer, "Decisions_XinguQuarup") == true then
				for pCity in pPlayer:Cities() do
					local iName = Locale.ConvertTextKey(pCity:GetName());
					if (pCity:GetWeLoveTheKingDayCounter() == 19) then
						save(pPlayer, "Festival " .. iName .. " bool", true)
					end
					if (pCity:GetWeLoveTheKingDayCounter() == 1) then 
						if load(pPlayer, "Festival " .. iName .. " bool") == true then
							pCity:ChangeWeLoveTheKingDayCounter(10)
							save(pPlayer, "Festival " .. iName .. " bool", false)
						end
					end
				end
			end
		end
	end
end)

