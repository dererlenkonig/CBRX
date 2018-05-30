--Decisions
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('TomatekhXinguDecisions.lua');

CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('TomatekhXinguEvents.lua');

--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_INCA")
		THEN "_INCA"
		ELSE "_AMER" END
	) WHERE Type = "CIVILIZATION_XINGU_MOD";

--Map Labels
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,							    CultureType,	CultureEra)
VALUES		('CIVILIZATION_XINGU_MOD',  'MOD_TP_SOUTH_AMERICAN',	     'ANY');

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
VALUES      ('LEADER_XINGU_MOD',          'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',         4);

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
SELECT  ('CIVILIZATION_XINGU_MOD'), LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_INCA';

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,          HeadOfGovernmentName)
SELECT  ('CIVILIZATION_XINGU_MOD'), HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE CivilizationType = 'CIVILIZATION_INCA';

INSERT INTO Civilization_JFD_Titles
        (CivilizationType,                                                    DefaultTitle,                               UniqueTitle)
VALUES  ('CIVILIZATION_XINGU_MOD',      'TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_LEADER',     'TXT_KEY_GOVERNMENT_JFD_XINGU_PRINCE'),
		('CIVILIZATION_XINGU_MOD',          'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER',       'TXT_KEY_GOVERNMENT_JFD_XINGU_KING'),
		('CIVILIZATION_XINGU_MOD',            'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER',    'TXT_KEY_GOVERNMENT_JFD_XINGU_EMPEROR');

INSERT INTO Civilization_JFD_Politics
        (CivilizationType,                   PoliticsType,                          UniqueName)
VALUES  ('CIVILIZATION_XINGU_MOD',     'PARTY_JFD_CLERGY',    'TXT_KEY_JFD_PARTY_XINGU_CLERGY'),
		('CIVILIZATION_XINGU_MOD',   'PARTY_JFD_NOBILITY',  'TXT_KEY_JFD_PARTY_XINGU_NOBILITY');

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
VALUES  ('LEADER_XINGU_MOD',			'FLAVOR_JFD_REFORM_GOVERNMENT',                              3),
        ('LEADER_XINGU_MOD',			   'FLAVOR_JFD_REFORM_CULTURE',                              7),
        ('LEADER_XINGU_MOD',			  'FLAVOR_JFD_REFORM_ECONOMIC',                              4),
        ('LEADER_XINGU_MOD',			   'FLAVOR_JFD_REFORM_FOREIGN',                              7),
        ('LEADER_XINGU_MOD',			  'FLAVOR_JFD_REFORM_INDUSTRY',                              3),
        ('LEADER_XINGU_MOD',			  'FLAVOR_JFD_REFORM_RELIGION',                              5);

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
SELECT	('CIVILIZATION_XINGU_MOD'),	('JFD_Katuje'), ('JFD_Katuje'), ('JFD_Katuje'), ('JFD_Katuje'), ('AS2D_SOUND_JFD_TUPI')
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_INCA';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Katuje'
WHERE Type = 'CIVILIZATION_XINGU_MOD'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Katuje')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);

--Civ IV Traits
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);

INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,									          TraitOne,					   TraitTwo)
SELECT		('LEADER_XINGU_MOD'),		               ('POLICY_MERCANTILE_X'),	    ('POLICY_INDUSTRIOUS_X')
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Kusétani[ICON_GOLD][ICON_PRODUCTION]'
	ELSE 'TXT_KEY_LEADER_XINGU_MOD_DESC' END) 
WHERE Type = 'LEADER_XINGU_MOD';

CREATE TRIGGER CivIVTraitsXingu
AFTER INSERT ON Leaders WHEN 'LEADER_XINGU_MOD' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Kusétani[ICON_GOLD][ICON_PRODUCTION]'
		ELSE 'TXT_KEY_LEADER_XINGU_MOD_DESC' END) 
	WHERE Type = 'LEADER_XINGU_MOD';
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
VALUES		('CIVILIZATION_XINGU_MOD', 			          null,						     'JFD_Quechumaran');

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,							RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_XINGU_MOD',			                 'CIVILIZATION_BRAZIL');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_XINGU_MOD'),		('CIVILIZATION_TUPI')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_TUPI');

