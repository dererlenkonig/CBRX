--==========================================================================================================================
-- Civilizations
--==========================================================================================================================			
INSERT INTO Civilizations 	
			(Type, 							Description, 						ShortDescription, 							Adjective, 								Civilopedia, 							CivilopediaTag, 				DefaultPlayerColor, 			ArtDefineTag, ArtStyleType,				ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 				DawnOfManQuote, 							DawnOfManImage)
SELECT		('CIVILIZATION_LEUGI_HAITI'), 	('TXT_KEY_CIV_LEUGI_HAITI_DESC'), 	('TXT_KEY_CIV_LEUGI_HAITI_SHORT_DESC'), 	('TXT_KEY_CIV_LEUGI_HAITI_ADJECTIVE'), 	('TXT_KEY_CIV5_LEUGI_HAITI_TEXT_1'), 	('TXT_KEY_CIV5_LEUGI_HAITI'), 	('PLAYERCOLOR_LEUGI_HAITI'), 	ArtDefineTag, ('ARTSTYLE_GRECO_ROMAN'), ArtStyleSuffix, ArtStylePrefix, ('LEUGI_HAITI_ATLAS'), 	1, 				('LEUGI_HAITI_ALPHA_ATLAS'), 	('Brazil'), 	('HaitiMap.dds'), 		('TXT_KEY_CIV5_DOM_LEUGI_LOUVERTURE_TEXT'), ('HaitiDOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_BRAZIL');

--==========================================================================================================================
-- Civilization_FreeBuildingClasses
--==========================================================================================================================		
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_LEUGI_HAITI'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');

--==========================================================================================================================
-- CivilizatioN Start Biases
--==========================================================================================================================		
INSERT INTO Civilization_Start_Region_Priority 
			(CivilizationType, 				RegionType)
VALUES		('CIVILIZATION_LEUGI_HAITI', 	'REGION_JUNGLE');

--==========================================================================================================================
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_LEUGI_HAITI'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');
--==========================================================================================================================
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_LEUGI_HAITI'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');
--==========================================================================================================================
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_LEUGI_HAITI', 	'LEADER_LEUGI_LOUVERTURE');	
--==========================================================================================================================
-- Civilization_UnitClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_LEUGI_HAITI', 	'UNITCLASS_MUSKETMAN', 	'UNIT_LEUGI_MAWON'),
			('CIVILIZATION_LEUGI_HAITI', 	'UNITCLASS_MISSIONARY',	'UNIT_LEUGI_HOUNGAN');
--==========================================================================================================================
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================	
--INSERT INTO Civilization_BuildingClassOverrides 
--			(CivilizationType, 				BuildingClassType, 					BuildingType)
--VALUES		('CIVILIZATION_LEUGI_HAITI', 	'BUILDINGCLASS_BARRACKS', 			'BUILDING_LEUGI_HAITIN_BARRACKS');
--==========================================================================================================================
-- Civilization_Religions
--==========================================================================================================================	
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
SELECT		('CIVILIZATION_LEUGI_HAITI'), 	ReligionType			
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');		
--------------------------------	
-- Historical Religions Support
--------------------------------	
UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_VODUN' )
		THEN 'RELIGION_VODUN'
		ELSE ( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_VODUN' )
		THEN 'RELIGION_VODUN'
		ELSE 'RELIGION_CHRISTIANITY' END ) END
	) WHERE CivilizationType = 'CIVILIZATION_LEUGI_HAITI';

CREATE TRIGGER ReligionHaiti
AFTER INSERT ON Religions WHEN 'RELIGION_VODUN' = NEW.Type
BEGIN
	UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_VODUN' )
		THEN 'RELIGION_VODUN'
		ELSE ( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_VODUN' )
		THEN 'RELIGION_VODUN'
		ELSE 'RELIGION_CHRISTIANITY' END ) END
	) WHERE CivilizationType = 'CIVILIZATION_LEUGI_HAITI';
END;		
--==========================================================================================================================
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_0'),	
			('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_1'),
			('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_2'),
			('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_3'),
			('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_4'),
			('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_5'),
			('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_6'),
			('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_7'),
			('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_8'),
			('CIVILIZATION_LEUGI_HAITI', 	'TXT_KEY_SPY_NAME_9');
--==========================================================================================================================	
--==========================================================================================================================					
			
			

