print("Trading Stones - Zimbabwe Trait Code")

include("IconSupport.lua")
IconHookup(2, 64, "CIV_MOD_LS_5_ATLAS", Controls.MyImage )
IconHookup(2, 64, "CIV_MOD_LS_5_ATLAS", Controls.MyImage2 )
local CTCZ = {}
local PTCZ = {}
local uadummy = GameInfoTypes.BUILDING_DUMMY_ZIMBABWE
local ValidPlayerTable = {}

function GiveTableOfValidTraitPlayers(tab)
	for i, player in pairs(tab) do
		ValidPlayerTable[player] = 1;
		if player == Game.GetActivePlayer() then
			Events.SerialEventExitCityScreen.Add(ExitCity);
			Events.SerialEventEnterCityScreen.Add(EnterCity);
			Events.SerialEventCityScreenDirty.Add(IsNextCitySelected);
		end
	end
end

function ZimbCheck(iPlayer)
	if ValidPlayerTable[iPlayer] then
		if Players[iPlayer]:GetNumCities() > 0 then
			CTCZ = {}
			PTCZ = {}
			local iTeam = Players[iPlayer]:GetTeam();
			MakeTablesZimb(iPlayer)
			local gCity = GetNumGC()
			for jTeam, it in pairs(PTCZ) do
				if not Teams[iTeam]:IsHasMet(jTeam) then
					if iTeam ~= jTeam then
						Teams[iTeam]:Meet(jTeam, true)
					end
				end
			end
			for iCity in Players[iPlayer]:Cities() do
				local gLinked = 0;
				if CTCZ[iCity] then
					for lcity, sth in pairs(CTCZ[iCity]) do
						gLinked = gLinked + 1;
					end
				end
				local numL = math.min(20, math.ceil(math.min(math.max(1, 50 / gCity), 3) * gLinked))
				iCity:SetNumRealBuilding(uadummy, numL)
			end
		end
	end	
end

function GetNumGC()
	local gnc = 0;
	for i,v in pairs(Players) do
		gnc = gnc + v:GetNumCities();
	end
	return gnc;
end

function MakeTablesZimb(iPlayer)
	for i,v in ipairs(Players[iPlayer]:GetTradeRoutes()) do
		if not CTCZ[v.FromCity] then
			OtherZim(v.FromCity, v.FromCity)
		end
		if v.ToCity:GetOwner() == iPlayer then
			if not CTCZ[v.ToCity] then
				OtherZim(v.ToCity, v.ToCity)
			end	
		end
	end
	for i,v in ipairs(Players[iPlayer]:GetTradeRoutesToYou()) do
		if not CTCZ[v.ToCity] then
			OtherZim(v.ToCity, v.ToCity)
		end
	end
end

function OtherZim(iCity, bCity)
	if iCity == bCity then
		if not CTCZ[bCity] then
			CTCZ[bCity] = {}
		end
	elseif CTCZ[bCity][iCity] then
		return
	else
		CTCZ[bCity][iCity] = 1;
	end
	local iPlayer = iCity:GetOwner();
	PTCZ[Players[iPlayer]:GetTeam()] = 1;
	for i,v in ipairs(Players[iPlayer]:GetTradeRoutes()) do
		if v.FromCity == iCity then
			OtherZim(v.ToCity, bCity)
		end
		if v.ToCity == iCity then
			OtherZim(v.FromCity, bCity)
		end
	end
	for i,v in ipairs(Players[iPlayer]:GetTradeRoutesToYou()) do
		if v.ToCity == iCity then
			OtherZim(v.FromCity, bCity)
		end
	end
end
GameEvents.PlayerDoTurn.Add(ZimbCheck)
Events.AIProcessingEndedForPlayer.Add(ZimbCheck)

function MakeNiceTooltip(sCity)
	sText = "City is linked with:"
	CTCZ[sCity] = nil;
	OtherZim(sCity, sCity)
	local sPlayer = sCity:GetOwner();
	for iCity, it in pairs(CTCZ[sCity]) do
		local iPlayer = iCity:GetOwner();
		if iPlayer == sPlayer then
			sText = sText .. "[NEWLINE]" .. iCity:GetName() .. " (" .. iCity:GetPopulation() .. "[ICON_CITIZEN], " .. Map.PlotDistance(sCity:GetX(), sCity:GetY(), iCity:GetX(), iCity:GetY()) .. "[ICON_MOVES])";
		elseif Players[iPlayer]:IsMinorCiv() then
			sText = sText .. "[NEWLINE]" .. iCity:GetName() .. " ([ICON_CITY_STATE] " .. Players[iPlayer]:GetCivilizationShortDescription() .. ", " .. iCity:GetPopulation() .. "[ICON_CITIZEN], " .. Map.PlotDistance(sCity:GetX(), sCity:GetY(), iCity:GetX(), iCity:GetY()) .. "[ICON_MOVES])";
		else
			sText = sText .. "[NEWLINE]" .. iCity:GetName() .. " (" .. Players[iPlayer]:GetCivilizationShortDescription() .. ", " .. iCity:GetPopulation() .. "[ICON_CITIZEN], " .. Map.PlotDistance(sCity:GetX(), sCity:GetY(), iCity:GetX(), iCity:GetY()) .. "[ICON_MOVES])";
		end
	end
	return sText;
end

function UpdateButton()
	Controls.MyBackground2:SetHide(true)
	local sCity = UI.GetHeadSelectedCity();
	if sCity then
		local nBonus = sCity:GetNumRealBuilding(uadummy);
		if nBonus == 0 then
			Controls.MyButton2:LocalizeAndSetToolTip("City is not linked with any other city.")
		else
			Controls.MyButton2:LocalizeAndSetToolTip(MakeNiceTooltip(sCity))
		end
		Controls.MyButton2:SetText("+" .. nBonus .. "% [ICON_PRODUCTION], [ICON_GOLD]")
		Controls.MyImage2:SetAlpha(0.6)
		Controls.MyBackground2:SetHide(false)
	end
end

function EnterCity()
	IsCityView = true;
	UpdateButton()
end

function ExitCity()
	IsCityView = false;
	UpdateButton()
end

function IsNextCitySelected()
	if IsCityView then
		UpdateButton()
	end
end