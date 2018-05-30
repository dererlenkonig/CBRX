local MCPyramids1 = GameInfoTypes.IMPROVEMENT_MC_LITE_NUBIAN_ROYAL_PYRAMID
local MCPyramids2 = GameInfoTypes.IMPROVEMENT_MC_ROYAL_PYRAMID2
local MCPyramids3 = GameInfoTypes.IMPROVEMENT_MC_ROYAL_PYRAMID3
local MCPyramids4 = GameInfoTypes.IMPROVEMENT_MC_ROYAL_PYRAMID4
local MCPyramids5 = GameInfoTypes.IMPROVEMENT_MC_ROYAL_PYRAMID5
local MCPyramids6 = GameInfoTypes.IMPROVEMENT_MC_ROYAL_PYRAMID6
local MCPyramids7 = GameInfoTypes.IMPROVEMENT_MC_ROYAL_PYRAMID7
local MCPyramids8 = GameInfoTypes.IMPROVEMENT_MC_ROYAL_PYRAMID8

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

local PyramidPlots = {}

for iPlot = 0, Map.GetNumPlots() - 1, 1 do
    local pPlot = Map.GetPlotByIndex(iPlot)
	if (pPlot:GetImprovementType() == MCPyramids1) or (pPlot:GetImprovementType() == MCPyramids2) or (pPlot:GetImprovementType() == MCPyramids3) or (pPlot:GetImprovementType() == MCPyramids4) or (pPlot:GetImprovementType() == MCPyramids5) or (pPlot:GetImprovementType() == MCPyramids6) or (pPlot:GetImprovementType() == MCPyramids7) or (pPlot:GetImprovementType() == MCPyramids8) then
		local sKey = CompilePlotID(pPlot)
		PyramidPlots[sKey] = -1
    end
end

GameEvents.BuildFinished.Add(function(iPlayer, x, y, eImprovement) 
	local pPlot = Map.GetPlot(x, y);
	if eImprovement == MCPyramids1 then
		local sKey = CompilePlotID(pPlot)						
		PyramidPlots[sKey] = -1
	end
end)

function UpgradeNubiaUI(iTeam, iEra)
	for sKey, tTable in pairs(PyramidPlots) do
		local pPlot = DecompilePlotID(sKey)
		if (pPlot:GetOwner() ~= -1) then
			local pPlayer = Players[pPlot:GetOwner()];
			local pTeam = pPlayer:GetTeam();
			if pTeam == iTeam then
				if (pPlot:GetImprovementType() == MCPyramids1) then
					pPlot:SetImprovementType(MCPyramids2);
				elseif (pPlot:GetImprovementType() == MCPyramids2) then
					pPlot:SetImprovementType(MCPyramids3);
				elseif (pPlot:GetImprovementType() == MCPyramids3) then
					pPlot:SetImprovementType(MCPyramids4);
				elseif (pPlot:GetImprovementType() == MCPyramids4) then
					pPlot:SetImprovementType(MCPyramids5);
				elseif (pPlot:GetImprovementType() == MCPyramids5) then
					pPlot:SetImprovementType(MCPyramids6);
				elseif (pPlot:GetImprovementType() == MCPyramids6) then
					pPlot:SetImprovementType(MCPyramids7);
				elseif (pPlot:GetImprovementType() == MCPyramids7) then
					pPlot:SetImprovementType(MCPyramids8);
				end
			end
		end
	end
end

GameEvents.TeamSetEra.Add(UpgradeNubiaUI)