--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================				
INSERT INTO Civilizations 	
			(Type, 								Description, 							ShortDescription, 							Adjective, 									Civilopedia, 								CivilopediaTag, 					DefaultPlayerColor, 					DerivativeCiv,			ArtDefineTag, ArtStyleType,			ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 					DawnOfManQuote, 						DawnOfManImage,		DawnOfManAudio)
SELECT		('CIVILIZATION_SENSHI_KOREA'), 		('TXT_KEY_CIV_SENSHI_KOREA_DESC'), 		('TXT_KEY_CIV_SENSHI_KOREA_SHORT_DESC'),		('TXT_KEY_CIV_SENSHI_KOREA_ADJECTIVE'), Civilopedia, 								CivilopediaTag,  		('PLAYERCOLOR_SENSHI_KOREA'), 	('CIVILIZATION_KOREA'),	ArtDefineTag, ArtStyleType,			ArtStyleSuffix,	ArtStylePrefix,	('SENSHI_KOREA_ATLAS'), 		0, 				('SENSHI_KOREA_ALPHA_ATLAS'), 	('KOREA'), 	('SeonjoMap.dds'), 	('TXT_KEY_CIV5_DOM_SENSHI_SEONJO_TEXT'), 	('SeonjoDOM.dds'),	('AS2D_DOM_SPEECH_SENSHI_SEONJO')
FROM Civilizations WHERE (Type = 'CIVILIZATION_KOREA');

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_KOREA' )
	THEN '_KOREA'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_SENSHI_KOREA';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================			
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			 CityName)
VALUES		('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_01'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_02'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_03'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_04'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_05'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_06'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_07'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_08'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_09'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_10'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_11'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_12'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_13'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_14'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_15'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_16'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_17'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_18'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_19'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_20'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_21'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_22'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_23'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_CITY_NAME_SENSHI_KOREA_24');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_SENSHI_KOREA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_KOREA');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SENSHI_KOREA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_KOREA');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SENSHI_KOREA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_KOREA');
--==========================================================================================================================	
-- Civilization_Start_Along_Ocean
--==========================================================================================================================			
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 					StartAlongOcean)
VALUES		('CIVILIZATION_SENSHI_KOREA', 		'1');	
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================			
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_SENSHI_KOREA', 	'LEADER_SENSHI_SEONJO');	
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_SENSHI_KOREA', 	'UNITCLASS_CARAVEL',	'UNIT_KOREAN_TURTLE_SHIP'),
			('CIVILIZATION_SENSHI_KOREA', 	'UNITCLASS_CANNON',		'UNIT_SENSHI_CHONGTONG');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		'CIVILIZATION_SENSHI_KOREA', 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_KOREA');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================		
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_0'),	
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_1'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_2'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_3'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_4'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_5'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_6'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_7'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_8'),
			('CIVILIZATION_SENSHI_KOREA', 	'TXT_KEY_SPY_NAME_SENSHI_KOREA_9');
--==========================================================================================================================		
--==========================================================================================================================						
			
			

