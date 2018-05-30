--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------  
CREATE TABLE IF NOT EXISTS
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(TYPE)        DEFAULT NULL,
    TraitOne            text    REFERENCES Policies(TYPE)       DEFAULT NULL,
    TraitTwo            text    REFERENCES Policies(TYPE)       DEFAULT NULL);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,                TraitOne,               	TraitTwo)
SELECT  'LEADER_MC_ROBERT_BRUS',    'POLICY_CHARISMATIC_X',		'POLICY_PROTECTIVE_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------  
-- Leaders
------------------------------  
UPDATE Leaders
SET Description = 'Robert I Bruce [ICON_HAPPINESS_1][ICON_STRENGTH]'
WHERE TYPE = 'LEADER_MC_ROBERT_BRUS'
AND EXISTS (SELECT * FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X');
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
-- Events & Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_Scotland_Decisions.lua');

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
        (CivilizationType,           ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_MC_SCOTLAND',  ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_CELTS';
------------------------------  
-- Civilizations
------------------------------  
UPDATE Civilizations
SET SoundtrackTag = 'JFD_Northern'
WHERE TYPE = 'CIVILIZATION_MC_SCOTLAND'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Northern')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE TYPE = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND VALUE = 1);

--==========================================================================================================================
-- JFD's Cities in Development
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------  
CREATE TABLE IF NOT EXISTS
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(TYPE)      DEFAULT NULL,
    ColonyName                                  text                                        DEFAULT NULL,
    LinguisticType                              text                                        DEFAULT NULL,
    CultureType                                 text                                        DEFAULT NULL);
 
INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 						ColonyName,								LinguisticType)
VALUES		('CIVILIZATION_MC_SCOTLAND', 			null,									'JFD_Celtic'),
			('CIVILIZATION_MC_SCOTLAND', 			'TXT_KEY_COLONY_NAME_MC_SCOTLAND_01',	null),
			('CIVILIZATION_MC_SCOTLAND', 			'TXT_KEY_COLONY_NAME_MC_SCOTLAND_02',	null),
			('CIVILIZATION_MC_SCOTLAND', 			'TXT_KEY_COLONY_NAME_MC_SCOTLAND_03',	null),
			('CIVILIZATION_MC_SCOTLAND', 			'TXT_KEY_COLONY_NAME_MC_SCOTLAND_04',	null),
			('CIVILIZATION_MC_SCOTLAND', 			'TXT_KEY_COLONY_NAME_MC_SCOTLAND_05',	null),
			('CIVILIZATION_MC_SCOTLAND', 			'TXT_KEY_COLONY_NAME_MC_SCOTLAND_06',	null);
--==========================================================  
-- JFD's CiD: Slavery
--==========================================================    
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 0-10 may be set. This value determines the proclivity a civ has toward enslaving a captured city and toward spending Slavery on Units.
INSERT INTO Leader_Flavors
        (LeaderType,            	FlavorType,                 Flavor)
VALUES  ('LEADER_MC_ROBERT_BRUS',   'FLAVOR_JFD_SLAVERY',       2);
--==========================================================================================================================
-- TOMATEKH HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions
------------------------------
--UPDATE Civilization_Religions
--SET ReligionType = 'RELIGION_SLAVINISM'
--WHERE CivilizationType = 'CIVILIZATION_MC_SCOTLAND'
--AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_SLAVINISM');
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------  
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
        (CivType,                       CultureType,        CultureEra)
VALUES  ('CIVILIZATION_MC_SCOTLAND',      'EUROPEAN',         'ANY');
--==========================================================================================================================  
-- JFD's and Pouakai's MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT OR REPLACE INTO Leader_Flavors
        (LeaderType,            FlavorType,                 Flavor)
VALUES  ('LEADER_MC_ROBERT_BRUS',   'FLAVOR_JFD_MERCENARY',     6);
--==========================================================================================================================    
-- JFD's Rise to Power
--==========================================================================================================================
--==========================================================  
-- JFD's RtP: Piety
--==========================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-12 may be set. This value determines the diplomatic penalty/bonus with civilizations of a different/same state religion
--A value higher than 9 means this civilization will never secularise. A value of 0 means this civilization has no interest in State Religion.
INSERT INTO Leader_Flavors
        (LeaderType,            FlavorType,                             Flavor)
