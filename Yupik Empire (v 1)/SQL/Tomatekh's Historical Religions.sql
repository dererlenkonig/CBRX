DELETE FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_YUPIK';
INSERT INTO Civilization_Religions 
		        (CivilizationType,	ReligionType)
SELECT		Type,			('RELIGION_PROTESTANTISM')
FROM Civilizations WHERE Type = 'CIVILIZATION_YUPIK'; 

UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_ANGAKKUQISM' )
		THEN 'RELIGION_ANGAKKUQISM'
		ELSE 'RELIGION_PROTESTANTISM' END 
	) WHERE CivilizationType = 'CIVILIZATION_YUPIK';

CREATE TRIGGER CivilizationTierYupik
AFTER INSERT ON Civilization_Religions WHEN 'CIVILIZATION_YUPIK' = NEW.CivilizationType
BEGIN
	UPDATE Civilization_Religions SET ReligionType = 
		( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_ANGAKKUQISM' )
			THEN 'RELIGION_ANGAKKUQISM'
			ELSE 'RELIGION_PROTESTANTISM' END 
		) WHERE CivilizationType = 'CIVILIZATION_YUPIK';
END;