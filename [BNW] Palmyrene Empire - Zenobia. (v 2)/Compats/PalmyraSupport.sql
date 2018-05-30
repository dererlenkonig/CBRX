--=======================================================================================================================
-- *** BINGLES CIV IV TRAITS ***
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------ 
CREATE TABLE IF NOT EXISTS
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(TYPE)        DEFAULT NULL,
    TraitOne            text    REFERENCES Policies(TYPE)       DEFAULT NULL,
    TraitTwo            text    REFERENCES Policies(TYPE)       DEFAULT NULL);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,            TraitOne,                   TraitTwo)
VALUES  ('LEADER_FB_ZENOBIA',    'POLICY_MERCANTILE_X',      'POLICY_AGGRESSIVE_X');
------------------------------ 
-- Leaders
------------------------------ 
UPDATE Leaders
SET Description = 'Zenobia [ICON_TRADE][ICON_WAR]'
WHERE TYPE = 'LEADER_FB_ZENOBIA'
AND EXISTS (SELECT * FROM Policies WHERE TYPE = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- *** JFD's CULTURAL DIVERSITY ***
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    CultureType                                 text                                        default null,
    SplashScreenTag                             text                                        default null,
    SoundtrackTag                               text                                        default null);
 
INSERT OR REPLACE INTO Civilization_JFD_CultureTypes
        (CivilizationType,      CultureType,            SplashScreenTag,        SoundtrackTag)
VALUES  ('CIVILIZATION_FB_PALMYRA', 'JFD_Semitic',    'JFD_Semitic',    'JFD_Semitic');
--==========================================================================================================================
-- *** BARATHOR's YNAEMP ***
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
            (TYPE,                                      X,      Y,      AltX,   AltY)
