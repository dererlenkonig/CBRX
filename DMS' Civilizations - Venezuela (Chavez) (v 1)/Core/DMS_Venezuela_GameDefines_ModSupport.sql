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
-- Sukritact's Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('DMS_Venezuela_Decisions.lua');
------------------------------
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 	
		(Type, 							Description,							Help,										CombatPercent,	Sound,				PortraitIndex,	IconAtlas,						PediaType,			PediaEntry,									CannotBeChosen)
VALUES	('PROMOTION_DMS_ALBA_STRENGTH',	'TXT_KEY_PROMOTION_DMS_ALBA_STRENGTH',	'TXT_KEY_PROMOTION_DMS_ALBA_STRENGTH_HELP',	25,				'AS2D_IF_LEVELUP',	4,				'EXPANSION2_PROMOTION_ATLAS',	'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_ALBA_STRENGTH_HELP',	1);
------------------------------
-- UnitPromotions_UnitCombats
------------------------------
INSERT INTO UnitPromotions_UnitCombats 	
		(PromotionType, 				UnitCombatType)
VALUES	('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_ARCHER'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_SIEGE'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_HELICOPTER'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_NAVAL'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_NAVALRANGED'),
		('PROMOTION_DMS_ALBA_STRENGTH',	'UNITCOMBAT_NAVALMELEE');
------------------------------
-- BuildingClasses
------------------------------
INSERT OR REPLACE INTO BuildingClasses 
		(DefaultBuilding, 							Type, 											Description)
VALUES	('BUILDING_DMS_DECISIONS_ALO_PRESIDENTE',	'BUILDINGCLASS_DMS_DECISIONS_ALO_PRESIDENTE', 	'TXT_KEY_BUILDING_DMS_DECISIONS_ALO_PRESIDENTE');
------------------------------
-- Buildings
------------------------------
INSERT INTO Buildings
		(Type, 						 				BuildingClass, 									Cost,	FaithCost,	PolicyCostModifier,	GreatWorkSlotType,	GreatWorkCount,	PrereqTech,	MinAreaSize,	Description, 										Help,													ConquestProb,	IconAtlas,	PortraitIndex)
VALUES	('BUILDING_DMS_DECISIONS_ALO_PRESIDENTE', 	'BUILDINGCLASS_DMS_DECISIONS_ALO_PRESIDENTE',	-1,		-1,			-10,				NULL,				-1,				NULL,		-1,				'TXT_KEY_BUILDING_DMS_DECISIONS_ALO_PRESIDENTE',	'TXT_KEY_BUILDING_DMS_DECISIONS_ALO_PRESIDENTE_HELP',	0,				NULL,		-1);
--==========================================================================================================================
-- Sukritact's Events
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,								CultureType,	CultureEra)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			'AMER',		'ANY');
--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_BRAZIL' )
	THEN '_BRAZIL'
	ELSE '_AMER' END) 
WHERE Type = 'CIVILIZATION_DMS_VENEZUELA';
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
     
INSERT OR REPLACE INTO Leader_SharedTraits
        (LeaderType,           			TraitOne,					TraitTwo)
VALUES	('LEADER_DMS_HUGO_CHAVEZ',	'POLICY_INDUSTRIOUS_X',		'POLICY_FINANCIAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Hugo Chávez [ICON_PRODUCTION][ICON_TRADE]'
	ELSE 'TXT_KEY_LEADER_DMS_HUGO_CHAVEZ' END) 
WHERE Type = 'LEADER_DMS_HUGO_CHAVEZ';

CREATE TRIGGER CivIVTraitsVenezuelaHugoChavez
AFTER INSERT ON Leaders WHEN 'LEADER_DMS_HUGO_CHAVEZ' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
		THEN 'Hugo Chávez [ICON_PRODUCTION][ICON_TRADE]'
		ELSE 'TXT_KEY_LEADER_DMS_HUGO_CHAVEZ' END) 
	WHERE Type = 'LEADER_DMS_HUGO_CHAVEZ';
END;		
--==========================================================================================================================
-- TOMATEKH'S HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions
------------------------------------------------------------
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23)
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
--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			158,	41,		null,	null);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			33,		38,		null,	null);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			14,		19,		null,	null);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			26,		24,		null,	null);



