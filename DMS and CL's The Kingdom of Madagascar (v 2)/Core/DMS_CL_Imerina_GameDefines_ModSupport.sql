--==========================================================================================================================
-- USER SETTINGS (THIS IS NEEDED IN MOST CASES)
--==========================================================================================================================
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
    Type                text            default null,
    Value               integer         default 1);
--==========================================================================================================================
-- SUKRITACT'S DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('DMS_CL_Imerina_Decisions.lua');
------------------------------------------------------------
-- Policies
------------------------------------------------------------
INSERT INTO Policies 
		(Type,										Description) 
VALUES	('POLICY_DMS_CL_ROVAN_I_MANJAKAMIADANA',	'TXT_KEY_DECISIONS_DMS_CL_ROVAN_I_MANJAKAMIADANA');
------------------------------------------------------------
-- Policy_ImprovementYieldChanges
------------------------------------------------------------
INSERT INTO Policy_ImprovementYieldChanges 
		(PolicyType,								ImprovementType,			YieldType,			Yield) 
VALUES	('POLICY_DMS_CL_ROVAN_I_MANJAKAMIADANA',	'IMPROVEMENT_DMS_CL_ROVA',	'YIELD_FAITH',		2);
------------------------------------------------------------
-- Policy_ImprovementCultureChanges
------------------------------------------------------------
INSERT INTO Policy_ImprovementCultureChanges 
		(PolicyType,								ImprovementType,			CultureChange) 
VALUES	('POLICY_DMS_CL_ROVAN_I_MANJAKAMIADANA',	'IMPROVEMENT_DMS_CL_ROVA',	1);
------------------------------------------------------------	
-- BuildingClasses
------------------------------------------------------------
INSERT INTO BuildingClasses
		(Type, 											DefaultBuilding, 							Description)
VALUES	('BUILDINGCLASS_DMS_CL_ROVAN_I_MANJAKAMIADANA',	'BUILDING_DMS_CL_ROVAN_I_MANJAKAMIADANA', 	'TXT_KEY_BUILDING_DMS_CL_ROVAN_I_MANJAKAMIADANA');
------------------------------------------------------------
-- Buildings
------------------------------------------------------------
INSERT INTO Buildings
		(Type, 						 				BuildingClass, 									MilitaryProductionModifier,	Cost,	FaithCost,	GreatWorkCount,	PrereqTech,	MinAreaSize,	Description, 										Help)
VALUES	('BUILDING_DMS_CL_ROVAN_I_MANJAKAMIADANA', 	'BUILDINGCLASS_DMS_CL_ROVAN_I_MANJAKAMIADANA',	3,							-1,		-1,			-1,				NULL,		-1,				'TXT_KEY_BUILDING_DMS_CL_ROVAN_I_MANJAKAMIADANA',	'TXT_KEY_BUILDING_DMS_CL_ROVAN_I_MANJAKAMIADANA_HELP');
------------------------------------------------------------
-- Units
------------------------------------------------------------
INSERT INTO Units
		(Class, Type, 								Cost,	Moves,	CivilianAttackPriority,	Special,	Domain,	DefaultUnitAI,	Description,	Civilopedia,	Strategy,	AdvancedStartCost,	WorkRate,	CombatLimit,	BaseCultureTurnsToCount,	UnitArtInfo,	UnitArtInfoEraVariation,	UnitFlagAtlas,	UnitFlagIconOffset,	IconAtlas,	PortraitIndex,	MoveRate)
SELECT	Class,	('UNIT_DMS_CL_FIBONIA_WRITER'),		-1,		Moves,	CivilianAttackPriority,	Special,	Domain,	DefaultUnitAI,	Description,	Civilopedia,	Strategy,	AdvancedStartCost,	WorkRate,	CombatLimit,	BaseCultureTurnsToCount,	UnitArtInfo,	UnitArtInfoEraVariation,	UnitFlagAtlas,	UnitFlagIconOffset,	IconAtlas,	PortraitIndex,	MoveRate
FROM Units WHERE (Type = 'UNIT_WRITER');
------------------------------------------------------------
-- UnitGameplay2DScripts
------------------------------------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_CL_FIBONIA_WRITER'),	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WRITER');
------------------------------------------------------------
-- Unit_AITypes
------------------------------------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_CL_FIBONIA_WRITER'),	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_WRITER');
------------------------------------------------------------
-- Unit_Flavors
------------------------------------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType, Flavor)
SELECT	('UNIT_DMS_CL_FIBONIA_WRITER'),	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WRITER');
------------------------------------------------------------
-- Unit_UniqueNames
------------------------------------------------------------
INSERT INTO Unit_UniqueNames 
		(UnitType, 							UniqueName,								GreatWorkType)