VALUES  ('LEADER_MC_ROBERT_BRUS',   'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     7);
--==========================================================  
-- JFD's RtP: Prosperity
--==========================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Currencies (
    CivilizationType                text        REFERENCES Civilizations(TYPE)  DEFAULT NULL,
    CurrencyType                    text                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_Currencies
        (CivilizationType,                  CurrencyType)
VALUES	( 'CIVILIZATION_MC_SCOTLAND',         'CURRENCY_JFD_POUND');
--==========================================================  
-- JFD's RtP: Sovereignty
--==========================================================
------------------------------------------------------------    
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Governments (
    CivilizationType                text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    CultureType                     text                                                        DEFAULT NULL,
    LegislatureName                 text                                                        DEFAULT NULL,
    OfficeTitle                     text                                                        DEFAULT NULL,
    GovernmentType                  text                                                        DEFAULT NULL,
    Weight                          INTEGER                                                     DEFAULT 0);
 
INSERT INTO Civilization_JFD_Governments
        (CivilizationType,        LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  'CIVILIZATION_MC_SCOTLAND', LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_ENGLAND';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    PoliticsType                        text                                                        DEFAULT NULL,
    UniqueName                          text                                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_Politics
        (CivilizationType,          PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_MC_SCOTLAND'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_ENGLAND';
------------------------------------------------------------
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_REFORM_GOVERNMENT'),
        ('FLAVOR_JFD_REFORM_CULTURE'),
        ('FLAVOR_JFD_REFORM_ECONOMIC'),
        ('FLAVOR_JFD_REFORM_FOREIGN'),
        ('FLAVOR_JFD_REFORM_INDUSTRY'),
        ('FLAVOR_JFD_REFORM_MILITARY'),
        ('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--Each flavour corresponds to one of the seven Reform Categories, and how likely a civ is to take a reform in either the Right, Centre, or Left column.
--A value of 1-3 will favour Left Reforms. A value of 4-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT OR REPLACE INTO Leader_Flavors
        (LeaderType,         	 FlavorType,                         Flavor)
VALUES  ('LEADER_MC_ROBERT_BRUS',    'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_ROBERT_BRUS',    'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_ROBERT_BRUS',    'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_ROBERT_BRUS',    'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_ROBERT_BRUS',    'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_ROBERT_BRUS',    'FLAVOR_JFD_REFORM_LEGAL',       	 5),
        ('LEADER_MC_ROBERT_BRUS',    'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_MC_ROBERT_BRUS',    'FLAVOR_JFD_REFORM_RELIGION',       6);
--==========================================================================================================================
-- R.E.D. / Ethnic Units
--==========================================================================================================================
-- Civilizations
------------------------------  
UPDATE Civilizations
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ENGLAND' )
    THEN '_CELTS'
    ELSE '_EURO' END)
WHERE TYPE = 'CIVILIZATION_MC_SCOTLAND';
--==========================================================================================================================
-- YnAEMP v24
--==========================================================================================================================
------------------------------------------------------------
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_MC_SCOTLAND',			9,		77);
--------------------------------	
-- The Celts
--------------------------------	
UPDATE Civilizations_YagemStartPosition
SET	X = 12, Y = 71
WHERE Type = 'CIVILIZATION_CELTS';
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_MC_SCOTLAND',			55,		66);
--------------------------------	
-- The Celts
--------------------------------	
UPDATE Civilizations_YahemStartPosition
SET	X = 56, Y = 63
WHERE Type = 'CIVILIZATION_CELTS';
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_MC_SCOTLAND',			33,		36);
--------------------------------	
-- The Celts
--------------------------------	
UPDATE Civilizations_CordiformStartPosition
SET	X = 34, Y = 33
WHERE Type = 'CIVILIZATION_CELTS';
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_MC_SCOTLAND',			38,		58);
--------------------------------	
-- The Celts
--------------------------------	
UPDATE Civilizations_GreatestEarthStartPosition
SET	X = 40, Y = 54
WHERE Type = 'CIVILIZATION_CELTS';
------------------------------------------------------------	
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_MC_SCOTLAND',			39,		88);
--------------------------------	
-- The Celts
--------------------------------	
UPDATE Civilizations_EuroGiantStartPosition
SET	X = 43, Y = 75
WHERE Type = 'CIVILIZATION_CELTS';
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_MC_SCOTLAND',			22,		56);
--------------------------------	
-- The Celts
--------------------------------	
UPDATE Civilizations_EuroLargeStartPosition
SET	X = 21, Y = 47
WHERE Type = 'CIVILIZATION_CELTS';
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_MC_SCOTLAND',			79,		36);
--------------------------------	
-- The Celts
--------------------------------	
UPDATE Civilizations_NorthAtlanticStartPosition
SET	X = 83, Y = 32
WHERE Type = 'CIVILIZATION_CELTS';
------------------------------------------------------------	
-- Civilizations_BritishIslesStartPosition (British Isles)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_BritishIslesStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_BritishIslesStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_MC_SCOTLAND',			32,		51);
--------------------------------	
-- The Celts
--------------------------------	
UPDATE Civilizations_BritishIslesStartPosition
SET	X = 49, Y = 26
WHERE Type = 'CIVILIZATION_CELTS';
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeStartPosition (North-West Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthWestEuropeStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_MC_SCOTLAND',			14,		31);
--------------------------------	
-- The Celts
--------------------------------	
UPDATE Civilizations_NorthWestEuropeStartPosition
SET	X = 19, Y = 20
WHERE Type = 'CIVILIZATION_CELTS';
--==========================================================================================================================
--==========================================================================================================================