UPDATE Traits SET Description = 
	( CASE WHEN EXISTS(SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_JUNGLE_IMMUNITY' )
		THEN 'TXT_KEY_TRAIT_GARDEN_CITIES_EXCE'
		ELSE 'TXT_KEY_TRAIT_GARDEN_CITIES' END 
	) WHERE Type = 'TRAIT_GARDEN_CITIES';

CREATE TRIGGER GardenCitiesExCE
AFTER INSERT ON UnitPromotions WHEN 'PROMOTION_JFD_JUNGLE_IMMUNITY' = NEW.Type
BEGIN
	UPDATE Traits SET Description = 
		( CASE WHEN EXISTS(SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_JUNGLE_IMMUNITY' )
			THEN 'TXT_KEY_TRAIT_GARDEN_CITIES_EXCE'
			ELSE 'TXT_KEY_TRAIT_GARDEN_CITIES' END 
		) WHERE Type = 'TRAIT_GARDEN_CITIES';
END;

--Mercenaries 
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');

INSERT INTO Leader_Flavors
        (LeaderType,									 FlavorType,                  Flavor)
VALUES  ('LEADER_XINGU_MOD',                 'FLAVOR_JFD_MERCENARY',                       4);

--Cultural Developments
CREATE TABLE IF NOT EXISTS 
Events_CulturalDevelopments(
	CivilizationType		text  REFERENCES Civilizations(Type)	default null,
	CultureType				text									default null,
	Description				text									default null);

INSERT INTO Events_CulturalDevelopments 
			(Description,								                      CivilizationType,						           CultureType)
VALUES		('TXT_KEY_EVENT_CULDEV_TOMATEKH_XINGU_01',			      'CIVILIZATION_XINGU_MOD',					              'JFD_Katuje');

--Gedemo Amazonia
INSERT INTO Civilization_FreeTechs
		   (CivilizationType,												       			   TechType)
SELECT	   ('CIVILIZATION_XINGU_MOD'),							                       ('TECH_AMAZONIA')
WHERE EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_AMAZONIA');

CREATE TRIGGER XinguGedAmz
AFTER INSERT ON Technologies WHEN 'TECH_AMAZONIA' = NEW.Type
BEGIN
	INSERT INTO Civilization_FreeTechs
			   (CivilizationType,												       			   TechType)
	SELECT	   ('CIVILIZATION_XINGU_MOD'),							                       ('TECH_AMAZONIA')
	WHERE EXISTS (SELECT Type FROM Technologies WHERE Type = 'TECH_AMAZONIA');
END;

--Future Worlds
INSERT INTO Unit_Builds
			(UnitType,						                   BuildType)
SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_COMM_ARRAY')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_COMM_ARRAY');

INSERT INTO Unit_Builds
			(UnitType,						                     BuildType)
SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_NETWORK_NODE')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_NETWORK_NODE');

INSERT INTO Unit_Builds
			(UnitType,						                         BuildType)
SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_HYDROPONICS_DOME')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_HYDROPONICS_DOME');

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_INDUSTRIAL_COMPLEX')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_INDUSTRIAL_COMPLEX');

INSERT INTO Unit_Builds
			(UnitType,						                 BuildType)
SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_PRESERVE')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_PRESERVE');

INSERT INTO Unit_Builds
			(UnitType,						                 BuildType)
SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_GENERATOR')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_GENERATOR');

INSERT INTO Unit_Builds
			(UnitType,						                BuildType)
SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_BIOWELL')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_BIOWELL');

INSERT INTO Unit_Builds
			(UnitType,						             BuildType)
SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_CORE')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_CORE');

INSERT INTO Unit_Builds
			(UnitType,						                   BuildType)
SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_COMM_ARRAY')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_COMM_ARRAY');

INSERT INTO Unit_Builds
			(UnitType,						                     BuildType)
SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_NETWORK_NODE')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_NETWORK_NODE');

INSERT INTO Unit_Builds
			(UnitType,						                         BuildType)
SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_HYDROPONICS_DOME')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_HYDROPONICS_DOME');

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_INDUSTRIAL_COMPLEX')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_INDUSTRIAL_COMPLEX');

INSERT INTO Unit_Builds
			(UnitType,						                 BuildType)
SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_PRESERVE')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_PRESERVE');

INSERT INTO Unit_Builds
			(UnitType,						                 BuildType)
SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_GENERATOR')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_GENERATOR');

INSERT INTO Unit_Builds
			(UnitType,						                BuildType)
SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_BIOWELL')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_BIOWELL');

INSERT INTO Unit_Builds
			(UnitType,						             BuildType)
SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_CORE')
WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_CORE');

