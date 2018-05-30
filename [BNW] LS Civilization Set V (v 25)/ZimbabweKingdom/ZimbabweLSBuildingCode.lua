print("Trading Stones - Zimbabwe Building Code")

include( "FLuaVector" );
local ValidPlayerTable = {}
local TRcurrent = {}
local buildingUB = GameInfoTypes.BUILDING_LS_ZIMBABWE;

function GiveTableOfValidBuildingPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
		for iUnit in Players[iplayer]:Units() do
			if iUnit:IsTrade() then
				if CheckCaravan(iUnit, iUnit:GetPlot()) then
					TRcurrent[iUnit] = 1;
				end
			end
		end
	end
end

function CheckCaravan(cUnit, cPlot)
	for i = 0, cPlot:GetNumUnits() - 1 do
		local iUnit = cPlot:GetUnit(i);
		if iUnit == cUnit then
			return false;
		end
	end
	return true;
end

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	if ValidPlayerTable[player] then
		local cUnit = Players[player]:GetUnitByID(unit);
		if cUnit then
			if cUnit:IsTrade() then
				local cPlot = cUnit:GetPlot();
				if cPlot then
					if cPlot:IsCity() then
						if CheckCaravan(cUnit, cPlot) then
							if not TRcurrent[cUnit] then
								TRcurrent[cUnit] = 1;
								local cCity = cPlot:GetPlotCity();
								if cCity:IsHasBuilding(buildingUB) then
									iPlot = cCity:GetNextBuyablePlot();
									if iPlot then
										iPlot:SetOwner(player, cCity:GetID(), true, true);
										if player == Game.GetActiveTeam() then
											local hex = ToHexFromGrid(Vector2(iPlot:GetX(), iPlot:GetY()))
											Events.GameplayFX(hex.x, hex.y)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end	
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		for iCity in Players[iPlayer]:Cities() do
			if iCity:IsHasBuilding(buildingUB) then
				local tow = math.ceil(iCity:GetYieldRateTimes100(YieldTypes.YIELD_GOLD) / 200)
				iCity:ChangeJONSCultureStored(tow);
				if iCity:GetJONSCultureThreshold() <= iCity:GetJONSCultureStored() then
					local nPlot = iCity:GetNextBuyablePlot();
					if nPlot then
						iCity:ChangeJONSCultureStored(- iCity:GetJONSCultureThreshold())
						iCity:ChangeJONSCultureLevel(1)
						nPlot:SetOwner(iPlayer, iCity:GetID())
					end
				end
			end
		end
	end
end)