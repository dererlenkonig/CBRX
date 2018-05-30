--Decisions
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('TomatekhPovertyDecisions.lua');

--Ethnic Units
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_IROQUOIS")
		THEN "_IROQUOIS"
		ELSE "_AMER" END
	) WHERE Type = "CIVILIZATION_POVERTY_POINT_MOD";

--Map Labels
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,							          CultureType,	CultureEra)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD',		'FIRST_AMERICANS',		 'ANY');

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
            (LeaderType,									                FlavorType,    Flavor)
VALUES      ('LEADER_POVERTY_POINT_MOD',            'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',         6);

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

CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Currencies (
    CivilizationType                text        REFERENCES Civilizations(Type)  default null,
    CurrencyType                    text                                        default null);

INSERT INTO Civilization_JFD_Governments
        (CivilizationType,          LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT  ('CIVILIZATION_POVERTY_POINT_MOD'), LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,          HeadOfGovernmentName)
SELECT  ('CIVILIZATION_POVERTY_POINT_MOD'), HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

INSERT INTO Civilization_JFD_Titles
        (CivilizationType,          DefaultTitle,   UniqueTitle)
SELECT  ('CIVILIZATION_POVERTY_POINT_MOD'), DefaultTitle,   UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

INSERT INTO Civilization_JFD_Politics
        (CivilizationType,          PoliticsType, UniqueName)
SELECT  ('CIVILIZATION_POVERTY_POINT_MOD'), PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

INSERT INTO Civilization_JFD_Currencies
        (CivilizationType,                  CurrencyType)
SELECT  'CIVILIZATION_POVERTY_POINT_MOD', CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';  

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
        (LeaderType,							                   FlavorType,                         Flavor)
VALUES  ('LEADER_POVERTY_POINT_MOD',           'FLAVOR_JFD_REFORM_GOVERNMENT',                              4),
        ('LEADER_POVERTY_POINT_MOD',              'FLAVOR_JFD_REFORM_CULTURE',                              4),
        ('LEADER_POVERTY_POINT_MOD',             'FLAVOR_JFD_REFORM_ECONOMIC',                              5),
        ('LEADER_POVERTY_POINT_MOD',              'FLAVOR_JFD_REFORM_FOREIGN',                              2),
        ('LEADER_POVERTY_POINT_MOD',             'FLAVOR_JFD_REFORM_INDUSTRY',                              6),
        ('LEADER_POVERTY_POINT_MOD',             'FLAVOR_JFD_REFORM_RELIGION',                              8);

--Cultural Diversity
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
    CivilizationType                            text    REFERENCES Civilizations(Type)          default null,
    CultureType                                 text                                            default null,
    ArtDefineTag                                text                                            default null,
    DefeatScreenEarlyTag                        text                                            default null,
    DefeatScreenMidTag                          text                                            default null,
    DefeatScreenLateTag                         text                                            default null,
    IdealsTag                                   text                                            default null,
    SplashScreenTag                             text                                            default null,
    SoundtrackTag                               text                                            default null,
    UnitDialogueTag                             text                                            default null);
 
INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType, CultureType, ArtDefineTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  ('CIVILIZATION_POVERTY_POINT_MOD'),  CultureType, ArtDefineTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_TribalAmerican'
WHERE Type = 'CIVILIZATION_POVERTY_POINT_MOD'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_TribalAmerican')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);

--Civ IV Traits
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,									                  TraitOne,				    TraitTwo)
SELECT		('LEADER_POVERTY_POINT_MOD'),		                ('POLICY_SPIRITUAL_X'),	  ('POLICY_MERCANTILE_X')
WHERE EXISTS (SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'TXT_KEY_POVERTY_LEADER_CIV_IV_TRAITS'
	ELSE 'TXT_KEY_LEADER_POVERTY_POINT_MOD_DESC' END) 
WHERE Type = 'LEADER_POVERTY_POINT_MOD';

CREATE TRIGGER CivIVTraitsPoverty
AFTER INSERT ON Leaders WHEN 'LEADER_POVERTY_POINT_MOD' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'TXT_KEY_POVERTY_LEADER_CIV_IV_TRAITS'
		ELSE 'TXT_KEY_LEADER_POVERTY_POINT_MOD_DESC' END) 
	WHERE Type = 'LEADER_POVERTY_POINT_MOD';
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
VALUES		('CIVILIZATION_POVERTY_POINT_MOD', 			          null,		           'JFD_NorthAmerican');

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD',			  'CIVILIZATION_IROQUOIS');

--Mercenaries 
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY');

INSERT INTO Leader_Flavors
        (LeaderType,									           FlavorType,                 Flavor)
VALUES  ('LEADER_POVERTY_POINT_MOD',                   'FLAVOR_JFD_MERCENARY',                      1);

--Cultural Developments
CREATE TABLE IF NOT EXISTS 
Events_CulturalDevelopments(
	CivilizationType		text  REFERENCES Civilizations(Type)	default null,
	CultureType				text									default null,
	Description				text									default null);

INSERT INTO Events_CulturalDevelopments 
			(Description,								                                CivilizationType,						                   CultureType)
VALUES		('TXT_KEY_EVENT_CULDEV_TOMATEKH_POVERTY_01',			    'CIVILIZATION_POVERTY_POINT_MOD',					                              null);

--RTP
INSERT INTO Unit_UniqueNames
		(UnitType,	UniqueName, GreatWorkType)
SELECT	'UNIT_POVERTY_POINT_MOD',	UniqueName, GreatWorkType
FROM Unit_UniqueNames WHERE UnitType = 'UNIT_PROPHET'
AND EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_RELIGIOUS_UNIT');

INSERT INTO Unit_UniqueNames
		(UnitType,	UniqueName, GreatWorkType)
SELECT	'UNIT_POVERTY_POINT_MOD_DUMMY',	UniqueName, GreatWorkType
FROM Unit_UniqueNames WHERE UnitType = 'UNIT_PROPHET'
AND EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_RELIGIOUS_UNIT');

CREATE TRIGGER PovertyRTPSupport
AFTER INSERT ON UnitPromotions WHEN 'PROMOTION_JFD_RELIGIOUS_UNIT' = NEW.Type
BEGIN
	INSERT INTO Unit_UniqueNames
			(UnitType,	UniqueName, GreatWorkType)
	SELECT	'UNIT_POVERTY_POINT_MOD',	UniqueName, GreatWorkType
	FROM Unit_UniqueNames WHERE UnitType = 'UNIT_PROPHET'
	AND EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_RELIGIOUS_UNIT');

	INSERT INTO Unit_UniqueNames
			(UnitType,	UniqueName, GreatWorkType)
	SELECT	'UNIT_POVERTY_POINT_MOD_DUMMY',	UniqueName, GreatWorkType
	FROM Unit_UniqueNames WHERE UnitType = 'UNIT_PROPHET'
	AND EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_RELIGIOUS_UNIT');
END;