CREATE TRIGGER XinguFuture
AFTER INSERT ON Builds WHEN 'BUILD_FW_CORE' = NEW.Type
BEGIN

	INSERT INTO Unit_Builds
				(UnitType,						                   BuildType)
	SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_COMM_ARRAY')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_COMM_ARRAY');

	INSERT INTO Unit_Builds
				(UnitType,						                     BuildType)
	SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_NETWORK_NODE')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_NETWORK_NODE');

	INSERT INTO Unit_Builds
				(UnitType,						                         BuildType)
	SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_HYDROPONICS_DOME')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_HYDROPONICS_DOME');

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_INDUSTRIAL_COMPLEX')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_INDUSTRIAL_COMPLEX');

	INSERT INTO Unit_Builds
				(UnitType,						                 BuildType)
	SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_PRESERVE')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_PRESERVE');

	INSERT INTO Unit_Builds
				(UnitType,						                 BuildType)
	SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_GENERATOR')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_GENERATOR');

	INSERT INTO Unit_Builds
				(UnitType,						                BuildType)
	SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_BIOWELL')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_BIOWELL');

	INSERT INTO Unit_Builds
				(UnitType,						             BuildType)
	SELECT		('UNIT_XINGU_WORKER'),		          ('BUILD_FW_CORE')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_CORE');

	INSERT INTO Unit_Builds
				(UnitType,						                   BuildType)
	SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_COMM_ARRAY')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_COMM_ARRAY');

	INSERT INTO Unit_Builds
				(UnitType,						                     BuildType)
	SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_NETWORK_NODE')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_NETWORK_NODE');

	INSERT INTO Unit_Builds
				(UnitType,						                         BuildType)
	SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_HYDROPONICS_DOME')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_HYDROPONICS_DOME');

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_INDUSTRIAL_COMPLEX')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_INDUSTRIAL_COMPLEX');

	INSERT INTO Unit_Builds
				(UnitType,						                 BuildType)
	SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_PRESERVE')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_PRESERVE');

	INSERT INTO Unit_Builds
				(UnitType,						                 BuildType)
	SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_GENERATOR')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_GENERATOR');

	INSERT INTO Unit_Builds
				(UnitType,						                BuildType)
	SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_BIOWELL')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_BIOWELL');

	INSERT INTO Unit_Builds
				(UnitType,						             BuildType)
	SELECT		('UNIT_XINGU_AI_WORKER'),		          ('BUILD_FW_CORE')
	WHERE EXISTS (SELECT Type FROM Builds WHERE Type = 'BUILD_FW_CORE');

END;

--CID
UPDATE Builds
SET Recommendation = 'TXT_KEY_BUILD_JFD_TRADING_POST_REC', Help = 'TXT_KEY_BUILD_JFD_TRADING_POST_HELP', PrereqTech = 'TECH_TRAPPING', ImprovementType = 'IMPROVEMENT_JFD_TRADING_POST'
WHERE Type = 'BUILD_TRADING_POST_XINGU'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_PROVINCES_IMPROVEMENT_CHANGES_TRADING_POST' AND Value = 1);

CREATE TRIGGER XinguTradingPost
AFTER INSERT ON Improvements WHEN 'IMPROVEMENT_JFD_TOWN' = NEW.Type
BEGIN
	UPDATE Builds
	SET Recommendation = 'TXT_KEY_BUILD_JFD_TRADING_POST_REC', Help = 'TXT_KEY_BUILD_JFD_TRADING_POST_HELP', PrereqTech = 'TECH_TRAPPING', ImprovementType = 'IMPROVEMENT_JFD_TRADING_POST'
	WHERE Type = 'BUILD_TRADING_POST_XINGU'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_PROVINCES_IMPROVEMENT_CHANGES_TRADING_POST' AND Value = 1);
END;

--
INSERT INTO UnitClasses 
		(Type,						                      Description,				DefaultUnit)
SELECT	'UNITCLASS_JFD_WORKER_XINGU',		'TXT_KEY_UNIT_JFD_WORKER', 	 'UNIT_JFD_WORKER_XINGU'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Civilization_UnitClassOverrides	
		(CivilizationType, 			UnitClassType, 				UnitType)
SELECT 	'CIVILIZATION_BARBARIAN',   'UNITCLASS_JFD_WORKER_XINGU', 	null
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Civilization_UnitClassOverrides	
		(CivilizationType, 			UnitClassType, 				UnitType)
SELECT 	'CIVILIZATION_MINOR',	    'UNITCLASS_JFD_WORKER_XINGU', 	null
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

