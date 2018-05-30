print("Xingu Events")

--=========================================================
--Deforestation
--=========================================================

local isBNW = (GameInfoTypes.UNITCOMBAT_SUBMARINE ~= nil);
local eIndustrial = GameInfoTypes.ERA_INDUSTRIAL;
local fForest = GameInfoTypes.FEATURE_FOREST;
local fJungle = GameInfoTypes.FEATURE_JUNGLE;
local iLumber = GameInfoTypes.IMPROVEMENT_LUMBERMILL;
local iBrazil = GameInfoTypes.IMPROVEMENT_BRAZILWOOD_CAMP;

function DecompilePlotID(sKey)
    iBreak = string.find(sKey, "Y")
    iX = tonumber(string.sub(sKey, 1, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1))
    pPlot = Map.GetPlot(iX, iY)
    return pPlot
end

function CompilePlotID(pPlot)
    iX = pPlot:GetX()
    iY = pPlot:GetY()
    return(iX .. "Y" .. iY)
end

local XinguForestPlots = {}
local XinguJunglePlots = {}

for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	if pPlot:GetFeatureType() == fForest then
		local sKey = CompilePlotID(pPlot)
		XinguForestPlots[sKey] = -1
    end
	if pPlot:GetFeatureType() == fJungle then
		local sKey = CompilePlotID(pPlot)
		XinguJunglePlots[sKey] = -1
    end
end

function XinguGetRandom(lower, upper)
    return (Game.Rand((upper + 1) - lower, "")) + lower
end

function GetHumanPlayer()
	local hPlayer = 0;
	for oPlayer=0, GameDefines.MAX_MAJOR_CIVS-1 do
		local oPlayer = Players[oPlayer];
		if (oPlayer:IsAlive()) and (oPlayer:IsHuman()) then
			hPlayer = oPlayer;
			break
		end
	end
	return hPlayer;
end

local Event_TomatekhXinguDeforestation = {}
	Event_TomatekhXinguDeforestation.Name = "TXT_KEY_EVENT_TOMATEKH_XINGU_DEFORESTATION"
	Event_TomatekhXinguDeforestation.Desc = "TXT_KEY_EVENT_TOMATEKH_XINGU_DEFORESTATION_DESC"
	Event_TomatekhXinguDeforestation.EventImage = "EDSlashBrunEarly.dds"
	Event_TomatekhXinguDeforestation.Weight = 2
	Event_TomatekhXinguDeforestation.CanFunc = (

		function(pPlayer)		
		
			if load(pPlayer, "Event_TomatekhXinguDeforestation") == true then return false end

			local pTeam = pPlayer:GetTeam();
			if (Teams[pTeam]:GetCurrentEra() < eIndustrial) then return false end

			if not isBNW then return false end

			Event_TomatekhXinguDeforestation.Name = "TXT_KEY_EVENT_TOMATEKH_XINGU_DEFORESTATION"

			return true

		end
		)

	Event_TomatekhXinguDeforestation.Outcomes = {}

	-- Outcome 1
	Event_TomatekhXinguDeforestation.Outcomes[1] = {}
	Event_TomatekhXinguDeforestation.Outcomes[1].Name = "TXT_KEY_EVENT_TOMATEKH_XINGU_DEFORESTATION_OUTCOME_1"
	Event_TomatekhXinguDeforestation.Outcomes[1].Desc = "TXT_KEY_EVENT_TOMATEKH_XINGU_DEFORESTATION_OUTCOME_1_DESC"
	Event_TomatekhXinguDeforestation.Outcomes[1].Weight = 10
	Event_TomatekhXinguDeforestation.Outcomes[1].CanFunc = (

		function(pPlayer)

			Event_TomatekhXinguDeforestation.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_XINGU_DEFORESTATION_OUTCOME_1_DESC")

			return true
		end
		)
	Event_TomatekhXinguDeforestation.Outcomes[1].DoFunc = (
		function(pPlayer)

			save(pPlayer, "Event_TomatekhXinguDeforestation", true)

			--JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_TOMATEKH_XINGU_DEFORESTATION_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_TomatekhXinguDeforestation.Name))

			local hPlayer = GetHumanPlayer();
			if hPlayer ~= 0 then
				if hPlayer ~= pPlayer then
					local pTeam = pPlayer:GetTeam();
					local hTeam = hPlayer:GetTeam();
					if Teams[pTeam]:IsHasMet(hTeam) then	
						Events.GameplayAlertMessage("" .. Locale.ConvertTextKey(pPlayer:GetCivilizationAdjective()) .. " lands are suffering from deforestation!")
					end
				end	
			end

			local pTeam = pPlayer:GetTeam();
			local EraCount = (Teams[pTeam]:GetCurrentEra() + 1);
			local Random = XinguGetRandom(1, 3);
			local JungleLoss = (EraCount - Random);
			if JungleLoss > 5 then
				JungleLoss = 5;
			end
			local ForestCheck = 0;
			for sKey, tTable in pairs(XinguJunglePlots) do
				local title = "Deforestation";
				local descr = "A Jungle has been lost to deforestation.";		
				local pPlot = DecompilePlotID(sKey)
				if (pPlot:GetFeatureType() == fJungle) then
					local pID = pPlayer:GetID();
					if pPlot:GetOwner() == pID then
						if JungleLoss >= 1 then						
							pPlot:SetFeatureType(-1);
							if (pPlot:GetImprovementType() == iLumber) or (pPlot:GetImprovementType() == iBrazil) then
								pPlot:SetImprovementType(-1);
							end
							JungleLoss = JungleLoss - 1;
							ForestCheck = ForestCheck + 1;
							pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, pPlot:GetX(), pPlot:GetY());	
						end
					end
				end
			end
			if ForestCheck == 0 then
				for sKey, tTable in pairs(XinguForestPlots) do
					local title = "Deforestation";
					local descr = "A Forest has been lost to deforestation.";		
					local pPlot = DecompilePlotID(sKey)
					if (pPlot:GetFeatureType() == fForest) then
						local pID = pPlayer:GetID();
						if pPlot:GetOwner() == pID then
							if JungleLoss >= 1 then						
								pPlot:SetFeatureType(-1);
								if (pPlot:GetImprovementType() == iLumber) or (pPlot:GetImprovementType() == iBrazil) then
									pPlot:SetImprovementType(-1);
								end
								JungleLoss = JungleLoss - 1;
								pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, descr, title, pPlot:GetX(), pPlot:GetY());	
							end
						end
					end
				end
			end

		end
		)

tEvents.Event_TomatekhXinguDeforestation = Event_TomatekhXinguDeforestation