VALUES	('UNIT_DMS_CL_FIBONIA_WRITER', 		'TXT_KEY_DMS_CL_FIBONIA_GREAT_WRITER',	'GREAT_WORK_DMS_CL_FIBONIA');
------------------------------------------------------------	
-- GreatWorks
------------------------------------------------------------	
INSERT INTO GreatWorks 
		(Type, 							GreatWorkClassType,			Description,							Quote,										Audio,							Image)
VALUES	('GREAT_WORK_DMS_CL_FIBONIA', 	'GREAT_WORK_LITERATURE',	'TXT_KEY_GREAT_WORK_DMS_CL_FIBONIA',	'TXT_KEY_GREAT_WORK_QUOTE_DMS_CL_FIBONIA',	'AS2D_GREAT_ARTIST_ARTWORK',	'GreatWriter_Background.dds');
--==========================================================================================================================
-- SUKRITACT'S EVENTS
--==========================================================================================================================
-- EventsAddin_Support
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('DMS_CL_Imerina_Events.lua');
------------------------------------------------------------
-- Policies
------------------------------------------------------------
-- PROMOTIONS
------------------------------------------------------------	
-- UnitPromotions
------------------------------------------------------------	
-- BUILDINGS
------------------------------------------------------------	
-- BuildingClasses
-- Buildings
--==========================================================================================================================
-- HAZEL'S MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,								CultureType,	CultureEra)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			'AFRICAN',		'ANY');
--==========================================================================================================================
-- BRUTALSAMURAI'S ETHNIC UNITS / GEDEMON'S R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ZULU' )
	THEN '_ZULU'
	ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_DMS_CL_IMERINA';
--==========================================================================================================================
-- BINGLE'S CIV IV TRAITS
--==========================================================================================================================
-- Leader_SharedTraits
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS  
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
         (LeaderType,					TraitOne,					TraitTwo)
VALUES  ('LEADER_DMS_CL_RANAVALONA_I',	'POLICY_SPIRITUAL_X',		'POLICY_MERCANTILE_X');
------------------------------------------------------------	
-- Leaders
------------------------------------------------------------	
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Ranavalona I [ICON_STRENGTH][ICON_CULTURE]'
	ELSE 'TXT_KEY_LEADER_DMS_CL_RANAVALONA_I' END) 
WHERE Type = 'LEADER_DMS_CL_RANAVALONA_I';

CREATE TRIGGER CivIVTraitsDMSCLImerina
AFTER INSERT ON Leaders WHEN 'LEADER_DMS_CL_RANAVALONA_I' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Ranavalona I [ICON_STRENGTH][ICON_CULTURE]'
		ELSE 'TXT_KEY_LEADER_DMS_CL_RANAVALONA_I' END) 
	WHERE Type = 'LEADER_DMS_CL_RANAVALONA_I';
END;		
--==========================================================================================================================
-- TOMATEKH'S HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions
------------------------------------------------------------
UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = "RELIGION_RAZANA" )
		THEN "RELIGION_RAZANA"
		ELSE ( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = "RELIGION_ORTHODOXY" )
		THEN "RELIGION_ORTHODOXY" 
		ELSE "RELIGION_CHRISTIANITY" END ) END
	) WHERE CivilizationType = "CIVILIZATION_DMS_CL_IMERINA";

CREATE TRIGGER CivilizationDMSImerina
AFTER INSERT ON Civilization_Religions WHEN 'CIVILIZATION_DMS_CL_IMERINA' = NEW.CivilizationType
BEGIN
	UPDATE Civilization_Religions SET ReligionType = 
		( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_RAZANA' )
			THEN 'RELIGION_RAZANA'
			ELSE ( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_ORTHODOXY' )
			THEN 'RELIGION_ORTHODOXY'
			ELSE 'RELIGION_CHRISTIANITY' END ) END
		) WHERE CivilizationType = 'CIVILIZATION_DMS_CL_IMERINA';
