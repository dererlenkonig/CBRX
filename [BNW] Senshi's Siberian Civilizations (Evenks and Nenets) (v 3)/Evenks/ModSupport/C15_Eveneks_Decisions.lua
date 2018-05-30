-- C15_Eveneks_Decisions
-- Author: Chrisy15
-- DateCreated: 10/8/2016 12:58:17 AM
--------------------------------------------------------------

local civilisationID = GameInfoTypes["CIVILIZATION_SENSHI_EVENKS"]
local iSaddlePolicy = GameInfoTypes["POLICY_C15_EVENEK_SADDLE"]

--[[
Develop the Reindeer Saddle
> Player must be the Evenks
> Player must have researched Animal Husbandry
> May only be enacted once
> Costs a small amount of Science (Animal Husbandry's worth? See vanilla Korea) and 2 Magistrates
> +1 Culture on Camps
> Mounted units gain +1 Movement
]]

local Decisions_C15_Evenek_Saddle = {}
	Decisions_C15_Evenek_Saddle.Name = "TXT_KEY_DECISION_C15_EVENEK_SADDLE"
	Decisions_C15_Evenek_Saddle.Desc = "TXT_KEY_DECISION_C15_EVENEK_SADDLE_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_Evenek_Saddle, "CIVILIZATION_SENSHI_EVENKS")

	Decisions_C15_Evenek_Saddle.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= civilisationID then return false, false end
		if load(pPlayer, "Decisions_C15_Evenek_Saddle") == true then
			Decisions_C15_Evenek_Saddle.Desc = Locale.ConvertTextKey("TXT_KEY_DECISION_C15_EVENEK_SADDLE_DESC_ENACTED")
			return false, false, true
		end
		local iTech = GameInfoTypes["TECH_ANIMAL_HUSBANDRY"]
		local iCost = math.ceil(pPlayer:GetResearchCost(iTech) / 2)
		
		Decisions_C15_Evenek_Saddle.Desc = Locale.ConvertTextKey("TXT_KEY_DECISION_C15_EVENEK_SADDLE_DESC", iCost)

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		
		if (pPlayer:GetCurrentResearch() == -1) then return true, false end
			
		if (Teams[pPlayer:GetTeam()]:IsHasTech(iTech)) and (pPlayer:GetResearchProgress(pPlayer:GetCurrentResearch()) >= iCost) then
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_C15_Evenek_Saddle.DoFunc = (
	function(pPlayer)
		
		local iTech = GameInfoTypes["TECH_ANIMAL_HUSBANDRY"]
		local iCost = math.ceil(pPlayer:GetResearchCost(iTech) / 2)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), -iCost, pPlayer:GetID())
		
		if GrantPolicy then
			pPlayer:GrantPolicy(iSaddlePolicy, true)
		else
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iSaddlePolicy, true)
		end
		
		save(pPlayer, "Decisions_C15_Evenek_Saddle", true)
	end
	)
	
Decisions_AddCivilisationSpecific(civilisationID, "Decisions_C15_Evenek_Saddle", Decisions_C15_Evenek_Saddle)

	
--[[
Institutionalise Nimat
> Player must be the Evenks
> Player must have an Internal Trade Route
> May not be enacted after the Medieval Era
> May only be enacted once
> Costs a large amount of Culture and Gold
> Gain +1 Furs and an an additional Trade Route Slot for each Internal Trade Route in operation when enacted
]]

local iTradeRouteDummy = GameInfoTypes["BUILDING_C15_NIMAT"]

