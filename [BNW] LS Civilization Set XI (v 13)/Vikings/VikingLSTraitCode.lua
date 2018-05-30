print("Age of Thor - Viking Trait Code")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "LS11Viking";
local dummyReducer = GameInfoTypes.BUILDING_DUMMY_LS_VIKING_DEF;
local dummyReducer50 = GameInfoTypes.BUILDING_DUMMY_LS_VIKING_DEF_50;
local cPlayer;
local cCities = {}
local ValidPlayerTable = {}
local ContConqT = {}
local TLSHT = {}
local TLSCT = {}
local TLSCC = 0;

function GiveTableOfValidTraitPlayers(tab)
	for i, iplayer in pairs(tab) do
		ValidPlayerTable[iplayer] = 1;
		ContConqT[iplayer] = {}
	end
	cPlayer = load(Players[63], "LSvikCP") or 0;
	for i, v in pairs(Players) do
		for iCity in v:Cities() do
			if iCity:IsHasBuilding(dummyReducer) or iCity:IsHasBuilding(dummyReducer50) then
				table.insert(cCities, iCity:Plot())
			end
		end
	end
end

function Clear()
	for it, iPlot in pairs(cCities) do
		local iCity = iPlot:GetPlotCity();
		if iCity then
			iCity:SetNumRealBuilding(dummyReducer, 0)
			iCity:SetNumRealBuilding(dummyReducer50, 0)
		end
	end
	cCities = {};
end

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	cPlayer = iPlayer;
	save(Players[63], "LSvikCP", iPlayer)
	Clear()
	if ValidPlayerTable[iPlayer] then
		CheckPlayerBonus(iPlayer)
	end
end)

function CheckPlayerBonus(iPlayer)
	local pTeam = Teams[Players[iPlayer]:GetTeam()]
	for i, v in pairs(Players) do
		if pTeam:IsAtWar(v:GetTeam()) then
			for iCity in v:Cities() do
				if iCity:IsCoastal() then
					local num = iCity:GetBuildingDefense() / 50;
					iCity:SetNumRealBuilding(GetBuildingDefReducer(iPlayer, iCity:Plot()), math.floor(iCity:GetStrengthValue()*0.01 + 0.49))
					table.insert(cCities, iCity:Plot());
				end
			end
		end
	end
end

GameEvents.DeclareWar.Add(function(t1, t2)
	if ValidPlayerTable[cPlayer] then
		if (Players[cPlayer]:GetTeam() == t1) or (Players[cPlayer]:GetTeam() == t2) then
			Clear()
			CheckPlayerBonus(cPlayer)
		end
	end
end)

function GetBuildingDefReducer(iPlayer, iPlot)
	local contID = ContTahCh(iPlot)
	if not ContConqT[iPlayer][contID] then
		ContConqT[iPlayer][contID] = load(Players[iPlayer], "LS11vcc" .. contID) or 0;
	end
	if ContConqT[iPlayer][contID] == 0 then
		return dummyReducer50;
	else
		return dummyReducer;
	end
end

GameEvents.CityCaptureComplete.Add(function(cPlayer, cap, x, y, iPlayer)
	if ValidPlayerTable[iPlayer] then
		local contID = ContTahCh(Map.GetPlot(x,y));
		if (not ContConqT[iPlayer][contID]) or ContConqT[iPlayer][contID] == 0 then
			save(Players[iPlayer], "LS11vcc" .. contID, 1)
			ContConqT[iPlayer][contID] = 1;
		end
	end
end)

--ocean

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if TLSHT[fPlot] == nil then
			if not fPlot:IsWater() then
				TLSCC = TLSCC + 1;
				TLSCT[TLSCC] = {}
				ContinentITP(fPlot, TLSCC)
			end
		end
	end
	TLSHT = nil;
end)

function ContinentITP(iPlot, continentID)
	TLSHT[iPlot] = 1;
	TLSCT[continentID][iPlot] = 1;
	for j = 0, 5 do
		local jPlot = Map.PlotDirection(iPlot:GetX(), iPlot:GetY(), j);
		if jPlot ~= nil then
			if TLSHT[jPlot] == nil then
				if not jPlot:IsWater() then
					ContinentITP(jPlot, continentID)
				end
			end
		end
	end
end

function ContTahCh(iPlot)
	for i = 1, TLSCC do
		if TLSCT[i][iPlot] ~= nil then
			return i;
		end
	end
	print("Tahitian Mod reporting in: Failure")
	return 0;
end

GameEvents.DeclareWar.Add(function(teamId, bTeamId)
	if ValidPlayerTable[cPlayer] then	
		if Players[cPlayer]:GetTeam() == teamId or Players[cPlayer]:GetTeam() == bTeamId then
			Clear()
			CheckPlayerBonus(cPlayer)
		end
	end
end)