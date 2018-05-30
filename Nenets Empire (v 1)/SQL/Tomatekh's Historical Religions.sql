DELETE FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_SAMOYED';
INSERT INTO Civilization_Religions 
		        (CivilizationType,	ReligionType)
SELECT		Type,			('RELIGION_ORTHODOXY')
FROM Civilizations WHERE Type = 'CIVILIZATION_SAMOYED'; 

UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_SAMAN' )
		THEN 'RELIGION_SAMAN'
		ELSE 'RELIGION_ORTHODOXY' END 
	) WHERE CivilizationType = 'CIVILIZATION_SAMOYED';

CREATE TRIGGER CivilizationTierGedemoNenets
AFTER INSERT ON Civilization_Religions WHEN 'CIVILIZATION_SAMOYED' = NEW.CivilizationType
BEGIN
	UPDATE Civilization_Religions SET ReligionType = 
		( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_SAMAN' )
			THEN 'RELIGION_SAMAN'
			ELSE 'RELIGION_ORTHODOXY' END 
		) WHERE CivilizationType = 'CIVILIZATION_SAMOYED';
END;