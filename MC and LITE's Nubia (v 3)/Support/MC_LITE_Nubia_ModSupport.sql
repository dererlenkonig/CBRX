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
        (LeaderType,                TraitOne,               TraitTwo)
VALUES  ('LEADER_MC_LITE_PIYE',     'POLICY_MERCANTILE_X',  'POLICY_SEAFARING_X');
------------------------------  
-- Leaders
------------------------------  
UPDATE Leaders 
SET Description = 'MC_LITE_PIYE [ICON_CONNECTED][ICON_MOVES]'
WHERE Type = 'LEADER_MC_LITE_PIYE'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------  
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_EGYPT' )
    THEN '_EGYPT'
    ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_MC_LITE_NUBIA';
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  32, 38);
------------------------------------------------------------    
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  70, 39);
------------------------------------------------------------    
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  43, 15);
------------------------------------------------------------    
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  60, 28);
------------------------------------------------------------    
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  59, 2);
------------------------------------------------------------    
-- Civilizations_AfricaLargeStartPosition (Africa Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfricaLargeStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  43, 56);
------------------------------------------------------------    
-- Civilizations_NileValleyStartPosition (Nile Valley)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_NileValleyStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NileValleyStartPosition
        (Type,                          X,  Y)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  49, 3);
------------------------------------------------------------    
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
------------------------------------------------------------    
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
------------------------------------------------------------    
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
------------------------------------------------------------    
-- Civilizations_EuroLargeRequestedResource (Europe Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
------------------------------------------------------------    
-- Civilizations_AfricaLargeRequestedResource (Africa Large)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfricaLargeRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfricaLargeRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
------------------------------------------------------------    
-- Civilizations_NileValleyRequestedResource (Nile Valley)
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS Civilizations_NileValleyRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NileValleyRequestedResource
        (Type,                          Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NileValleyRequestedResource WHERE Type = 'CIVILIZATION_EGYPT';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------  
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
        (CivType,                       CultureType,        CultureEra)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  'MEDITERRANEAN',    'ANCIENT'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'ARABIAN',          'MODERN');
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
    Type                                        text                                        default null,
    Value                                       integer                                     default 1);
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------  
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
    CivilizationType                            text    REFERENCES Civilizations(Type)          default null,
    CultureType                                 text                                            default null,
    ArtDefineTag                                text                                            default null,
    SplashScreenTag                             text                                            default null,
    SoundtrackTag                               text                                            default null,
    UnitDialogueTag                             text                                            default null);
     
INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,              ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_EGYPT';
------------------------------  
-- Civilizations
------------------------------  
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Mesopotamic'
WHERE Type = 'CIVILIZATION_MC_LITE_NUBIA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Mesopotamic')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
-- JFD EXPLORATION CONTINUED EXPANDED
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------  
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    ColonyName                                  text                                        default null,
    LinguisticType                              text                                        default null,
    CultureType                                 text                                        default null);
 
INSERT INTO Civilization_JFD_ColonialCityNames
        (CivilizationType,              LinguisticType)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  'JFD_Mesopotamian');
--==========================================================================================================================    
-- JFD PIETY & SOVEREIGNTY
--==========================================================================================================================    
------------------------------------------------------------    
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Governments (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    LegislatureName                 text                                                        default null,
    OfficeTitle                     text                                                        default null,
    GovernmentType                  text                                                        default null,
    Weight                          integer                                                     default 0);
 
INSERT INTO Civilization_JFD_Governments
        (CivilizationType,              LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_EGYPT';
------------------------------------------------------------    
-- Civilization_JFD_HeadsOfGovernment   
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS  
    Civilization_JFD_HeadsOfGovernment (    
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    HeadOfGovernmentName            text                                                        default null);
 
INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,              HeadOfGovernmentName)
VALUES  ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_1'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_2'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_3'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_4'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_5'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_6'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_7'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_8'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_9'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_10'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_11'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_12'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_13'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_14'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_15'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_16'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_17'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_18'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_19'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_20'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_21'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_22'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_23'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_24'),
        ('CIVILIZATION_MC_LITE_NUBIA',  'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MC_LITE_NUBIA_25');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Titles (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    ReligionType                    text        REFERENCES Religions(Type)                      default null,
    DefaultTitle                    text                                                        default null,
    UniqueTitle                     text                                                        default null,
    UseAdjective                    boolean                                                     default 0); 
 
INSERT INTO Civilization_JFD_Titles
        (CivilizationType,              DefaultTitle,   UniqueTitle)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), DefaultTitle,   UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_EGYPT';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(Type)                  default null,
    PoliticsType                        text                                                        default null,
    UniqueName                          text                                                        default null);
 
INSERT INTO Civilization_JFD_Politics
        (CivilizationType,              PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_MC_LITE_NUBIA'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_EGYPT';
------------------------------------------------------------            
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
        (LeaderType,            FlavorType,                          Flavor)
VALUES  ('LEADER_MC_LITE_PIYE', 'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',  4);
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_LITE_Nubia_Decisions.lua');
--==========================================================================================================================
-- SUKRITACT EVENTS
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
--CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
--INSERT INTO EventsAddin_Support (FileName) VALUES ('MC_Nubia_Events.lua');
--==========================================================================================================================
-- TOMATEKH HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions
------------------------------
UPDATE Civilization_Religions 
SET ReligionType = 'RELIGION_PESEDJET'
WHERE CivilizationType = 'CIVILIZATION_MC_LITE_NUBIA'
AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_PESEDJET');
--==========================================================================================================================   
-- JFD's and Pouakai's MERCENARIES
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT INTO Leader_Flavors
        (LeaderType,                FlavorType,                 Flavor)
VALUES  ('LEADER_MC_LITE_PIYE',    'FLAVOR_JFD_MERCENARY',      5);
--==========================================================================================================================
--==========================================================================================================================  