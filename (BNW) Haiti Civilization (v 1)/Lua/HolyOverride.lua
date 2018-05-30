-- MissionaryReplacer
-- Author: LastSword
-- DateCreated: 8/24/2013 2:56:18 PM
--------------------------------------------------------------
local sUnitType = "MISSIONARY"
local iMissionaryID = GameInfo.Units.UNIT_MISSIONARY.ID
local iMissionaryOverride = GameInfo.Units.UNIT_LEUGI_HOUNGAN.ID
local iCivType = GameInfo.Civilizations["CIVILIZATION_LEUGI_HAITI"].ID
local iUnwelcomePromo = GameInfoTypes.PROMOTION_UNWELCOME_EVANGELIST

function MissionaryOverride(iPlayer, iUnit)
    local pPlayer = Players[iPlayer];
    if (pPlayer:IsEverAlive()) then
        if (pPlayer:GetCivilizationType() == iCivType) then
       	    if pPlayer:GetUnitByID(iUnit) ~= nil then
			pUnit = pPlayer:GetUnitByID(iUnit);
                if (pUnit:GetUnitType() == iMissionaryID) then
  					Events.SerialEventUnitCreated.Remove(MissionaryOverride)
  					pUnit:SetHasPromotion(iUnwelcomePromo, false)
					local newUnit = pPlayer:InitUnit(iMissionaryOverride, pUnit:GetX(), pUnit:GetY())
					newUnit:Convert(pUnit);
					Events.SerialEventUnitCreated.Add(MissionaryOverride)
				end
			end
        end
    end
end

Events.SerialEventUnitCreated.Add(MissionaryOverride)