--
INSERT INTO Units 
		(Type,											  Class,		Cost,	ShowInPedia,	ExtraMaintenanceCost,	HurryCostModifier,	AdvancedStartCost, 	WorkRate,		CivilianAttackPriority, 			Capture, 				Moves,	Unhappiness, 	BaseHurry,  HurryMultiplier, WorkRate, 	Domain,			DefaultUnitAI,		Description,					Civilopedia,						Strategy,								Help,								UnitArtInfo,				IconAtlas,		PortraitIndex,	UnitFlagAtlas,		UnitFlagIconOffset,		MoveRate)
SELECT	'UNIT_JFD_WORKER_XINGU',	'UNITCLASS_JFD_WORKER_XINGU',		  -1,			  0,						1,				    0,				   35,		 150,		'CIVILIAN_ATTACK_PRIORITY_LOW',		'UNITCLASS_WORKER',		2,		0, 				0, 			0, 				 50, 		'DOMAIN_LAND',	'UNITAI_WORKER',	'TXT_KEY_UNIT_JFD_WORKER',		'TXT_KEY_CIV5_JFD_WORKER_TEXT',		'TXT_KEY_UNIT_JFD_WORKER_STRATEGY',		'TXT_KEY_UNIT_HELP_JFD_WORKER', 	'ART_DEF_UNIT_JFD_WORKER',	'UNIT_ATLAS_2',	43,				'UNIT_FLAG_ATLAS',	1,						'BIPED'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

--
UPDATE Units
SET UnitArtInfoEraVariation = 0, ExtraMaintenanceCost = 0, WorkRate = 75
WHERE Class = 'UNITCLASS_XINGU_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

UPDATE Units
SET UnitArtInfoEraVariation = 0, ExtraMaintenanceCost = 0, WorkRate = 75
WHERE Class = 'UNITCLASS_XINGU_AI_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_ClassUpgrades
		(UnitType, 			UnitClassType)
SELECT 	'UNIT_XINGU_WORKER',		'UNITCLASS_JFD_WORKER'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_ClassUpgrades
		(UnitType, 			UnitClassType)
SELECT 	'UNIT_XINGU_AI_WORKER',		'UNITCLASS_JFD_WORKER'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

UPDATE Units
SET Description = 'TXT_KEY_UNIT_JFD_PEASANT', Strategy = 'TXT_KEY_UNIT_JFD_PEASANT_STRATEGY', Help = 'TXT_KEY_UNIT_JFD_PEASANT_HELP', Civilopedia = 'TXT_KEY_UNIT_JFD_PEASANT_PEDIA'
WHERE Type = 'UNIT_XINGU_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

UPDATE Units
SET Description = 'TXT_KEY_UNIT_JFD_PEASANT', Strategy = 'TXT_KEY_UNIT_JFD_PEASANT_STRATEGY', Help = 'TXT_KEY_UNIT_JFD_PEASANT_HELP', Civilopedia = 'TXT_KEY_UNIT_JFD_PEASANT_PEDIA'
WHERE Type = 'UNIT_XINGU_AI_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

DELETE FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_WORKER' AND BuildType = 'BUILD_RAILROAD'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

DELETE FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_AI_WORKER' AND BuildType = 'BUILD_RAILROAD'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

--
INSERT INTO Unit_AITypes 
		(UnitType,			UnitAIType)
SELECT	'UNIT_JFD_WORKER_XINGU',	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Flavors 
		(UnitType,			FlavorType, Flavor)
SELECT	'UNIT_JFD_WORKER_XINGU',	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

--
INSERT INTO Unit_Builds 
		(UnitType,							   BuildType)
SELECT	('UNIT_JFD_WORKER_XINGU'),	('BUILD_JFD_VILLAGE')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_PROVINCES_IMPROVEMENT_CHANGES_TRADING_POST' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_ROAD')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_RAILROAD')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_FARM_XINGU')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_MINE_XINGU')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_TRADING_POST_XINGU')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_LUMBERMILL')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_PASTURE_XINGU')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_CAMP')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_PLANTATION_XINGU')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_QUARRY_XINGU')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_WELL_XINGU')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_FORT_XINGU')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REMOVE_JUNGLE')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REMOVE_MARSH')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REMOVE_FOREST')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_SCRUB_FALLOUT')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REPAIR')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Unit_Builds
			(UnitType,						                           BuildType)
SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REMOVE_ROUTE')
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

--
--
--

