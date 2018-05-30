-- MC_LITE_Moors_CoreFunctions.lua
-- Author: Sukritact
--=======================================================================================================================

include("IconSupport")
print("Loaded")

--=======================================================================================================================
-- Utility Functions
--=======================================================================================================================
-- JFD_IsCivilisationActive
-------------------------------------------------------------------------------------------------------------------------
function JFD_IsCivilisationActive(civilisationID)
	for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
		local slotStatus = PreGame.GetSlotStatus(iSlot)
		if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
			if PreGame.GetCivilization(iSlot) == civilisationID then
				return true
			end
		end
	end

	return false
end

if not(JFD_IsCivilisationActive(GameInfoTypes.CIVILIZATION_MC_LITE_MOOR)) then return end
-------------------------------------------------------------------------------------------------------------------------
-- GetMeanTechCost
-------------------------------------------------------------------------------------------------------------------------
function GetMeanTechCost(iPlayer)
	pPlayer = Players[iPlayer] or iPlayer

	local iTotal = 0
	local iNumTotal = 0
	for tTech in GameInfo.Technologies() do
		if pPlayer:CanResearch(tTech.ID) then
			iTotal = iTotal + pPlayer:GetResearchCost(tTech.ID)
			iNumTotal = iNumTotal +1
		end
	end

	return iTotal/iNumTotal
end
--=======================================================================================================================
-- Moorish UA: Glory of Al-Andalus
--=======================================================================================================================
-- Glory of Al-Andalus: Initial Processes
-------------------------------------------------------------------------------------------------------------------------
iCiv = GameInfoTypes.CIVILIZATION_MC_LITE_MOOR

tValidClasses = {}
tValidClasses['UNITCLASS_MUSICIAN']	= true
tValidClasses['UNITCLASS_WRITER']	= true
tValidClasses['UNITCLASS_ARTIST'] 	= true
tValidClasses['UNITCLASS_PROPHET'] 	= true

tValidGreatPeople = {}
for tUnit in GameInfo.Units() do
	if tValidClasses[tUnit.Class] then
		tValidGreatPeople[tUnit.ID] = true
	end
end
-------------------------------------------------------------------------------------------------------------------------
-- Glory of Al-Andalus: Great Person Expenditure
-------------------------------------------------------------------------------------------------------------------------
function MoorishUA(iPlayer, iType, iTypeCP)

	if iTypeCP then
		iType = iTypeCP
	end

	pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= iCiv) then return end
	
	if tValidGreatPeople[iType] then
		local iDelta = math.ceil(GetMeanTechCost(iPlayer) * 0.2)
		LuaEvents.Sukritact_ChangeResearchProgress(iPlayer, iDelta)
		if iPlayer == Game.GetActivePlayer() then
			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED_ACTIVE_PLAYER, Locale.ConvertTextKey('TXT_KEY_TRAIT_MC_LITE_MOOR_SCI', iDelta), Locale.ConvertTextKey('TXT_KEY_TRAIT_MC_LITE_MOOR_SHORT'), -1, -1, GameInfoTypes.BUILDING_MC_LITE_AL_ANDALUS, -1);	
		end
	else
		local iDelta = math.ceil(pPlayer:GetNextPolicyCost() * 0.2)
		pPlayer:ChangeJONSCulture(iDelta)
		if iPlayer == Game.GetActivePlayer() then
			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_WONDER_COMPLETED_ACTIVE_PLAYER, Locale.ConvertTextKey('TXT_KEY_TRAIT_MC_LITE_MOOR_CULT', iDelta), Locale.ConvertTextKey('TXT_KEY_TRAIT_MC_LITE_MOOR_SHORT'), -1, -1, GameInfoTypes.BUILDING_MC_LITE_AL_ANDALUS, -1);	
		end
	end

end


