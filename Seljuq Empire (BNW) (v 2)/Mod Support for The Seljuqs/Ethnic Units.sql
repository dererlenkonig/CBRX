--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_PERSIA")
		THEN "_PERSIA"
		ELSE "_ASIA" END
	) WHERE Type = "CIVILIZATION_DJSH_SELJUQ";