END;
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23 / 24)
--==========================================================================================================================
/*
Tables (example below; replace Civilizations with MinorCivilizations where appropriate):
   
v22
    Civilizations_YagemRequestedResource (Earth Giant)
    Civilizations_YahemRequestedResource (Earth Huge)
    Civilizations_GreatestEarthRequestedResource 
    Civilizations_EuroLargeRequestedResource
     
v23
    Civilizations_EuroGiantRequestedResource 
    Civilizations_EastAsiaStartPosition 
    Civilizations_ApennineStartPosition
    Civilizations_BritishIslesStartPosition
    Civilizations_NorthEastAsiaStartPosition
    Civilizations_AegeanStartPosition
    Civilizations_NorthAtlanticStartPosition
    Civilizations_PacificStartPosition
    Civilizations_SouthPacificStartPosition
    Civilizations_NorthWestEuropeStartPosition
    Civilizations_CaribbeanStartPosition
    Civilizations_AsiaStartPosition
    Civilizations_MediterraneanStartPosition
    Civilizations_MesopotamiaStartPosition
    Civilizations_AfricaLargeStartPosition
    Civilizations_NileValleyStartPosition
    Civilizations_AmericasStartPosition
v24
	Civilizations_MesopotamiaGiantStartPosition
	Civilizations_AsiaSmallStartPosition
	Civilizations_EuroLargeNewStartPosition
	Civilizations_AdriaticStartPosition
	Civilizations_WestAfricaStartPosition
	Civilizations_CaucasusStartPosition
	Civilizations_AsiaSteppeGiantStartPosition
	Civilizations_CentralAsiaStartPosition
	Civilizations_EuroEasternStartPosition
	Civilizations_NorthSeaEuropeStartPosition
	Civilizations_AfriAsiaAustStartPosition
	Civilizations_AfriSouthEuroStartPosition
	Civilizations_AfriGiantStartPosition
	Civilizations_SouthAmericaGiantStartPosition
	Civilizations_AustralasiaGiantStartPosition
	Civilizations_IndianOceanStartPosition
	Civilizations_AmericasGiantStartPosition
	Civilizations_IndiaGiantStartPosition
	Civilizations_SouthAmericaCentralHugeStartPosition
	Civilizations_SouthAmericaCentralGiantStartPosition
	Civilizations_ScotlandIrelandHugeStartPosition
	Civilizations_SouthAmericaLargeStartPosition
	Civilizations_SouthAsiaHugeStartPosition
	Civilizations_SouthPacificGiantStartPosition
	Civilizations_NorthAmericaGiantStartPosition
	Civilizations_NorthAmericaHugeStartPosition 
*/
------------------------------------------------------------
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,									X,	Y)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			42,	17);
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 									Req1,				Yield1, Req2,				Yield2, Req3,				Yield3)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			'RESOURCE_SPICE',	null,	'RESOURCE_GOLD',	null,	'RESOURCE_IRON',	4);
------------------------------------------------------------
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,									X,	Y)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			78,	20);
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 									Req1,				Yield1, Req2,				Yield2, Req3,				Yield3)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			'RESOURCE_SPICE',	null,	'RESOURCE_GOLD',	null,	'RESOURCE_IRON',	4);
------------------------------------------------------------
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,									X,	Y)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			66,	9);
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 									Req1,				Yield1, Req2,				Yield2, Req3,				Yield3)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			'RESOURCE_SPICE',	null,	'RESOURCE_GOLD',	null,	'RESOURCE_IRON',	4);
------------------------------------------------------------
-- Civilizations_AfricaLargeStartPosition (Africa Pangea)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfricaLargeStartPosition
		(Type,									X,	Y)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			56,	17);
------------------------------------------------------------	
-- Civilizations_AfricaLargeRequestedResource (Africa Pangea)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfricaLargeRequestedResource
		(Type, 									Req1,				Yield1, Req2,				Yield2, Req3,				Yield3)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			'RESOURCE_SPICE',	null,	'RESOURCE_GOLD',	null,	'RESOURCE_IRON',	4);
------------------------------------------------------------
-- Civilizations_AfriGiantStartPosition (Africa Giant)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriGiantStartPosition
		(Type,									X,	Y)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			59,	90);