function DMS_toBits(iNum) -- MFW casual banter later becomes crucial to mod development
    tBits={}
    while iNum > 0 do
        local iRest = math.fmod(iNum, 2)
        tBits[#tBits + 1] = iRest
        iNum = (iNum - iRest) / 2
    end
    return tBits
end

local tTradeRouteDummies = {}
	tTradeRouteDummies[1] = GameInfoTypes["BUILDING_C15_NIMAT"]
	tTradeRouteDummies[2] = GameInfoTypes["BUILDING_C15_NIMAT2"]
	tTradeRouteDummies[3] = GameInfoTypes["BUILDING_C15_NIMAT4"]
	tTradeRouteDummies[4] = GameInfoTypes["BUILDING_C15_NIMAT8"]
	tTradeRouteDummies[5] = GameInfoTypes["BUILDING_C15_NIMAT16"]
	

local Decisions_C15_Evenk_Nimat = {}
	Decisions_C15_Evenk_Nimat.Name = "TXT_KEY_DECISION_C15_EVENK_NIMAT"
	Decisions_C15_Evenk_Nimat.Desc = "TXT_KEY_DECISION_C15_EVENK_NIMAT_DESC"
	HookDecisionCivilizationIcon(Decisions_C15_Evenk_Nimat, "CIVILIZATION_SENSHI_EVENKS")
	
	Decisions_C15_Evenk_Nimat.CanFunc = (
		function(pPlayer)
		
		if pPlayer:GetCivilizationType() ~= civilisationID then return false, false end

		
		if load(pPlayer, "Decisions_C15_Evenk_Nimat") == true then
			Decisions_C15_Evenk_Nimat.Desc = Locale.ConvertTextKey("TXT_KEY_DECISION_C15_EVENK_NIMAT_DESC_ENACTED")
			return false, false, true
		end
		
		local tPlayerTradeRoutes = pPlayer:GetTradeRoutes()
		local playerID = pPlayer:GetID()
		local iNumInternals = 0
		
		for i = 1, #tPlayerTradeRoutes do
			if (tPlayerTradeRoutes[i]["FromID"] == playerID) and (tPlayerTradeRoutes[i]["ToID"] == playerID) then
				iNumInternals = iNumInternals + 1
			end
		end
		
		--print("iNumInternals = ", iNumInternals)
		
		local iCost = math.ceil(iNumInternals * 100 * iMod)
		
		Decisions_C15_Evenk_Nimat.Desc = Locale.ConvertTextKey("TXT_KEY_DECISION_C15_EVENK_NIMAT_DESC", iCost)
		
		if iNumInternals == 0 then return true, false end
		
		if pPlayer:GetCurrentEra() < GameInfoTypes["ERA_MEDIEVAL"] then return true, false end
		
		if pPlayer:GetGold() < iCost then return true, false end
		if pPlayer:GetJONSCulture() < iCost then return true, false end
		
		return true, true
	end
	)
	
	Decisions_C15_Evenk_Nimat.DoFunc = (
		function(pPlayer)
		local tPlayerTradeRoutes = pPlayer:GetTradeRoutes()
		local playerID = pPlayer:GetID()
		local iNumInternals = 0
		
		for i = 1, #tPlayerTradeRoutes do
			if (tPlayerTradeRoutes[i]["FromID"] == playerID) and (tPlayerTradeRoutes[i]["ToID"] == playerID) then
				iNumInternals = iNumInternals + 1
			end
		end
		
		local iCost = math.ceil(iNumInternals * 100 * iMod)
		
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeJONSCulture(-iCost)
		
		--print("Do I run to here?")
		
		--pPlayer:ChangeNumResourceTotal(GameInfoTypes["RESOURCE_FUR"], 1)
		
		local pCapital = pPlayer:GetCapitalCity()
		
		--print("Do I run to here?")
		
		pCapital:SetNumRealBuilding(GameInfoTypes["BUILDING_C15_NIMAT_FURS"], 1)
		
		--print("Do I run to here?")
		
		for k, v in pairs(DMS_toBits(iNumInternals)) do
			if v == 1 then
				pCapital:SetNumRealBuilding(tTradeRouteDummies[k], 1)
			end
		end
		
		--pCapital:SetNumRealBuilding(iTradeRouteDummy, iNumInternals)
		
		--print("Do I run to here")
		save(pPlayer, "Decisions_C15_Evenk_Nimat", true)
	end
	)

Decisions_AddCivilisationSpecific(civilisationID, "Decisions_C15_Evenk_Nimat", Decisions_C15_Evenk_Nimat)
