--==========================================================================================================================
-- USER SETTINGS (THIS IS NEEDED IN MOST CASES)
--==========================================================================================================================
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);
--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23 / 24)
--==========================================================================================================================
/*
Tables (example below; replace Civilizations with MinorCivilizations where appropriate):
   
v22
    Civilizations_YagemStartPosition (Earth Giant)
    Civilizations_YahemStartPosition (Earth Huge)
    Civilizations_GreatestEarthStartPosition
    Civilizations_EuroLargeStartPosition
     
v23
    Civilizations_EuroGiantStartPosition
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


CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_KHAMUG',			76,		73);
-------------------------------------
-- Civilizations_YagemRequestedResource (Earth Giant)
-------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_KHAMUG',	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_MONGOL';

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
    ConstructionAudio                           text											default null);
	
INSERT INTO BuildingClass_ConstructionAudio 
		(BuildingClassType, ConstructionAudio)
SELECT	Type,				'AS2D_BUILDING_JFD_WALLS'
FROM BuildingClasses WHERE Type IN ('BUILDINGCLASS_WALLS')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1);
	
--The following will override any entries for the above.
CREATE TABLE IF NOT EXISTS
Building_ConstructionAudio (
    BuildingType                                text    REFERENCES Buildings(Type)              default null,
    ConstructionAudio                           text											default null);
	
INSERT INTO Building_ConstructionAudio 
		(BuildingType, 				ConstructionAudio)
SELECT	'BUILDING_COFFEE_HOUSE',	'AS2D_BUILDING_JFD_COFFEE_HOUSE'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1);

--If you wish to add your own unique sounds, the beginning Jingle can be found here:
--https://www.dropbox.com/s/p5llo4y55ym4toa/StarterSfx.wav?dl=0
--==========================================================	
-- COLONIES 
--==========================================================	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);
	
/*
Linguistic Types:
JFD_Germanic, JFD_Latinate, JFD_Tai_Khmer, JFD_Austronesian, JFD_Arabic, JFD_Slavic, JFD_Mesopotamian, JFD_Mesoamerican, JFD_Oriental,
JFD_Finno_Ugric, JFD_Semitic, JFD_Hellenic, JFD_Bantu, JFD_Songhay, JFD_Indo_Iranian, JFD_Altaic, JFD_Celtic, JFD_NorthAmerican, JFD_Quechumaran
*/
INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 					ColonyName,		LinguisticType)
VALUES	('CIVILIZATION_KHAMUG', 			null,			'JFD_Altaic'),
		('CIVILIZATION_KHAMUG', 			null,			'JFD_Altaic'),
		('CIVILIZATION_KHAMUG', 			null,			null),
		('CIVILIZATION_KHAMUG', 			null,			null),
		('CIVILIZATION_KHAMUG', 			null,			null),
		('CIVILIZATION_KHAMUG', 			null,			null),
		('CIVILIZATION_KHAMUG', 			null,			null);
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
		(LeaderType,			FlavorType,						Flavor)
VALUES	('LEADER_JAMUKHA',		'FLAVOR_JFD_DECOLONIZATION',	8);
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
--This is an example of support which copies all attributes from an existing civ (i.e. Denmark). For the most part, this is probably all you'll need; just change 'CIVILIZATION_KHAMUG' to the
--tag of your custom civ. 
INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'CIVILIZATION_KHAMUG',	DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_MONGOL';
--==========================================================	
-- SLAVERY 
--==========================================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
--A value of 0-10 may be set. This value determines the proclivity a civ has toward enslaving a captured city and toward spending Slavery on Units.
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,					Flavor)
VALUES	('LEADER_JAMUKHA',	'FLAVOR_JFD_SLAVERY',		2);
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
  CULTURE_JFD_ABORIGINAL, CULTURE_JFD_ANDEAN, CULTURE_JFD_BANTU, CULTURE_JFD_BHARATA, CULTURE_JFD_CENTRAL, CULTURE_JFD_CLASSICAL, CULTURE_JFD_COLONIAL, CULTURE_JFD_EASTERN, CULTURE_JFD_EAST_INDIES, CULTURE_JFD_GREAT_PLAINS, CULTURE_JFD_HIMALAYAN, CULTURE_JFD_IRANIAN, CULTURE_JFD_ISLAMIC, CULTURE_JFD_KATUJE, CULTURE_JFD_MANDALA, CULTURE_JFD_MESOAMERICAN, CULTURE_JFD_MESOPOTAMIC, CULTURE_JFD_NORTHERN, CULTURE_JFD_OCEANIC, CULTURE_JFD_ORIENTAL, CULTURE_JFD_PACIFIC, CULTURE_JFD_POLAR, CULTURE_JFD_SEMITIC, CULTURE_JFD_STEPPE, CULTURE_JFD_SOUTHERN, CULTURE_JFD_TOTALITARIAN, CULTURE_JFD_WEST_AFRICAN, CULTURE_JFD_WESTERN, CULTURE_JFD_WOODLANDS

