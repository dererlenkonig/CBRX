-- Hawke_Functions
-- Author: Typhlomence
-- DateCreated: 1/26/2017 8:35:12 PM
--------------------------------------------------------------

-- ============================================================================
-- Includes
-- ============================================================================
include("PlotIterators.lua")
--include("TableSaverLoader016.lua")

-- ============================================================================
-- TableSaverLoader setup
-- ============================================================================
--[[MapModData.HawkeData = {}
HawkeData = MapModData.HawkeData
HawkeData.tCurrentPolicyCosts = {}
tCurrentPolicyCosts = HawkeData.tCurrentPolicyCosts
include("TSLSerializerV3_Hawke.lua")--]]

-- ============================================================================
-- Enables debug statements
-- ============================================================================
local bDebug = true

function dprint(...)
  if (bDebug) then
    print(string.format(...))
  end
end

-- ============================================================================
-- Locals
-- ============================================================================
local iTraitHawke =					GameInfoTypes.TRAIT_SENSHI_HAWKE -- < put trait type here
local iImprovementFarm =			GameInfoTypes.IMPROVEMENT_FARM
local iImprovementFarmHawkeDummy =	GameInfoTypes.IMPROVEMENT_SENSHI_HAWKE_FARM -- < put improvement type here
local iPolicyHawkeDummyGA =			GameInfoTypes.POLICY_SENSHI_HAWKE -- < put policy type here for golden ages
local iPolicyHawkeDummyOff =		GameInfoTypes.POLICY_SENSHI_HAWKE_DUMMY -- < put policy type here for other times - an empty dummy is required to swap in when the GA is no longer in effect
local iTerrainDesert =				GameInfoTypes.TERRAIN_DESERT

-- The maximum number of specialists that can refund policy costs
local iSpecialistCap = 25

-- Stores the number of cities for each Hawke player, so we don't make surplus
-- tile checks if they have none
local tHawkeCities = {}

-- Stores the current policy costs for each Hawke player
local tCurrentPolicyCosts = {}

-- ============================================================================
-- JFD Helper Functions
-- ============================================================================
function JFD_IsCPDLL()
	for _, mod in pairs(Modding.GetActivatedMods()) do
		if mod.ID == "d1b6328c-ff44-4b0d-aad7-c657f83610cd" then
			return true
		end
	end
	return false
end
local isCPDLL = JFD_IsCPDLL()

-- HasTrait
function JFD_HasTrait(player, traitID)
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

-- ============================================================================
-- Hawke_Trait_FarmFinished
-- ============================================================================
-- When a civilization with Hawke's trait finishes a farm, replace it and any
-- surrounding farms with the +1 Food dummy if it meets the condition (two or
-- more farms adjacent on desert tiles)
--[[function Hawke_Trait_FarmFinished(iPlayer, iX, iY, iImprovement)
	local pPlayer = Players[iPlayer]

	-- Check if it's a player with Hawke's trait and it was a farm that was
	-- completed
	if (pPlayer:IsEverAlive() and JFD_HasTrait(pPlayer, iTraitHawke) and iImprovement = iImprovementFarm) then

		dprint("Hawke player in position " .. iPlayer .. " has finished a farm at " .. iX .. ", " .. iY)
		local pPlot = Map.GetPlot(iX, iY)
		local bChangeFarm = false
		if (pPlot:GetTerrainType() == iTerrainDesert) then
			dprint("This farm is on a desert tile. Checking if there are any adjacent farms on desert tiles")
			for pSpiralPlot in PlotAreaSpiralIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do

				-- If there's another desert farm
				if ((pSpiralPlot:GetImprovementType() == iImprovementFarm or pSpiralPlot:GetImprovementType() == iImprovementFarmHawkeDummy) and pPlot:GetTerrainType() == iTerrainDesert) then
					bChangeFarm = true
					dprint("Found an adjacent desert farm on " .. pSpiralPlot:GetX() .. ", " pSpiralPlot:GetY())
					if (pSpiralPlot:GetImprovementType() == iImprovementFarm and (pSpiralPlot:GetOwner() == iPlayer or JFD_HasTrait(Players[pSpiralPlot:GetOwner()], iTraitHawke))) then
						dprint("Changing that farm as well")
						pSpiralPlot:SetImprovementType(iImprovementFarmHawkeDummy)
					end
				end
			end

			if bChangeFarm then
				dprint("Changing the farm that was just built to the dummy farm")
				pPlot:SetImprovementType(iImprovementFarmHawkeDummy)
			end
		end
	end
end--]]

