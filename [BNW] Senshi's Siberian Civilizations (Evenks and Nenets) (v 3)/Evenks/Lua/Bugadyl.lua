local iDomainLand = GameInfoTypes.DOMAIN_LAND
function Senshi_Bugadyl(iPlayer, iUnitID, iUnitType, iX, iY, bDelay, iKillingPlayer)
    --print("function Senshi_Bugadyl fired")
    if Players[iKillingPlayer] and (iKillingPlayer ~= iPlayer) and (Players[iPlayer]:GetCivilizationType() == GameInfoTypes.CIVILIZATION_SENSHI_EVENKS) then
        --print("Unit belonged to CIVILIZATION_SENSHI_EVENKS")
        local pUnit = Players[iPlayer]:GetUnitByID(iUnitID)
        if pUnit:IsCombatUnit() and (pUnit:GetDomainType() == iDomainLand) then
            local pPlot = Map.GetPlot(iX, iY)
            if pPlot:GetImprovementType() == -1 or pPlot:IsImprovementPillaged() then
                --print("Plot had no improvement or the improvement was pillaged")
                pPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_SENSHI_BUGADYL)
                pPlot:SetImprovementPillaged(false)
            end
        else
            print("Unit killed was not a land combat unit, nothing to do")
        end
    end
end
GameEvents.UnitPrekill.Add(Senshi_Bugadyl)

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	for pUnit in Players[iPlayer]:Units() do
		local pPlot = pUnit:GetPlot()
		if pPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_SENSHI_BUGADYL then
			pUnit:ChangeDamage(50,pPlot:GetOwner())
			pPlot:SetImprovementType(-1)
		end
	end
end)