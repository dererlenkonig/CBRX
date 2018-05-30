local sCitizen = GameInfoTypes.SPECIALIST_CITIZEN;
local gHouse = GameInfoTypes.BUILDING_GAMBLING_HOUSE;
local iUnemployedCitizenDummy = GameInfoTypes.BUILDING_DUMMY_GOLD_BONUS;

function GoldBonusCalc(playerID)
    local player = Players[playerID]
    for city in player:Cities() do
        local iNumberUnemployed = 0
        if city:IsHasBuilding(gHouse) then
        iNumberUnemployed = math.min(4, city:GetSpecialistCount(sCitizen))
        end
    city:SetNumRealBuilding(iUnemployedCitizenDummy, iNumberUnemployed)
    end
end
GameEvents.PlayerDoTurn.Add(GoldBonusCalc)