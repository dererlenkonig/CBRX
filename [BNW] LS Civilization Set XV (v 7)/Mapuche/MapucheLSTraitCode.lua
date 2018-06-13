print ("Mapucho - Mapuche Trait code ")

local ValidPlayerTable = {}
local hTable = {}
local pTable = {}
local bType = -1;
local GreatPromotionTable = {}
local GreatResourceTable = {}
local TPT = {GameInfoTypes.PROMOTION_DEFEND_NEAR_CAPITAL, GameInfoTypes.PROMOTION_EMBARKED_SIGHT, GameInfoTypes.PROMOTION_MOVEMENT_TO_GENERAL, GameInfoTypes.PROMOTION_GENERAL_STACKING, GameInfoTypes.PROMOTION_WITHDRAW_BEFORE_MELEE, GameInfoTypes.PROMOTION_BUFFALO_HORNS, GameInfoTypes.PROMOTION_HEAVY_CHARGE, GameInfoTypes.PROMOTION_GOLDEN_AGE_POINTS, GameInfoTypes.PROMOTION_DESERT_WARRIOR, GameInfoTypes.PROMOTION_MOON_STRIKER, GameInfoTypes.PROMOTION_STRONGER_VS_DAMAGED, GameInfoTypes.PROMOTION_FOREIGN_LANDS, GameInfoTypes.PROMOTION_JAGUAR, GameInfoTypes.PROMOTION_MOHAWK, GameInfoTypes.PROMOTION_ATTACK_BONUS, GameInfoTypes.PROMOTION_PARTIAL_HEAL_IF_DESTROY_ENEMY, GameInfoTypes.PROMOTION_HEAL_IF_DESTROY_ENEMY, GameInfoTypes.PROMOTION_FREE_PILLAGE_MOVES, GameInfoTypes.PROMOTION_SPAWN_GENERALS_II, GameInfoTypes.PROMOTION_SPAWN_GENERALS_I, GameInfoTypes.PROMOTION_IGNORE_TERRAIN_COST}
local CBC = {}
local TypeTab = {}
local KillingPT = {}

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
	end
end

for it, promID in pairs(TPT) do
	if promID then
		table.insert(CBC, promID)
	end
end

for row in GameInfo.UnitPromotions_UnitCombats() do
	if not GreatPromotionTable[GameInfoTypes[row.UnitCombatType]] then
		GreatPromotionTable[GameInfoTypes[row.UnitCombatType]] = {}
	end
	GreatPromotionTable[GameInfoTypes[row.UnitCombatType]][GameInfoTypes[row.PromotionType]] = 1;
end

for row in GameInfo.Unit_ResourceQuantityRequirements() do
	GreatResourceTable[GameInfoTypes[row.UnitType]] = GameInfoTypes[row.ResourceType];
end

function PreKillFunction(unitOwnerId, unitId, unitType, unitX, unitY, bDelay, eKillingPlayer)
	if bDelay then
		if eKillingPlayer ~= -1 then
			if ValidPlayerTable[eKillingPlayer] then
				local kUnit = Players[unitOwnerId]:GetUnitByID(unitId);
				if kUnit:IsCombatUnit() then
					local gID = unitId .. "x" .. unitOwnerId .. "x" .. Game.GetGameTurn();
					TypeTab[gID] = unitType;
					KillingPT[gID] = eKillingPlayer;
					hTable[gID] = {}
					for iUnit in Players[eKillingPlayer]:Units() do
						hTable[gID][iUnit] = {iUnit:GetDamage(), iUnit:IsOutOfAttacks(), iUnit:GetExperience()};
					end
					pTable[gID] = {}
					for iProm, bool in pairs(GreatPromotionTable[kUnit:GetUnitCombatType()]) do
						if kUnit:IsHasPromotion(iProm) then
							pTable[gID][iProm] = true;
						end
					end
					for it, iProm in pairs(CBC) do
						if kUnit:IsHasPromotion(iProm) then
							pTable[gID][iProm] = true;
						end
					end
				end
			end
		end
	else
		local gID = unitId .. "x" .. unitOwnerId .. "x" .. Game.GetGameTurn();
		if KillingPT[gID] then
			local mPlayer = KillingPT[gID];
			local dUnit;
			local HPT = Map.GetPlot(unitX, unitY)
			for iUnit, data in pairs(hTable[gID]) do
				if (data[1] < iUnit:GetDamage()) or (iUnit:GetPlot() == HPT) or (iUnit:GetExperience() > data[3]) or (iUnit:IsOutOfAttacks() ~= data[2]) then
					dUnit = iUnit;
					break;
				end
			end
			if dUnit then
				local dpTable = {}
				for iProm, bool in pairs(GreatPromotionTable[dUnit:GetUnitCombatType()]) do
					if pTable[gID][iProm] then
						if not dUnit:IsHasPromotion(iProm) then
							table.insert(dpTable, iProm)
						end
					end
				end			
				for it, iProm in pairs(CBC) do
					if pTable[gID][iProm] then
						if not dUnit:IsHasPromotion(iProm) then
							table.insert(dpTable, iProm)
						end
					end
				end
				if #dpTable > 0 then
					local gProm = dpTable[math.random(1, #dpTable)];
					dUnit:SetHasPromotion(gProm, true)
					if mPlayer == Game.GetActivePlayer() then
						Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(dUnit:GetX(),dUnit:GetY()))), Locale.Lookup(GameInfo.UnitPromotions[gProm].Description), 1)
					end
					return
				end
			end
			if math.random(1,4) == 3 then
				local gResource = GreatResourceTable[TypeTab[gID]];
				if gResource then
					Players[mPlayer]:ChangeNumResourceTotal(gResource, 1)
					if mPlayer == Game.GetActivePlayer() then
						Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(unitX,unitY))), "+1" .. Locale.Lookup(GameInfo.Resources[gResource].IconString), 1)
					end
					return;
				end
			end
			if math.random(1,5) == 4 then
				local gTech = GameInfoTypes[GameInfo.Units[TypeTab[gID]].PrereqTech];
				if gTech then
					if not Teams[Players[mPlayer]:GetTeam()]:IsHasTech(gTech) then
						Teams[Players[mPlayer]:GetTeam()]:SetHasTech(gTech, true, mPlayer)
					end
				end
			end
		end
	end
end
GameEvents.UnitPrekill.Add(PreKillFunction)