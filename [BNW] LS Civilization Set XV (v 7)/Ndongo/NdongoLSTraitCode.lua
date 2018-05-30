print ("Ndongo - Ndongo Trait code ")

local ValidPlayerTable = {}
local Ton2 = GameInfoTypes.PROMOTION_LS_UU_NDONGO_ON_2;
local Ton1 = GameInfoTypes.PROMOTION_LS_UU_NDONGO_ON_1;
local Toff = GameInfoTypes.PROMOTION_LS_UU_NDONGO;
local teamT = {}
local dLand = GameInfoTypes.DOMAIN_LAND;

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if not player:IsMinorCiv() then
			if not player:IsBarbarian() then
				teamT[player:GetTeam()] = 1;
			end
		end
	end
end

function IsAbilityOn(plot, teamV)
	local b = 2;
	for iTeam, vTeam in pairs(teamT) do
		if plot:IsVisible(iTeam) then
			if iTeam ~= teamV then
				if Teams[teamV]:IsAtWar(iTeam) then
					return 0;
				end
				b = 1;
			end
		end
	end
	return b;
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		for iUnit in Players[iPlayer]:Units() do
			if iUnit:IsCombatUnit() and iUnit:GetDomainType() == dLand then
				local type = IsAbilityOn(iUnit:GetPlot(), Players[iPlayer]:GetTeam())
				local rate = iUnit:GetMoves() / iUnit:MaxMoves();
				iUnit:SetHasPromotion(Ton2, type == 2);
				iUnit:SetHasPromotion(Ton1, type == 1);
				iUnit:SetHasPromotion(Toff, type == 0);
				iUnit:SetMoves(iUnit:MaxMoves() * rate);
			end
		end
	end
end)