--HasTrait
function HasTrait(player, traitID)
	if isCPDLL then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
	return false
end

include( "SaveUtils" ); MY_MOD_NAME = "LN_CANADA"; WARN_NOT_SHARED = false

local traitLNCanadaID 		= GameInfoTypes["TRAIT_LNKC_KING_OR_CHAOS"]
local canadaWarDummy  		= GameInfoTypes["BUILDING_LNKC_WARTIMEBUFF"] -- +2 production and +20% unit production
local canadaPeaceDummy		= GameInfoTypes["BUILDING_LNKC_PEACETIMEBUFF"] -- +2 science and +2 production

function Canada_ChaosHandler(playerID)
	local player = Players[playerID]
	if (not player:IsAlive()) then return end
	if (not HasTrait(player, traitLNCanadaID)) then return end
	
	local warTemp = load(player, "WarTemp")
	local peaceTemp = load(player, "PeaceTemp")
	if warTemp == nil then warTemp = 0 end
	if peaceTemp == nil then peaceTemp = 0 end

	
	if (warTemp == 0 and peaceTemp == 0) then return end
	if warTemp == 1 then
		for city in player:Cities() do
			city:SetNumRealBuilding(canadaWarDummy, 0)
		end
	end
	if warTemp > 0 then
		warTemp = warTemp - 1
		save(player, "WarTemp", warTemp)
	end	
	if peaceTemp == 1 then
		for city in player:Cities() do
			city:SetNumRealBuilding(canadaPeaceDummy, 0)
		end
	end
	if peaceTemp > 0 then
		peaceTemp = peaceTemp - 1
		save(player, "PeaceTemp", peaceTemp)
	end	
end
GameEvents.PlayerDoTurn.Add(Canada_ChaosHandler)

function Canada_PeaceDeclare(teamID, otherTeamID)
	local player = Players[Teams[teamID]:GetLeaderID()]
	local otherPlayer = Players[Teams[otherTeamID]:GetLeaderID()]

	if not player:IsAlive() or not otherPlayer:IsAlive() then return end
	if not HasTrait(player, traitLNCanadaID) and not HasTrait(otherPlayer, traitLNCanadaID) then return end
	if HasTrait(otherPlayer, traitLNCanadaID) then player = otherPlayer end	
	
	for city in player:Cities() do
		if not load(player, "WarTemp") > 0 then
			city:SetNumRealBuilding(canadaPeaceDummy, city:GetNumNationalWonders() + city:GetNumTeamWonders())
			print("CANADA: Created a Canadian peace dummy building in " .. city:GetName())
			save(player, "PeaceTemp", 5)
		end
	end
end
GameEvents.MakePeace.Add(Canada_PeaceDeclare)

function Canada_WarDeclare(teamID, otherTeamID)
	local player = Players[Teams[teamID]:GetLeaderID()]
	local otherPlayer = Players[Teams[otherTeamID]:GetLeaderID()]

	if not player:IsAlive() or not otherPlayer:IsAlive() then return end
	if not HasTrait(player, traitLNCanadaID) and not HasTrait(otherPlayer, traitLNCanadaID) then return end
	if HasTrait(otherPlayer, traitLNCanadaID) then player = otherPlayer end
	
	for city in player:Cities() do
		if player:IsCapitalConnectedToCity(city) and not load(player, "PeaceTemp") > 0 then
			city:SetNumRealBuilding(canadaWarDummy, 1)
			print("CANADA: Created a Canadian war dummy building in " .. city:GetName())
			save(player, "WarTemp", 5)
		end
	end
end
GameEvents.DeclareWar.Add(Canada_WarDeclare)

local canadaRamTank = GameInfoTypes["UNIT_LNKC_RAMTANK"]

function Canada_RamTankExperience(playerID, cityID, unitID, bGold, bFaithOrCulture)
	local player = Players[playerID]
	local pUnit = player:GetUnitByID(unitID)
	--print("Running Canada Ram Tank Experience")
	
	if pUnit:GetUnitType() == canadaRamTank then
		pUnit:ChangeExperience(30)
		for unit in player:Units() do
			if (unit:IsCombatUnit() and unit:GetPlot():IsFriendlyTerritory(player)) then
				unit:ChangeExperience(5)
			end
		end
		print("CANADA: A Ram Tank was born, giving 5 XP to all units within our borders")
	end
end
GameEvents.CityTrained.Add(Canada_RamTankExperience)

local canadaWarFactory = GameInfoTypes["BUILDING_LNKC_WARTIMEINDUSTRY"]

function Canada_WarFactory(playerID, cityID, unitID, bGold, bFaithOrCulture)
	local player = Players[playerID]
	local pUnit = player:GetUnitByID(unitID)
	local city = player:GetCityByID(cityID)

	if not city:IsHasBuilding(canadaWarFactory) then return end
	
	local unitExperience = pUnit:GetExperience()
	city:ChangeProduction(unitExperience)
	city:ChangeJONSCultureStored(unitExperience)
	player:ChangeGold(unitExperience)
	
	print("CANADA: Added " .. tostring(unitExperience) .. " Production, Gold and Culture to " .. city:GetName())
end
GameEvents.CityTrained.Add(Canada_WarFactory)


print("Canada's King is in the game!")
