print ("Exodus - Israeli Trait Code")

include("FLuaVector.lua")
include( "LSSaveUtils.lua" )
local tSettler = GameInfoTypes.UNIT_SETTLER;
local tDesert = GameInfoTypes.TERRAIN_DESERT;
local eMeSp = GameInfoTypes.PROMOTION_LS_ISREALI_UA;
local ValidPlayerTable = {}

function GiveTableOfValidTraitPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
		local player = Players[iplayer];
		if player:GetNumCities() == 0 then
			for iUnit in player:Units() do
				if not iUnit:IsHasPromotion(eMeSp) then
					iUnit:SetHasPromotion(eMeSp, true)
					iUnit:ChangeMoves(120);
				end
			end
		end
		for iUnit in player:Units() do
			if iUnit:GetUnitType() == tSettler then
				local uID = iUnit:GetID() .. "x" .. iUnit:GetOwner() .. "x" .. iUnit:GetGameTurnCreated();
				if load("LS11IsrP" .. uID) == nil then
					save("LS11IsrP" .. uID, iUnit:GetPlot():GetPlotIndex())
					save("LS11IsrB" .. uID, 0)
				end
			end
		end
	end
end
 
GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	if ValidPlayerTable[player] then
		local cPlot = Map.GetPlot(x, y);
		if cPlot then
			local cUnit = Players[player]:GetUnitByID(unit);
			if cUnit:GetUnitType() == tSettler then
				local uID = cUnit:GetID() .. "x" .. cUnit:GetOwner() .. "x" .. cUnit:GetGameTurnCreated();
				local pDis = load("LS11IsrB" .. uID)
				if pDis then
					local bPlot = Map.GetPlotByIndex(load("LS11IsrP" .. uID));
					local nDis = Map.PlotDistance(bPlot:GetX(), bPlot:GetY(), x, y);
					if nDis > pDis then
						save("LS11IsrB" .. uID, nDis)
						Players[player]:ChangeJONSCulture(2);
						if player == Game.GetActivePlayer() then
							Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(x, y))), "[COLOR_CULTURE_STORED]+2[ENDCOLOR][ICON_CULTURE]", 0)
						end
					end
				else
					save("LS11IsrP" .. uID, cUnit:GetPlot():GetPlotIndex())
					save("LS11IsrB" .. uID, 0)
				end
			end
		end
	end
end)

GameEvents.PlayerCityFounded.Add(function(iPlayer, iCityX, iCityY)
	if ValidPlayerTable[iPlayer] then
		for iUnit in Players[iPlayer]:Units() do
			iUnit:SetHasPromotion(eMeSp, false)
		end
	end
end)

GameEvents.CityTrained.Add(function(iPlayer, cityId, unitId, bGold, bFaithOrCulture)
	if ValidPlayerTable[iPlayer] then
		local cUnit = Players[iPlayer]:GetUnitByID(unitId);
		if cUnit:GetUnitType() == tSettler then
			local uID = cUnit:GetID() .. "x" .. cUnit:GetOwner() .. "x" .. cUnit:GetGameTurnCreated();
			save("LS11IsrP" .. uID, cUnit:GetPlot():GetPlotIndex())
			save("LS11IsrB" .. uID, 0)
		end
	end
end)