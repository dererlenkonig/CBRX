-- C15_CrusaderVenice_Lua
-- Author: Chrisy15
-- DateCreated: 9/24/2016 2:00:45 PM
--------------------------------------------------------------

-- IsCPDLL
function IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = IsCPDLL()

-- HasTrait
function HasTrait(player, traitID)
	if isCPDLL then 
		return player:HasTrait(traitID)
	else
		local leaderType = GameInfo.Leaders[player:GetLeaderType()].Type
		local traitType  = GameInfo.Traits[traitID].Type
		for row in GameInfo.Leader_Traits("LeaderType = '" .. leaderType .. "' AND TraitType = '" .. traitType .. "'") do
			return true
		end
	end
	return false
end

local civilizationID = GameInfoTypes["CIVILIZATION_VENICE"]
local traitID = GameInfoTypes["TRAIT_C15_VENICE_CRUSADE"]
local iNavalProdDummy = GameInfoTypes["BUILDING_C15_VENICE_NAVAL_PROD"]
local iTradeRouteDummy = GameInfoTypes["BUILDING_C15_VENICE_TRADE_SLOT"]
local iPromotionNoleggiatore = GameInfoTypes["PROMOTION_C15_VENICE_NOLEGGIATORE"]
local iPromotionNoleggiatoreMoves = GameInfoTypes["PROMOTION_C15_VENICE_NOLEGGIATORE_ROUTE"]
local iCapHasBeenCappedDummy = GameInfoTypes["BUILDING_C15_VENICE_CAP_CAPPED"]
local iWLTKDduration = GameDefines.CITY_RESOURCE_WLTKD_TURNS

--==================================================================================================
-- Actual Code
----------------------------------------------------------------------------------------------------

--[[
	Upon capturing an enemy capital, all cities enter 'We Love the King Day' and you receive an 
	additional trade route slot.
]]

function C15_Venice_CapitalCapture(oldID, bCapital, iX, iY, newID, iOldPop, bConquest)
	--print("CapCap running")
	local pPlayer = Players[newID]
	--local pLostPlayer = Players[oldID]
	if HasTrait(pPlayer, traitID) then
		local pCaptured = Map.GetPlot(iX, iY):GetPlotCity()
		if bConquest and pCaptured:IsOriginalMajorCapital() and pCaptured:GetOriginalOwner() ~= newID then
			--print("Capital Captured")
			if not pCaptured:IsHasBuilding(iCapHasBeenCappedDummy) then
				for pCity in pPlayer:Cities() do
					--print("Iterating Cities")
					if not (pCity:IsRazing() or pCity:IsResistance()) and pCity ~= pCaptured then
						pCity:ChangeWeLoveTheKingDayCounter(iWLTKDduration)
						--print("WLTKD!")
					end
				end
				if pPlayer:IsHuman() then
					local sScienceGoldHeader = Locale.ConvertTextKey("TXT_KEY_C15_VENICE_HEADER")
					local sScienceGold = Locale.ConvertTextKey("TXT_KEY_C15_VENICE_TEXT", pCaptured:GetName())
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sScienceGold, sScienceGoldHeader)
				end
			end
			pCaptured:SetNumRealBuilding(iTradeRouteDummy, 1)
			pCaptured:SetNumRealBuilding(iCapHasBeenCappedDummy, 1)
		end
	end
end

GameEvents.CityCaptureComplete.Add(C15_Venice_CapitalCapture)

--[[
	Naval unit production is increased by 3% in the capital for every  puppet in the empire. 
	(up to a maximum of +66%)
]]

function C15_Venice_PuppetCount(playerID)
	local pPlayer = Players[playerID]
	if HasTrait(pPlayer, traitID) and pPlayer:GetCapitalCity() then
		local iNumPuppets = 0
		for pCity in pPlayer:Cities() do
			if pCity:IsPuppet() then
				iNumPuppets = iNumPuppets + 1
			end
		end
		if iNumPuppets > 22 then
			iNumPuppets = 22
		end
		if pPlayer:GetCapitalCity():GetNumRealBuilding(iNavalProdDummy) ~= iNumPuppets then
			pPlayer:GetCapitalCity():SetNumRealBuilding(iNavalProdDummy, iNumPuppets)
		end
	end
end

function C15_Venice_PuppetCount_Capture(oldID, bCapital, iX, iY, newID)
	local pPlayer = Players[newID]
	if HasTrait(pPlayer, traitID) then
		pPlayer:GetCapitalCity():SetNumRealBuilding(iNavalProdDummy, pPlayer:GetCapitalCity():GetNumRealBuilding(iNavalProdDummy) + 1)
	end
end

GameEvents.PlayerDoTurn.Add(C15_Venice_PuppetCount)
GameEvents.CityCaptureComplete.Add(C15_Venice_PuppetCount_Capture)

function C15_Venice_TraderBoatStuff(playerID)
	local pPlayer = Players[playerID]
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(iPromotionNoleggiatore) then
			local pPlot = pUnit:GetPlot()
			if pPlot:IsCity() then
				local pCity = pPlot:GetPlotCity()
				if pCity:IsPuppet() or pCity:IsOccupied() then
					local iPop = pCity:GetPopulation()
					pPlayer:ChangeGold(iPop)
					if playerID == Game.GetActivePlayer() then
						--Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))), "[COLOR_YIELD_GOLD]+"..iPop.."[ICON_GOLD] Gold[ENDCOLOR]", 0)
						local iX = pPlot:GetX()
						local iY = pPlot:GetY()
						local pHexPos = ToHexFromGrid{x=iX, y=iY}
						local pWorldPos = HexToWorld(pHexPos)
						Events.AddPopupTextEvent(pWorldPos, "[COLOR_YIELD_GOLD]+"..iPop.."[ICON_GOLD] Gold[ENDCOLOR]")
					end
				end
			end
			--local bIsCargo = false
			--[[for i=0, pPlot:GetNumUnits()-1, 1 do
				local pOtherUnit = pPlayer:GetUnitByID(i)
				if pOtherUnit:GetUnitType() == iCargoShip then
					bIsCargo = true
					break
				end
			end]]
			local tTradeRoutes = pPlayer:GetInternationalTradeRoutePlotToolTip(pPlot);
			local bIsRoute = #tTradeRoutes > 0
			pUnit:SetHasPromotion(iPromotionNoleggiatoreMoves, bIsRoute)
			if bIsRoute then pUnit:ChangeMoves(120) end
		end
	end
end

GameEvents.PlayerDoTurn.Add(C15_Venice_TraderBoatStuff)
