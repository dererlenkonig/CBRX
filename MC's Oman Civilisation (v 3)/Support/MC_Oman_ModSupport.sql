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
        (LeaderType,                TraitOne,               TraitTwo)
SELECT  'LEADER_MC_SAIF_BIN_SULTAN',       'POLICY_SEAFARING_X',   'POLICY_FINANCIAL_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------  
-- Leaders
------------------------------  
UPDATE Leaders
SET Description = 'Saif bin Sultan [ICON_MOVES][ICON_GOLD]'
WHERE TYPE = 'LEADER_MC_SAIF_BIN_SULTAN'
AND EXISTS (SELECT * FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- ENLIGHTENMENT ERA
--==========================================================================================================================
-- Unit
------------------------------
UPDATE Units
SET Class = 'UNITCLASS_EE_GALLEON',   PrereqTech =  'TECH_EE_EXPLORATION',	Combat = '28', Cost = '165',	Strategy = 'TXT_KEY_UNIT_MC_OMANI_BAGHLAH_STRATEGY_EE'
WHERE TYPE = 'UNIT_MC_OMANI_BAGHLAH'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_EE_GALLEON');

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_SHIP_OF_THE_LINE'
WHERE UnitType ='UNIT_MC_OMANI_BAGHLAH'
AND EXISTS (SELECT * FROM Units WHERE Class = 'UNITCLASS_EE_SHIP_OF_THE_LINE');

UPDATE Civilization_UnitClassOverrides
SET UnitClassType = 'UNITCLASS_EE_GALLEON'
WHERE UnitType ='UNIT_MC_OMANI_BAGHLAH'
AND EXISTS (SELECT * FROM Units WHERE Class = 'UNITCLASS_EE_GALLEON');
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
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_Oman_Decisions.lua');
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
        (CivilizationType,          ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  'CIVILIZATION_MC_OMAN',   ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_ARABIA';
------------------------------  
-- Civilizations
------------------------------  
UPDATE Civilizations
SET SoundtrackTag = 'JFD_Islamic'
WHERE TYPE = 'CIVILIZATION_MC_OMAN'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Islamic')
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
        (CivilizationType,					ColonyName,                             LinguisticType)
VALUES  ('CIVILIZATION_MC_OMAN',            null,									'JFD_Arabic'),
        ('CIVILIZATION_MC_OMAN',            'TXT_KEY_COLONY_NAME_MC_OMAN_01',		null),
        ('CIVILIZATION_MC_OMAN',            'TXT_KEY_COLONY_NAME_MC_OMAN_02',		null),
        ('CIVILIZATION_MC_OMAN',            'TXT_KEY_COLONY_NAME_MC_OMAN_03',		null),
        ('CIVILIZATION_MC_OMAN',            'TXT_KEY_COLONY_NAME_MC_OMAN_04',		null),
        ('CIVILIZATION_MC_OMAN',            'TXT_KEY_COLONY_NAME_MC_OMAN_03',		null),
        ('CIVILIZATION_MC_OMAN',            'TXT_KEY_COLONY_NAME_MC_OMAN_04',		null);
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
        (LeaderType,            FlavorType,                 Flavor)
VALUES  ('LEADER_MC_SAIF_BIN_SULTAN',   'FLAVOR_JFD_SLAVERY',       7);
--==========================================================================================================================
-- TOMATEKH HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions
------------------------------
UPDATE Civilization_Religions
SET ReligionType = 'RELIGION_ISLAM_IBADI'
WHERE CivilizationType = 'CIVILIZATION_MC_OMAN'
AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_ISLAM_IBADI');
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------  
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
        (CivType,                       CultureType,        CultureEra)
VALUES  ('CIVILIZATION_MC_OMAN',      'ARABIAN',         'ANCIENT');
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
VALUES  ('LEADER_MC_SAIF_BIN_SULTAN',   'FLAVOR_JFD_MERCENARY',     6);
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
        (LeaderType,				      FlavorType,                             Flavor)
VALUES  ('LEADER_MC_SAIF_BIN_SULTAN',   'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     4);
--==========================================================  
-- JFD's RtP: Prosperity
--==========================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
--CREATE TABLE IF NOT EXISTS
--    Civilization_JFD_Currencies (
--    CivilizationType                text        REFERENCES Civilizations(TYPE)  DEFAULT NULL,
--    CurrencyType                    text                                        DEFAULT NULL);
-- 
--INSERT INTO Civilization_JFD_Currencies
--          (CivilizationType,                  CurrencyType)
--VALUES	( 'CIVILIZATION_MC_OMAN',         'CURRENCY_JFD_DINAR');
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
SELECT  'CIVILIZATION_MC_OMAN', LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_ARABIA';
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
SELECT  ('CIVILIZATION_MC_OMAN'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_ARABIA';
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
VALUES  ('LEADER_MC_SAIF_BIN_SULTAN',    'FLAVOR_JFD_REFORM_GOVERNMENT',     6),
        ('LEADER_MC_SAIF_BIN_SULTAN',    'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_MC_SAIF_BIN_SULTAN',    'FLAVOR_JFD_REFORM_ECONOMIC',       4),
        ('LEADER_MC_SAIF_BIN_SULTAN',    'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_MC_SAIF_BIN_SULTAN',    'FLAVOR_JFD_REFORM_INDUSTRY',       5),
        ('LEADER_MC_SAIF_BIN_SULTAN',    'FLAVOR_JFD_REFORM_LEGAL',       	 5),
        ('LEADER_MC_SAIF_BIN_SULTAN',    'FLAVOR_JFD_REFORM_MILITARY',       6),
        ('LEADER_MC_SAIF_BIN_SULTAN',    'FLAVOR_JFD_REFORM_RELIGION',       7);
--==========================================================================================================================
-- R.E.D. / Ethnic Units
--==========================================================================================================================
-- Civilizations
------------------------------  
UPDATE Civilizations
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ARABIA' )
    THEN '_ARABIA'
    ELSE '_AFRI' END)
WHERE TYPE = 'CIVILIZATION_MC_OMAN';
--==========================================================================================================================
-- YnAEMP v24
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
        (TYPE,                        X,  Y)
VALUES  ('CIVILIZATION_MC_OMAN',      51, 42);
------------------------------------------------------------    
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
        (TYPE,                        X,  Y)
VALUES  ('CIVILIZATION_MC_OMAN',      81, 42);
------------------------------------------------------------    
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
        (TYPE,                        X,  Y)
VALUES  ('CIVILIZATION_MC_OMAN',      53, 16);
------------------------------------------------------------    
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
        (TYPE,                        X,  Y)
VALUES  ('CIVILIZATION_MC_OMAN',      70, 32);
------------------------------------------------------------    
-- Civilizations_AfriAsiaAustStartPosition (Africa, Asia, Oceania Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
        (TYPE,                        X,  Y)
VALUES  ('CIVILIZATION_MC_OMAN',      63, 57);
------------------------------------------------------------    
-- Civilizations_AfriGiantStartPosition (Africa Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriGiantStartPosition
        (TYPE,                        X,   Y)
VALUES  ('CIVILIZATION_MC_OMAN',      135, 111);
------------------------------------------------------------    
-- Civilizations_AfriSouthEuroStartPosition (Africa and Southern Europe Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriSouthEuroStartPosition
        (TYPE,                         X,  Y)
VALUES  ('CIVILIZATION_MC_OMAN',      70, 50);
------------------------------------------------------------    
-- Civilizations_AsiaStartPosition (Asia Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition
        (TYPE,                        X, Y)
VALUES  ('CIVILIZATION_MC_OMAN',      3, 33);
------------------------------------------------------------    
-- Civilizations_IndianOceanStartPosition (Indian Ocean Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndianOceanStartPosition
        (TYPE,                        X,  Y)
VALUES  ('CIVILIZATION_MC_OMAN',      29, 63);
--==========================================================================================================================
--==========================================================================================================================