------------------------------------------------------------	
-- Civilizations_NorthAmericaGiantStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAmericaGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			119,	6,		null,	null);
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			49,		38,		null,	null);
------------------------------------------------------------	
-- Civilizations_AmericasGiantStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			87,		82,		null,	null);
------------------------------------------------------------	
-- Civilizations_CaribbeanStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaribbeanStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			78,		10,		null,	null);
------------------------------------------------------------	
-- Civilizations_SouthAmericaCentralGiantStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaCentralGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			73,		116,	null,	null);
------------------------------------------------------------	
-- Civilizations_SouthAmericaCentralHugeStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaCentralHugeStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			55,		87,		null,	null);
------------------------------------------------------------	
-- Civilizations_SouthAmericaGiantStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			54,		140,	null,	null);
------------------------------------------------------------	
-- Civilizations_SouthAmericaLargeStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaLargeStartPosition
		(Type,									X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_VENEZUELA',			39,		85,		null,	null);
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 								Req1,				Yield1, Req2,				Yield2, Req3,				Yield3, Req4,				Yield4)
VALUES	('CIVILIZATION_DMS_VENEZUELA',		'RESOURCE_OIL',		2,		'RESOURCE_SILVER',	0,		'RESOURCE_IRON',	4,		'RESOURCE_COW',		0);
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1,				Yield1, Req2,				Yield2, Req3,				Yield3, Req4,				Yield4)
VALUES	('CIVILIZATION_DMS_VENEZUELA',		'RESOURCE_OIL',		2,		'RESOURCE_SILVER',	0,		'RESOURCE_IRON',	4,		'RESOURCE_COW',		0);
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1,				Yield1, Req2,				Yield2, Req3,				Yield3, Req4,				Yield4)
VALUES	('CIVILIZATION_DMS_VENEZUELA',		'RESOURCE_OIL',		2,		'RESOURCE_SILVER',	0,		'RESOURCE_IRON',	4,		'RESOURCE_COW',		0);
--==========================================================================================================================
-- JFD CIVILOPEDIA
--==========================================================================================================================
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);
 
--Any items entered into this table will not show into the Civilopedia. There is no technical limitation as to what can be hidden (I think).
INSERT INTO JFD_Civilopedia_HideFromPedia
        (Type)
VALUES  --('BUILDING_DMS_UBUGABIRE_BUILDING_BONUS'),
		('');
--==========================================================================================================================
-- JFD's CITIES IN DEVELOPMENT (10e9728f-d61c-4317-be4f-7d52d6bae6f4)
-- Please Note: it is NOT necessary to make any changes to this if you had supported Colony Names under the ExCE ID. 
-- You will only need to add support for Claims if you wish some of your Decisions to cost Dignitaries instead of Magistrates. Examples TBD.
--==========================================================================================================================
-- BuildingClass_ConstructionAudio
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
BuildingClass_ConstructionAudio (
    BuildingClassType                           text    REFERENCES BuildingClasses(Type)        default null,
    ConstructionAudio                           text                                            default null);

--The following will override any entries for the above.
CREATE TABLE IF NOT EXISTS
Building_ConstructionAudio (
    BuildingType                                text    REFERENCES Buildings(Type)              default null,
    ConstructionAudio                           text                                            default null);
  
--If you wish to add your own unique sounds, the beginning Jingle can be found here:
--https://www.dropbox.com/s/p5llo4y55ym4toa/StarterSfx.wav?dl=0
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
INSERT INTO Civilization_JFD_ColonialCityNames
        (CivilizationType,                  ColonyName,                             LinguisticType)
