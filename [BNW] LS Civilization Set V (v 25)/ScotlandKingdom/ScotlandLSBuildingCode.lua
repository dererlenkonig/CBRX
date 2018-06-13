print("Flower of Enlightenment - Scotland Building Code")

local cPalace = GameInfoTypes.BUILDING_LS_SCOTS;
local artSlot = GameInfoTypes.GREAT_WORK_SLOT_ART_ARTIFACT;
local ActivePlayer = Game.GetActivePlayer();
local sModifier = GameInfoTypes.BUILDING_DUMMY_LS_SCOTLAND_SCIENCE;
local cMusuem = GameInfoTypes.BUILDINGCLASS_MUSEUM;
local ValidPlayerTable = {}

function GiveTableOfValidBuildingPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
		if iplayer == ActivePlayer then
			Events.SerialEventGameDataDirty.Add(OnChangeEvent)
		end
	end
end

function OnChangeEvent()
	CheckAllCities(ActivePlayer)
end

function IsValidSMB(iCity)
	for i = 0, 1 do
		if iCity:GetBuildingGreatWork(cMusuem, i) == -1 then
			return false;
		end
	end
	return true;
end

function CheckAllCities(iPlayer)
	for iCity in Players[iPlayer]:Cities() do
		iCity:SetNumRealBuilding(sModifier, 0)
		if iCity:IsHasBuilding(cPalace) then
			if IsValidSMB(iCity) then
				iCity:SetNumRealBuilding(sModifier, 1)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		CheckAllCities(iPlayer)
	end
end)