CREATE TRIGGER XinguSlaveChanges
AFTER INSERT ON Units WHEN 'UNIT_JFD_SLAVE' = NEW.Type
BEGIN

	INSERT INTO UnitClasses 
			(Type,						                      Description,				DefaultUnit)
	SELECT	'UNITCLASS_JFD_WORKER_XINGU',		'TXT_KEY_UNIT_JFD_WORKER', 	 'UNIT_JFD_WORKER_XINGU'
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Civilization_UnitClassOverrides	
			(CivilizationType, 			UnitClassType, 				UnitType)
	SELECT 	'CIVILIZATION_BARBARIAN',   'UNITCLASS_JFD_WORKER_XINGU', 	null
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Civilization_UnitClassOverrides	
			(CivilizationType, 			UnitClassType, 				UnitType)
	SELECT 	'CIVILIZATION_MINOR',	    'UNITCLASS_JFD_WORKER_XINGU', 	null
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	--
	INSERT INTO Units 
			(Type,											  Class,		Cost,	ShowInPedia,	ExtraMaintenanceCost,	HurryCostModifier,	AdvancedStartCost, 	WorkRate,		CivilianAttackPriority, 			Capture, 				Moves,	Unhappiness, 	BaseHurry,  HurryMultiplier, WorkRate, 	Domain,			DefaultUnitAI,		Description,					Civilopedia,						Strategy,								Help,								UnitArtInfo,				IconAtlas,		PortraitIndex,	UnitFlagAtlas,		UnitFlagIconOffset,		MoveRate)
	SELECT	'UNIT_JFD_WORKER_XINGU',	'UNITCLASS_JFD_WORKER_XINGU',		  -1,			  0,						1,				    0,				   35,		 150,		'CIVILIAN_ATTACK_PRIORITY_LOW',		'UNITCLASS_WORKER',		2,		0, 				0, 			0, 				 50, 		'DOMAIN_LAND',	'UNITAI_WORKER',	'TXT_KEY_UNIT_JFD_WORKER',		'TXT_KEY_CIV5_JFD_WORKER_TEXT',		'TXT_KEY_UNIT_JFD_WORKER_STRATEGY',		'TXT_KEY_UNIT_HELP_JFD_WORKER', 	'ART_DEF_UNIT_JFD_WORKER',	'UNIT_ATLAS_2',	43,				'UNIT_FLAG_ATLAS',	1,						'BIPED'
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	--
	UPDATE Units
	SET UnitArtInfoEraVariation = 0, ExtraMaintenanceCost = 0, WorkRate = 75
	WHERE Class = 'UNITCLASS_XINGU_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	UPDATE Units
	SET UnitArtInfoEraVariation = 0, ExtraMaintenanceCost = 0, WorkRate = 75
	WHERE Class = 'UNITCLASS_XINGU_AI_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_ClassUpgrades
			(UnitType, 			UnitClassType)
	SELECT 	'UNIT_XINGU_WORKER',		'UNITCLASS_JFD_WORKER'
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_ClassUpgrades
			(UnitType, 			UnitClassType)
	SELECT 	'UNIT_XINGU_AI_WORKER',		'UNITCLASS_JFD_WORKER'
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	UPDATE Units
	SET Description = 'TXT_KEY_UNIT_JFD_PEASANT', Strategy = 'TXT_KEY_UNIT_JFD_PEASANT_STRATEGY', Help = 'TXT_KEY_UNIT_JFD_PEASANT_HELP', Civilopedia = 'TXT_KEY_UNIT_JFD_PEASANT_PEDIA'
	WHERE Type = 'UNIT_XINGU_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	UPDATE Units
	SET Description = 'TXT_KEY_UNIT_JFD_PEASANT', Strategy = 'TXT_KEY_UNIT_JFD_PEASANT_STRATEGY', Help = 'TXT_KEY_UNIT_JFD_PEASANT_HELP', Civilopedia = 'TXT_KEY_UNIT_JFD_PEASANT_PEDIA'
	WHERE Type = 'UNIT_XINGU_AI_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	DELETE FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_WORKER' AND BuildType = 'BUILD_RAILROAD'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	DELETE FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_AI_WORKER' AND BuildType = 'BUILD_RAILROAD'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	--
	INSERT INTO Unit_AITypes 
			(UnitType,			UnitAIType)
	SELECT	'UNIT_JFD_WORKER_XINGU',	UnitAIType
	FROM Unit_AITypes WHERE UnitType = 'UNIT_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Flavors 
			(UnitType,			FlavorType, Flavor)
	SELECT	'UNIT_JFD_WORKER_XINGU',	FlavorType, Flavor
	FROM Unit_Flavors WHERE UnitType = 'UNIT_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	--
	INSERT INTO Unit_Builds 
			(UnitType,							   BuildType)
	SELECT	('UNIT_JFD_WORKER_XINGU'),	('BUILD_JFD_VILLAGE')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1)
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_PROVINCES_IMPROVEMENT_CHANGES_TRADING_POST' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_ROAD')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_RAILROAD')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_FARM_XINGU')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_MINE_XINGU')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_TRADING_POST_XINGU')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_LUMBERMILL')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_PASTURE_XINGU')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_CAMP')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_PLANTATION_XINGU')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_QUARRY_XINGU')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_WELL_XINGU')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_FORT_XINGU')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REMOVE_JUNGLE')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REMOVE_MARSH')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REMOVE_FOREST')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_SCRUB_FALLOUT')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REPAIR')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Unit_Builds
				(UnitType,						                           BuildType)
	SELECT		('UNIT_JFD_WORKER_XINGU'),		                       ('BUILD_REMOVE_ROUTE')
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

