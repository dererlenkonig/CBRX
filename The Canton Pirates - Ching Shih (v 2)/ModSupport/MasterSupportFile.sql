--==========================================================================================================================
-- USER SETTINGS (THIS IS NEEDED IN MOST CASES)
--==========================================================================================================================
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23 / 24)
--==========================================================================================================================
/*
Tables (example below; replace Civilizations with MinorCivilizations where appropriate):
   
v22
    Civilizations_YagemStartPosition (Earth Giant)
    Civilizations_YahemStartPosition (Earth Huge)
    Civilizations_GreatestEarthStartPosition
    Civilizations_EuroLargeStartPosition
     
v23
    Civilizations_EuroGiantStartPosition
    Civilizations_EastAsiaStartPosition
    Civilizations_ApennineStartPosition
    Civilizations_BritishIslesStartPosition
    Civilizations_NorthEastAsiaStartPosition
    Civilizations_AegeanStartPosition
    Civilizations_NorthAtlanticStartPosition
    Civilizations_PacificStartPosition
    Civilizations_SouthPacificStartPosition
    Civilizations_NorthWestEuropeStartPosition
    Civilizations_CaribbeanStartPosition
    Civilizations_AsiaStartPosition
    Civilizations_MediterraneanStartPosition
    Civilizations_MesopotamiaStartPosition
    Civilizations_AfricaLargeStartPosition
    Civilizations_NileValleyStartPosition
    Civilizations_AmericasStartPosition
v24
    Civilizations_MesopotamiaGiantStartPosition
    Civilizations_AsiaSmallStartPosition
    Civilizations_EuroLargeNewStartPosition
    Civilizations_AdriaticStartPosition
    Civilizations_WestAfricaStartPosition
    Civilizations_CaucasusStartPosition
    Civilizations_AsiaSteppeGiantStartPosition
    Civilizations_CentralAsiaStartPosition
    Civilizations_EuroEasternStartPosition
    Civilizations_NorthSeaEuropeStartPosition
    Civilizations_AfriAsiaAustStartPosition
    Civilizations_AfriSouthEuroStartPosition
    Civilizations_AfriGiantStartPosition
    Civilizations_SouthAmericaGiantStartPosition
    Civilizations_AustralasiaGiantStartPosition
    Civilizations_IndianOceanStartPosition
    Civilizations_AmericasGiantStartPosition
    Civilizations_IndiaGiantStartPosition
    Civilizations_SouthAmericaCentralHugeStartPosition
    Civilizations_SouthAmericaCentralGiantStartPosition
    Civilizations_ScotlandIrelandHugeStartPosition
    Civilizations_SouthAmericaLargeStartPosition
    Civilizations_SouthAsiaHugeStartPosition
    Civilizations_SouthPacificGiantStartPosition
    Civilizations_NorthAmericaGiantStartPosition
    Civilizations_NorthAmericaHugeStartPosition
*/
--*/

CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_CANTON_PIRATES',		84,		48);
-------------------------------------
-- Civilizations_YagemRequestedResource (Earth Giant)
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 							Req1, 				Yield1, Req2, 				Yield2, Req3,				 	Yield3, 				Req4, 				Yield4)
SELECT	'CIVILIZATION_CANTON_PIRATES',	'RESOURCE_WHALE',	1,		'RESOURCE_GOLD',	1,		'RESOURCE_FISH',		1,						'RESOURCE_IRON',	6
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_JAPAN';
--Earth Huge
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,								X,		Y) 
VALUES	 ('CIVILIZATION_CANTON_PIRATES',	105,	43);

CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource (Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type,							Req1,				Yield1,	Req2,			Yield2,	Req3,				Yield3,	Req4,				Yield4) VALUES
		('CIVILIZATION_CANTON_PIRATES',	'RESOURCE_WHALE',	1,		'RESOURCE_GOLD',	1,		'RESOURCE_FISH',	1,		'RESOURCE_IRON',	6);
