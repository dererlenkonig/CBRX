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
SELECT  'LEADER_JFD_CIXI',		'POLICY_AGGRESSIVE_X',	 'POLICY_CHARISMATIC_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Cixi [ICON_WAR][ICON_HAPPINESS_1]'
WHERE Type = 'LEADER_JFD_CIXI'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GAZEBO COMMUNITY PATCH
--==========================================================================================================================
-- COMMUNITY
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
--==========================================================================================================================
-- GAZEBO COMMUNITY BALANCE OVERHAUL
--==========================================================================================================================
-- Buildings
------------------------------	
UPDATE Buildings 
SET Help = 'TXT_KEY_BUILDING_JFD_NAVAL_COLLEGE_HELP_CBO'
WHERE Type = 'BUILDING_JFD_NAVAL_COLLEGE'
AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value = 1);
--------------------------------	
-- Building_SeaPlotYieldChanges
--------------------------------	
INSERT INTO Building_SeaPlotYieldChanges 	
		(BuildingType, 						YieldType,	 Yield)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',		YieldType,	 Yield
FROM Building_SeaPlotYieldChanges WHERE BuildingType = 'BUILDING_SEAPORT';	
--------------------------------	
-- Building_ResourceQuantityRequirements
--------------------------------	
INSERT INTO Building_ResourceQuantityRequirements 	
		(BuildingType, 						ResourceType, Cost)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',		ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_SEAPORT';	
--------------------------------	
-- Building_YieldModifiers
--------------------------------	
INSERT INTO Building_YieldModifiers 	
		(BuildingType, 						YieldType, Yield)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',		YieldType, Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_SEAPORT';	
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_CHINA'
WHERE Type = 'CIVILIZATION_JFD_QING'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_CHINA');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,						X,	Y)
SELECT	'CIVILIZATION_JFD_QING',	X,	Y
FROM Civilizations_YagemStartPosition WHERE Type = 'CIVILIZATION_CHINA';
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,						X,	Y)
SELECT	'CIVILIZATION_JFD_QING',	X,	Y
FROM Civilizations_YahemStartPosition WHERE Type = 'CIVILIZATION_CHINA';
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,						X,	Y)
SELECT	'CIVILIZATION_JFD_QING',	X,	Y
FROM Civilizations_CordiformStartPosition WHERE Type = 'CIVILIZATION_CHINA';
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,						X,	Y)
SELECT	'CIVILIZATION_JFD_QING',	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE Type = 'CIVILIZATION_CHINA';
------------------------------------------------------------	
-- Civilizations_EastAsiaStartPosition (East Asia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EastAsiaStartPosition
		(Type,						X,	Y)
SELECT	'CIVILIZATION_JFD_QING',	X,	Y
FROM Civilizations_EastAsiaStartPosition WHERE Type = 'CIVILIZATION_CHINA';
------------------------------------------------------------	
-- Civilizations_PacificStartPosition (Pacific)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition
		(Type,						X,	Y)
SELECT	'CIVILIZATION_JFD_QING',	X,	Y
FROM Civilizations_PacificStartPosition WHERE Type = 'CIVILIZATION_CHINA';
------------------------------------------------------------
-- Civilizations_NorthEastAsiaStartPosition (North-East Asia)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_NorthEastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthEastAsiaStartPosition
		(Type,						X,	Y)
SELECT	'CIVILIZATION_JFD_QING',	X,	Y
FROM Civilizations_NorthEastAsiaStartPosition WHERE Type = 'CIVILIZATION_CHINA';
------------------------------------------------------------
-- Civilizations_AsiaStartPosition (Asia)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition
		(Type,						X,	Y)
SELECT	'CIVILIZATION_JFD_QING',	X,	Y
FROM Civilizations_AsiaStartPosition WHERE Type = 'CIVILIZATION_CHINA';
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_QING',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_JAPAN';
------------------------------------------------------------
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_QING',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_JAPAN';
------------------------------------------------------------
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_QING',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_JAPAN';
------------------------------------------------------------
-- Civilizations_GreatestEarthRequestedResource (Asia)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AsiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AsiaRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_QING',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AsiaRequestedResource WHERE Type = 'CIVILIZATION_JAPAN';
------------------------------------------------------------
-- Civilizations_EastAsiaRequestedResource (East Asia)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EastAsiaRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_QING',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EastAsiaRequestedResource WHERE Type = 'CIVILIZATION_JAPAN';
------------------------------------------------------------
-- Civilizations_PacificRequestedResource (Pacific)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_PacificRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_PacificRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_QING',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_PacificRequestedResource WHERE Type = 'CIVILIZATION_JAPAN';
------------------------------------------------------------
-- Civilizations_NorthEastAsiaRequestedResource (North-East Asia)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_NorthEastAsiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthEastAsiaRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_QING',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthEastAsiaRequestedResource WHERE Type = 'CIVILIZATION_JAPAN';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,					CultureType,	CultureEra)
SELECT	'CIVILIZATION_JFD_QING',	CultureType,	CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_CHINA';
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
-- JFD CIVILOPEDIA
--==========================================================================================================================
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
-- Building_ConstructionAudio
----------------------
CREATE TABLE IF NOT EXISTS
	Building_ConstructionAudio (
    BuildingType								text		REFERENCES Buildings(Type)      default null,
    ConstructionAudio							text										default null);
	
INSERT INTO Building_ConstructionAudio
		(BuildingType, 					ConstructionAudio)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',	'AS2D_BUILDING_JFD_NAVAL_COLLEGE'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1);
--====================================	
-- JFD COLONIES
--====================================	
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType,			LinguisticType)
SELECT	'CIVILIZATION_JFD_QING',	LinguisticType
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_CHINA';
------------------------------------------------------------
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,						Flavor)
VALUES	('LEADER_JFD_CIXI',		'FLAVOR_JFD_DECOLONIZATION',	2);
--====================================	
-- JFD LOYALTY
--====================================	
-- Units
------------------------------------------------------------
UPDATE Units
SET PrereqTech = 'TECH_JFD_NATIONALISM', Strategy = 'TXT_KEY_UNIT_JFD_PEKING_FORCE_STRATEGY_NATIONALISM'
WHERE Type = 'UNIT_JFD_PEKING_FORCE'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_LOYALTY_TECH_ADDITIONS_NATIONALISM' AND Value = 1);
--====================================
-- JFD PROVINCES 
--====================================
-- Civilization_JFD_ProvinceTitles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle,											UniqueTitle)
VALUES	('CIVILIZATION_JFD_QING',	'TXT_KEY_PROVINCE_JFD_BARONY_DESC_MONARCHY',			'TXT_KEY_PROVINCE_JFD_BARONY_DESC_QING'),
		('CIVILIZATION_JFD_QING',	'TXT_KEY_PROVINCE_JFD_BARONY_DESC_RULER_MONARCHY',		'TXT_KEY_PROVINCE_JFD_BARONY_DESC_RULER_QING'),
		('CIVILIZATION_JFD_QING',	'TXT_KEY_PROVINCE_JFD_COUNTY_DESC_MONARCHY',			'TXT_KEY_PROVINCE_JFD_COUNTY_DESC_QING'),
		('CIVILIZATION_JFD_QING',	'TXT_KEY_PROVINCE_JFD_COUNTY_DESC_RULER_MONARCHY',		'TXT_KEY_PROVINCE_JFD_COUNTY_DESC_RULER_QING'),
		('CIVILIZATION_JFD_QING',	'TXT_KEY_PROVINCE_JFD_DUCHY_DESC_MONARCHY',				'TXT_KEY_PROVINCE_JFD_DUCHY_DESC_QING'),
		('CIVILIZATION_JFD_QING',	'TXT_KEY_PROVINCE_JFD_DUCHY_DESC_RULER_MONARCHY',		'TXT_KEY_PROVINCE_JFD_DUCHY_DESC_RULER_QING');
