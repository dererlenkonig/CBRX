--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_SENSHI_EVENKS',	79,	80);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_SENSHI_EVENKS',	100, 69);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Cordiform)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,							X,	Y)
VALUES	('CIVILIZATION_SENSHI_EVENKS',	46, 44);
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_SENSHI_EVENKS',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_MONGOL';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_SENSHI_EVENKS',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_MONGOL';
--==========================================================================================================================
-- Historical Religions
--==========================================================================================================================
UPDATE Civilization_Religions SET ReligionType =
        ( CASE WHEN EXISTS(SELECT TYPE FROM Religions WHERE TYPE='RELIGION_SAMAN' )
                THEN 'RELIGION_SAMAN'
                ELSE 'RELIGION_TENGRIISM' END
        ) WHERE CivilizationType = 'CIVILIZATION_SENSHI_EVENKS';
 
CREATE TRIGGER EvenksReligion
AFTER INSERT ON Religions WHEN 'RELIGION_SAMAN' = NEW.TYPE
BEGIN
        UPDATE Civilization_Religions
        SET ReligionType = 'RELIGION_SAMAN'
        WHERE CivilizationType IN ('CIVILIZATION_SENSHI_EVENKS');
END;
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_MONGOL'
WHERE Type = 'CIVILIZATION_SENSHI_EVENKS'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_MONGOL');
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,						CultureType,	CultureEra)
SELECT	'CIVILIZATION_SENSHI_EVENKS',	CultureType,	CultureEra
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_MONGOL';
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
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
    CivilizationType                             text     REFERENCES Civilizations(Type)             default null,
    CultureType                                 text                                            default null,
    ArtDefineTag                                text                                            default    null,
    DefeatScreenEarlyTag                        text                                            default    null,
    DefeatScreenMidTag                            text                                            default    null,
    DefeatScreenLateTag                            text                                            default    null,
    IdealsTag                                    text                                            default    null,
    SplashScreenTag                                text                                            default    null,
    SoundtrackTag                                text                                            default    null,
    UnitDialogueTag                                text                                            default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType,	 IdealsTag,		SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_SENSHI_EVENKS',	'JFD_Polar', 'JFD_Polar', 'JFD_Polar',	'JFD_Polar',	 'JFD_Polar', UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_MONGOL';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Polar'
WHERE Type = 'CIVILIZATION_SENSHI_EVENKS'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Polar')
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
VALUES	('LEADER_SENSHI_BOMBOGOR',	'FLAVOR_JFD_MERCENARY',		3);
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
SELECT	'CIVILIZATION_SENSHI_EVENKS',	LegislatureName,	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SENSHI_EVENKS',	'GOVERNMENT_JFD_THEOCRACY',	80
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
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
VALUES  ('CIVILIZATION_SENSHI_EVENKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SENSHI_EVENKS_1'),
        ('CIVILIZATION_SENSHI_EVENKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SENSHI_EVENKS_2'),
        ('CIVILIZATION_SENSHI_EVENKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SENSHI_EVENKS_3');
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
VALUES	('LEADER_SENSHI_BOMBOGOR',	'FLAVOR_JFD_REFORM_GOVERNMENT',		2),
		('LEADER_SENSHI_BOMBOGOR',	'FLAVOR_JFD_REFORM_CULTURE',		3),
		('LEADER_SENSHI_BOMBOGOR',	'FLAVOR_JFD_REFORM_ECONOMIC',		3),
		('LEADER_SENSHI_BOMBOGOR',	'FLAVOR_JFD_REFORM_FOREIGN',		7),
		('LEADER_SENSHI_BOMBOGOR',	'FLAVOR_JFD_REFORM_INDUSTRY',		2),
		('LEADER_SENSHI_BOMBOGOR',	'FLAVOR_JFD_REFORM_MILITARY',		4),
		('LEADER_SENSHI_BOMBOGOR',	'FLAVOR_JFD_REFORM_RELIGION',		9),
		('LEADER_SENSHI_BOMBOGOR',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	10);
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
SELECT	'CIVILIZATION_SENSHI_EVENKS',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_MONGOL';
--==========================================================================================================================
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
        (LeaderType,            TraitOne,                    TraitTwo)
SELECT  'LEADER_SENSHI_BOMBOGOR',     'POLICY_SPIRITUAL_X',    'POLICY_PROTECTIVE_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Bombogor [ICON_PEACE][ICON_STRENGTH]'
WHERE Type = 'LEADER_SENSHI_BOMBOGOR'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_SPIRITUAL_X');
--==========================================================================================================================