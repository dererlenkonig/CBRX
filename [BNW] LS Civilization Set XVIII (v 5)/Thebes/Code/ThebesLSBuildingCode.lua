print ("Thebes UB Code ")

include("FLuaVector.lua")
local ValidPlayerTable = {}
local HUBT = {}
local uThebesUB = GameInfoTypes.BUILDING_LS_THEBES;
local HTED = {}
local pDoneEraTable = {}
for row in GameInfo.Technology_PrereqTechs() do
	if GameInfo.Technologies[row.TechType] and GameInfo.Technologies[row.TechType].Era and GameInfo.Technologies[row.PrereqTech] and GameInfo.Technologies[row.PrereqTech].Era then
		local pEra = GameInfoTypes[GameInfo.Technologies[row.TechType].Era];
		local cEra = GameInfoTypes[GameInfo.Technologies[row.PrereqTech].Era]
		if pEra and cEra and (cEra ~= pEra) then
			pDoneEraTable[pEra] = cEra;
		end
	end
end
for row in GameInfo.Eras() do
	if not pDoneEraTable[row.ID] then
		HTED[row.ID] = 3;
	end
end
function GetEraValueDis(iEra)
	return (HTED[pDoneEraTable[iEra]] or GetEraValueDis(pDoneEraTable[iEra])) + 1;
end
for row in GameInfo.Eras() do
	if not HTED[row.ID] then
		HTED[row.ID] = GetEraValueDis(row.ID)
	end
end

function GiveTableOfValidBuildingPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end

function IsNearbyEnough(x, y, iPlayer)
	local dis = HTED[Players[iPlayer]:GetCurrentEra()];
	for iCity in Players[iPlayer]:Cities() do
		if iCity:IsHasBuilding(uThebesUB) then
			if Map.PlotDistance(x, y, iCity:GetX(), iCity:GetY()) <= dis then
				return true;
			end
		end
	end
	return false;
end

GameEvents.UnitPrekill.Add(function(unitOwnerId, unitId, unitType, unitX, unitY, bDelay, eKillingPlayer)
	if ValidPlayerTable[eKillingPlayer] then
		local kUnit = Players[unitOwnerId]:GetUnitByID(unitId);
		if kUnit:IsCombatUnit() then
			local gID = unitId .. "x" .. unitOwnerId .. "x" .. Game.GetGameTurn();
			if not HUBT[gID] then
				HUBT[gID] = 1;
				local bonus = kUnit:GetBaseCombatStrength()
				if bonus > 0 then
					if IsNearbyEnough(unitX, unitY, eKillingPlayer) then
						Players[eKillingPlayer]:ChangeFaith(bonus);
						if eKillingPlayer == Game.GetActivePlayer() then
							Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(unitX, unitY))), "+" .. bonus .. "[ICON_PEACE]", 0)
						end
					end
				end
			end
		end
	end
end)