-- ============================================================================
-- Hawke_Trait_TurnCheck
-- ============================================================================
-- This checks all farms on the map to see if they should get Hawke's bonus or
-- not, as well as if a Hawke player is a golden age or not and changes dummy
-- policies accordingly
-- I know that checking all of the plots for Hawke's farms each turn is
-- inefficient, but it's the best way to ensure they're most likely to be
-- correct
function Hawke_Trait_TurnFarmCheck(iPlayer)
	local pPlayer = Players[iPlayer]

	-- Check if it's a player with Hawke's trait
	if (pPlayer:IsEverAlive() and JFD_HasTrait(pPlayer, iTraitHawke)) then
		dprint("Hawke player in position " .. iPlayer .. " is on turn " .. Game.GetElapsedGameTurns())

		bInGoldenAge = (pPlayer:GetGoldenAgeTurns() > 0)

		-- Change the dummy policies if they are not correct. Different method
		-- if using the Community Patch
		if bInGoldenAge then
			dprint("They are in a golden age")
			if isCPDLL then
				dprint("Adding dummy policy if necessary")
				pPlayer:GrantPolicy(iPolicyHawkeDummyGA, true)
			else

				-- Only switch polices if we haven't already done so
				if (pPlayer:HasPolicy(iPolicyHawkeDummyOff)) then
					dprint("Swapping dummy policies")
					player:SetHasPolicy(iPolicyHawkeDummyOff, false)
					player:SetHasPolicy(iPolicyHawkeDummyGA, true)
				end
			end
		else
			dprint("They are not in a golden age")
			if isCPDLL then
				dprint("Removing dummy policy if necessary")
				pPlayer:RevokePolicy(iPolicyHawkeDummyGA)
			else

				-- Only switch polices if we haven't already done so
				if (pPlayer:HasPolicy(iPolicyHawkeDummyGA)) then
					dprint("Swapping dummy policies")
					player:SetHasPolicy(iPolicyHawkeDummyGA, false)
					player:SetHasPolicy(iPolicyHawkeDummyOff, true)
				end
			end
		end

		-- Only check all the plots on the map if this player has any cities
		-- (since if they don't, they have no farms in their territory that can
		-- get a bonus)
		if (tHawkeCities[iPlayer] > 0) then
			dprint("They have at least one city, checking all plots on the map")
			for iPlot = 0, Map.GetNumPlots() - 1, 1 do
				local pPlot = Map.GetPlotByIndex(iPlot)


				-- Check if it's one of the farms on a desert tile
				if ((pPlot:GetImprovementType() == iImprovementFarm or pPlot:GetImprovementType() == iImprovementFarmHawkeDummy) and pPlot:GetTerrainType() == iTerrainDesert) then
					dprint("Found a desert farm at " .. pPlot:GetX() .. ", " .. pPlot:GetY())

					-- Check if it's owned by a Hawke player
					iOwner = pPlot:GetOwner()
					if ((iOwner == iPlayer or JFD_HasTrait(Players[iOwner], iTraitHawke))) then
						dprint("This farm is owned by a Hawke player (" .. iOwner .. ") - checking if it should be a bonus farm or not")

						local bGetsBonus = false
						for pSpiralPlot in PlotAreaSpiralIterator(pPlot, 1, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do

							-- If there's another desert farm
							if((pSpiralPlot:GetImprovementType() == iImprovementFarm or pSpiralPlot:GetImprovementType() == iImprovementFarmHawkeDummy) and pPlot:GetTerrainType() == iTerrainDesert) then
								bGetsBonus = false
								dprint("Found an adjacent desert farm on " .. pSpiralPlot:GetX() .. ", " .. pSpiralPlot:GetY())
								break
							end
						end

						if (bGetsBonus and pPlot:GetImprovementType() == iImprovementFarm) then
							dprint("This normal farm is eligible for Hawke's trait bonus - changing it to a bonus farm!")
							pPlot:SetImprovementType(iImprovementFarmHawkeDummy)
						end
						if (not bGetsBonus and pPlot:GetImprovementType() == iImprovementFarmHawkeDummy) then
							dprint("This bonus farm is no longer eligible for Hawke's trait bonus - reverting it back to a normal farm!")
							pPlot:SetImprovementType(iImprovementFarm)
						end
					else
						if (pPlot:GetImprovementType() == iImprovementFarmHawkeDummy) then
							dprint("This bonus farm is no longer owned by a Hawke player - reverting it back to a normal farm!")
							pPlot:SetImprovementType(iImprovementFarm)
						end
					end
				end
			end
		else
			dprint("They have no cities; not checking any plots for them")
		end

		-- Store the number of cities they own for next time
		tHawkeCities[iPlayer] = pPlayer:GetNumCities()
	end
end

-- ============================================================================
-- Hawke_Trait_RefundPolicyCost
-- ============================================================================
-- If a Hawke player adopts a social policy, they get 1% of the cost of that
-- policy refunded for every specialist, up to 25%
function Hawke_Trait_RefundPolicyCost(iPlayer, iPolicy)
	local pPlayer = Players[iPlayer]

	-- Check if it's a player with Hawke's trait and not their dummy policies
	if (pPlayer:IsEverAlive() and JFD_HasTrait(pPlayer, iTraitHawke) and (iPolicy ~= iPolicyHawkeDummyGA or iPolicy ~= iPolicyHawkeDummyOff)) then
		dprint("Hawke player in position " .. iPlayer .. " has adopted a policy")

		dprint("The cost of that policy was " .. tCurrentPolicyCosts[iPlayer])

		-- Determine the number of specialists that can refund
		local iTotalSpecalists = 0
		for pCity in pPlayer:Cities() do
			-- Checks each city for the number of specialists that aren't
			-- unemployed citizens, stopping if we reach the cap
			-- Sniped this from TarcisioCM, sorry but I was in a hurry ^^"
			for row in GameInfo.Specialists() do
				local sSpecialist = row.Type
				if sSpecialist ~= "SPECIALIST_CITIZEN" then
					iTotalSpecalists = pCity:GetSpecialistCount(GameInfoTypes[sSpecialist]) + iTotalSpecalists
				end

				-- If we reach the max number or go over, cap and stop
				if (iTotalSpecalists >= iSpecialistCap) then
					iTotalSpecalists = iSpecialistCap
					break
				end
			end
		end

		dprint(iTotalSpecalists .. " can refund policy costs")
		iCultureToGive = math.floor(tCurrentPolicyCosts[iPlayer] * (iTotalSpecalists / 100))

		dprint("Player " .. iPlayer .. " gets " .. iCultureToGive .. " Culture")

		pPlayer:ChangeJONSCulture(iCultureToGive)

		dprint("Culture is now " .. pPlayer:GetJONSCulture())

		tCurrentPolicyCosts[iPlayer] = pPlayer:GetNextPolicyCost()
		dprint("Next policy cost is " .. tCurrentPolicyCosts[iPlayer])
	end
end

-- ============================================================================
-- Typh_GrantDummyPolicy
-- ============================================================================
-- Used to grant a civilization a dummy policy. Will not do anything if the
-- player already has this policy
function Typh_GrantDummyPolicy(pPlayer, iPolicy)
	if (not pPlayer:HasPolicy(iPolicy)) then
		if isCPDLL then
			pPlayer:GrantPolicy(iPolicy, true)
			return true
		else
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iPolicy, true)
			return true
		end
	else
		return false
	end
