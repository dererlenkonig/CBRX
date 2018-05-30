print("Benin - Unit Code")

include("LSSaveUtils.lua")
local BeninLSPlayersImprovement = {}
local BeninCivIDBuilding = {}

local impcivID = GameInfoTypes[ GameInfo.Improvements["IMPROVEMENT_LS_BENIN"].CivilizationType]
if impcivID then
	BeninCivIDBuilding[impcivID] = 1;
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if BeninCivIDBuilding[player:GetCivilizationType()] then
			table.insert(BeninLSPlayersImprovement, i)
		end
	end
end

if #BeninLSPlayersImprovement > 0 then
	include("BeninLSImprovementCode.lua")
	GiveTableOfValidImproPlayers(BeninLSPlayersImprovement)
end

-- unit code

local uuBenin = GameInfoTypes.UNIT_LS_BENIN;

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:GetUnitType() == uuBenin then
			AdjustUUBonus(iUnit, iUnit:GetPlot(), iPlayer)
		end
	end
end)

function GetNearbyCity(iPlot)
	local cCity;
	if not iPlot:IsCity() then
		for i = 0, 5 do
			local nPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), i);
			if nPlot then
				if nPlot:IsCity() then
					return nPlot:GetPlotCity();
				end
			end
		end
	end
	return cCity;
end

GameEvents.UnitSetXY.Add(function(iPlayer, unit, x, y)
	local cPlot = Map.GetPlot(x,y);
	if cPlot then
		local cUnit = Players[iPlayer]:GetUnitByID(unit);
		if cUnit then
			if cUnit:GetUnitType() == uuBenin then
				AdjustUUBonus(cUnit, cPlot, iPlayer)
			end
		end
	end
end)

GameEvents.MakePeace.Add(function(teamId, otherTeamId)
	for i, v in pairs(Players) do
		if v:GetTeam() == teamId or v:GetTeam() == otherTeamId then
			for iUnit in v:Units() do
				if iUnit:GetUnitType() == uuBenin then
					AdjustUUBonus(iUnit, iUnit:GetPlot(), i)
				end
			end
		end
	end
end)

GameEvents.DeclareWar.Add(function(teamId, otherTeamId)
	for i, v in pairs(Players) do
		if v:GetTeam() == teamId or v:GetTeam() == otherTeamId then
			for iUnit in v:Units() do
				if iUnit:GetUnitType() == uuBenin then
					AdjustUUBonus(iUnit, iUnit:GetPlot(), i)
				end
			end
		end
	end
end)

function AdjustUUBonus(iUnit, cPlot, iPlayer)
	local bonus = 0;
	local cCity = GetNearbyCity(cPlot);
	if cCity then
		if Teams[cCity:GetOwner()]:IsAtWar(Players[iPlayer]:GetTeam()) then
			bonus = GreatestDiffer(cCity, iPlayer)
		end
	end
	local cBonus = load(iUnit:GetID() .. "o" .. iPlayer .. "LS18bnUnitB") or 0;
	if cBonus ~= bonus then
		iUnit:SetBaseCombatStrength(iUnit:GetBaseCombatStrength() + bonus - cBonus)
		save(iUnit:GetID() .. "o" .. iPlayer .. "LS18bnUnitB", bonus)
	end
end

function GreatestDiffer(cCity, iPlayer)
	local max = 0;
	for iCity in Players[iPlayer]:Cities() do
		if iCity:GetBuildingDefense() > max then
			max = iCity:GetBuildingDefense();
		end
	end
	return math.max(0, math.floor((max - cCity:GetBuildingDefense()) / 100))
end