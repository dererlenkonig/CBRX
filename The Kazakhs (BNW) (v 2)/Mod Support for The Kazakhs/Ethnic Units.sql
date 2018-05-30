--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_MONGOL")
		THEN "_MONGOL"
		ELSE "_ASIA" END
	) WHERE Type = "CIVILIZATION_DJSH_KAZAKH";