end

-- ============================================================================
-- OnModLoaded
-- ============================================================================
function HawkeInit()

	--local bNewGame = not TableLoad(HawkeData, "HawkeData")

	-- Check if Hawke is in this game and add event listeners where required
	-- Trait
	for iPlayer = 0, iMaxMajorCivs-1, 1 do
		local pPlayer = Players[iPlayer]
		if (pPlayer:IsEverAlive() and JFD_HasTrait(pPlayer, iTraitHawke)) then
			dprint("A civilization with Bob Hawke's trait is in this game")

			-- Go through all the players in this game, and initialise things
			-- for Hawke's trait for all Hawke players
			for iNextPlayer = 0, iMaxMajorCivs-1, 1 do
				local pNextPlayer = Players[iNextPlayer]

				-- Grant the player the trait dummy policy if they haven't already got it
				--if (bNewGame) then
				if (not (pPlayer:HasPolicy(iPolicyHawkeDummyOff) or pPlayer:HasPolicy(iPolicyHawkeDummyGA))) then
					dprint("This is a new game - giving dummy policy for Hawke player in position " .. iNextPlayer)
					if (pNextPlayer:GetGoldenAgeTurns() > 0) then
						Typh_GrantDummyPolicy(pPlayer, iPolicyHawkeDummyGA)
					else
						Typh_GrantDummyPolicy(pPlayer, iPolicyHawkeDummyOff)
					end
					--tCurrentPolicyCosts[iNextPlayer] = pNextPlayer:GetNextPolicyCost()
					--dprint("Current policy cost for this player is " .. tCurrentPolicyCosts[iNextPlayer])
				end
				tCurrentPolicyCosts[iNextPlayer] = pNextPlayer:GetNextPolicyCost()
				dprint("Current policy cost for this player is " .. tCurrentPolicyCosts[iNextPlayer])

				-- Store the number of cities they own
				tHawkeCities[iNextPlayer] = pNextPlayer:GetNumCities()
				dprint("Hawke player in position " .. iNextPlayer .. " has " .. tHawkeCities[iNextPlayer] .. " cities")
			end

			-- Add the event listeners
			--GameEvents.BuildFinished.Add(Hawke_Trait_FarmFinished)
			GameEvents.PlayerDoTurn.Add(Hawke_Trait_TurnCheck)
			GameEvents.PlayerAdoptPolicy.Add(Hawke_Trait_RefundPolicyCost)

			-- We need these to help handle times where farm tiles may switch
			-- owners
			break
		end
	end
end

HawkeInit()