SELECT	'CIVILIZATION_DMS_VENEZUELA',		ColonyName,                             LinguisticType
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_BRAZIL';
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
VALUES	('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_DECOLONIZATION',	7);
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
--This is an example of support which copies all attributes from an existing civ (i.e. Denmark). For the most part, this is probably all you'll need; just change 'CIVILIZATION_JFD_SCOTLAND' to the
--tag of your custom civ. 
INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,					DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'CIVILIZATION_DMS_VENEZUELA',		DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_BRAZIL';
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
VALUES  ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_SLAVERY',       2);   
--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY (31a31d1c-b9d7-45e1-842c-23232d66cd47)
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
-------------------------------------   
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
/*
CultureTypes:
  CULTURE_JFD_ABORIGINAL, CULTURE_JFD_ANDEAN, CULTURE_JFD_BANTU, CULTURE_JFD_BHARATA, CULTURE_JFD_CENTRAL, CULTURE_JFD_CLASSICAL, CULTURE_JFD_COLONIAL, CULTURE_JFD_EASTERN, CULTURE_JFD_EAST_INDIES, CULTURE_JFD_GREAT_PLAINS, CULTURE_JFD_HIMALAYAN, CULTURE_JFD_ISLAMIC, CULTURE_JFD_KATUJE, CULTURE_JFD_MANDALA, CULTURE_JFD_MESOAMERICAN, CULTURE_JFD_MESOPOTAMIC, CULTURE_JFD_NORTHERN, CULTURE_JFD_OCEANIC, CULTURE_JFD_ORIENTAL, CULTURE_JFD_PACIFIC, CULTURE_JFD_POLAR, CULTURE_JFD_SAHARAN, CULTURE_JFD_SEMITIC, CULTURE_JFD_STEPPE, CULTURE_JFD_SOUTHERN, CULTURE_JFD_TOTALITARIAN, CULTURE_JFD_WEST_AFRICAN, CULTURE_JFD_WESTERN, CULTURE_JFD_WOODLANDS

SplashScreenTags (As above, unless otherwise specified):
   As above in single word lower-case, e.g. CULTURE_JFD_CENTRAL = JFD_Central, CULTURE_JFD_WEST_AFRICAN = JFD_WestAfrican
   JFD_ClassicalRoman, JFD_ColonialLatin, JFD_NorthernCeltic, JFD_OrientalJapanese, JFD_SemiticEthiopic, JFD_SouthernPapal
  
SoundtrackTag (As above, unless otherwise specified):
  As above in single word lower-case, e.g. CULTURE_JFD_CENTRAL = JFD_Central, CULTURE_JFD_WEST_AFRICAN = JFD_WestAfrican
  JFD_ClassicalRoman, JFD_ColonialLatin, JFD_MesopotamicEgyptian, JFD_NorthernCeltic, JFD_OrientalJapanese, JFD_SemiticEthiopic, JFD_SouthernPapal
  
 UnitDialogueTag:
	AS2D_SOUND_JFD_AMERICAN, AS2D_SOUND_JFD_AMERICAN_WEST, AS2D_SOUND_JFD_ALBANIAN*, AS2D_SOUND_JFD_ARABIC, AS2D_SOUND_JFD_AZTEC, AS2D_SOUND_JFD_BABYLONIAN, AS2D_SOUND_JFD_BERBER*, AS2D_SOUND_JFD_BYZANTINE, AS2D_SOUND_JFD_CARTHAGINIAN, AS2D_SOUND_JFD_CELTIC, AS2D_SOUND_JFD_CHINESE, AS2D_SOUND_JFD_COMANCHE*, AS2D_SOUND_JFD_DUTCH, AS2D_SOUND_JFD_EGYPTIAN, AS2D_SOUND_JFD_ENGLISH, AS2D_SOUND_JFD_ETHIOPIAN, AS2D_SOUND_JFD_FINNISH*, AS2D_SOUND_JFD_FRENCH, AS2D_SOUND_JFD_GAELIC*, AS2D_SOUND_JFD_GERMAN, AS2D_SOUND_JFD_GREEK, AS2D_SOUND_JFD_HOLY_ROMAN, AS2D_SOUND_JFD_HUNNIC, AS2D_SOUND_JFD_INCAN, AS2D_SOUND_JFD_INDIAN, AS2D_SOUND_JFD_ITALIAN, AS2D_SOUND_JFD_JAPANESE, AS2D_SOUND_JFD_KHMER, AS2D_SOUND_JFD_KOREAN, AS2D_SOUND_JFD_LATINO, AS2D_SOUND_JFD_MALINESE, AS2D_SOUND_JFD_MAMLUKE*, AS2D_SOUND_JFD_MAYAN, AS2D_SOUND_JFD_MOHAWK, AS2D_SOUND_JFD_MONGOL, AS2D_SOUND_JFD_OTTOMAN, AS2D_SOUND_JFD_PERSIAN, AS2D_SOUND_JFD_POLISH, AS2D_SOUND_JFD_PORTUGUESE, AS2D_SOUND_JFD_ROMAN, AS2D_SOUND_JFD_RUSSIAN, AS2D_SOUND_JFD_SIAMESE, AS2D_SOUND_JFD_SIOUX, AS2D_SOUND_JFD_SPANISH, AS2D_SOUND_JFD_SUMERIAN, AS2D_SOUND_JFD_SWEDISH, AS2D_SOUND_JFD_TUPI*, AS2D_SOUND_JFD_VIKING, AS2D_SOUND_JFD_ZAPOTEC*, AS2D_SOUND_JFD_ZULU
	
	*Recommended to only use for Mercenary Units, as these have fewer tracks.
*/
 