GameEvents.GreatPersonExpended.Add(MoorishUA)
--=======================================================================================================================
-- Specialists
--=======================================================================================================================
-- Glory of Al-Andalus: Production from Specialists \ Alcázar: Faith from Specialists
-------------------------------------------------------------------------------------------------------------------------
-- Initial Defines
------------------------------
local tSpecialists = {}
for tSpecialist in GameInfo.Specialists() do
	if tSpecialist.ID ~= GameInfoTypes.SPECIALIST_CITIZEN then
		table.insert(tSpecialists, tSpecialist.ID)
	end
end

local iGlory = GameInfoTypes.BUILDING_MC_LITE_AL_ANDALUS
local iAlcazar = GameInfoTypes.BUILDING_MC_LITE_ALCAZAR
local iAlcazarDummy = GameInfoTypes.BUILDING_MC_LITE_ALCAZAR_DUMMY
------------------------------
------------------------------
function ResetSpecialists(pCity)

	local iNumSpecialists = 0
	for iKey, iSpecialist in ipairs(tSpecialists) do
		iNumSpecialists = iNumSpecialists + pCity:GetSpecialistCount(iSpecialist)
	end
	pCity:SetNumRealBuilding(iGlory, iNumSpecialists)

	pCity:SetNumRealBuilding(iAlcazarDummy, 0)
	if (pCity:GetNumBuilding(iAlcazar) > 0) then
		pCity:SetNumRealBuilding(iAlcazarDummy, iNumSpecialists);
	end

end
------------------------------
------------------------------
function PlayerDoTurn_ResetSpecialists(iPlayer)
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= iCiv) then return end
	for pCity in pPlayer:Cities() do
		ResetSpecialists(pCity)
	end
end
GameEvents.PlayerDoTurn.Add(PlayerDoTurn_ResetSpecialists)

local iSpecialistUpdateType = CityUpdateTypes.CITY_UPDATE_TYPE_SPECIALISTS
function SpecificCityInfoDirty_ResetSpecialists(iPlayer, iCity, iUpdateType)

	if iUpdateType ~= iSpecialistUpdateType then return end

	local iPlayer = Game.GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if not(pPlayer:IsTurnActive()) then	return end
	
	if (pPlayer:GetCivilizationType() ~= iCiv) then return end
	
	local pCity = pPlayer:GetCityByID(iCity)
	ResetSpecialists(pCity)
	LuaEvents.MoorUpdate()
end
Events.SpecificCityInfoDirty.Add(SpecificCityInfoDirty_ResetSpecialists)
-------------------------------------------------------------------------------------------------------------------------
-- Sukritact's Modular City Info Stack Support
-------------------------------------------------------------------------------------------------------------------------
function CityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "MC_LITE_MOOR", ["SortOrder"] = 1})

	table.insert(tEventsToHook, LuaEvents.MoorUpdate)
end
LuaEvents.CityInfoStackDataRefresh.Add(CityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()
local tGlory = GameInfo.Buildings.BUILDING_MC_LITE_AL_ANDALUS

function CityInfoStackDirty(sKey, pInstance)
	if sKey ~= "MC_LITE_MOOR" then return end

	-- Ensure City Selected
	local pCity = UI.GetHeadSelectedCity()
	if not(pCity) then
		pInstance.IconFrame:SetHide(true)
		return
	end	

	-- Ensure Player is Moorish
	local iPlayer = pCity:GetOwner()
	local pPlayer = Players[iPlayer]
	if (pPlayer:GetCivilizationType() ~= iCiv) then
		pInstance.IconFrame:SetHide(true)
		return
	end	

	IconHookup(tGlory.PortraitIndex, 64, tGlory.IconAtlas, pInstance.IconImage)
	pInstance.IconFrame:LocalizeAndSetToolTip("TXT_KEY_TRAIT_MC_LITE_MOOOR_TOOLTIP", pCity:GetNumBuilding(iGlory), pCity:GetNumBuilding(iGlory) * 5)
	pInstance.IconFrame:SetHide(false)	

end
LuaEvents.CityInfoStackDirty.Add(CityInfoStackDirty)
--=======================================================================================================================
--=======================================================================================================================