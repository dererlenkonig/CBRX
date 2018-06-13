print ("Raids - Hetmanate Trait code ")

include("FLuaVector.lua")

local FoodID = YieldTypes.YIELD_FOOD;
local ProdID = YieldTypes.YIELD_PRODUCTION;
local HetPilTab = {}
local ValidPlayerTable = {}

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end
 

Events.SequenceGameInitComplete.Add(function()
	local curTurn = Game.GetGameTurn();
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		local data =  GetPersistentProperty("LSHetPill" .. fPlot:GetPlotIndex())
		if data then
			local gTurn = math.floor(data);
			if gTurn == curTurn then
				HetPilTab[fPlot] = (data - gTurn) * 100;
			end
		end
	end
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		HetPilTab = {}
		HetInitCheck(iPlayer)
	end
end)

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		HetAfterCheck(iPlayer)
		HetPilTab = {}
	end
end)

function HetInitCheck(player)
	for iUnit in Players[player]:Units() do
		if iUnit:IsCombatUnit() then
			CheckPlotForPotentialPillage(iUnit:GetPlot(), player)
		end
	end
end

function CheckPlotForPotentialPillage(cPlot, player)
	if cPlot:GetOwner() ~= player then
		if cPlot:GetOwner() ~= -1 then
			if cPlot:GetImprovementType() ~= - 1 then
				if not cPlot:IsImprovementPillaged() then
					HetPilTab[cPlot] = player;
					SetPersistentProperty("LSHetPill" .. cPlot:GetPlotIndex(), Game.GetGameTurn() + 0.01 * player)
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	if ValidPlayerTable[player] then
		local cPlot = Map.GetPlot(x,y);
		if cPlot then
			local cUnit = Players[player]:GetUnitByID(unit);
			if cUnit:IsCombatUnit() then
				CheckPlotForPotentialPillage(cPlot, player)
			end
		end
	end
end)

--Here the bonus from pillaging

function HetAfterCheck(player)
	local HetPillage = 0;
	local HetPoints = 0;
	local isActive = (player == Game.GetActivePlayer())
	for iPlot, playerc in pairs(HetPilTab) do
		if iPlot:IsImprovementPillaged() or (iPlot:GetImprovementType() == - 1) then
			if playerc == player then
				local ukrDisHelp = 9999;
				local ukrCityHelp, foodGain;
				for iCity in Players[player]:Cities() do
					if iCity:GetOriginalOwner() == player  then
						local dPlot = iCity:Plot();
						local UkrDH = Map.PlotDistance(iPlot:GetX(), iPlot:GetY(), dPlot:GetX(), dPlot:GetY()) / iCity:GetPopulation();
						if ukrDisHelp > UkrDH then
							ukrDisHelp = UkrDH;
							ukrCityHelp = iCity;
						end
					end
				end
				if ukrCityHelp then
					foodGain = 6 * iPlot:GetYield(FoodID) + 6;
					ukrCityHelp:ChangeFood(foodGain);
					HetPillage = HetPillage + foodGain;
				end
				local hetGain = math.random(2,4);
				HetPoints = HetPoints + hetGain;
				if isActive then
					if foodGain then
						Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iPlot:GetX(),iPlot:GetY()))), "+" .. foodGain .. "[ICON_FOOD]", 0)
					end
					Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(iPlot:GetX(),iPlot:GetY()))), "+" .. hetGain .. "[ICON_WAR]", 0.5)
				end

			end
		end
	end
	if HetPillage > 0 then
		Players[player]:ChangeCombatExperience(HetPoints)
		local sText = "Our brave soldiers restored " .. HetPillage .. " points of [ICON_FOOD] Food from enemy territory!"
		Players[player]:AddNotification(NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE,sText,"Raids!",-1,-1,GameInfoTypes.RESOURCE_WHEAT);			
	end
end
