--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 								Description, 							ShortDescription, 							Adjective, 									Civilopedia, 								CivilopediaTag, 					DefaultPlayerColor, 				ArtDefineTag, ArtStyleType,			ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_CL_MURRI'), 		('TXT_KEY_CIV_CL_MURRI_DESC'), 		('TXT_KEY_CIV_CL_MURRI_SHORT_DESC'),		('TXT_KEY_CIV_CL_MURRI_ADJECTIVE'), 		('TXT_KEY_CIV5_CL_MURRI_TEXT_1'), 		('TXT_KEY_CIV5_CL_MURRI'), 		('PLAYERCOLOR_CL_MURRI'), 		ArtDefineTag, ArtStyleType,			ArtStyleSuffix,	ArtStylePrefix,	('CL_MURRI_ATLAS'), 		0, 				('CL_MURRI_ALPHA_ATLAS'), 	('POLYNESIA'), 	('MURRIMAP.dds'), 	('TXT_KEY_CIV5_DOM_CL_GANUURRU_TEXT'), 	('MurriDoM.dds'),	('AS2D_DOM_SPEECH_CL_GANUURRU')
FROM Civilizations WHERE (Type = 'CIVILIZATION_POLYNESIA');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_POLYNESIA' )
	THEN '_POLYNESIA'
	ELSE '_MED' END) 
WHERE Type = 'CIVILIZATION_CL_MURRI';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_01'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_02'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_03'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_04'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_05'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_06'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_07'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_08'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_09'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_10'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_11'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_12'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_13'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_14'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_15'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_16'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_17'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_18'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_19'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_20'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_21'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_22'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_23'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_24'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_25'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_26'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_27'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_CITY_NAME_CL_MURRI_28');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_CL_MURRI'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_POLYNESIA');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_CL_MURRI'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_POLYNESIA');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_CL_MURRI'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_POLYNESIA');
--==========================================================================================================================	
-- Civilization_Start_Region_Priority
--==========================================================================================================================			
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType, 					RegionType)
VALUES		('CIVILIZATION_CL_MURRI', 		'REGION_FOREST');	
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_CL_MURRI', 	'LEADER_CL_GANUURRU');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 			 UnitType)
VALUES		('CIVILIZATION_CL_MURRI', 	'UNITCLASS_SCOUT',		'UNIT_CL_MARBULL');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 			 BuildingType)
VALUES		('CIVILIZATION_CL_MURRI', 	'BUILDINGCLASS_CARAVANSARY',		'BUILDING_CL_HUMPY');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		'CIVILIZATION_CL_MURRI', 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_POLYNESIA');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_0'),	
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_1'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_2'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_3'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_4'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_5'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_6'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_7'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_8'),
			('CIVILIZATION_CL_MURRI', 	'TXT_KEY_SPY_NAME_CL_MURRI_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

