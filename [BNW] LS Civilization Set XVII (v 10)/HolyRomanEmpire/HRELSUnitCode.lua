print ("Legacy Grabbers - HRE UU code ")

ContextPtr:SetHide(true)
Controls.Background:SetAlpha(0.5)
local HRELeaderIDTrait = {}
local HREPlayersTrait = {}

for row in GameInfo.Leader_Traits() do
	if row.TraitType == "TRAIT_LS_HRE" then
		HRELeaderIDTrait[GameInfoTypes[row.LeaderType]] = 1
	end
end

for i, player in pairs(Players) do
	if player:IsEverAlive() then
		if HRELeaderIDTrait[player:GetLeaderType()] then
			table.insert(HREPlayersTrait, i)
		end
	end
end

if #HREPlayersTrait > 0 then
	include("HRELSTraitCode")
	GiveTableOfValidTraitPlayers(HREPlayersTrait)
end

--

local rangeP = GameInfoTypes.PROMOTION_HRE_LS_RANGE;
local jezail = GameInfoTypes.UNIT_LS_HRE_REITER;
local RangAtt = GameInfoTypes.MISSION_RANGE_ATTACK;
local fIndi = GameInfoTypes.PROMOTION_LS_REITER_COUNTERSTRIKE;
local bKnight = GameInfoTypes.UNIT_LS_HRE_KNIGHT
local eMoves = GameInfoTypes.PROMOTION_LS_HRE_RAID

GameEvents.PlayerDoTurn.Add(function(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:GetUnitType() == jezail then
			if not iUnit:IsHasPromotion(fIndi) then
				SearchAttack(iUnit, iPlayer)
			else
				iUnit:SetHasPromotion(fIndi, false)
			end
		elseif iUnit:GetUnitType() == bKnight then
			local iMoves = iUnit:GetMoves() / iUnit:MaxMoves();
			iUnit:SetHasPromotion(eMoves, iUnit:GetPlot():GetOwner() == iPlayer)
			iUnit:SetMoves( math.floor(iMoves * iUnit:MaxMoves()))
		end
	end
end)


Events.AIProcessingEndedForPlayer.Add(function(iPlayer)
	for iUnit in Players[iPlayer]:Units() do
		if iUnit:GetUnitType() == jezail then
			iUnit:SetHasPromotion(fIndi, true)
		end
	end
end)

function SearchAttack(jUnit, iPlayer)
	local iPlot = jUnit:GetPlot();
	local iMoves = jUnit:GetMoves()
	if iMoves <= 0 then
		return
	end
	jUnit:SetHasPromotion(rangeP, true)
	local hTab = {}
	local hCou = 0;
	local bX = jUnit:GetX();
	local bY = jUnit:GetY();	
	for iX = -2, 2 do
		for iY = -2, 2 do
			local plot = Map.PlotXYWithRangeCheck(bX, bY, iX, iY, 2)
			if plot then
				if jUnit:CanStartMission(RangAtt, plot:GetX(), plot:GetY()) then
					if not plot:IsCity() then
						if not plot:IsWater() then
							table.insert(hTab, plot)
						end
					end
				end
			end
		end
	end
	if #hTab > 0 then
		local ePlot = hTab[math.random(1, #hTab)];
		jUnit:PushMission(RangAtt, ePlot:GetX(), ePlot:GetY())
	end
	jUnit:SetMoves(iMoves);
	jUnit:SetMadeAttack(false);
	jUnit:SetHasPromotion(rangeP, false)
end