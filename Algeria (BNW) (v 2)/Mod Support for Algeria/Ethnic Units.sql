--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_MOROCCO")
		THEN "_MOROCCO"
		ELSE "_AFRI" END
	) WHERE Type = "CIVILIZATION_DJSH_ALGERIA";