SplashScreenTags (As above, unless otherwise specified):
   As above in single word lower-case, e.g. CULTURE_JFD_CENTRAL = JFD_Central, CULTURE_JFD_WEST_AFRICAN = JFD_WestAfrican
   JFD_ColonialLatin, JFD_NorthernCeltic, JFD_OrientalJapanese, JFD_SouthernPapal
  
SoundtrackTag (As above, unless otherwise specified):
  As above in single word lower-case, e.g. CULTURE_JFD_CENTRAL = JFD_Central, CULTURE_JFD_WEST_AFRICAN = JFD_WestAfrican
  JFD_MesopotamicEgyptian, JFD_NorthernCeltic, JFD_OrientalJapanese
  
 UnitDialogueTag:
	AS2D_SOUND_JFD_AMERICAN, AS2D_SOUND_JFD_AMERICAN_WEST, AS2D_SOUND_JFD_ALBANIAN*, AS2D_SOUND_JFD_ARABIC, AS2D_SOUND_JFD_AZTEC, AS2D_SOUND_JFD_BABYLONIAN, AS2D_SOUND_JFD_BERBER*, AS2D_SOUND_JFD_BYZANTINE, AS2D_SOUND_JFD_CARTHAGINIAN, AS2D_SOUND_JFD_CELTIC, AS2D_SOUND_JFD_CHINESE, AS2D_SOUND_JFD_COMANCHE*, AS2D_SOUND_JFD_DUTCH, AS2D_SOUND_JFD_EGYPTIAN, AS2D_SOUND_JFD_ENGLISH, AS2D_SOUND_JFD_ETHIOPIAN, AS2D_SOUND_JFD_FINNISH*, AS2D_SOUND_JFD_FRENCH, AS2D_SOUND_JFD_GAELIC*, AS2D_SOUND_JFD_GERMAN, AS2D_SOUND_JFD_GREEK, AS2D_SOUND_JFD_HOLY_ROMAN, AS2D_SOUND_JFD_HUNNIC, AS2D_SOUND_JFD_INCAN, AS2D_SOUND_JFD_INDIAN, AS2D_SOUND_JFD_ITALIAN, AS2D_SOUND_JFD_JAPANESE, AS2D_SOUND_JFD_KHMER, AS2D_SOUND_JFD_KOREAN, AS2D_SOUND_JFD_MALINESE, AS2D_SOUND_JFD_MAMLUKE*, AS2D_SOUND_JFD_MAYAN, AS2D_SOUND_JFD_MOHAWK, AS2D_SOUND_JFD_MONGOL, AS2D_SOUND_JFD_OTTOMAN, AS2D_SOUND_JFD_PERSIAN, AS2D_SOUND_JFD_POLISH, AS2D_SOUND_JFD_PORTUGUESE, AS2D_SOUND_JFD_ROMAN, AS2D_SOUND_JFD_RUSSIAN, AS2D_SOUND_JFD_SIAMESE, AS2D_SOUND_JFD_SIOUX, AS2D_SOUND_JFD_SPANISH, AS2D_SOUND_JFD_SUMERIAN, AS2D_SOUND_JFD_SWEDISH, AS2D_SOUND_JFD_TUPI*, AS2D_SOUND_JFD_VIKING, AS2D_SOUND_JFD_ZAPOTEC*, AS2D_SOUND_JFD_ZULU
	
	*Recommended to only use for Mercenary Units, as these have fewer tracks.
*/

--This is an example of support which copies all attributes from an existing civ (i.e. Denmark). For the most part, this is probably all you'll need; just change 'CIVILIZATION_KHAMUG' to the
--tag of your custom civ. 
INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,		ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_KHAMUG',	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_MONGOL';

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Steppe'
WHERE Type = 'CIVILIZATION_KHAMUG'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Steppe');

--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED (6676902b-b907-45f1-8db5-32dcb2135eee)
--==========================================================================================================================
--PROMOTION_JFD_SNOW_IMMUNITY, PROMOTION_JFD_DESERT_IMMUNITY, PROMOTION_JFD_DISEASE_IMMUNITY, PROMOTION_JFD_JUNGLE_IMMUNITY, PROMOTION_JFD_SCUVRY_IMMUNITY
INSERT INTO Unit_FreePromotions
		(UnitType, 				PromotionType)