--====================================	
-- JFD SLAVERY
--====================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,				Flavor)
VALUES	('LEADER_JFD_CIXI',		'FLAVOR_JFD_SLAVERY',	0);
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
	DefeatScreenEarlyTag						text											default	null,
	DefeatScreenMidTag							text											default	null,
	DefeatScreenLateTag							text											default	null,
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType,	DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag,	IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_QING',	ArtDefineTag, CultureType,	DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag,	IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_CHINA';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Oriental'
WHERE Type = 'CIVILIZATION_JFD_QING'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Oriental')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
-- JFD RISE TO POWER
--==========================================================================================================================
--====================================	
-- JFD AND POUAKAI MERCENARIES
--====================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_JFD_CIXI',		'FLAVOR_JFD_MERCENARY',					6);
--====================================	
-- JFD PIETY
--====================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_JFD_CIXI',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		7),
		('LEADER_JFD_CIXI',		'FLAVOR_JFD_STATE_RELIGION',			8);
--====================================
-- JFD PROSPERITY
--====================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,			CurrencyType)
SELECT	'CIVILIZATION_JFD_QING',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_CHINA';
--====================================	
-- JFD SOVEREIGNTY
--====================================	
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
		(CivilizationType,			LegislatureName,										OfficeTitle,													GovernmentType,				Weight)
SELECT	'CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING',	'GOVERNMENT_JFD_MONARCHY',	100
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
        (CivilizationType,      	HeadOfGovernmentName)
VALUES  ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_1'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_2'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_3'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_4'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_5'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_6'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_7'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_8'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_9'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_10'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_11'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_12'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_13'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_14'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_15'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_16'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_17'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_18'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_19'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_20'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_21'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_22'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_23'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_24'),
        ('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_QING_25');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 				default null,
	CultureType							text 		 											default null,
	ReligionType						text 		REFERENCES Religions(Type) 					default null,
	DefaultTitle						text 		 											default null,
	UniqueTitle							text 		 											default null,
	UseAdjective						boolean													default 0);	
	
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,			DefaultTitle, UniqueTitle,	UseAdjective)
SELECT	'CIVILIZATION_JFD_QING',	DefaultTitle, UniqueTitle,	UseAdjective
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_CHINA';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 				default null,
	PoliticsType  						text 													default null,
	UniqueName							text													default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,			PoliticsType, UniqueName)
