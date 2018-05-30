--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 								Description, 							ShortDescription, 							Adjective, 									Civilopedia, 								CivilopediaTag, 					DefaultPlayerColor, 								DerivativeCiv,					ArtDefineTag, ArtStyleType,			ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_SENSHI_HAWKE'), 		('TXT_KEY_CIV_SENSHI_HAWKE_DESC'), 		('TXT_KEY_CIV_SENSHI_HAWKE_SHORT_DESC'),		('TXT_KEY_CIV_SENSHI_HAWKE_ADJECTIVE'),		('TXT_KEY_CIV5_SENSHI_HAWKE_TEXT_1'), 		('TXT_KEY_CIV5_SENSHI_HAWKE'),  		('PLAYERCOLOR_SENSHI_HAWKE'), 						('CIVILIZATION_CL_AUSTRALIA'),	ArtDefineTag, ArtStyleType,			ArtStyleSuffix,	ArtStylePrefix,	('SENSHI_HAWKE_ATLAS'), 		0, 				('SENSHI_HAWKE_ALPHA_ATLAS'), 	('ENGLAND'), 	('HawkeMap.dds'), 	('TXT_KEY_CIV5_DOM_SENSHI_HAWKE_TEXT'), 	('HawkeDOM.dds'),	('AS2D_DOM_SPEECH_SENSHI_HAWKE')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ENGLAND');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ENGLAND' )
	THEN '_ENGLAND'
	ELSE '_EURO' END) 
WHERE Type = 'CIVILIZATION_SENSHI_HAWKE';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_01'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_02'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_03'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_04'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_05'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_06'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_07'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_08'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_09'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_10'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_11'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_12'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_13'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_14'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_15'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_16'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_17'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_18'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_19'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_20'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_21'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_22'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_23'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_24'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_25'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_26'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_27'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_28'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_29'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_30'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_31'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_32'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_33'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_34'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_35'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_36'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_CITY_NAME_SENSHI_HAWKE_37');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_SENSHI_HAWKE'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SENSHI_HAWKE'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SENSHI_HAWKE'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');
--==========================================================================================================================	
-- Civilization_Start_Region_Priority
--==========================================================================================================================			
INSERT INTO Civilization_Start_Region_Priority 
			(CivilizationType, 					RegionType)
VALUES		('CIVILIZATION_SENSHI_HAWKE', 		'REGION_DESERT');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_SENSHI_HAWKE', 	'LEADER_SENSHI_HAWKE');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_SENSHI_HAWKE', 	'UNITCLASS_PARATROOPER',	'UNIT_SENSHI_SASR');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_SENSHI_HAWKE', 	'BUILDINGCLASS_LABORATORY',	'BUILDING_SENSHI_CSIRO');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		'CIVILIZATION_SENSHI_HAWKE', 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_0'),	
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_1'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_2'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_3'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_4'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_5'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_6'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_7'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_8'),
			('CIVILIZATION_SENSHI_HAWKE', 	'TXT_KEY_SPY_NAME_SENSHI_HAWKE_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

