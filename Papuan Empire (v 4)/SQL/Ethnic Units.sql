--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_INDONESIA')
		THEN '_INDONESIA'
		ELSE '_ASIA' END
	) WHERE Type = 'CIVILIZATION_PAPUA';