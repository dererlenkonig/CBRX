--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType			text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,			TraitOne,				TraitTwo)
VALUES  ('LEADER_EADNI',		'POLICY_DIPLOMATIC_X',	'POLICY_PROTECTIVE_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Eadni [ICON_INFLUENCE][ICON_STRENGTH]'
WHERE Type = 'LEADER_EADNI'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_DENMARK'
WHERE Type = 'CIVILIZATION_SAMI'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_DENMARK');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_YagemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_SAMI',						29,		89,		null,	null);
------------------------------
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_YahemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_SAMI',						67,		73,		null,	null);
------------------------------
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_CordiformStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_SAMI',						39,		41,		null,	null);
------------------------------
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_EuroLargeStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_SAMI',						49,		71,		null,	null);
------------------------------
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR IGNORE INTO Civilizations_YagemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
VALUES		('CIVILIZATION_SAMI',						'RESOURCE_FUR', null, 'RESOURCE_DEER', null, 'RESOURCE_SILVER', null, 'RESOURCE_FISH', null);
------------------------------
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR IGNORE INTO Civilizations_YahemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
VALUES		('CIVILIZATION_SAMI',						'RESOURCE_FUR', null, 'RESOURCE_DEER', null, 'RESOURCE_SILVER', null, 'RESOURCE_FISH', null);
------------------------------
-- Civilizations_CordiformRequestedResource (Earth Standard)
------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR IGNORE INTO Civilizations_CordiformRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
VALUES		('CIVILIZATION_SAMI',						'RESOURCE_FUR', null, 'RESOURCE_DEER', null, 'RESOURCE_SILVER', null, 'RESOURCE_FISH', null);
------------------------------
-- Civilizations_EuroLargeRequestedResource (Europe Large)
------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR IGNORE INTO Civilizations_EuroLargeRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
VALUES		('CIVILIZATION_SAMI',						'RESOURCE_FUR', null, 'RESOURCE_DEER', null, 'RESOURCE_SILVER', null, 'RESOURCE_FISH', null);
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,							CultureType,	CultureEra)
VALUES	('CIVILIZATION_SAMI',				'FRENCH',		'ANY'),
		('CIVILIZATION_SAMI',				'GERMANIC',		'ANY');
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);
--==========================================================================================================================
-- JFD CLAIMS & COLONIES
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 					LinguisticType)
VALUES	('CIVILIZATION_SAMI',				'JFD_Germanic');
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,				ArtDefineTag,	CultureType,	SplashScreenTag,	SoundtrackTag,	UnitDialogueTag)
VALUES	('CIVILIZATION_SAMI',			'JFD_Polar', 	'JFD_Polar',	'JFD_Polar',		'JFD_Polar',	null);
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Polar'
WHERE Type = 'CIVILIZATION_SAMI'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Polar')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED (6676902b-b907-45f1-8db5-32dcb2135eee)
--==========================================================================================================================
--PROMOTION_JFD_SNOW_IMMUNITY, PROMOTION_JFD_DESERT_IMMUNITY, PROMOTION_JFD_DISEASE_IMMUNITY, PROMOTION_JFD_JUNGLE_IMMUNITY, PROMOTION_JFD_SCUVRY_IMMUNITY
INSERT INTO Unit_FreePromotions
		(UnitType, 				PromotionType)
SELECT	'UNIT_SAMI_BOAZOVAZZI',	'PROMOTION_JFD_SNOW_IMMUNITY'
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_SNOW_IMMUNITY');
--==========================================================================================================================	
-- JFD AND POUAKAI MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,				 Flavor)
VALUES	('LEADER_EADNI',	'FLAVOR_JFD_MERCENARY',	 4);
--==========================================================================================================================	
-- JFD PIETY & SOVEREIGNTY
--==========================================================================================================================
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 			default null,
	CultureType	  					text 		 										default null,
	LegislatureName					text												default	null,
	OfficeTitle						text												default	null,
	GovernmentType					text												default	null,
	Weight							integer												default	0);
	
INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					LegislatureName,										OfficeTitle,														GovernmentType,				Weight)
VALUES	('CIVILIZATION_SAMI',				'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_SAMI', 		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI',			'GOVERNMENT_JFD_REPUBLIC',	100);
------------------------------------------------------------
-- Language_en_US
------------------------------------------------------------
INSERT INTO Language_en_US (Tag, Text) 
VALUES
	(
		'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_SAMI',
		'Sámediggi'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI',
		'Presideanta'
	);
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
	(CivilizationType,      			HeadOfGovernmentName)
VALUES  ('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_1'),
		('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_2'),
		('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_3'),
		('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_4'),
		('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_5'),
		('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_6'),
		('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_7'),
		('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_8'),
		('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_9'),
		('CIVILIZATION_SAMI',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_10');
------------------------------------------------------------
-- Language_en_US
------------------------------------------------------------
INSERT INTO Language_en_US (Tag, Text) 
VALUES
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_1',
		'Ole Henrik Magga'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_2',
		'Sven-Roald Nystø'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_3',
		'Aili Keskitalo'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_4',
		'Egil Olli'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_5',
		'Pekka Aikio'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_6',
		'Klemetti Näkkäläjärvi'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_7',
		'Tiina Sanila'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_8',
		'Stefan Mikaelsson'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_9',
		'Sylvia Simma'
	),
	(
		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SAMI_10',
		'Lars-Jon Allas'
	);
------------------------------------------------------------			
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION'),
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,							 Flavor)
VALUES	('LEADER_EADNI',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 1),
		('LEADER_EADNI',	'FLAVOR_JFD_REFORM_CULTURE',		 3),
		('LEADER_EADNI',	'FLAVOR_JFD_REFORM_ECONOMIC',		 1),
		('LEADER_EADNI',	'FLAVOR_JFD_REFORM_FOREIGN',		 2),
		('LEADER_EADNI',	'FLAVOR_JFD_REFORM_INDUSTRY',		 2),
		('LEADER_EADNI',	'FLAVOR_JFD_REFORM_MILITARY',		 2),
		('LEADER_EADNI',	'FLAVOR_JFD_REFORM_RELIGION',		 2),
		('LEADER_EADNI',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	 0);
--==========================================================================================================================
--==========================================================================================================================