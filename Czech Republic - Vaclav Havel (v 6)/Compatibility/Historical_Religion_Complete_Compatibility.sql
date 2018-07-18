-- Update Civ to choose Hussites instead of Protestant--
-- Code taken from example on CivFanatic forums--
UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type="RELIGION_HUSSITISM" )
		THEN "RELIGION_HUSSITISM"
		ELSE "RELIGION_PROTESTANTISM" END
	) WHERE CivilizationType = "CIVILIZATION_CZECH";