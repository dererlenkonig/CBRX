print("One thousand nights - Durrani Trait Code")

local ValidPlayerTable = {}
local CultureBonus = {}
local numGWA = {}
local gWriter = GameInfoTypes.UNITCLASS_WRITER;
local gScientist = GameInfoTypes.UNITCLASS_SCIENTIST;
local Iacademy = GameInfoTypes.IMPROVEMENT_ACADEMY;
local citadelHD = {}

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
		numGWA[player] = Players[player]:GetNumGreatWorks();
		for iUnit in Players[player]:Units() do
			if iUnit:GetUnitClassType() == gWriter then
				if iUnit:GetGivePoliciesCulture() then
					CultureBonus[player] = iUnit:GetGivePoliciesCulture();
				end
			end
		end
	end
end

function GetTechTypeResearching(iPlayer)
	local cRes = Players[iPlayer]:GetCurrentResearch();
	if cRes > -1 then
		return cRes;
	end
	for row in GameInfo.Technologies() do
		if Players[iPlayer]:CanResearch(row.ID) then
			return row.ID;
		end
	end
	return nil;
end

function ChangeScienceRawBonusNow(iPlayer, amount)
	local team = Players[iPlayer]:GetTeam();
	local teamtechs = Teams[team]:GetTeamTechs();
	local techtype = GetTechTypeResearching(iPlayer)
	if techtype then
		teamtechs:ChangeResearchProgress(techtype, amount, iPlayer)
	end
end

GameEvents.UnitSetXY.Add(function(player, unit, x, y)
	if ValidPlayerTable[player] then
		local iPlot = Map.GetPlot(x,y);
		if iPlot then
			local cUnit = Players[player]:GetUnitByID(unit);
			if cUnit:GetUnitClassType() == gWriter then
				if cUnit:GetGivePoliciesCulture() > 0 then
					CultureBonus[player] = cUnit:GetGivePoliciesCulture();
				end
			end
		end
	end
end)

GameEvents.GreatPersonExpended.Add(function(iPlayer, uType)
	if ValidPlayerTable[iPlayer] then
		if Players[iPlayer]:GetNumGreatWorks() ~= numGWA[iPlayer] then
			numGWA[iPlayer] = Players[iPlayer]:GetNumGreatWorks();
			if GameInfoTypes[GameInfo.Units[uType].Class] == gWriter then
				if CultureBonus[iPlayer] then
					if CultureBonus[iPlayer] > 0 then
						Players[iPlayer]:ChangeJONSCulture(math.ceil(CultureBonus[iPlayer]/2))
					end
				end
			end
		end
		if GameInfoTypes[GameInfo.Units[uType].Class] == gScientist then
			if citadelHD[1] == iPlayer then
				if citadelHD[2] == Game.GetGameTurn() then
					ChangeScienceRawBonusNow(iPlayer, citadelHD[4])
				end
			end
		end
	end
	citadelHD = {}
end)

GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	if ValidPlayerTable[iNewOwner] then
		numGWA[iNewOwner] = Players[iNewOwner]:GetNumGreatWorks();
	end
	if ValidPlayerTable[iOldOwner] then
		numGWA[iOldOwner] = Players[iOldOwner]:GetNumGreatWorks();
	end
end)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	if ValidPlayerTable[iPlayer] then
		numGWA[iPlayer] = Players[iPlayer]:GetNumGreatWorks();
		for iUnit in Players[iPlayer]:Units() do
			if iUnit:GetUnitClassType() == gWriter then
				if iUnit:GetGivePoliciesCulture() > 0 then
					CultureBonus[iPlayer] = iUnit:GetGivePoliciesCulture();
				end
			end
		end
	end
end)

GameEvents.BuildFinished.Add(function(iPlayer, x, y, improID)
	if ValidPlayerTable[iPlayer] then
		if improID == Iacademy then
			local iPlot = Map.GetPlot(x, y);
			for i = 0, iPlot:GetNumUnits() -1 do
				local iUnit = iPlot:GetUnit(i);
				if iUnit:GetUnitClassType() == gScientist then
					if iUnit:GetDiscoverAmount() > 0 then
						citadelHD[1] = iPlayer;
						citadelHD[2] = Game.GetGameTurn();
						citadelHD[3] = Map.GetPlot(x, y);
						citadelHD[4] = math.ceil(iUnit:GetDiscoverAmount()/2)
						return;
					end
				end
			end
		end
	end
end)