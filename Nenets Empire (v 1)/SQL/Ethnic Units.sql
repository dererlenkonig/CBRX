--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_RUSSIA')
		THEN '_RUSSIA'
		ELSE '_ASIA' END
	) WHERE Type = 'CIVILIZATION_SAMOYED';