--Cordiform Earth
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition (Type,							X,	Y) VALUES
												 ('CIVILIZATION_CANTON_PIRATES',	63,	33);
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource (Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource (Type,							Req1,				Yield1,	Req2,			Yield2,	Req3,				Yield3,	Req4,				Yield4) VALUES
													 ('CIVILIZATION_CANTON_PIRATES',	'RESOURCE_WHALE',	1,		'RESOURCE_GOLD',	1,		'RESOURCE_FISH',	1,		'RESOURCE_IRON',	6);
--Greatest Earth
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition (Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition (Type,							X,		Y) VALUES
													 ('CIVILIZATION_CANTON_PIRATES',	87,	42);
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource (Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource (Type,							Req1,				Yield1,	Req2,			Yield2,	Req3,				Yield3,	Req4,				Yield4) VALUES
														 ('CIVILIZATION_CANTON_PIRATES',	'RESOURCE_WHALE',	1,		'RESOURCE_GOLD',	1,		'RESOURCE_FISH',	1,		'RESOURCE_IRON',	6);
--==========================================================================================================================
-- JFD CIVILOPEDIA
--==========================================================================================================================
-- JFD_Civilopedia_HideFromPedia
-------------------------------------------------------------------------------------------------------------------------
--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,            TraitOne,                TraitTwo)
SELECT    'LEADER_CHING_SHIH',    'POLICY_AGGRESSIVE_X',    'POLICY_SEAFARING_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
UPDATE Leaders 
SET Description = 'Ching Shih [ICON_WAR][ICON_MOVES]'
WHERE Type = 'LEADER_CHING_SHIH'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_MERCANTILE_X');
--==========================================================================================================================
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
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
------------------------------
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType,			LinguisticType, ColonyName)
SELECT	'CIVILIZATION_CANTON_PIRATES',	LinguisticType, ColonyName
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_CHINA';
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
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,            ArtDefineTag, CultureType,     IdealsTag,        SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT    'CIVILIZATION_CANTON_PIRATES',    ArtDefineTag, CultureType, IdealsTag,    SplashScreenTag,     SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_CHINA';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Oriental'
WHERE Type = 'CIVILIZATION_CANTON_PIRATES'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Oriental')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
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
		(LeaderType,						FlavorType,					Flavor)
VALUES	('LEADER_CHING_SHIH',	'FLAVOR_JFD_MERCENARY',		7);
--==========================================================================================================================	
-- JFD PIETY & SOVEREIGNTY
--==========================================================================================================================	
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType	  					text 		 												default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,			LegislatureName,											OfficeTitle,														GovernmentType,				Weight)
SELECT	'CIVILIZATION_CANTON_PIRATES',	LegislatureName,	OfficeTitle,	GovernmentType,	Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_CHINA';
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      		HeadOfGovernmentName)
VALUES  ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_1'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_2'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_3'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_4'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_5'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_6'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_7'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_8'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_9'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_10'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_11'),
        ('CIVILIZATION_CANTON_PIRATES',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_CANTON_PIRATES_12');
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
		(LeaderType,				FlavorType,							Flavor)
VALUES	('LEADER_CHING_SHIH',	'FLAVOR_JFD_REFORM_GOVERNMENT',		9),
		('LEADER_CHING_SHIH',	'FLAVOR_JFD_REFORM_CULTURE',		5),
		('LEADER_CHING_SHIH',	'FLAVOR_JFD_REFORM_ECONOMIC',		6),
		('LEADER_CHING_SHIH',	'FLAVOR_JFD_REFORM_FOREIGN',		9),
		('LEADER_CHING_SHIH',	'FLAVOR_JFD_REFORM_INDUSTRY',		7),
		('LEADER_CHING_SHIH',	'FLAVOR_JFD_REFORM_MILITARY',		9),
		('LEADER_CHING_SHIH',	'FLAVOR_JFD_REFORM_RELIGION',		4),
		('LEADER_CHING_SHIH',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0);
--==========================================================================================================================
-- JFD PROSPERITY
--==========================================================================================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies	
		(CivilizationType,			CurrencyType)
SELECT	'CIVILIZATION_CANTON_PIRATES',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_CHINA';
--==========================================================================================================================
--==========================================================================================================================