SELECT	'CIVILIZATION_JFD_QING',	PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_CHINA' AND NOT PoliticsType = 'ASSEMBLY_JFD_MILITARY';

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,			UniqueName,											PoliticsType)
VALUES	('CIVILIZATION_JFD_QING',	'TXT_KEY_JFD_ASSEMBLY_JFD_MILITARY_JFD_QING',		'ASSEMBLY_JFD_MILITARY');
------------------------------------------------------------
-- JFD_PrivyCouncillor_UniqueNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_PrivyCouncillor_UniqueNames (
	PrivyCouncillorType  				text 										 	default null,
	PolicyType  						text 	REFERENCES Policies(Type) 				default null,
	CivilizationType					text	REFERENCES Civilizations(Type) 			default	null,
	CultureType							text											default	null,
	GovernmentType  					text 	 										default null,
	ReligionType						text	REFERENCES Religions(Type) 				default	null,
	UniqueName							text											default	null);

INSERT INTO JFD_PrivyCouncillor_UniqueNames
		(CivilizationType,				PrivyCouncillorType, UniqueName)
SELECT	'CIVILIZATION_JFD_QING',		PrivyCouncillorType, UniqueName
FROM JFD_PrivyCouncillor_UniqueNames WHERE CivilizationType = 'CIVILIZATION_CHINA';
------------------------------------------------------------			
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,							Flavor)
VALUES	('LEADER_JFD_CIXI',		'FLAVOR_JFD_REFORM_GOVERNMENT',		8),
		('LEADER_JFD_CIXI',		'FLAVOR_JFD_REFORM_LEGAL',			8),
		('LEADER_JFD_CIXI',		'FLAVOR_JFD_REFORM_CULTURE',		4),
		('LEADER_JFD_CIXI',		'FLAVOR_JFD_REFORM_ECONOMIC',		7),
		('LEADER_JFD_CIXI',		'FLAVOR_JFD_REFORM_FOREIGN',		8),
		('LEADER_JFD_CIXI',		'FLAVOR_JFD_REFORM_INDUSTRY',		8),
		('LEADER_JFD_CIXI',		'FLAVOR_JFD_REFORM_MILITARY',		9),
		('LEADER_JFD_CIXI',		'FLAVOR_JFD_REFORM_RELIGION',		6);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  					text 	REFERENCES Leaders(Type) 	default	null,
	ReformType						text								default	null);
	
INSERT INTO Leader_JFD_Reforms
		(LeaderType,			ReformType)
VALUES	('LEADER_JFD_CIXI',		'REFORM_JFD_EXECUTIVE_ABSOLUTE');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_Qing_Decisions.lua');
------------------------------
-- Policies
------------------------------
INSERT INTO Policies
		(Type,											PolicyCostModifier,		Description)
VALUES	('POLICY_DECISIONS_JFD_QING_IMPERIAL_EXAMS',	-15,					'TXT_KEY_DECISIONS_JFD_QING_IMPERIAL_EXAMS'),
		('POLICY_DECISIONS_JFD_SELF_STRENGTHENING',		0,						'TXT_KEY_DECISIONS_JFD_QING_ROMANIA');
		
UPDATE Policies
SET PolicyCostModifier = 0
WHERE Type = 'POLICY_DECISIONS_JFD_QING_IMPERIAL_EXAMS'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_RTP_SOVEREIGNTY_CORE' AND Value = 1);
------------------------------
-- Policy_JFD_SovereigntyMods
------------------------------	
CREATE TABLE IF NOT EXISTS 
	Policy_JFD_SovereigntyMods (
	PolicyType  										text 		REFERENCES Policies(Type) 				default null,
	ReformBranchType									text 	 											default null,
	FactionSovMod										integer												default 0,
	LegitimacySovMod									integer												default 0,
	MaxSovChange										integer												default 0,
	ReformCooldownMod									integer												default 0,
	ReformCostMod										integer												default 0); 
	
INSERT INTO Policy_JFD_SovereigntyMods
		(PolicyType, 									ReformCooldownMod)
SELECT	'POLICY_DECISIONS_JFD_QING_IMPERIAL_EXAMS', 	-15
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_RTP_SOVEREIGNTY_CORE' AND Value = 1);
------------------------------
-- Policy_BuildingClassProductionModifiers
------------------------------	
INSERT INTO Policy_BuildingClassProductionModifiers
		(PolicyType, 									BuildingClassType,	ProductionModifier)
SELECT	'POLICY_DECISIONS_JFD_SELF_STRENGTHENING', 		Type,				50
FROM BuildingClasses WHERE Type IN ('BUILDINGCLASS_BARRACKS', 'BUILDINGCLASS_ARMORY', 'BUILDINGCLASS_MILITARY_ACADEMY', 'BUILDINGCLASS_EE_GUNSMITH', 'BUILDINGCLASS_JFD_DRILL_ACADEMY');
--==========================================================================================================================
--==========================================================================================================================