END;

--Charges
CREATE TABLE IF NOT EXISTS
	Unit_JFD_BuildCharges (
	UnitType													text	 										default null,
	NumCharges  												integer 										default 0);	

CREATE TABLE IF NOT EXISTS
    Build_JFD_ChargeCosts (
    BuildType                                                    text                                             default null,
    UnitType                                                    text     REFERENCES Units(Type)                 default null,
    ChargeCost                                                  integer                                            default 0,
    RequiresPolicy                                              text     REFERENCES Policies(Type)                 default null);

UPDATE Units
SET Strategy = 'TXT_KEY_UNIT_JFD_PEASANT_STRATEGY_CHARGES', Help = 'TXT_KEY_UNIT_JFD_PEASANT_HELP_CHARGES'
WHERE Type = 'UNIT_XINGU_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_UNIT_ADDITIONS_SLAVE_WORKER' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

UPDATE Units
SET WorkRate = 1000
WHERE Type = 'UNIT_XINGU_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

INSERT INTO Unit_JFD_BuildCharges
		(UnitType,			NumCharges)
SELECT	Type,				3
FROM Units WHERE Class = 'UNITCLASS_XINGU_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

UPDATE Units
SET Strategy = 'TXT_KEY_UNIT_JFD_PEASANT_STRATEGY_CHARGES', Help = 'TXT_KEY_UNIT_JFD_PEASANT_HELP_CHARGES'
WHERE Type = 'UNIT_XINGU_AI_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_UNIT_ADDITIONS_SLAVE_WORKER' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

UPDATE Units
SET WorkRate = 1000
WHERE Type = 'UNIT_XINGU_AI_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

INSERT INTO Unit_JFD_BuildCharges
		(UnitType,			NumCharges)
SELECT	Type,				3
FROM Units WHERE Class = 'UNITCLASS_XINGU_AI_WORKER'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

UPDATE Units
SET Strategy = 'TXT_KEY_UNIT_JFD_WORKER_STRATEGY_CHARGES', Help = 'TXT_KEY_UNIT_HELP_JFD_WORKER_CHARGES'
WHERE Type = 'UNIT_JFD_WORKER_XINGU'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_UNIT_ADDITIONS_SLAVE_WORKER' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

INSERT INTO Unit_JFD_BuildCharges
		(UnitType,			NumCharges)
SELECT	Type,				5
FROM Units WHERE Class = 'UNITCLASS_JFD_WORKER_XINGU'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

UPDATE Builds
SET Time = null
WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR'))
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES_EXCLUDES_REMOVING' AND Value = 0);

UPDATE Builds
SET Time = null
WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR', 'BUILD_REMOVE_JUNGLE', 'BUILD_REMOVE_FOREST', 'BUILD_REMOVE_MARSH', 'BUILD_SCRUB_FALLOUT'))
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES_EXCLUDES_REMOVING' AND Value = 1);

UPDATE Builds
SET Time = null
WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_AI_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR'))
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES_EXCLUDES_REMOVING' AND Value = 0);

UPDATE Builds
SET Time = null
WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_AI_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR', 'BUILD_REMOVE_JUNGLE', 'BUILD_REMOVE_FOREST', 'BUILD_REMOVE_MARSH', 'BUILD_SCRUB_FALLOUT'))
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES_EXCLUDES_REMOVING' AND Value = 1);

