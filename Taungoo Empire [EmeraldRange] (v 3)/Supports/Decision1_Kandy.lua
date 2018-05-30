-- Decisions1_Kandy
-- Author: EmeraldRange, Chrisy15
-- DateCreated: 5/21/2017 7:28:38 PM
--------------------------------------------------------------
print "Taungoo Decisions: loaded"
--============================================================
-- Taungoo: Recover the Tooth of Kandy
--============================================================
local Decisions_TaungooKandy = {}
	Decisions_TaungooKandy.Name = "TXT_KEY_DECISIONS_TAUNGOOKANDY"
	--Decisions_TaungooKandy.Desc = "TXT_KEY_DECISIONS_TAUNGOOKANDY_DESC"
	HookDecisionCivilizationIcon(Decisions_TaungooKandy, "CIVILIZATION_TAUNGOO")
	Decisions_TaungooKandy.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TAUNGOO then return false, false end
		if load(pPlayer, "Decisions_TaungooKandy") == true then
			Decisions_TaungooKandy.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TAUNGOOKANDY_ENACTED_DESC")
			return false, false, true
		end
		local iCost = math.ceil(800 * iMod)
		Decisions_TaungooKandy.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_TAUNGOOKANDY_DESC", iCost)

		if (pPlayer:GetCapitalCity() == nil) then return true, false end
		--Has Theology? Gold? Free Great Work of Art Slot? Magistrates?
		if (Teams[pPlayer:GetTeam()]:IsHasTech(GameInfoTypes.TECH_THEOLOGY)) and (pPlayer:GetGold() >= iCost) and 
			(pPlayer:HasAvailableGreatWorkSlot(GameInfoTypes["GREAT_WORK_SLOT_ART_ARTIFACT"])) and (pPlayer:GetNumResourceAvailable(iMagistrate, false) >= 1) then
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_TaungooKandy.DoFunc = (
	function(pPlayer)
		local iToothDummy = GameInfoTypes.UNIT_ER_DUMMY_ED_ARCHAEOLOGIST
		local iFaithBuilding = GameInfoTypes.BUILDING_ER_DECISION_KANDY
		local pCapCity = pPlayer:GetCapitalCity()
		local iCost = math.ceil(800* iMod)		
		pPlayer:ChangeGold(-iCost)
		pCapCity:SetNumRealBuilding(iFaithBuilding, 1)
		local pUnit = pPlayer:InitUnit(iToothDummy, pCapCity:GetX(), pCapCity:GetY(), UNITAI_ARTIST)
		pUnit:PushMission(GameInfoTypes["MISSION_CREATE_GREAT_WORK"])
		save(pPlayer, "Decisions_TaungooKandy", true)
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TAUNGOO,'Decisions_TaungooKandy', Decisions_TaungooKandy)