VALUES      ('CIVILIZATION_FB_PALMYRA',                    38,     52,     NULL,   NULL);     
--==========================================================================================================================
-- Civilizations_YahemStartPosition (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
            (TYPE,                                      X,      Y,      AltX,   AltY)
VALUES      ('CIVILIZATION_FB_PALMYRA',                    73,     48,     NULL,   NULL);
--==========================================================================================================================
-- Civilizations_CordiformStartPosition (Earth Standard)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
            (TYPE,                                      X,      Y,      AltX,   AltY)
VALUES      ('CIVILIZATION_FB_PALMYRA',                    48,     20,     NULL,   NULL);
--==========================================================================================================================
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
            (TYPE,                                      X,      Y,      AltX,   AltY)
VALUES      ('CIVILIZATION_FB_PALMYRA',                    63,     39,     NULL,   NULL);
--==========================================================================================================================
-- Civilizations_EuroLargeStartPosition (Europe Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(TYPE, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
            (TYPE,                                      X,      Y,      AltX,   AltY)
VALUES      ('CIVILIZATION_FB_PALMYRA',                    65,     18,     NULL,   NULL);
--==========================================================================================================================
-- Civilizations_YagemRequestedResource (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(TYPE, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
            (TYPE,                                      Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT      ('CIVILIZATION_FB_PALMYRA'),                   Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE TYPE = 'CIVILIZATION_BABYLON';
--==========================================================================================================================
-- Civilizations_YahemRequestedResource (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(TYPE, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
            (TYPE,                                      Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT      ('CIVILIZATION_FB_PALMYRA'),                   Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE TYPE = 'CIVILIZATION_BABYLON';
--==========================================================================================================================
-- Civilizations_CordiformRequestedResource (Earth Standard)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(TYPE, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource
            (TYPE,                                      Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT      ('CIVILIZATION_FB_PALMYRA'),                   Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_CordiformRequestedResource WHERE TYPE = 'CIVILIZATION_BABYLON';
--==========================================================================================================================
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(TYPE, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
            (TYPE,                                      Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT      ('CIVILIZATION_FB_PALMYRA'),                   Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE TYPE = 'CIVILIZATION_BABYLON';
--==========================================================================================================================
-- Civilizations_EuroLargeRequestedResource (Europe Large)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(TYPE, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
            (TYPE,                                      Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT      ('CIVILIZATION_FB_PALMYRA'),                   Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE TYPE = 'CIVILIZATION_BABYLON';
--==========================================================================================================================
-- *** JFD's USER SETTINGS ***
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS
JFD_GlobalUserSettings (
    TYPE                                        text                                            DEFAULT NULL,
    VALUE                                       INTEGER                                         DEFAULT 1);
--==========================================================================================================================    
-- *** JFD's and Pouakai's MERCENARIES ***
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
INSERT INTO Leader_Flavors
        (LeaderType,                FlavorType,                 Flavor)
VALUES  ('LEADER_FB_ZENOBIA',    'FLAVOR_JFD_MERCENARY',     7);
--==========================================================================================================================
-- *** Hazel16's MAP LABELS ***
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
        (CivType,               CultureType,        CultureEra)
VALUES  ('CIVILIZATION_FB_PALMYRA', 'MEDITERRANEAN',    'ANY');
--==========================================================================================================================   
-- *** JFD's PIETY ***
--==========================================================================================================================           
INSERT OR REPLACE INTO Flavors
            (TYPE)
VALUES      ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
 
INSERT INTO Leader_Flavors
            (LeaderType,            FlavorType,                             Flavor)
VALUES      ('LEADER_FB_ZENOBIA',    'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     5);
--==========================================================================================================================
-- *** JFD COLONIES ***
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------ 
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    ColonyName                                  text                                        default null,
    LinguisticType                              text                                        default null,
    CultureType                                 text                                        default null);
 
INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
        (CivilizationType,      ColonyName,                         LinguisticType)
VALUES  ('CIVILIZATION_FB_PALMYRA', null,                               'JFD_Hellenic'),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_01',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_02',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_03',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_04',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_05',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_06',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_07',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_08',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_09',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_10',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_11',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_12',    null),
        ('CIVILIZATION_FB_PALMYRA', 'TXT_KEY_COLONY_NAME_BABYLON_13',    null);
		------------------------------  
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------  
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    RevolutionaryCivilizationType               text    REFERENCES Civilizations(Type)      default null);
     
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
        (CivilizationType,                      RevolutionaryCivilizationType)
VALUES  ('CIVILIZATION_ROME',                 'CIVILIZATION_FB_PALMYRA'),
        ('CIVILIZATION_FB_PALMYRA',                 'CIVILIZATION_ROME');
--==========================================================================================================================
-- *** JFD PROSPERITY ***
--==========================================================================================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Currencies (
    CivilizationType                text        REFERENCES Civilizations(TYPE)  DEFAULT NULL,
    CurrencyType                    text                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_Currencies
        (CivilizationType,          CurrencyType)
SELECT  'CIVILIZATION_FB_PALMYRA', CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_ROME';
--==========================================================================================================================
-- *** ETHNIC UNITS/GEDEMON's R.E.D. ***
--==========================================================================================================================
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_MED' )
    THEN '_BABYLON'
    ELSE '_MED' END) 
WHERE Type = 'CIVILIZATION_FB_PALMYRA';
--==========================================================================================================================    
-- *** JFD's SOVEREIGNTY ***
--==========================================================================================================================
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
        (CivilizationType,                  LegislatureName,                                    OfficeTitle,                                                GovernmentType,             Weight)
VALUES  ('CIVILIZATION_FB_PALMYRA',   'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_FB_PALMYRA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_FB_PALMYRA',  'GOVERNMENT_JFD_MONARCHY',  100);
------------------------------------------------------------    
-- Civilization_JFD_HeadsOfGovernment  
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS  
    Civilization_JFD_HeadsOfGovernment (    
    CivilizationType                text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    CultureType                     text                                                        DEFAULT NULL,
    HeadOfGovernmentName            text                                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,                      HeadOfGovernmentName)
VALUES  ('CIVILIZATION_FB_PALMYRA',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_GREECE_1'),
        ('CIVILIZATION_FB_PALMYRA',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_GREECE_2'),
        ('CIVILIZATION_FB_PALMYRA',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_GREECE_3'),
        ('CIVILIZATION_FB_PALMYRA',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_GREECE_4'),
        ('CIVILIZATION_FB_PALMYRA',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_GREECE_5'),
        ('CIVILIZATION_FB_PALMYRA',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_GREECE_6'),
        ('CIVILIZATION_FB_PALMYRA',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_GREECE_7'),
        ('CIVILIZATION_FB_PALMYRA',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_GREECE_8'),
        ('CIVILIZATION_FB_PALMYRA',       'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_GREECE_9');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Titles (
    CivilizationType                text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    CultureType                     text                                                        DEFAULT NULL,
    ReligionType                    text        REFERENCES Religions(TYPE)                      DEFAULT NULL,
    DefaultTitle                    text                                                        DEFAULT NULL,
    UniqueTitle                     text                                                        DEFAULT NULL,
    UseAdjective                    BOOLEAN                                                     DEFAULT 0);
 
INSERT INTO Civilization_JFD_Titles
        (CivilizationType,                  DefaultTitle,   UniqueTitle)
SELECT  'CIVILIZATION_FB_PALMYRA', DefaultTitle,   UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_GREECE';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    PoliticsType                        text                                                        DEFAULT NULL,
    UniqueName                          text                                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_Politics
        (CivilizationType,                  PoliticsType, UniqueName)
SELECT  'CIVILIZATION_FB_PALMYRA', PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_GREECE';
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
INSERT INTO Leader_Flavors
        (LeaderType,            FlavorType,                         Flavor)
VALUES  ('LEADER_FB_ZENOBIA',    'FLAVOR_JFD_REFORM_GOVERNMENT',     7),
        ('LEADER_FB_ZENOBIA',    'FLAVOR_JFD_REFORM_CULTURE',        6),
        ('LEADER_FB_ZENOBIA',    'FLAVOR_JFD_REFORM_ECONOMIC',       5),
        ('LEADER_FB_ZENOBIA',    'FLAVOR_JFD_REFORM_FOREIGN',        5),
        ('LEADER_FB_ZENOBIA',    'FLAVOR_JFD_REFORM_INDUSTRY',       6),
        ('LEADER_FB_ZENOBIA',    'FLAVOR_JFD_REFORM_MILITARY',       7),
        ('LEADER_FB_ZENOBIA',    'FLAVOR_JFD_REFORM_RELIGION',       4);