------------------------------------------------------------	
-- Civilizations_AfriGiantRequestedResource (Africa Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriGiantRequestedResource
		(Type, 									Req1,				Yield1, Req2,				Yield2, Req3,				Yield3)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			'RESOURCE_SPICE',	null,	'RESOURCE_GOLD',	null,	'RESOURCE_IRON',	4);
------------------------------------------------------------
-- Civilizations_AfriSouthEuroStartPosition (Africa & Southern Europe)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriSouthEuroStartPosition
		(Type,									X,	Y)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			38,	42);
------------------------------------------------------------	
-- Civilizations_AfriSouthEuroRequestedResource (Africa & Southern Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriSouthEuroRequestedResource
		(Type, 									Req1,				Yield1, Req2,				Yield2, Req3,				Yield3)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			'RESOURCE_SPICE',	null,	'RESOURCE_GOLD',	null,	'RESOURCE_IRON',	4);
------------------------------------------------------------
-- Civilizations_AfriAsiaAustStartPosition (Africa, Asia & Australia)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
		(Type,									X,	Y)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			18,	19);
------------------------------------------------------------	
-- Civilizations_AfriAsiaAustRequestedResource (Africa, Asia & Australia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriAsiaAustRequestedResource
		(Type, 									Req1,				Yield1, Req2,				Yield2, Req3,				Yield3)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			'RESOURCE_SPICE',	null,	'RESOURCE_GOLD',	null,	'RESOURCE_IRON',	4);
------------------------------------------------------------
-- Civilizations_IndianOceanStartPosition (Indian Ocean)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndianOceanStartPosition
		(Type,									X,	Y)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			53, 20);
------------------------------------------------------------	
-- Civilizations_IndianOceanRequestedResource (Indian Ocean)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_IndianOceanRequestedResource
		(Type, 									Req1,				Yield1, Req2,				Yield2, Req3,				Yield3)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',			'RESOURCE_SPICE',	null,	'RESOURCE_GOLD',	null,	'RESOURCE_IRON',	4);
--==========================================================================================================================
-- JFD CIVILOPEDIA
--==========================================================================================================================
-- JFD_Civilopedia_HideFromPedia
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);

--Any items entered into this table will not show into the Civilopedia. There is no technical limitation as to what can be hidden (I think).
 INSERT INTO JFD_Civilopedia_HideFromPedia
        (Type)
VALUES  ('BUILDING_DMS_ROVA_EXPEND_COUNTER'),
        ('PROMOTION_DMS_IMERINA_AFTERRANDOM');

-- For a leader to appear as belonging to another civilization, fill in the tag: "DerivativeCiv" e.g.
UPDATE Civilizations
SET DerivativeCiv = 'CIVILIZATION_DMS_CL_IMERINA'
WHERE Type = 'CIVILIZATION_DMS_CL_IMERINA';
-- Thanks to Sukritact, you can also fill this tag in with a text string, which will group this civ with others that also have this text string.
--UPDATE Civilizations
--SET DerivativeCiv = 'TXT_KEY_JFD_RUSSIA_MASTER_RACE'
--WHERE Type = 'CIVILIZATION_DMS_CL_IMERINA';   
--==========================================================================================================================
-- JFD's CITIES IN DEVELOPMENT (10e9728f-d61c-4317-be4f-7d52d6bae6f4)
-- Please Note: it is NOT necessary to make any changes to this if you had supported Colony Names under the ExCE ID. 
-- You will only need to add support for Claims if you wish some of your Decisions to cost Dignitaries instead of Magistrates. Examples TBD.
--==========================================================================================================================
------------------------------------------------------------
-- BuildingClass_ConstructionAudio
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
BuildingClass_ConstructionAudio (
    BuildingClassType                           text    REFERENCES BuildingClasses(Type)        default null,
    ConstructionAudio                           text                                            default null);
------------------------------------------------------------
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    ColonyName                                  text                                        default null,
    LinguisticType                              text                                        default null,
    CultureType                                 text                                        default null);
 /*
JFD_Germanic, JFD_Latinate, JFD_Tai_Khmer, JFD_Austronesian, JFD_Arabic, JFD_Slavic, JFD_Mesopotamian, JFD_Mesoamerican, JFD_Oriental,
JFD_Finno_Ugric, JFD_Semitic, JFD_Hellenic, JFD_Bantu, JFD_Songhay, JFD_Indo_Iranian, JFD_Altaic, JFD_Celtic, JFD_NorthAmerican, JFD_Quechumaran
*/
INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 							ColonyName,			LinguisticType)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',				null,				'Austronesian'),
		('CIVILIZATION_DMS_CL_IMERINA',				null,				'JFD_Bantu');
