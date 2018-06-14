-- BurmaDecisions
-- Author: Chrisy
-- DateCreated: 6/17/2017 10:52:34 AM
--------------------------------------------------------------

-- Decision2_BagoGates
-- Author: EmeraldRange, Chrisy15
-- DateCreated: 5/22/2017 9:39:02 AM
--------------------------------------------------------------
print("Taungoo Decisions: loaded (2)")
--============================================================
-- Taungoo: Construct the Gates of Bago
--============================================================
local Decisions_TaungooBagoGates = {}
	Decisions_TaungooBagoGates.Name = "TXT_KEY_DECISIONS_TAUNGOOBAGOGATES"
	--Decisions_TaungooBagoGates.Desc = "TXT_KEY_DECISIONS_TAUNGOOBAGOGATES_DESC"
	HookDecisionCivilizationIcon(Decisions_TaungooBagoGates, "CIVILIZATION_TAUNGOO")
	Decisions_TaungooBagoGates.CanFunc = (
	function(pPlayer)
		local iERBagoGateTotalCost = 0
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TAUNGOO then return false, false end
		if load(pPlayer, "Decisions_TaungooBagoGates") == true then
			Decisions_TaungooBagoGates.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TAUNGOOBAGOGATES_ENACTED_DESC")
			return false, false, true
		end
		--cost per city
		local iCost = math.ceil(180 * iMod)
		Decisions_TaungooBagoGates.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TAUNGOOBAGOGATES_DESC", iCost)
		HookDecisionCivilizationIcon(Decisions_TaungooBagoGates, "CIVILIZATION_TAUNGOO")
		--checking for four puppets and calculating total cost
		local iPuppetNum = 0
		if pPlayer:IsAlive() then
			for pCity in pPlayer:Cities() do
				if pCity:IsPuppet() then
					iERBagoGateTotalCost= iERBagoGateTotalCost + iCost
					iPuppetNum = iPuppetNum + 1
				end
			end
			print("Taungoo Bago Gates: " .. iPuppetNum .. " puppets.")
			print("Taungoo Bago Gates Total Cost: " .. iERBagoGateTotalCost)
			if (iPuppetNum > 3) and (pPlayer:GetGold() >= iERBagoGateTotalCost) and (pPlayer:GetNumResourceAvailable(iMagistrate, false) >= 2) then 
				return true, true 
			else return true, false
			end
		else return false, false 
		end
	end
	)
	
	Decisions_TaungooBagoGates.DoFunc = (
	function(pPlayer)
		print("DoFunc loaded")
		local iERBagoGateTotalCost = 0
		local iCost = math.ceil(180 * iMod)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		if pPlayer:IsAlive() then
			for pCity in pPlayer:Cities() do
				print("going through city")
				if pCity:IsPuppet() then
					print("is puppet")
					iERBagoGateTotalCost = iERBagoGateTotalCost + iCost
					pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_ER_DUMMY_GATE_OF_BAGO"], 1)
					print("Add dummy to ", pCity:GetName())
				end
			end
		end		
		print("Total Cost" .. iERBagoGateTotalCost)
		pPlayer:ChangeGold(-iERBagoGateTotalCost)
		save(pPlayer, "Decisions_TaungooBagoGates", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TAUNGOO,'Decisions_TaungooBagoGates', Decisions_TaungooBagoGates)
