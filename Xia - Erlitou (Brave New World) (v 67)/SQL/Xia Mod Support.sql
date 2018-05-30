--Decisions
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('TomatekhXiaDecisions.lua');

--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_CHINA")
		THEN "_CHINA"
		ELSE "_ASIA" END
	) WHERE Type = "CIVILIZATION_ERLITOU_MOD";

--Map Labels
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,									  CultureType,	CultureEra)
VALUES		('CIVILIZATION_ERLITOU_MOD',		         'EAST_ASIAN',		 'ANY');

--JFD
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
    Type                                        text                                        default null,
    Value                                       integer                                     default 1);

--Piety
INSERT OR REPLACE INTO Flavors
            (Type)
VALUES      ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
 
INSERT INTO Leader_Flavors
            (LeaderType,									      FlavorType,    Flavor)
VALUES      ('LEADER_XIA_YU_MOD',         'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',         3);

--Prestige
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Governments (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    LegislatureName                 text                                                        default null,
    OfficeTitle                     text                                                        default null,
    GovernmentType                  text                                                        default null,
    Weight                          integer                                                     default 0);

CREATE TABLE IF NOT EXISTS  
    Civilization_JFD_HeadsOfGovernment (    
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    HeadOfGovernmentName            text                                                        default null);

CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Titles (
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    ReligionType                    text        REFERENCES Religions(Type)                      default null,
    DefaultTitle                    text                                                        default null,
    UniqueTitle                     text                                                        default null,
    UseAdjective                    boolean                                                     default 0); 

CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(Type)                  default null,
    PoliticsType                        text                                                        default null,
    UniqueName                          text                                                        default null);

INSERT INTO Civilization_JFD_Governments
        (CivilizationType,          LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  ('CIVILIZATION_ERLITOU_MOD'), LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,          HeadOfGovernmentName)
SELECT  ('CIVILIZATION_ERLITOU_MOD'), HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO Civilization_JFD_Titles
        (CivilizationType,          DefaultTitle,   UniqueTitle)
SELECT  ('CIVILIZATION_ERLITOU_MOD'), DefaultTitle,   UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT INTO Civilization_JFD_Politics
        (CivilizationType,          PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_ERLITOU_MOD'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_CHINA';

INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_REFORM_GOVERNMENT'),
        ('FLAVOR_JFD_REFORM_CULTURE'),
        ('FLAVOR_JFD_REFORM_ECONOMIC'),
        ('FLAVOR_JFD_REFORM_FOREIGN'),
        ('FLAVOR_JFD_REFORM_INDUSTRY'),
        ('FLAVOR_JFD_REFORM_MILITARY'),
        ('FLAVOR_JFD_REFORM_RELIGION');

INSERT INTO Leader_Flavors
        (LeaderType,							            FlavorType,                         Flavor)
VALUES  ('LEADER_XIA_YU_MOD',           'FLAVOR_JFD_REFORM_GOVERNMENT',                              5),
        ('LEADER_XIA_YU_MOD',              'FLAVOR_JFD_REFORM_CULTURE',                              5),
        ('LEADER_XIA_YU_MOD',             'FLAVOR_JFD_REFORM_ECONOMIC',                              5),
        ('LEADER_XIA_YU_MOD',              'FLAVOR_JFD_REFORM_FOREIGN',                              5),
        ('LEADER_XIA_YU_MOD',             'FLAVOR_JFD_REFORM_INDUSTRY',                              8),
        ('LEADER_XIA_YU_MOD',             'FLAVOR_JFD_REFORM_RELIGION',                              2);

--Cultural Diversity
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,					ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	('CIVILIZATION_ERLITOU_MOD'),	ArtDefineTag, CultureType, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_CHINA';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Oriental'
WHERE Type = 'CIVILIZATION_ERLITOU_MOD'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Oriental')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);

--Civ IV Traits
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,									          TraitOne,					 TraitTwo)
SELECT		('LEADER_XIA_YU_MOD'),		            ('POLICY_IMPERIALISTIC_X'),	  ('POLICY_INDUSTRIOUS_X')
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Yu[ICON_CITY_STATE][ICON_PRODUCTION]'
	ELSE 'TXT_KEY_LEADER_XIA_YU_MOD_DESC' END) 
