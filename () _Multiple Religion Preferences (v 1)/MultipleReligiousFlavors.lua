local newRel = false
local civType;
local updateNextTurn = false

function updateReligionFlavors(ePlayer, holyCityId, eReligion, eBelief1, eBelief2, eBelief3, eBelief4, eBelief5)
	
	print(GameInfo.Religions[eReligion].Type)
	updateNextTurn = false
	
	local selection  = 'SELECT CivilizationType FROM Civilization_Religions WHERE ReligionType = \'' .. GameInfo.Religions[eReligion].Type .. '\''
	print("Select Statement: " .. selection)
	
	for row in DB.Query(selection) do
		civType = row.CivilizationType
		print(civType)
		newRel = religionDBFinder(civType)
		print(Game.IsCivEverActive(civType))
		if newRel ~= false and Game.IsCivEverActive(civType) then
			updateNextTurn = true
		end
	end
end
GameEvents.ReligionFounded.Add(updateReligionFlavors)

function religionDBFinder(civ)
	local SEL = 'SELECT * FROM Lime_MultipleReligions WHERE CivilizationType = \'' .. civ .. '\''
	for r in DB.Query(SEL) do
		print(r["Pref2"])
		print(GameInfo.Religions[r["Pref2"]].ID)
		--print(Game.GetFounder(GameInfo.Religions[r["Pref2"]].ID, -1))

		if r ~= nil and r["Pref2"] ~= 'null' then
			assert(Game.GetFounder(GameInfo.Religions[r["Pref2"]].ID, -1), return r["Pref2"])
		end		
	end
	return false
end

function updateDatabase()
	if not updateNextTurn then return end
	print("Updating...")
	local update = 'UPDATE Civilization_Religions SET ReligionType = "' .. newRel .. '" WHERE CivilizationType = "' .. civType .. '"'
	print("Update Statement: " .. update)
	for r in DB.Query(update) do end
end	
Events.SerialEventEndTurnDirty.Add(updateDatabase)

print("Loaded Multiple Religious Flavors")