-- This is an example of support which copies all attributes from an existing civ (i.e. Denmark). For the most part, this is probably all you'll need; just change 'CIVILIZATION_JFD_NORWAY' to the
-- tag of your custom civ. 
INSERT INTO Civilization_JFD_CultureTypes
        (CivilizationType,				ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT  ('CIVILIZATION_DMS_VENEZUELA'),	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_BRAZIL';
--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED (6676902b-b907-45f1-8db5-32dcb2135eee)
--==========================================================================================================================
--PROMOTION_JFD_SNOW_IMMUNITY, PROMOTION_JFD_DESERT_IMMUNITY, PROMOTION_JFD_DISEASE_IMMUNITY, PROMOTION_JFD_JUNGLE_IMMUNITY, PROMOTION_JFD_SCUVRY_IMMUNITY
INSERT INTO Unit_FreePromotions
        (UnitType,						PromotionType)
SELECT  ('UNIT_DMS_VE_NILANGAL'),		('PROMOTION_JFD_JUNGLE_IMMUNITY')
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_JUNGLE_IMMUNITY');
--==========================================================================================================================    
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
        (LeaderType,					FlavorType,					Flavor)
VALUES  ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_MERCENARY',		7);
--==========================================================================================================================    
-- JFD's PIETY (eea66053-7579-481a-bb8d-2f3959b59974)
--==========================================================================================================================    
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-12 may be set. This value determines the diplomatic penalty/bonus with civilizations of a different/same state religion
--A value higher than 9 means this civilization will never secularise. A value of 0 means this civilization has no interest in State Religion.
INSERT INTO Leader_Flavors
        (LeaderType,					FlavorType,                             Flavor)
VALUES  ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     3),
		('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_STATE_RELIGION',			3);
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
SELECT  ('CIVILIZATION_DMS_VENEZUELA'),		CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_BRAZIL'; 
--==========================================================================================================================    
-- JFD's SOVEREIGNTY (d99bf7aa-51ac-4bef-bd88-d765b28e260e)
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
        (CivilizationType,				LegislatureName,										OfficeTitle,	GovernmentType,				Weight)
VALUES  ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_LEGISLATURE_CIVILIZATION_DMS_VENEZUELA',	null,			'GOVERNMENT_JFD_REPUBLIC',  85);
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
        (CivilizationType,				HeadOfGovernmentName)
VALUES  ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_1'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_2'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_3'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_4'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_5'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_6'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_7'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_8'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_9'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_10'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_11'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_12'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_13'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_14'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_15'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_16'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_17'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_18'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_19'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_20'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_21'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_22'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_23'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_24'),
        ('CIVILIZATION_DMS_VENEZUELA',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_DMS_VENEZUELA_25');
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
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);
------------------------------------------------------------
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
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
        (LeaderType,					FlavorType,                         Flavor)
VALUES  ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_REFORM_GOVERNMENT',     3),
		('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_REFORM_LEGAL',			4),
        ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_REFORM_CULTURE',        1),
        ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_REFORM_ECONOMIC',       2),
        ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_REFORM_FOREIGN',        6),
        ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_REFORM_INDUSTRY',       2),
        ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_REFORM_MILITARY',       6),
        ('LEADER_DMS_HUGO_CHAVEZ',		'FLAVOR_JFD_REFORM_RELIGION',       1);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  												text 	REFERENCES Leaders(Type) 				default	null,
	ReformType													text											default	null);
--==========================================================================================================================	
-- JFD's DYNAMIC TOP PANEL
--==========================================================================================================================			
-- JFD_TopPanelIncludes
------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_TopPanelIncludes (
	FileName				text		default null);
	
INSERT INTO JFD_TopPanelIncludes
		(FileName)
VALUES	('DMS_VenezuelaDynamicTopPanelSupport.lua');
------------------------------		
-- JFD_TopPanelAdditions
------------------------------		
CREATE TABLE IF NOT EXISTS 
	JFD_TopPanelAdditions (
	CivilizationType		text		REFERENCES Civilizations(Type) 	default null,
	YieldType  				text 										default null,
	YieldSourceFunction 	text										default null,
	YieldSourceToolTip		text										default	null,
	MiscToolTipFunction		text										default	null);
	
INSERT OR REPLACE INTO JFD_TopPanelAdditions
		(CivilizationType,				YieldType,			YieldSourcefunction,					YieldSourceToolTip)
VALUES	('CIVILIZATION_DMS_VENEZUELA',	'YIELD_CULTURE',	'DMS_GetCultureFromCivsDenounced',		'TXT_KEY_DMS_BOLIVARIAN_SOCIALISM_DTP_HELP');
--==========================================================================================================================	
-- The Enlightenment Era
--==========================================================================================================================
--==========================================================================================================================        
--==========================================================================================================================