------------------------------------------------------------		
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
--A value of 0-10 may be set. This value determines the proclivity a civ has toward annexing a colony, where 0 means never, and 10 means as soon as possible.
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,						Flavor)
VALUES	('LEADER_DMS_CL_RANAVALONA_I',	'FLAVOR_JFD_DECOLONIZATION',	5);
--==========================================================	
-- PROVINCES 
--==========================================================	
-- Civilization_JFD_ProvinceTitles
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null, -- ignore this
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	
	
/*
Default Titles:
TXT_KEY_PROVINCE_JFD_BARONY_DESC_MONARCHY -- Barony
TXT_KEY_PROVINCE_JFD_BARONY_DESC_RULER_MONARCHY
TXT_KEY_PROVINCE_JFD_BARONY_DESC_RULER_MONARCHY_FEMININE
TXT_KEY_PROVINCE_JFD_COUNTY_DESC_MONARCHY -- County
TXT_KEY_PROVINCE_JFD_COUNTY_DESC_RULER_MONARCHY
TXT_KEY_PROVINCE_JFD_COUNTY_DESC_RULER_MONARCHY_FEMININE
TXT_KEY_PROVINCE_JFD_DUCHY_DESC_MONARCHY -- Duchy
TXT_KEY_PROVINCE_JFD_DUCHY_DESC_RULER_MONARCHY
TXT_KEY_PROVINCE_JFD_DUCHY_DESC_RULER_MONARCHY_FEMININE
TXT_KEY_PROVINCE_JFD_COLONY_DESC_MONARCHY -- Colony
TXT_KEY_PROVINCE_JFD_COLONY_DESC_RULER_MONARCHY
TXT_KEY_PROVINCE_JFD_COLONY_DESC_RULER_MONARCHY_FEMININE 

(Generally, Republics do not have unique titles)
TXT_KEY_PROVINCE_JFD_BARONY_DESC_REPUBLIC -- Municipality
TXT_KEY_PROVINCE_JFD_BARONY_DESC_RULER_REPUBLIC
TXT_KEY_PROVINCE_JFD_BARONY_DESC_RULER_REPUBLIC_FEMININE
TXT_KEY_PROVINCE_JFD_COUNTY_DESC_REPUBLIC -- County
TXT_KEY_PROVINCE_JFD_COUNTY_DESC_REPUBLIC_MONARCHY
TXT_KEY_PROVINCE_JFD_COUNTY_DESC_REPUBLIC_MONARCHY_FEMININE
TXT_KEY_PROVINCE_JFD_DUCHY_DESC_REPUBLIC -- State
TXT_KEY_PROVINCE_JFD_DUCHY_DESC_RULER_REPUBLIC
TXT_KEY_PROVINCE_JFD_DUCHY_DESC_RULER_REPUBLIC_FEMININE
TXT_KEY_PROVINCE_JFD_COLONY_DESC_REPUBLIC -- Colony
TXT_KEY_PROVINCE_JFD_COLONY_DESC_RULER_REPUBLIC
TXT_KEY_PROVINCE_JFD_COLONY_DESC_RULER_REPUBLIC_FEMININE 
*/	
--==========================================================================================================================    
-- JFD's CITIES IN DEVELOPMENT: SLAVERY (10e9728f-d61c-4317-be4f-7d52d6bae6f4)
--==========================================================================================================================    
-- Flavors
------------------------------------------------------------
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------  
--A value of 0-10 may be set. This value determines the proclivity a civ has toward enslaving a captured city and toward spending Slavery on Units.
INSERT INTO Leader_Flavors
        (LeaderType,            		FlavorType,                 Flavor)