INSERT INTO Build_JFD_ChargeCosts 
			(BuildType,								                      UnitType,						  ChargeCost)
VALUES		('BUILD_FARM_XINGU',								'UNIT_XINGU_WORKER',					           1),
			('BUILD_MINE_XINGU',								'UNIT_XINGU_WORKER',					           1),
			('BUILD_TRADING_POST_XINGU',						'UNIT_XINGU_WORKER',					           1),
			('BUILD_PASTURE_XINGU',								'UNIT_XINGU_WORKER',					           1),
			('BUILD_PLANTATION_XINGU',							'UNIT_XINGU_WORKER',					           1),
			('BUILD_QUARRY_XINGU',								'UNIT_XINGU_WORKER',					           1),
			('BUILD_WELL_XINGU',								'UNIT_XINGU_WORKER',					           1),
			('BUILD_FORT_XINGU',								'UNIT_XINGU_WORKER',					           1),	
			('BUILD_FARM_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
			('BUILD_MINE_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
			('BUILD_TRADING_POST_XINGU',						'UNIT_XINGU_AI_WORKER',					           1),
			('BUILD_PASTURE_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
			('BUILD_PLANTATION_XINGU',							'UNIT_XINGU_AI_WORKER',					           1),
			('BUILD_QUARRY_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
			('BUILD_WELL_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
			('BUILD_FORT_XINGU',								'UNIT_XINGU_AI_WORKER',					           1);

INSERT INTO Build_JFD_ChargeCosts 
			(BuildType,								    UnitType,				      ChargeCost)
SELECT		('BUILD_FARM_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Build_JFD_ChargeCosts 
			(BuildType,								    UnitType,				      ChargeCost)
SELECT		('BUILD_MINE_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Build_JFD_ChargeCosts 
			(BuildType,								    UnitType,				      ChargeCost)
SELECT		('BUILD_TRADING_POST_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Build_JFD_ChargeCosts 
			(BuildType,								    UnitType,				      ChargeCost)
SELECT		('BUILD_PASTURE_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Build_JFD_ChargeCosts 
			(BuildType,								    UnitType,				      ChargeCost)
SELECT		('BUILD_PLANTATION_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Build_JFD_ChargeCosts 
			(BuildType,								    UnitType,				      ChargeCost)
SELECT		('BUILD_QUARRY_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Build_JFD_ChargeCosts 
			(BuildType,								    UnitType,				      ChargeCost)
SELECT		('BUILD_WELL_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

INSERT INTO Build_JFD_ChargeCosts 
			(BuildType,								    UnitType,				      ChargeCost)
SELECT		('BUILD_FORT_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

---

CREATE TRIGGER XinguChargeChanges
AFTER INSERT ON Units WHEN 'UNIT_JFD_WORKER' = NEW.Type
BEGIN

	UPDATE Units
	SET Strategy = 'TXT_KEY_UNIT_JFD_PEASANT_STRATEGY_CHARGES', Help = 'TXT_KEY_UNIT_JFD_PEASANT_HELP_CHARGES'
	WHERE Type = 'UNIT_XINGU_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1)
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_UNIT_ADDITIONS_SLAVE_WORKER' AND Value = 1)
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

	UPDATE Units
	SET WorkRate = 1000
	WHERE Type = 'UNIT_XINGU_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

	INSERT INTO Unit_JFD_BuildCharges
			(UnitType,			NumCharges)
	SELECT	Type,				3
	FROM Units WHERE Class = 'UNITCLASS_XINGU_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

	UPDATE Units
	SET Strategy = 'TXT_KEY_UNIT_JFD_PEASANT_STRATEGY_CHARGES', Help = 'TXT_KEY_UNIT_JFD_PEASANT_HELP_CHARGES'
	WHERE Type = 'UNIT_XINGU_AI_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1)
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_UNIT_ADDITIONS_SLAVE_WORKER' AND Value = 1)
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

	UPDATE Units
	SET WorkRate = 1000
	WHERE Type = 'UNIT_XINGU_AI_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

	INSERT INTO Unit_JFD_BuildCharges
			(UnitType,			NumCharges)
	SELECT	Type,				3
	FROM Units WHERE Class = 'UNITCLASS_XINGU_AI_WORKER'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

	UPDATE Units
	SET Strategy = 'TXT_KEY_UNIT_JFD_WORKER_STRATEGY_CHARGES', Help = 'TXT_KEY_UNIT_HELP_JFD_WORKER_CHARGES'
	WHERE Type = 'UNIT_JFD_WORKER_XINGU'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1)
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_UNIT_ADDITIONS_SLAVE_WORKER' AND Value = 1)
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

	INSERT INTO Unit_JFD_BuildCharges
			(UnitType,			NumCharges)
	SELECT	Type,				5
	FROM Units WHERE Class = 'UNITCLASS_JFD_WORKER_XINGU'
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1);

	UPDATE Builds
	SET Time = null
	WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR'))
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1)
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES_EXCLUDES_REMOVING' AND Value = 0);

	UPDATE Builds
	SET Time = null
	WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR', 'BUILD_REMOVE_JUNGLE', 'BUILD_REMOVE_FOREST', 'BUILD_REMOVE_MARSH', 'BUILD_SCRUB_FALLOUT'))
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES_EXCLUDES_REMOVING' AND Value = 1);

	UPDATE Builds
	SET Time = null
	WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_AI_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR'))
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES' AND Value = 1)
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES_EXCLUDES_REMOVING' AND Value = 0);

	UPDATE Builds
	SET Time = null
	WHERE Type IN (SELECT BuildType FROM Unit_Builds WHERE UnitType = 'UNIT_XINGU_AI_WORKER' AND BuildType NOT IN ('BUILD_ROAD', 'BUILD_RAILROAD', 'BUILD_REMOVE_ROUTE', 'BUILD_REPAIR', 'BUILD_REMOVE_JUNGLE', 'BUILD_REMOVE_FOREST', 'BUILD_REMOVE_MARSH', 'BUILD_SCRUB_FALLOUT'))
	AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_BUILD_CHARGES_EXCLUDES_REMOVING' AND Value = 1);

	INSERT INTO Build_JFD_ChargeCosts 
				(BuildType,								                      UnitType,						  ChargeCost)
	VALUES		('BUILD_FARM_XINGU',								'UNIT_XINGU_WORKER',					           1),
				('BUILD_MINE_XINGU',								'UNIT_XINGU_WORKER',					           1),
				('BUILD_TRADING_POST_XINGU',						'UNIT_XINGU_WORKER',					           1),
				('BUILD_PASTURE_XINGU',								'UNIT_XINGU_WORKER',					           1),
				('BUILD_PLANTATION_XINGU',							'UNIT_XINGU_WORKER',					           1),
				('BUILD_QUARRY_XINGU',								'UNIT_XINGU_WORKER',					           1),
				('BUILD_WELL_XINGU',								'UNIT_XINGU_WORKER',					           1),
				('BUILD_FORT_XINGU',								'UNIT_XINGU_WORKER',					           1),	
				('BUILD_FARM_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
				('BUILD_MINE_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
				('BUILD_TRADING_POST_XINGU',						'UNIT_XINGU_AI_WORKER',					           1),
				('BUILD_PASTURE_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
				('BUILD_PLANTATION_XINGU',							'UNIT_XINGU_AI_WORKER',					           1),
				('BUILD_QUARRY_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
				('BUILD_WELL_XINGU',								'UNIT_XINGU_AI_WORKER',					           1),
				('BUILD_FORT_XINGU',								'UNIT_XINGU_AI_WORKER',					           1);

	INSERT INTO Build_JFD_ChargeCosts 
				(BuildType,								    UnitType,				      ChargeCost)
	SELECT		('BUILD_FARM_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Build_JFD_ChargeCosts 
				(BuildType,								    UnitType,				      ChargeCost)
	SELECT		('BUILD_MINE_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Build_JFD_ChargeCosts 
				(BuildType,								    UnitType,				      ChargeCost)
	SELECT		('BUILD_TRADING_POST_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Build_JFD_ChargeCosts 
				(BuildType,								    UnitType,				      ChargeCost)
	SELECT		('BUILD_PASTURE_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Build_JFD_ChargeCosts 
				(BuildType,								    UnitType,				      ChargeCost)
	SELECT		('BUILD_PLANTATION_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Build_JFD_ChargeCosts 
				(BuildType,								    UnitType,				      ChargeCost)
	SELECT		('BUILD_QUARRY_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Build_JFD_ChargeCosts 
				(BuildType,								    UnitType,				      ChargeCost)
	SELECT		('BUILD_WELL_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

	INSERT INTO Build_JFD_ChargeCosts 
				(BuildType,								    UnitType,				      ChargeCost)
	SELECT		('BUILD_FORT_XINGU'),				('UNIT_JFD_WORKER_XINGU'),			  1
	WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_SLAVERY_CORE' AND Value = 1);

END;