SELECT	'UNIT_KHAMUG_HAWK_RIDER',	'PROMOTION_JFD_DESERT_IMMUNITY'
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_DESERT_IMMUNITY');
--==========================================================================================================================	
-- JFD's AND POUAKAI's MERCENARIES (a19351c5-c0b3-4b07-8695-4affaa199949)
--==========================================================================================================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
--A value of 0-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,					Flavor)
VALUES	('LEADER_JFD_JAMUKHA',	'FLAVOR_JFD_MERCENARY',			4);
--==========================================================================================================================	
-- JFD's RISE TO POWER (eea66053-7579-481a-bb8d-2f3959b59974)
--==========================================================================================================================	
-- PIETY
--==========================================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
--Religous Intolerance: A value of 0-12 may be set. This value determines the diplomatic penalty/bonus with civilizations of a different/same state religion
--State Religion: A value of 0-12 may be set. This value determines the chance to adopt a State Religion. A value higher than 9 means this civilization will never secularise. A value of 0 means this civilization has no interest in State Religion.
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_JAMUKHA',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		0),
		('LEADER_JAMUKHA',		'FLAVOR_JFD_STATE_RELIGION',			6);
--==========================================================	
-- PROSPERITY
--==========================================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,					CurrencyType)
SELECT	'CIVILIZATION_KHAMUG',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_MONGOL';	
--==========================================================	
-- SOVEREIGNTY
--==========================================================
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

--This table determines a variety of things relating to your Government.
--The LegislatureName refers to the name of your Legislature (e.g. the Imperial Diet). 
--The OfficeTitle refers to the title of your Head of Government (e.g. Vizier. Default is Prime Minister)
--GovernmentType and Weight prefer to a Government preference (GOVERNMENT_JFD_MONARCHY or GOVERNMENT_JFD_REPUBLIC or GOVERNMENT_JFD_THEOCRACY or GOVERNMENT_JFD_DICTATORSHIP) and how strong that preference is.
INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					LegislatureName, 									OfficeTitle, 												GovernmentType, 			Weight)
VALUES	('CIVILIZATION_KHAMUG',	'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_MONGOL', 	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MONGOL', 	'GOVERNMENT_JFD_MONARCHY', 		70);
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

--These are the Heads of your Government, which are randomly chosen when a new Legislature is formed.
--The standard number for each civ is 25. However, you may leave this table empty and your civ will call
--from a cultural list (so long as you have Cultural Diversity support).
INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      				HeadOfGovernmentName)
VALUES  ('CIVILIZATION_KHAMUG',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MONGOL_1');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	ReligionType					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

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
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,					DefaultTitle,									UniqueTitle)
VALUES	('CIVILIZATION_KHAMUG',	'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER',	'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER_MONGOL');
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

--This lists all the unique names for a civ's political parties.
--Political Parties are as follows:
----FACTION_JFD_NATIONALIST
----FACTION_JFD_POPULARIST
----PARTY_JFD_BURGHERS
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
		(CivilizationType,					PoliticsType, 				UniqueName)
VALUES	('CIVILIZATION_KHAMUG',	'PARTY_JFD_REVOLUTIONARY',	'TXT_KEY_JFD_PARTY_JFD_REVOLUTIONARY_MONGOL');
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
--A value of 1-4 will favour Left Reforms. A value of 5-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,							Flavor)
VALUES	('LEADER_JAMUKHA',	'FLAVOR_JFD_REFORM_GOVERNMENT',		6),
		('LEADER_JAMUKHA',	'FLAVOR_JFD_REFORM_LEGAL',			3),
		('LEADER_JAMUKHA',	'FLAVOR_JFD_REFORM_CULTURE',		8),
		('LEADER_JAMUKHA',	'FLAVOR_JFD_REFORM_ECONOMIC',		4),
		('LEADER_JAMUKHA',	'FLAVOR_JFD_REFORM_FOREIGN',		6),
		('LEADER_JAMUKHA',	'FLAVOR_JFD_REFORM_INDUSTRY',		7),
		('LEADER_JAMUKHA',	'FLAVOR_JFD_REFORM_MILITARY',		10),
		('LEADER_JAMUKHA',	'FLAVOR_JFD_REFORM_RELIGION',		4);

--==========================================================================================================================		
--==========================================================================================================================		
