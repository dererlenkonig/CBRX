
--==========================================================================================================================
--==========================================================================================================================
--=======================================================================================================================
-- Bingle's Civ IV Traits
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,            TraitOne,               TraitTwo)
SELECT  'LEADER_UC_GERONIMO',     'POLICY_PROTECTIVE_X',    'POLICY_AGGRESSIVE_X'
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	


CREATE TABLE IF NOT EXISTS Civilization_JFD_CultureTypes(CivilizationType, CultureType, SplashScreenTag, SoundtrackTag);
--=======================================================================================================================
-- JFD'S Cultural Diversity
--=======================================================================================================================
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
		(CivilizationType,						ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_UC_APACHE',	ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_SHOSHONE';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Tribal_American'
WHERE Type = 'CIVILIZATION_UC_APACHE'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Tribal_American')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition(Type, X, Y, AltX, AltY);


CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_APACHE',					136,		60,		null,	null);
--==========================================================================================================================
-- Civilizations_YahemStartPosition (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition(Type, X, Y, AltX, AltY);


CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_APACHE',					18,		53,		null,	null);
--==========================================================================================================================
-- Civilizations_CordiformStartPosition (Earth Standard)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_CordiformStartPosition(Type, X, Y, AltX, AltY);


CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_APACHE',					49,		21,		null,	null);
--==========================================================================================================================
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_UC_APACHE',					8,		43,		null,	null);

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
        (CivilizationType,          LegislatureName,                                            OfficeTitle,                                                        GovernmentType,             Weight)
SELECT  'CIVILIZATION_UC_APACHE', 'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_UC_APACHE',    'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE',    'GOVERNMENT_JFD_REPUBLIC',  100
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_BRAZIL';
------------------------------------------------------------   
-- Civilization_JFD_HeadsOfGovernment  
------------------------------------------------------------   
CREATE TABLE IF NOT EXISTS  
    Civilization_JFD_HeadsOfGovernment (   
    CivilizationType                text        REFERENCES Civilizations(TYPE)                  DEFAULT NULL,
    CultureType                     text                                                        DEFAULT NULL,
    HeadOfGovernmentName            text                                                        DEFAULT NULL);
 
INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,              HeadOfGovernmentName)
VALUES  ('CIVILIZATION_UC_APACHE',    'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_1'),
        ('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_2'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_3'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_4'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_5'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_6'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_7'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_8'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_9'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_10'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_11'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_12'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_13'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_14'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_15'),
	('CIVILIZATION_UC_APACHE',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_16');
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
        ('FLAVOR_JFD_REFORM_RELIGION'),
        ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
        (LeaderType,                FlavorType,                         Flavor)
VALUES  ('LEADER_UC_GERONIMO',    'FLAVOR_JFD_REFORM_GOVERNMENT',     4),
        ('LEADER_UC_GERONIMO',    'FLAVOR_JFD_REFORM_CULTURE',        3),
        ('LEADER_UC_GERONIMO',    'FLAVOR_JFD_REFORM_ECONOMIC',       6),
        ('LEADER_UC_GERONIMO',    'FLAVOR_JFD_REFORM_FOREIGN',        7),
        ('LEADER_UC_GERONIMO',    'FLAVOR_JFD_REFORM_INDUSTRY',       6),
        ('LEADER_UC_GERONIMO',    'FLAVOR_JFD_REFORM_MILITARY',       9),
        ('LEADER_UC_GERONIMO',    'FLAVOR_JFD_REFORM_RELIGION',       6),
        ('LEADER_UC_GERONIMO',    'FLAVOR_JFD_RELIGIOUS_INTOLERANCE', 4);

--Language_en_US

insert into Language_en_US (Tag, Text)
values 

('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_1', 'Cochise'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_2', 'Dahteste'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_3', 'Lozen'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_4', 'Mangas Coloradas'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_5', 'Nana'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_6', 'Victorio'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_7', 'Taza'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_8', 'Flechas Rayada'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_9', 'Baishan'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_10', 'Juh'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_11', 'Chatto'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_12', 'Massai'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_13', 'Saguaro'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_14', 'Nanni Chaddi'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_15', 'Delshay'),
('TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_UC_APACHE_16', 'Chacon');

