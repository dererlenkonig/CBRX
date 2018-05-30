-- C15_Iroquois_Decisions
-- Author: Chrisy15
-- DateCreated: 12/9/2017 11:59:25 AM
--------------------------------------------------------------

print("C15's Iroquois Decisions: Loaded")

include("C15_Iroquois_Utils.lua")

tDecisions.Decisions_IroquoisLawofPeace = nil
tDecisions.Decisions_JFD_Iroquois_LawOfPeace = nil

local civilizationID = GameInfoTypes["CIVILIZATION_IROQUOIS"]
local iPolicyReduceDummy = GameInfoTypes["BUILDING_C15_IROQUOIS_DECISION_POLICY_REDUCE"]

local tElder = {}
tElder["NATION_C15_ONONDAGA"] = true
tElder["NATION_C15_MOHAWK"] = true
tElder["NATION_C15_SENECA"] = true

local tYounger = {}
tYounger["NATION_C15_ONEIDA"] = true
tYounger["NATION_C15_CAYUGA"] = true
tYounger["NATION_C15_TUSCO"] = true

function C15_PolicyReduceGrant(playerID)
	local pPlayer = Players[playerID]
	if pPlayer:IsAlive() then
		local iElder = load(pPlayer, "Decisions_C15_Iroquois_Council_Elder")
		local iYounger = load(pPlayer, "Decisions_C15_Iroquois_Council_Younger")
		local iEra = pPlayer:GetCurrentEra()
		local iNum = 0
		if iElder and iElder == iEra then
			for pCity in pPlayer:Cities() do
				if tElder[C15_GetCityNation(pCity)] and iNum < 10 then
					pCity:SetNumRealBuilding(iPolicyReduceDummy, 1)
					iNum = iNum + 1
				else
					pCity:SetNumRealBuilding(iPolicyReduceDummy, 0)
				end
			end
		elseif iYounger and iYounger == iEra then
			for pCity in pPlayer:Cities() do
				if tYounger[C15_GetCityNation(pCity)] and iNum < 10 then
					pCity:SetNumRealBuilding(iPolicyReduceDummy, 1)
					iNum = iNum + 1
				else
					pCity:SetNumRealBuilding(iPolicyReduceDummy, 0)
				end
			end
		end
	end
end

function C15_PolicyReduceEra(teamID, eraID)
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local pPlayer = Players[i]
		if pPlayer:GetTeam() == teamID then
			local iElder = load(pPlayer, "Decisions_C15_Iroquois_Council_Elder")
			local iYounger = load(pPlayer, "Decisions_C15_Iroquois_Council_Younger")
			if (iElder and iElder < eraID) or (iYounger and iYounger < eraID) then
				for pCity in pPlayer:Cities() do
					pCity:SetNumRealBuilding(iPolicyReduceDummy, 0)
				end
			end
		end
	end
end

local Decisions_C15_Iroquois_Council_Elder = {}
	Decisions_C15_Iroquois_Council_Elder.Name = "TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_ELDER"
	Decisions_C15_Iroquois_Council_Elder.Desc = "TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_ELDER_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_Iroquois_Council_Elder, "CIVILIZATION_IROQUOIS")
	Decisions_C15_Iroquois_Council_Elder.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		local iEra = pPlayer:GetCurrentEra()
		local iLoadEra = load(pPlayer, "Decisions_C15_Iroquois_Council_Elder")
		if iLoadEra ~= nil then
			if iLoadEra < iEra then
				save(pPlayer, "Decisions_C15_Iroquois_Council_Elder", nil)
			else
				Decisions_C15_Iroquois_Council_Elder.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_ELDER_DESC_ENACTED")
				return false, false, true
			end
		end
		
		local bCity = false
		for pCity in pPlayer:Cities() do
			if tElder[C15_GetCityNation(pCity)] then
				bCity = true
				break
			end
		end
		
		local iCulture = math.floor(pPlayer:GetNextPolicyCost() * 0.75)
		
		Decisions_C15_Iroquois_Council_Elder.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_ELDER_DESC", iCulture)
		
		if load(pPlayer, "Decisions_C15_Iroquois_Council_Younger") == iEra then return true, false end
		if not bCity then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if iLoadEra and iEra < iLoadEra then return true, false end
		if pPlayer:GetJONSCulture() < iCulture then return true, false end
		
		return true, true
	end
	)
	
	Decisions_C15_Iroquois_Council_Elder.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeJONSCulture(math.floor(pPlayer:GetNextPolicyCost() * -0.75))
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		save(pPlayer, "Decisions_C15_Iroquois_Council_Elder", pPlayer:GetCurrentEra())
		C15_PolicyReduceGrant(pPlayer:GetID())
	end
	)
	
local Decisions_C15_Iroquois_Council_Younger = {}
	Decisions_C15_Iroquois_Council_Younger.Name = "TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_YOUNGER"
	Decisions_C15_Iroquois_Council_Younger.Desc = "TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_YOUNGER_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_Iroquois_Council_Younger, "CIVILIZATION_IROQUOIS")
	Decisions_C15_Iroquois_Council_Younger.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilizationID then return false, false end
		local iEra = pPlayer:GetCurrentEra()
		local iLoadEra = load(pPlayer, "Decisions_C15_Iroquois_Council_Younger")
		if iLoadEra ~= nil then
			if iLoadEra < iEra then
				save(pPlayer, "Decisions_C15_Iroquois_Council_Younger", nil)
			else
				Decisions_C15_Iroquois_Council_Younger.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_YOUNGER_DESC_ENACTED")
				return false, false, true
			end
		end
		
		local bCity = false
		for pCity in pPlayer:Cities() do
			if tYounger[C15_GetCityNation(pCity)] then
				bCity = true
				break
			end
		end
		
		local iCulture = math.floor(pPlayer:GetNextPolicyCost() * 0.75)
		
		Decisions_C15_Iroquois_Council_Younger.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_YOUNGER_DESC", iCulture)
		
		if load(pPlayer, "Decisions_C15_Iroquois_Council_Elder") == iEra then return true, false end
		if not bCity then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if iLoadEra and iEra < iLoadEra then return true, false end
		if pPlayer:GetJONSCulture() < iCulture then return true, false end
		
		return true, true
	end
	)
	
	Decisions_C15_Iroquois_Council_Younger.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeJONSCulture(math.floor(pPlayer:GetNextPolicyCost() * -0.75))
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		save(pPlayer, "Decisions_C15_Iroquois_Council_Younger", pPlayer:GetCurrentEra())
		C15_PolicyReduceGrant(pPlayer:GetID())
	end
	)
	
	Decisions_C15_Iroquois_Council_Elder.Monitors = {}
	Decisions_C15_Iroquois_Council_Younger.Monitors = {}
	Decisions_C15_Iroquois_Council_Elder.Monitors[GameEvents.PlayerDoTurn] = (C15_PolicyReduceGrant)
	Decisions_C15_Iroquois_Council_Younger.Monitors[GameEvents.PlayerDoTurn] = (C15_PolicyReduceGrant)
	Decisions_C15_Iroquois_Council_Elder.Monitors[GameEvents.TeamSetEra] = (C15_PolicyReduceEra)
	Decisions_C15_Iroquois_Council_Younger.Monitors[GameEvents.TeamSetEra] = (C15_PolicyReduceEra)
	
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_C15_Iroquois_Council_Elder", Decisions_C15_Iroquois_Council_Elder)
Decisions_AddCivilisationSpecific(civilizationID, "Decisions_C15_Iroquois_Council_Younger", Decisions_C15_Iroquois_Council_Younger)

print("C15's Iroquois Decisions: Loaded to End")