WHERE Type = 'LEADER_XIA_YU_MOD';

CREATE TRIGGER CivIVTraitsXia
AFTER INSERT ON Leaders WHEN 'LEADER_XIA_YU_MOD' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Yu[ICON_CITY_STATE][ICON_PRODUCTION]'
		ELSE 'TXT_KEY_LEADER_XIA_YU_MOD_DESC' END) 
	WHERE Type = 'LEADER_XIA_YU_MOD';
END;

--ExCE
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 						ColonyName,								LinguisticType)
VALUES		('CIVILIZATION_ERLITOU_MOD', 			null,									'JFD_Oriental');

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_ERLITOU_MOD',			'CIVILIZATION_CHINA');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_ERLITOU_MOD'),		('CIVILIZATION_SHANG_MOD')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_SHANG_MOD');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_ERLITOU_MOD'),		('CIVILIZATION_QIN_LS_MOD')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_QIN_LS_MOD');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_ERLITOU_MOD'),		('CIVILIZATION_JFD_HAN')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_HAN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_ERLITOU_MOD'),		('CIVILIZATION_TCM_SONG')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_TCM_SONG');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_ERLITOU_MOD'),		('CIVILIZATION_LITE_YUAN')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_LITE_YUAN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_ERLITOU_MOD'),		('CIVILIZATION_JFD_MING')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_MING');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_ERLITOU_MOD'),		('CIVILIZATION_JFD_QING')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_QING');

--Mercenaries 
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');

INSERT INTO Leader_Flavors
        (LeaderType,									 FlavorType,                 Flavor)
VALUES  ('LEADER_XIA_YU_MOD',                'FLAVOR_JFD_MERCENARY',                      6);

--Cultural Developments
CREATE TABLE IF NOT EXISTS 
Events_CulturalDevelopments(
	CivilizationType		text  REFERENCES Civilizations(Type)	default null,
	CultureType				text									default null,
	Description				text									default null);

INSERT INTO Events_CulturalDevelopments 
			(Description,								                      CivilizationType,						             CultureType)
VALUES		('TXT_KEY_EVENT_CULDEV_TOMATEKH_XIA_01',			    'CIVILIZATION_ERLITOU_MOD',					              'JFD_Oriental');

--Cities
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);

CREATE TABLE IF NOT EXISTS
Building_ConstructionAudio (
    BuildingType                                text    REFERENCES Buildings(Type)              default null,
    ConstructionAudio                           text											default null);
	
INSERT INTO Building_ConstructionAudio 
		(BuildingType, 				ConstructionAudio)
SELECT	'BUILDING_XIA_MOD_BRONZE_WOKRSHOP',	'AS2D_BUILDING_JFD_FORGE'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1);

--CiD
UPDATE Buildings
SET GoldMaintenance = 0
WHERE Type = 'BUILDING_XIA_MOD_BRONZE_WOKRSHOP'
AND EXISTS (SELECT Type FROM Buildings WHERE Type="BUILDING_JFD_GOVERNORS_MANSION" );

UPDATE Traits 
SET Description = 'TXT_KEY_TRAIT_DYNASTIC_CYCLE_CID_MOD'
WHERE Type = 'TRAIT_DYNASTIC_CYCLE'
AND EXISTS (SELECT Type FROM Buildings WHERE Type="BUILDING_JFD_GOVERNORS_MANSION" );

CREATE TRIGGER XiaCiDSupport
AFTER INSERT ON Buildings WHEN 'BUILDING_JFD_APOTHECARY' = NEW.Type
BEGIN

	UPDATE Buildings
	SET GoldMaintenance = 0
	WHERE Type = 'BUILDING_XIA_MOD_BRONZE_WOKRSHOP'
	AND EXISTS (SELECT Type FROM Buildings WHERE Type="BUILDING_JFD_GOVERNORS_MANSION" );

	UPDATE Traits 
	SET Description = 'TXT_KEY_TRAIT_DYNASTIC_CYCLE_CID_MOD'
	WHERE Type = 'TRAIT_DYNASTIC_CYCLE'
	AND EXISTS (SELECT Type FROM Buildings WHERE Type="BUILDING_JFD_GOVERNORS_MANSION" );

