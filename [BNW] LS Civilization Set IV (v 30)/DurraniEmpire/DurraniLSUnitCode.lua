print ("One thousand nights - Durrani Unit code")

local DurraniCivIDBuilding = {}
local DurraniLeaderIDTrait = {}
local DurraniPlayersBuilding = {}
local DurraniPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_PEARL_OF_PEARLS" then
		DurraniLeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for row in GameInfo.Civilization_BuildingClassOverrides() do
	if row.BuildingType == "BUILDING_LS_LITERATURE_NIGHT" then
		DurraniCivIDBuilding[GameInfoTypes[row.CivilizationType]] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if DurraniCivIDBuilding[player:GetCivilizationType()] then
			table.insert(DurraniPlayersBuilding, i)
		end
		if DurraniLeaderIDTrait[player:GetLeaderType()] then
			table.insert(DurraniPlayersTrait, i)
		end
	end
end

if #DurraniPlayersTrait > 0 then
	include("DurraniLSTraitCode")
	GiveTableOfValidTraitPlayers(DurraniPlayersTrait)
end
if #DurraniPlayersBuilding > 0 then
	include("DurraniLSBuildingCode")
	GiveTableOfValidBuildingPlayers(DurraniPlayersBuilding)
end

--

local rangeP = GameInfoTypes.PROMOTION_JEZAIL_LS_RANGE;
local jezail = GameInfoTypes.UNIT_LS_JEZAIL_RIFLEMAN;
local HorseClass = GameInfoTypes.UNITCLASS_RIFLEMAN;
local RangAtt = GameInfoTypes.MISSION_RANGE_ATTACK;

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if Players[iPlayer]:GetUnitClassCount(HorseClass) > 0 then
		for iUnit in Players[iPlayer]:Units() do
			if iUnit:GetUnitType() == jezail then
				if iUnit:GetPlot():IsHills() then
					SearchAttack(iUnit, iPlayer)
				end
			end
		end
	end
end)

function SearchAttack(jUnit, iPlayer)
	jUnit:SetHasPromotion(rangeP, true)
	local iPlot = jUnit:GetPlot();
	local hTab = {}
	local hCou = 0;
	local bX = jUnit:GetX();
	local bY = jUnit:GetY();	
	for iX = -2, 2 do
		for iY = -2, 2 do
			local plot = Map.PlotXYWithRangeCheck(bX, bY, iX, iY, 2)
			if plot then
				if jUnit:CanStartMission(RangAtt, plot:GetX(), plot:GetY()) then
					if plot:IsFlatlands() then
						if not plot:IsWater() then
							if not plot:IsCity() then
								hCou = hCou + 1;
								hTab[hCou] = plot;
							end
						end
					end
				end
			end
		end
	end
	if hCou > 0 then
		local ePlot = hTab[math.random(1, hCou)];
		jUnit:PushMission(RangAtt, ePlot:GetX(), ePlot:GetY())
	end
	jUnit:SetMoves(jUnit:MaxMoves());
	jUnit:SetMadeAttack(false);
	jUnit:SetHasPromotion(rangeP, false)
end