VALUES  ('LEADER_DMS_CL_RANAVALONA_I',	'FLAVOR_JFD_SLAVERY',       9);
--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY (31a31d1c-b9d7-45e1-842c-23232d66cd47)
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------------------------------------
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
/*
CultureTypes:
  JFD_Andean, JFD_Bantu, JFD_Bharata, JFD_Central, JFD_Colonial, JFD_Eastern, JFD_Islamic, JFD_Katuje, JFD_Mandala, JFD_Mediterranean, JFD_Mesoamerican, JFD_Mesopotamic, JFD_Northern, JFD_Oceanic, JFD_Oriental, JFD_Polar, JFD_Sahul, JFD_Semitic, JFD_Steppe, JFD_Southern, JFD_TribalAmerican, JFD_Totalitarian, JFD_WestAfrican, JFD_Western
 
SplashScreenTags (As above, unless otherwise specified)
  JFD_ColonialLatin, JFD_NorthernCeltic, JFD_OrientalJapanese, JFD_SouthernPapal
   
SoundtrackTag (As above, unless otherwise specified)
  JFD_MesopotamicEgyptian, JFD_NorthernCeltic, JFD_OrientalJapanese
   
 UnitDialogueTag
    AS2D_SOUND_JFD_AMERICAN, AS2D_SOUND_JFD_AMERICAN_WEST, AS2D_SOUND_JFD_ALBANIAN*, AS2D_SOUND_JFD_ARABIC, AS2D_SOUND_JFD_AZTEC, AS2D_SOUND_JFD_BABYLONIAN, AS2D_SOUND_JFD_BERBER*, AS2D_SOUND_JFD_BYZANTINE, AS2D_SOUND_JFD_CARTHAGINIAN, AS2D_SOUND_JFD_CELTIC, AS2D_SOUND_JFD_CHINESE, AS2D_SOUND_JFD_COMANCHE*, AS2D_SOUND_JFD_DUTCH, AS2D_SOUND_JFD_EGYPTIAN, AS2D_SOUND_JFD_ENGLISH, AS2D_SOUND_JFD_ETHIOPIAN, AS2D_SOUND_JFD_FINNISH*, AS2D_SOUND_JFD_FRENCH, AS2D_SOUND_JFD_GAELIC*, AS2D_SOUND_JFD_GERMAN, AS2D_SOUND_JFD_GREEK, AS2D_SOUND_JFD_HOLY_ROMAN, AS2D_SOUND_JFD_HUNNIC, AS2D_SOUND_JFD_INCAN, AS2D_SOUND_JFD_INDIAN, AS2D_SOUND_JFD_ITALIAN, AS2D_SOUND_JFD_JAPANESE, AS2D_SOUND_JFD_KHMER, AS2D_SOUND_JFD_KOREAN, AS2D_SOUND_JFD_MALINESE, AS2D_SOUND_JFD_MAMLUKE*, AS2D_SOUND_JFD_MAYAN, AS2D_SOUND_JFD_MONGOL, AS2D_SOUND_JFD_NATIVE_AMERICAN (Mohawk), AS2D_SOUND_JFD_OTTOMAN, AS2D_SOUND_JFD_PERSIAN, AS2D_SOUND_JFD_POLISH, AS2D_SOUND_JFD_PORTUGUESE, AS2D_SOUND_JFD_ROMAN, AS2D_SOUND_JFD_RUSSIAN, AS2D_SOUND_JFD_SIAMESE, AS2D_SOUND_JFD_SPANISH, AS2D_SOUND_JFD_SUMERIAN, AS2D_SOUND_JFD_SWEDISH, AS2D_SOUND_JFD_TUPI*, AS2D_SOUND_JFD_VIKING, AS2D_SOUND_JFD_ZAPOTEC*, AS2D_SOUND_JFD_ZULU
     
    *Recommended to only use for Mercenary Units, as these have fewer tracks.
*/
INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,        		CultureType)
VALUES  ('CIVILIZATION_DMS_CL_IMERINA',	'CULTURE_JFD_EAST_INDIES');

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_EastIndies'
WHERE Type = 'CIVILIZATION_DMS_CL_IMERINA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_EastIndies');
------------------------------------------------------------
-- MinorCivilization_JFD_CultureTypes
------------------------------------------------------------
--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED (6676902b-b907-45f1-8db5-32dcb2135eee)
--==========================================================================================================================
--PROMOTION_JFD_SNOW_IMMUNITY, PROMOTION_JFD_DESERT_IMMUNITY, PROMOTION_JFD_DISEASE_IMMUNITY, PROMOTION_JFD_JUNGLE_IMMUNITY, PROMOTION_JFD_SCUVRY_IMMUNITY
INSERT INTO Unit_FreePromotions
		(UnitType, 					PromotionType)
