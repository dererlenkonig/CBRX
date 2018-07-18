print("Paro Taktsang Mountain Code (+1 culture and +1 faith on mountains) - CBRX Wonder Pack")

WARN_NOT_SHARED = false; include( "SaveUtils" ); MY_MOD_NAME = "CBRX_Wonders_Paro";

local MountainsList = {}
local yFaith = GameInfoTypes.YIELD_FAITH;
local yCulture = GameInfoTypes.YIELD_CULTURE;
local wonder = GameInfoTypes.BUILDING_TAKTSANG
local wonderOwner = 0

Events.SequenceGameInitComplete.Add(function()
	for i = 0, Map:GetNumPlots() - 1, 1 do
		local fPlot = Map.GetPlotByIndex( i );
		if fPlot:IsMountain() then
			if (fPlot:GetFeatureType() == -1) or (not GameInfo.Features[fPlot:GetFeatureType()].NaturalWonder) then
				table.insert(MountainsList, fPlot)
			end
		end
	end
end)

GameEvents.CityBoughtPlot.Add(function(ownerId, cityId, plotX, plotY, bGold, bFaithOrCulture)
	MainHandler(ownerId)
end)

GameEvents.BuildFinished.Add(function(iPlayer, x, y, improID)
	if GameInfo.Improvements[improID] then
		if GameInfo.Improvements[improID].CultureBombRadius > 0 then
			MainHandler(iPlayer)
		end
	end
end)

GameEvents.CityCaptureComplete.Add(function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
	MainHandler(iNewOwner)
	MainHandler(iOldOwner)
end)

GameEvents.PlayerCityFounded.Add(function(iPlayer, iCityX, iCityY)
	MainHandler(iPlayer)
end)

function MainHandler(playerID)
	local player = Players[playerID]
	for city in player:Cities() do
		if city:IsHasBuilding(wonder) then
			wonderOwner = playerID
			UpdateMountainYields()
		end
	end
end

function UpdateMountainYields()
	for i, fPlot in pairs(MountainsList) do
		if fPlot:GetOwner() == wonderOwner then
			Game.SetPlotExtraYield(fPlot:GetX(), fPlot:GetY(), yFaith, 1)
			Game.SetPlotExtraYield(fPlot:GetX(), fPlot:GetY(), yCulture, 1)
		else
			Game.SetPlotExtraYield(fPlot:GetX(), fPlot:GetY(), yFaith, 0)
			Game.SetPlotExtraYield(fPlot:GetX(), fPlot:GetY(), yCulture, 0)
		end
	end
end