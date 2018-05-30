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
		(LeaderType,			TraitOne,				TraitTwo)
SELECT	'LEADER_JFD_MEHMED',	'POLICY_AGGRESSIVE_X',	'POLICY_SPIRITUAL_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Mehmed II [ICON_WAR][ICON_PEACE]'
WHERE Type = 'TXT_KEY_LEADER_JFD_MEHMED'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'LEADER_JFD_MEHMED');
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_OTTOMAN'
WHERE Type = 'CIVILIZATION_JFD_TURKS'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_OTTOMAN');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		32,		57);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		69,		52);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		60,		44);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Cordiform)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		45,		27);
------------------------------------------------------------	
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		109,	28);
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition (Europe Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeNewStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		59,		21);
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		54,		27);
------------------------------------------------------------	
-- Civilizations_MesopotamiaStartPosition (Mesopotamia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		15,		36);
------------------------------------------------------------	
-- Civilizations_AegeanStartPosition (Aegean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AegeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AegeanStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		34,		36);
------------------------------------------------------------	
-- Civilizations_MediterraneanStartPosition (Mediterranean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		74,		38);
------------------------------------------------------------	
-- Civilizations_MesopotamiaGiantStartPosition (Giant Levant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaGiantStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		21,		86);
------------------------------------------------------------	
-- Civilizations_CaucasusStartPosition (Caucasus)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaucasusStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaucasusStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		44,		35);
------------------------------------------------------------	
-- Civilizations_CaucasusStartPosition (Africa, Asia & Australia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		40,		72);
------------------------------------------------------------	
-- Civilizations_AfriSouthEuroStartPosition (Africa & Southern Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriSouthEuroStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_TURKS',		51,		70);
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_CordiformRequestedResource (Earth Cordiform)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_CordiformRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_EuroGiantRequestedResource (Euro Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Euro Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Euro Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeNewRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeNewRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_AegeanRequestedResource (Aegean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AegeanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AegeanRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_AegeanRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_MesopotamiaRequestedResource (Mesopotamia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MesopotamiaRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_MesopotamiaRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations__MediterraneanRequestedResource (Mediterranean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MediterraneanRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_MediterraneanRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_AfriSouthEuroRequestedResource (Africa & Southern Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriSouthEuroRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_MesopotamiaGiantRequestedResource (Giant Levant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MesopotamiaGiantRequestedResource 
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_MesopotamiaGiantRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_CaucasusRequestedResource (Caucasus)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaucasusRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CaucasusRequestedResource 
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_CaucasusRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_AfriAsiaAustRequestedResource (Africa, Asia & Australia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriAsiaAustRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriAsiaAustRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilizations_AfriSouthEuroRequestedResource (Africa & Southern Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriSouthEuroRequestedResource
		(Type, 							Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_TURKS',		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_OTTOMAN';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,						CultureType,	CultureEra)
SELECT	'CIVILIZATION_JFD_TURKS',		CultureType,	CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_OTTOMAN';
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 										text 											default null,
	Value 										integer 										default 1);
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
--====================================	
-- JFD COLONIES
--====================================	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 								text 	REFERENCES Civilizations(Type) 	default null,
	ColonyName 										text									default null,
	LinguisticType									text									default	null,
	CultureType										text									default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 				ColonyName,		LinguisticType)
SELECT	'CIVILIZATION_JFD_TURKS',		ColonyName,		LinguisticType
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
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
		(LeaderType,				FlavorType,						Flavor)
VALUES	('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_DECOLONIZATION',	4);
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
		(CivilizationType,			DefaultTitle, UniqueTitle)
SELECT	'CIVILIZATION_JFD_TURKS',	DefaultTitle, UniqueTitle
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
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
		(LeaderType,				FlavorType,				Flavor)
VALUES	('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_SLAVERY',	8);
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
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
		(CivilizationType,			ArtDefineTag, CultureType, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_TURKS',	ArtDefineTag, CultureType, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, 'JFD_Eastern', UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_IslamicTurkic'
WHERE Type = 'CIVILIZATION_JFD_TURKS'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_IslamicTurkic')
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
		(LeaderType,				FlavorType,				 Flavor)
VALUES	('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_MERCENARY',	 6);
--====================================	
-- JFD PIETY
--====================================	
-- Flavors
------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,								Flavor)
VALUES	('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		5),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_STATE_RELIGION',			8);
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
SELECT	'CIVILIZATION_JFD_TURKS',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
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
		(CivilizationType,			LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT	'CIVILIZATION_JFD_TURKS',	LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
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
VALUES  ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_1'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_2'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_3'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_4'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_5'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_6'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_7'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_8'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_9'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_10'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_11'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_12'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_13'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_14'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_15'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_16'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_17'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_18'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_19'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_20'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_21'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_22'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_23'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_24'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_TURKS_25');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	ReligionType					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_Titles
		(CivilizationType,			DefaultTitle,	UniqueTitle)
SELECT	'CIVILIZATION_JFD_TURKS',	DefaultTitle,	UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';

DELETE FROM Civilization_JFD_Titles WHERE DefaultTitle = 'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER' AND CivilizationType = 'CIVILIZATION_JFD_TURKS';
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,			DefaultTitle,									UniqueTitle)
VALUES	('CIVILIZATION_JFD_TURKS',	'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER',	'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER_JFD_TURKS');	
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,			PoliticsType, UniqueName)
SELECT	'CIVILIZATION_JFD_TURKS',	PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--------------------------------------------------------------------------------------------------------------------------
-- JFD_PrivyCouncillor_UniqueNames
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_PrivyCouncillor_UniqueNames (
	PrivyCouncillorType  			text 										 	default null,
	PolicyType  					text 	REFERENCES Policies(Type) 				default null,
	CivilizationType				text	REFERENCES Civilizations(Type) 			default	null,
	CultureType						text											default	null,
	GovernmentType  				text 	 										default null,
	ReligionType					text	REFERENCES Religions(Type) 				default	null,
	UniqueName						text											default	null);

INSERT INTO JFD_PrivyCouncillor_UniqueNames
		(CivilizationType,			PrivyCouncillorType, UniqueName)
SELECT	'CIVILIZATION_JFD_TURKS',	PrivyCouncillorType, UniqueName
FROM JFD_PrivyCouncillor_UniqueNames WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
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
		(LeaderType,				FlavorType,							 Flavor)
VALUES	('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_GOVERNMENT',		 6),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_LEGAL',			 7),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_CULTURE',		 4),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_ECONOMIC',		 5),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_FOREIGN',		 7),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_INDUSTRY',		 5),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_MILITARY',		 7),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_RELIGION',		 6);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  					text 	REFERENCES Leaders(Type) 	default	null,
	ReformType						text								default	null);
	
INSERT INTO Leader_JFD_Reforms
		(LeaderType,				ReformType)
VALUES	('LEADER_JFD_MEHMED_II',	'REFORM_JFD_LEGITIMACY_MIGHT');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_Turks_Decisions.lua');
------------------------------	
-- BuildingClasses
------------------------------	
INSERT INTO BuildingClasses 	
		(Type, 						 					DefaultBuilding, 								Description, 									MaxPlayerInstances)
VALUES	('BUILDINGCLASS_DECISIONS_JFD_ENDERUN_ACADEMY', 'BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY',		'TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY',		1);
------------------------------
-- Buildings
------------------------------
INSERT INTO Buildings			
		(Type, 											BuildingClass, 			  						GreatGeneralRateModifier,	Cost, 	FaithCost,	Help,											Description, 								Civilopedia,									IconAtlas,		PortraitIndex,	NukeImmune, ConquestProb)
VALUES	('BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY',		'BUILDINGCLASS_DECISIONS_JFD_ENDERUN_ACADEMY',  20,							-1, 	-1,			'TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY_HELP',	'TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY', 	'TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY_PEDIA',	'TECH_ATLAS_1',	28,				1,			100);
------------------------------
-- Building_UnitCombatFreeExperiences
------------------------------
INSERT INTO Building_UnitCombatFreeExperiences
		(BuildingType,									UnitCombatType,			Experience)
VALUES	('BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY',		'UNITCOMBAT_GUN',		10),
		('BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY',		'UNITCOMBAT_MOUNTED',	10);
--==========================================================================================================================
-- SUKRITACT EVENTS
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('JFD_Turks_Events.lua');
--==========================================================================================================================
--==========================================================================================================================