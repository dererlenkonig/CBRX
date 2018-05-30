print ("Xingu Check")

local XinguID = GameInfoTypes.CIVILIZATION_XINGU_MOD;

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if player:GetCivilizationType() == XinguID then
			include("Xingu Mod Scripts")
			break;
		end
	end
end

-- Stuff
local pHuka = GameInfoTypes.PROMOTION_XINGU;
local pHukaDummy = GameInfoTypes.PROMOTION_XINGU_DUMMMY;
local pXingu = GameInfoTypes.PROMOTION_XINGU_UPGRADE;

--Upgrade XP
GameEvents.UnitUpgraded.Add(
function(playerId, unitId, newUnitId, bGoodyHut)
	local pPlayer = Players[playerId];
	local pUnit = pPlayer:GetUnitByID(unitId);
	if (pUnit:IsHasPromotion(pXingu)) then
		local BaseXP = pUnit:GetExperience()
		local HukaXP = BaseXP + 10;
		pUnit:SetExperience(HukaXP);
	end
end);

--Huka-Huka Bonus
function GetWeLoveCount(pPlayer)	
	local cWeLove = 0;
	for pCity in pPlayer:Cities() do
		if (pCity:GetWeLoveTheKingDayCounter() >= 1) then
			cWeLove = 1;
			break
		end
	end
	return cWeLove;
end

function GetWeLoveDistance(pPlot, pPlayer)	
	local cWeLoveDistance = 0;
	for pCity in pPlayer:Cities() do
		if (pCity:GetWeLoveTheKingDayCounter() >= 1) then
			if Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCity:GetX(), pCity:GetY()) <= 5 then			
				cWeLoveDistance = 1;
				break
			end
		end
	end
	return cWeLoveDistance;
end

GameEvents.PlayerDoTurn.Add(
function(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsAlive()) then
		local cWeLove = GetWeLoveCount(pPlayer);
		if cWeLove >= 1 then
			for pUnit in pPlayer:Units() do
				local pPlot = pUnit:GetPlot()
				local cWeLoveDistance = GetWeLoveDistance(pPlot, pPlayer);
				if cWeLoveDistance >= 1 then
					if pUnit:IsHasPromotion(pHuka) then
						pUnit:SetHasPromotion(pHuka, false)	
						pUnit:SetHasPromotion(pHukaDummy, true)		
					end
				elseif cWeLoveDistance < 1 then
					if pUnit:IsHasPromotion(pHukaDummy) then
						pUnit:SetHasPromotion(pHukaDummy, false)	
						pUnit:SetHasPromotion(pHuka, true)		
					end
				end
			end
		elseif cWeLove < 1 then
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(pHukaDummy) then
					pUnit:SetHasPromotion(pHukaDummy, false)	
					pUnit:SetHasPromotion(pHuka, true)		
				end
			end
		end
	end
end)

GameEvents.UnitSetXY.Add( 
function(iPlayerID, iUnitID, iX, iY)
	local pPlot = Map.GetPlot(iX, iY)
	local pPlayer = Players[iPlayerID]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
	if pPlot then
		if (pUnit:IsHasPromotion(pHuka)) or (pUnit:IsHasPromotion(pHukaDummy)) then
			local cWeLove = GetWeLoveCount(pPlayer);
			if cWeLove >= 1 then
				local cWeLoveDistance = GetWeLoveDistance(pPlot, pPlayer);
				if cWeLoveDistance >= 1 then
					if pUnit:IsHasPromotion(pHuka) then
						pUnit:SetHasPromotion(pHuka, false)	
						pUnit:SetHasPromotion(pHukaDummy, true)		
					end
				elseif cWeLoveDistance < 1 then
					if pUnit:IsHasPromotion(pHukaDummy) then
						pUnit:SetHasPromotion(pHukaDummy, false)	
						pUnit:SetHasPromotion(pHuka, true)		
					end
				end
			elseif cWeLove < 1 then
				if pUnit:IsHasPromotion(pHukaDummy) then
					pUnit:SetHasPromotion(pHukaDummy, false)	
					pUnit:SetHasPromotion(pHuka, true)		
				end
			end
		end
	end
end)

GameEvents.BuildFinished.Add(function(iPlayer, x, y, eImprovement) 
	local pPlayer = Players[iPlayer];
	local cWeLove = GetWeLoveCount(pPlayer);
	if cWeLove >= 1 then
		for pUnit in pPlayer:Units() do
			local pPlot = pUnit:GetPlot()
			local cWeLoveDistance = GetWeLoveDistance(pPlot, pPlayer);
			if cWeLoveDistance >= 1 then
				if pUnit:IsHasPromotion(pHuka) then
					pUnit:SetHasPromotion(pHuka, false)	
					pUnit:SetHasPromotion(pHukaDummy, true)		
				end
			elseif cWeLoveDistance < 1 then
				if pUnit:IsHasPromotion(pHukaDummy) then
					pUnit:SetHasPromotion(pHukaDummy, false)	
					pUnit:SetHasPromotion(pHuka, true)		
				end
			end
		end
	elseif cWeLove < 1 then
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(pHukaDummy) then
				pUnit:SetHasPromotion(pHukaDummy, false)	
				pUnit:SetHasPromotion(pHuka, true)		
			end
		end
	end
end)

GameEvents.CityCaptureComplete.Add(
function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	local cPlot = Map.GetPlot(iX, iY);	
	local pCity = cPlot:GetPlotCity();
	local iPreviousOwner = pCity:GetPreviousOwner();
	local pPlayer = Players[iPreviousOwner];
	local cWeLove = GetWeLoveCount(pPlayer);
	if cWeLove >= 1 then
		for pUnit in pPlayer:Units() do
			local pPlot = pUnit:GetPlot()
			local cWeLoveDistance = GetWeLoveDistance(pPlot, pPlayer);
			if cWeLoveDistance >= 1 then
				if pUnit:IsHasPromotion(pHuka) then
					pUnit:SetHasPromotion(pHuka, false)	
					pUnit:SetHasPromotion(pHukaDummy, true)		
				end
			elseif cWeLoveDistance < 1 then
				if pUnit:IsHasPromotion(pHukaDummy) then
					pUnit:SetHasPromotion(pHukaDummy, false)	
					pUnit:SetHasPromotion(pHuka, true)		
				end
			end
		end
	elseif cWeLove < 1 then
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(pHukaDummy) then
				pUnit:SetHasPromotion(pHukaDummy, false)	
				pUnit:SetHasPromotion(pHuka, true)		
			end
		end
	end
end)

