--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_IROQUOIS')
		THEN '_IROQUOIS'
		ELSE '_AMER' END
	) WHERE Type = 'CIVILIZATION_YUPIK';