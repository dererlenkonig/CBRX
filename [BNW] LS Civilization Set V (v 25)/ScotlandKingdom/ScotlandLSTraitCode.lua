print("Flower of Enlightenment - Scotland Trait Code")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LS5SCOT";
local UAbB = {GameInfoTypes.BUILDING_DUMMY_SCOTLAND_DISABLER1, GameInfoTypes.BUILDING_DUMMY_SCOTLAND_DISABLER2, GameInfoTypes.BUILDING_DUMMY_SCOTLAND_DISABLER3, GameInfoTypes.BUILDING_DUMMY_SCOTLAND_DISABLER4, GameInfoTypes.BUILDING_DUMMY_SCOTLAND_DISABLER5, GameInfoTypes.BUILDING_DUMMY_SCOTLAND_DISABLER6, GameInfoTypes.BUILDING_DUMMY_SCOTLAND_DISABLER7}
local unValid = {}
local TeamsBS = {}
local HelpMMC = GameDefines.MAX_MAJOR_CIVS - 1;
local ValidPlayerTable = {}
local cBonusT = {}

function GiveTableOfValidTraitPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
		local player = Players[iplayer];
		cBonusT[iplayer] = load(player, "LS5ScotCB") or 0;
		if load(player, "LS5ScotInit") == nil then
			TeamsBS[player:GetTeam()] = Teams[player:GetTeam()];
			save(player, "LS5ScotInit", 1)
		end
	end
	for iTech in GameInfo.Technologies() do
		if 2 > GameInfo.Eras{Type= iTech.Era}().ID then
			unValid[iTech.ID] = 1;
		elseif iTech.Era == "ERA_INDUSTRIAL" then
			if Game.GetStartEra() <= GameInfoTypes.ERA_INDUSTRIAL then
				for iTeam, bTeam in pairs(TeamsBS) do
					bTeam:GetTeamTechs():ChangeResearchProgressPercent(iTech.ID, 15);
				end
			end
		end
	end
end



GameEvents.TeamSetHasTech.Add(function(iTeam, techID)
	if unValid[techID] == nil then
		if FirstTD(techID, iTeam) then
			for i = 0, HelpMMC do
				local hPlayer = Players[i];
				if hPlayer:IsEverAlive() then
					if ValidPlayerTable[i] then
						if hPlayer:GetTeam() == iTeam then
							save(hPlayer, "LS5ScotCB", cBonusT[i] + 1)
							cBonusT[i] = cBonusT[i] + 1;
							ExtraTH(i)
						end
					end
				end
			end
		end
	end
end)

function FirstTD(techID, iTeam)
	for i = 0, HelpMMC do
		local hPlayer = Players[i];
		if hPlayer:IsEverAlive() then
			local hTeam = hPlayer:GetTeam();
			if hTeam ~= iTeam then
				if Teams[hTeam]:IsHasTech(techID) then
					return false;
				end
			end
		end
	end
	return true;
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		ExtraTH(iPlayer)
	end
end)

function ExtraTH(iPlayer)
	if Players[iPlayer]:GetNumCities() > 0 then
		local pPlayer = Players[iPlayer];
		local tBonus = cBonusT[iPlayer] or 0;
		local iCity = pPlayer:GetCapitalCity();
		if iCity then
			for i = 1, 7 do
				if tBonus < math.pow(2, 7 - i) then
					iCity:SetNumRealBuilding(UAbB[8 - i], 0)
				else
					iCity:SetNumRealBuilding(UAbB[8 - i], 1)
					tBonus = tBonus - math.pow(2, 7 - i);
				end
			end
		end
	end
end

GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if ValidPlayerTable[iNewOwner] then
		for iCity in Players[iNewOwner]:Cities() do
			for i = 1, 7 do
				iCity:SetNumRealBuilding(UAbB[i], 0)
			end
		end
		ExtraTH(iNewOwner)
	end
end)