SELECT	'UNIT_DMS_CL_TAFIKA',		'PROMOTION_JFD_JUNGLE_IMMUNITY'
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_JUNGLE_IMMUNITY');
--===============================	===========================================================================================    
-- JFD's AND POUAKAI's MERCENARIES (a19351c5-c0b3-4b07-8695-4affaa199949)
--==========================================================================================================================
-- Flavors
------------------------------------------------------------
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_MERCENARY'); 
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 0-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT INTO Leader_Flavors
        (LeaderType,						FlavorType,                 Flavor)
VALUES  ('LEADER_DMS_CL_RANAVALONA_I',		'FLAVOR_JFD_MERCENARY',     5);
--==========================================================================================================================    
-- JFD's RISE TO POWER: PIETY (eea66053-7579-481a-bb8d-2f3959b59974)
--==========================================================================================================================    
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 0-12 may be set. This value determines the diplomatic penalty/bonus with civilizations of a different/same state religion
--A value higher than 9 means this civilization will never secularise. A value of 0 means this civilization has no interest in State Religion.
INSERT INTO Leader_Flavors
		(LeaderType,					FlavorType,								Flavor)
VALUES	('LEADER_DMS_CL_RANAVALONA_I',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		9),
		('LEADER_DMS_CL_RANAVALONA_I',	'FLAVOR_JFD_STATE_RELIGION',			8);
--==========================================================================================================================    
-- JFD's RISE TO POWER: PROSPERITY (eea66053-7579-481a-bb8d-2f3959b59974)
--==========================================================================================================================    
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Currencies (
    CivilizationType                text        REFERENCES Civilizations(Type)  default null,
    CurrencyType                    text                                        default null);
 
INSERT INTO Civilization_JFD_Currencies
        (CivilizationType,                  CurrencyType)
SELECT  'CIVILIZATION_DMS_CL_IMERINA',		CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_ZULU';  
--==========================================================================================================================    
-- JFD's RISE TO POWER: SOVEREIGNTY (eea66053-7579-481a-bb8d-2f3959b59974)
--==========================================================================================================================
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
 
--This table determines a variety of things relating to your Government.
--The LegislatureName refers to the name of your Legislature (e.g. the Imperial Diet). 
--The OfficeTitle refers to the title of your Head of Government (if a Const. Monarchy) (e.g. Vizier. Default is Prime Minister)
--GovernmentType and Weight prefer to a Government preference (GOVERNMENT_JFD_MONARCHY or GOVERNMENT_JFD_REPUBLIC) and how strong that preference is.
INSERT INTO Civilization_JFD_Governments
        (CivilizationType,				LegislatureName,	OfficeTitle,	GovernmentType,             Weight)
VALUES  ('CIVILIZATION_DMS_CL_IMERINA',	null,				null,			'GOVERNMENT_JFD_MONARCHY',  90);
------------------------------------------------------------    
-- Civilization_JFD_HeadsOfGovernment   
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS  
    Civilization_JFD_HeadsOfGovernment (    
    CivilizationType                text        REFERENCES Civilizations(Type)                  default null,
    CultureType                     text                                                        default null,
    HeadOfGovernmentName            text                                                        default null);
 
