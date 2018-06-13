print ("Army with the Army - PRussia UB code ")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LSPrussia";
local ValidPlayerTable = {}
local hGGP = {}
local uBuilding = GameInfoTypes.BUILDING_LS_KRIEGSSCHULE;
local hDummy = GameInfoTypes.BUILDING_DUMMY_LS_PRUSSIA_HAP;
local gpT = {}
local gtT = {}
local QueueOfEras = {}
local OrderOfEra = {};
local xpOfEra = {}
for row in GameInfo.Eras() do
	OrderOfEra[row.ID] = {}
end
for row in GameInfo.Technology_PrereqTechs() do
	local tech1 = GameInfo.Technologies[row.TechType];
	local tech2 = GameInfo.Technologies[row.PrereqTech];
	if tech1 and tech2 then
		if tech1.Era and tech2.Era and (tech1.Era ~= tech2.Era) then
			OrderOfEra[GameInfoTypes[tech1.Era]][GameInfoTypes[tech2.Era]] = 1;
		end
	end
end
local bLoop = true;
while(bLoop) do
	local nEra;
	for era, preeras in pairs(OrderOfEra) do
		local bCont = true;
		for bera, sth in pairs(preeras) do
			if OrderOfEra[bera] then
				bCont = false;
				break;
			end
		end
		if bCont then
			nEra = era;
			break;
		end
	end
	if nEra then
		OrderOfEra[nEra] = nil;
		table.insert(QueueOfEras, nEra);
	else
		bLoop = false;
	end
end
OrderOfEra = {}
local baseXP = 5;
local eraM = GameInfoTypes.ERA_MEDIEVAL;
local bPostM = false;
for i, era in pairs(QueueOfEras) do
	OrderOfEra[era] = i;
	if bPostM then
		baseXP = baseXP + 1;
	elseif era == eraM then
		bPostM = true;
	end
	xpOfEra[era] = baseXP;
end

function GiveTableOfValidBuildingPlayers(tab)
	local bHuman = false;
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
		hGGP[player] = {}
		for i = 1, 8 do
			hGGP[player][i] = load(Players[player], "LSggp" .. i) or 0;
		end
		gtT[player] = load(Players[player], "LSgt") or Players[player]:GreatGeneralThreshold()
		gpT[player] = load(Players[player], "LSce") or Players[player]:GetCombatExperience();
		if Players[player]:IsHuman() then
			bHuman = true;
		end
	end
	if bHuman then
		Events.GameplaySetActivePlayer.Add(UpdateIndicatorOnPlayerChange)
	end
end

function UpdateIndicatorOnPlayerChange()
	Controls.UprisingTurns:SetHide(true)
	if ValidPlayerTable[Game.GetActivePlayer()] then
		UpdateTextData(Game.GetActivePlayer())
	end
end

function DoBoostGGStuff(iPlayer)
	local index = 1 + Game.GetGameTurn()%8;
	local val = 0;
	if Players[iPlayer]:GreatGeneralThreshold() ~= gtT[iPlayer] then
		val = Players[iPlayer]:GetCombatExperience() + gtT[iPlayer] - gpT[iPlayer];
		gtT[iPlayer] = Players[iPlayer]:GreatGeneralThreshold();
		save(Players[iPlayer], "LSgt", Players[iPlayer]:GreatGeneralThreshold())
	else
		val = Players[iPlayer]:GetCombatExperience() - gpT[iPlayer]
	end
	if gpT[iPlayer] ~= Players[iPlayer]:GetCombatExperience() then
		gpT[iPlayer] = Players[iPlayer]:GetCombatExperience();
		save(Players[iPlayer], "LSce", gpT[iPlayer])
	end
	hGGP[iPlayer][index] = val;
	save(Players[iPlayer], "LSggp" .. index, val)
	if iPlayer == Game.GetActivePlayer() then
		UpdateTextData(iPlayer)
	end
end

local isF = true;
function UpdateTextData(iPlayer)
	if isF then
		if ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack") then
			Controls.UprisingTurns:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
		end
		isF = false;
	end
	Controls.UprisingTurns:SetHide(false)
	Controls.UprisingTurns:SetText("[ICON_WAR]" .. GetAvgGPP(iPlayer) )
	local perXP = xpOfEra[Players[iPlayer]:GetCurrentEra()];
	Controls.UprisingTurns:SetToolTipString("Indicates the average Great General points earned in last 8 turns. The bonus [ICON_HAPPINESS_1] Happiness from Kriegsschule is based on this value (1[ICON_HAPPINESS_1] for 1-" .. perXP .. ", 2[ICON_HAPPINESS_1] for " .. perXP + 1 .. "-" .. perXP * 3 .. ", 3[ICON_HAPPINESS_1] for " .. perXP * 3 + 1 .. "-" .. perXP * 6 .. " and so on).");
end

function GetAvgGPP(iPlayer)
	local num = 0;
	for i, val in pairs(hGGP[iPlayer]) do
		num = num + val;
	end
	return math.floor(num / 8);
end

function GetHapFromAvg(avg, perXP)
	local hap,b = 0, avg;
	while b > 0 do
		hap = hap + 1;
		b = b - hap * perXP;
	end
	return hap;
end

function CheckHapBonus(iPlayer)
	local avg = GetAvgGPP(iPlayer)
	local numHap = GetHapFromAvg(avg, xpOfEra[Players[iPlayer]:GetCurrentEra()])
	for iCity in Players[iPlayer]:Cities() do
		iCity:SetNumRealBuilding(hDummy, 0)
		if iCity:IsHasBuilding(uBuilding) then
			iCity:SetNumRealBuilding(hDummy, numHap)
		end
	end
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		DoBoostGGStuff(iPlayer)
		CheckHapBonus(iPlayer)
	end
end)

Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		CheckHapBonus(iPlayer)
	end
end)

Events.SequenceGameInitComplete.Add(function()
	if ValidPlayerTable[Game.GetActivePlayer()] then
		UpdateTextData(Game.GetActivePlayer())
	end
end)

GameEvents.PlayerCityFounded.Add(function(iPlayer, iCityX, iCityY)
	if ValidPlayerTable[iPlayer] then
		CheckHapBonus(iPlayer)
	end
end)

GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if ValidPlayerTable[iNewOwner] then
		CheckHapBonus(iNewOwner)
	end
end)

GameEvents.CityConstructed.Add(function(ownerId, cityId, buildingType, bGold, bFaithOrCulture)
	if uBuilding == buildingType then
		CheckHapBonus(ownerId)
	end
end)