END;

--RtP
CREATE TABLE IF NOT EXISTS
    Policy_JFD_CivilizationNames (
    PolicyType                              text    REFERENCES Policies(TYPE)               DEFAULT NULL,
    CivilizationType                        text    REFERENCES Civilizations(TYPE)          DEFAULT NULL,
    Description                             text                                            DEFAULT NULL,
    ShortDescription                        text                                            DEFAULT NULL,
    Adjective                               text                                            DEFAULT NULL);
   
INSERT INTO Policy_JFD_CivilizationNames    
        (PolicyType,                    CivilizationType,               Adjective,                                  Description,												  ShortDescription)
VALUES  ('POLICY_SHANG_BLANK',			'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_SHANG_ADJECTIVE',		'TXT_KEY_CIV_JFD_XIA_SHANG_DESC',		'TXT_KEY_CIV_JFD_XIA_SHANG_SHORT_DESC'),
		('POLICY_ZHOU_DYNASTY_DUMMY',	'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_ZHOU_ADJECTIVE',		'TXT_KEY_CIV_JFD_XIA_ZHOU_DESC',		 'TXT_KEY_CIV_JFD_XIA_ZHOU_SHORT_DESC'),
		('POLICY_QIN_BLANK',			'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_QIN_ADJECTIVE',			'TXT_KEY_CIV_JFD_XIA_QIN_DESC',			  'TXT_KEY_CIV_JFD_XIA_QIN_SHORT_DESC'),
		('POLICY_HAN_DYNASTY_DUMMY',	'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_HAN_ADJECTIVE',			'TXT_KEY_CIV_JFD_XIA_HAN_DESC',			  'TXT_KEY_CIV_JFD_XIA_HAN_SHORT_DESC'),
		('POLICY_SUI_BLANK',			'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_SUI_ADJECTIVE',			'TXT_KEY_CIV_JFD_XIA_SUI_DESC',			  'TXT_KEY_CIV_JFD_XIA_SUI_SHORT_DESC'),
		('POLICY_TANG_BLANK',			'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_TANG_ADJECTIVE',		'TXT_KEY_CIV_JFD_XIA_TANG_DESC',		 'TXT_KEY_CIV_JFD_XIA_TANG_SHORT_DESC'),
		('POLICY_SONG_BLANK',			'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_SONG_ADJECTIVE',		'TXT_KEY_CIV_JFD_XIA_SONG_DESC',		 'TXT_KEY_CIV_JFD_XIA_SONG_SHORT_DESC'),
		('POLICY_YUAN_BLANK',			'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_YUAN_ADJECTIVE',		'TXT_KEY_CIV_JFD_XIA_YUAN_DESC',		 'TXT_KEY_CIV_JFD_XIA_YUAN_SHORT_DESC'),
		('POLICY_MING_BLANK',			'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_MING_ADJECTIVE',		'TXT_KEY_CIV_JFD_XIA_MING_DESC',		 'TXT_KEY_CIV_JFD_XIA_MING_SHORT_DESC'),
		('POLICY_QING_DYNASTY_DUMMY',	'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_QING_ADJECTIVE',		'TXT_KEY_CIV_JFD_XIA_QING_DESC',		 'TXT_KEY_CIV_JFD_XIA_QING_SHORT_DESC'),
		('POLICY_CHINA_DYNASTY_DUMMY',  'CIVILIZATION_ERLITOU_MOD',    'TXT_KEY_CIV_JFD_XIA_CHINA_ADJECTIVE',		'TXT_KEY_CIV_JFD_XIA_CHINA_DESC',		'TXT_KEY_CIV_JFD_XIA_CHINA_SHORT_DESC');






