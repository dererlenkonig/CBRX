--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 								Description,						ShortDescription, 						 Adjective, 							 Civilopedia,							CivilopediaTag,					DefaultPlayerColor,				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 						DawnOfManQuote,						 DawnOfManImage,				DawnOfManAudio)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		('TXT_KEY_CIV_MC_LITE_MOOR_DESC'),	('TXT_KEY_CIV_MC_LITE_MOOR_SHORT_DESC'), ('TXT_KEY_CIV_MC_LITE_MOOR_ADJECTIVE'), ('TXT_KEY_CIV5_MC_LITE_MOOR_TEXT_1'),  ('TXT_KEY_CIV5_MC_LITE_MOOR'),	('PLAYERCOLOR_MC_LITE_MOOR'),	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('MC_LITE_MOORS_ATLAS'), 0, 			('MC_LITE_MOORS_ALPHA_ATLAS'), 	('Morocco'), 	('MC_LITE_MoorsMap_512.dds'),	('TXT_KEY_CIV5_DAWN_MOOR_TEXT'),	 ('AbdArRahmanIII_DOM.dds'),	('AS2D_DOM_SPEECH_MC_LITE_MOORS')
FROM Civilizations WHERE (Type = 'CIVILIZATION_MOROCCO');
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_1'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_2'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_3'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_4'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_5'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_6'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_7'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_8'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_9'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_10'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_11'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_12'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_13'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_14'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_15'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_16'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_17'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_18'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_19'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_20'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_21'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_22'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_23'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_24'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_25'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_26'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_27'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_28'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_29'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_30'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_31'),
			('CIVILIZATION_MC_LITE_MOOR', 	'TXT_KEY_CITY_NAME_CIVILIZATION_MC_LITE_MOOR_32');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 					BuildingClassType)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_MOROCCO');
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 					TechType)
SELECT	('CIVILIZATION_MC_LITE_MOOR'), 		TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_MOROCCO');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_MC_LITE_MOOR'), 		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_MOROCCO');
--------------------------------	
-- Civilization_Leaders
--------------------------------	
INSERT INTO Civilization_Leaders 
		(CivilizationType, 					LeaderheadType)
VALUES	('CIVILIZATION_MC_LITE_MOOR',		'LEADER_MC_LITE_ABD_AR_RAHMAN_III');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 					UnitClassType, 					UnitType)
VALUES	('CIVILIZATION_MC_LITE_MOOR', 		'UNITCLASS_CROSSBOWMAN',		'UNIT_MC_LITE_GRANADINE_CAVALRY');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES	('CIVILIZATION_MC_LITE_MOOR', 		'BUILDINGCLASS_UNIVERSITY',			'BUILDING_MC_LITE_ALCAZAR');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 					ReligionType)
SELECT	('CIVILIZATION_MC_LITE_MOOR'), 		ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_MOROCCO');
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 					SpyName)
VALUES	('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_0'),	
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_1'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_2'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_3'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_4'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_5'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_6'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_7'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_8'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_9'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_10'),
		('CIVILIZATION_MC_LITE_MOOR', 		'TXT_KEY_SPY_NAME_MC_LITE_MOOR_11');
--==========================================================================================================================
--==========================================================================================================================