DELETE FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_PAPUA';
INSERT INTO Civilization_Religions 
		        (CivilizationType,	ReligionType)
SELECT		Type,			('RELIGION_PROTESTANTISM')
FROM Civilizations WHERE Type = 'CIVILIZATION_PAPUA'; 

UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_TJUKURPA' )
		THEN 'RELIGION_TJUKURPA'
		ELSE 'RELIGION_PROTESTANTISM' END 
	) WHERE CivilizationType = 'CIVILIZATION_PAPUA';

CREATE TRIGGER CivilizationTierPapua
AFTER INSERT ON Civilization_Religions WHEN 'CIVILIZATION_PAPUA' = NEW.CivilizationType
BEGIN
	UPDATE Civilization_Religions SET ReligionType = 
		( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_TJUKURPA' )
			THEN 'RELIGION_TJUKURPA'
			ELSE 'RELIGION_PROTESTANTISM' END 
		) WHERE CivilizationType = 'CIVILIZATION_PAPUA';
END;