--These are the Heads of your Government, which are randomly chosen when a new Legislature is formed.
--The standard number for each civ is 25. However, you may leave this table empty and your civ will call
--from a cultural list (so long as you have Cultural Diversity support).
INSERT INTO Civilization_JFD_HeadsOfGovernment
		(CivilizationType,					HeadOfGovernmentName)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_1'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_2'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_3'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_4'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_5'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_6'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_7'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_8'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_9'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_10'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_11'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_12'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_13'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_14'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_15'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_16'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_17'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_18'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_19'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_20'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_21'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_22'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_23'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_24'),
		('CIVILIZATION_DMS_CL_IMERINA',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_CL_IMERINA_25');
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
	
--This lists all the unique titles that a civilization should use instead of a standard one. If left blank, a culture-specific title will be used instead (if CulDiv support).
--The default titles are as follows:
----TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_GOVERNMENT (Tribe)
----TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER (Chief/Chieftess)
----TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_LEADER (Grand Prince)
----TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_GOVERNMENT (Grand Principality)
----TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER (King/Queen)
----TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_GOVERNMENT (Kingdom)
----TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER (Emperor/Empress)
----TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_GOVERNMENT (Empire)
----TXT_KEY_GOVERNMENT_JFD_COMMONWEALTH_TITLE_GOVERNMENT (Commonwealth)
----TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER (Consul)
----TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_LEADER_LATE (President)
----TXT_KEY_GOVERNMENT_JFD_REPUBLIC_TITLE_GOVERNMENT (Republic)
----TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_LEADER (Dictator)
----TXT_KEY_GOVERNMENT_JFD_FEDERATION_TITLE_GOVERNMENT (Federation)
 
--For 'LEADER' titles, just include the title in the text, e.g. "Pharoah." 
--For 'GOVERNMENT' titles, include a placeholder for your civ's short description, e.g. "Kingdom of {1_CivName}"
--Use 'UseAdjective' when you want the 'GOVERNMENT' title to read (e.g.): "{1_CivAdj} Kingdom" instead of "Kingdom of {1_CivName}"
------------------------------------------------------------
-- JFD_PrivyCouncillor_UniqueNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_PrivyCouncillor_UniqueNames (
	PrivyCouncillorType  				text 										 	default null,
	PolicyType  						text 	REFERENCES Policies(Type) 				default null,
	CivilizationType					text	REFERENCES Civilizations(Type) 			default	null,
	CultureType							text											default	null,
	GovernmentType  					text 	 										default null,
	ReligionType						text	REFERENCES Religions(Type) 				default	null,
	UniqueName							text											default	null);
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Politics (
    CivilizationType                    text        REFERENCES Civilizations(Type)                  default null,
    PoliticsType                        text                                                        default null,
    UniqueName                          text                                                        default null);
 
--This lists all the unique names for a civ's political parties.
--Political Parties are as follows:
----PARTY_JFD_CLERGY
----PARTY_JFD_NOBILITY
----PARTY_JFD_REVOLUTIONARY
----PARTY_JFD_CONSERVATIVE
----PARTY_JFD_LIBERAL
----PARTY_JFD_REACTIONARY
----PARTY_JFD_SOCIALIST
----PARTY_JFD_COMMUNIST
----PARTY_JFD_FASCIST
----PARTY_JFD_LIBERTARIAN
INSERT INTO Civilization_JFD_Politics
		(CivilizationType, 			                PoliticsType,	UniqueName)
SELECT	'CIVILIZATION_DMS_CL_IMERINA',				PoliticsType,	UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_ZULU';
------------------------------------------------------------
-- Flavors
------------------------------------------------------------   
INSERT OR REPLACE INTO Flavors 
        (Type)
VALUES  ('FLAVOR_JFD_REFORM_GOVERNMENT'),
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
--Each flavour corresponds to one of the seven Reform Categories, and how likely a civ is to take a reform in either the Right, Centre, or Left column.
--A value of 1-3 will favour Left Reforms. A value of 4-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT INTO Leader_Flavors
        (LeaderType,            			FlavorType,                         Flavor)
VALUES  ('LEADER_DMS_CL_RANAVALONA_I',    	'FLAVOR_JFD_REFORM_GOVERNMENT',     5),
		('LEADER_DMS_CL_RANAVALONA_I',		'FLAVOR_JFD_REFORM_LEGAL',			7),
        ('LEADER_DMS_CL_RANAVALONA_I',    	'FLAVOR_JFD_REFORM_CULTURE',        5),
        ('LEADER_DMS_CL_RANAVALONA_I',    	'FLAVOR_JFD_REFORM_ECONOMIC',       5),
        ('LEADER_DMS_CL_RANAVALONA_I',    	'FLAVOR_JFD_REFORM_FOREIGN',        10),
        ('LEADER_DMS_CL_RANAVALONA_I',    	'FLAVOR_JFD_REFORM_INDUSTRY',       7),
        ('LEADER_DMS_CL_RANAVALONA_I',    	'FLAVOR_JFD_REFORM_MILITARY',       8),
        ('LEADER_DMS_CL_RANAVALONA_I',    	'FLAVOR_JFD_REFORM_RELIGION',       9);
--==========================================================================================================================	
-- The Enlightenment Era
--==========================================================================================================================	
--==========================================================================================================================        