--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 								Description, 							ShortDescription, 							Adjective, 									Civilopedia, 								CivilopediaTag, 					DefaultPlayerColor, 				ArtDefineTag, ArtStyleType,			ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_SENSHI_EVENKS'), 		('TXT_KEY_CIV_SENSHI_EVENKS_DESC'), 		('TXT_KEY_CIV_SENSHI_EVENKS_SHORT_DESC'),		('TXT_KEY_CIV_SENSHI_EVENKS_ADJECTIVE'), 		('TXT_KEY_CIV5_SENSHI_EVENKS_TEXT_1'), 		('TXT_KEY_CIV5_SENSHI_EVENKS'), 		('PLAYERCOLOR_SENSHI_EVENKS'), 		ArtDefineTag, ArtStyleType,			ArtStyleSuffix,	ArtStylePrefix,	('SENSHI_EVENKS_ATLAS'), 		0, 				('SENSHI_EVENKS_ALPHA_ATLAS'), 	('MONGOL'), 	('EvenkMap.dds'), 	('TXT_KEY_CIV5_DOM_SENSHI_BOMBOGOR_TEXT'), 	('EvenksDOM.dds'),	('AS2D_DOM_SPEECH_SENSHI_BOMBOGOR')
FROM Civilizations WHERE (Type = 'CIVILIZATION_MONGOL');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_MONGOL' )
	THEN '_MONGOL'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_SENSHI_EVENKS';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_01'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_02'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_03'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_04'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_05'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_06'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_07'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_08'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_09'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_10'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_11'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_12'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_13'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_14'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_15'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_16'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_17'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_18'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_19'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_20'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_21'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_22'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_CITY_NAME_SENSHI_EVENKS_23');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_SENSHI_EVENKS'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SENSHI_EVENKS'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SENSHI_EVENKS'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_Start_Region_Priority
--==========================================================================================================================			
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType, 					RegionType)
VALUES		('CIVILIZATION_SENSHI_EVENKS', 		'REGION_FOREST');	
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_SENSHI_EVENKS', 	'LEADER_SENSHI_BOMBOGOR');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			 UnitType)
VALUES		('CIVILIZATION_SENSHI_EVENKS', 	'UNITCLASS_CHARIOT_ARCHER',	'UNIT_SENSHI_REINDEER_ARCHER');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		'CIVILIZATION_SENSHI_EVENKS', 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_MONGOL');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_0'),	
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_1'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_2'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_3'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_4'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_5'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_6'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_7'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_8'),
			('CIVILIZATION_SENSHI_EVENKS', 	'TXT_KEY_SPY_NAME_SENSHI_EVENKS_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

