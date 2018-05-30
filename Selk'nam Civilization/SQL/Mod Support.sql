                               -- Gedemon's Mods --

-- R.E.D. Modpack
UPDATE Civilizations 
SET ArtStyleSuffix = '_INCA'
WHERE Type = 'CIVILIZATION_SELKNAM'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_INCA');

-- Yet (Not) Another Earths Map Pack
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasGiantStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_SELKNAM',		86,		3);

CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaGiantStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_SELKNAM',		55,		6);

CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaHugeStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_SELKNAM',		41,		6);


CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaCentralGiantStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_SELKNAM',		75,		8);


CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaHugeStartPosition
			(Type,									X,		Y)
VALUES		('CIVILIZATION_SELKNAM',		56,		8);

                              -- Pre Visula and Gedemo's Mods --

-- Ethnic Units							  
UPDATE Civilizations SET ArtStyleSuffix = 
	( CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = "_INCA")
		THEN "_INCA"
		ELSE "_AMER" END
	) WHERE Type = "CIVILIZATION_SELKNAM"; 

	                          -- Bingle's Mods --

-- Civ IV Leader Traits in Civ V

CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,            TraitOne,                TraitTwo)
SELECT  'LEADER_XOON',		'POLICY_PROTECTIVE_X',	 'POLICY_SPIRITUAL_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_SPIRITUAL_X');


UPDATE Leaders 
SET Description = 'XOON [ICON_CULTURE][ICON_PEACE]'
WHERE Type = 'LEADER_XOON'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_EXPANSIVE_X');

                            -- Tomatekh's Mods --

-- Historical Religions Complete

UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type="RELIGION_TEMAUKELISM" )
		THEN "RELIGION_TEMAUKELISM"
		ELSE "RELIGION_CHRISTIANITY" END
	) WHERE CivilizationType = "CIVILIZATION_SELKNAM";

	CREATE TRIGGER ReligionSELKNAMMod
AFTER INSERT ON Religions WHEN 'RELIGION_TEMAUKELISM' = NEW.Type
BEGIN
	UPDATE Civilization_Religions 
	SET ReligionType = 'RELIGION_TEMAUKELISM'
	WHERE CivilizationType IN (CIVILIZATION_SELKNAM);
END;

                           -- Hazel's Mods --

-- Map Labels

CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,					CultureType,		CultureEra)
VALUES		('CIVILIZATION_SELKNAM',	'MOD_TP_SOUTH_AMERICAN',	'ANY');

                           -- JFD's Mods --

-- Cultural Diversity

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	CultureType 								text										default null,
	SplashScreenTag								text										default	null,
	SoundtrackTag								text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_CultureTypes
			(CivilizationType,					CultureType,		SplashScreenTag,	SoundtrackTag)
VALUES		('CIVILIZATION_SELKNAM',	'JFD_Andean',	'JFD_Andean',	'JFD_Andean');

UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_Andean' )
	THEN 'JFD_Andean'
	ELSE 'Inca' END) 
WHERE Type = 'CIVILIZATION_SELKNAM';

-- Global UserSettings

CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);

-- Civilopedia

CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);

-- Cities in Development

CREATE TABLE IF NOT EXISTS
BuildingClass_ConstructionAudio (
    BuildingClassType                           text    REFERENCES BuildingClasses(Type)        default null,
    ConstructionAudio                           text											default null);

INSERT INTO BuildingClass_ConstructionAudio 
		(BuildingClassType, ConstructionAudio)
SELECT	Type,				'AS2D_BUILDING_JFD_WALLS'
FROM BuildingClasses WHERE Type IN ('BUILDINGCLASS_WALLS')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1)

-- Colonies

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 						ColonyName,								LinguisticType)
VALUES	('CIVILIZATION_SELKNAM', 			null,									'JFD_Quechumaran'),
		('CIVILIZATION_SELKNAM', 			'TXT_KEY_COLONY_NAME_SELKNAM_01',	null),
		('CIVILIZATION_SELKNAM', 			'TXT_KEY_COLONY_NAME_SELKNAM_02',	null),
		('CIVILIZATION_SELKNAM', 			'TXT_KEY_COLONY_NAME_SELKNAM_03',	null),
		('CIVILIZATION_SELKNAM', 			'TXT_KEY_COLONY_NAME_SELKNAM_04',	null),
		('CIVILIZATION_SELKNAM', 			'TXT_KEY_COLONY_NAME_SELKNAM_05',	null);

-- Colony Flavours

INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,						Flavor)
VALUES	('LEADER_XOON',	'FLAVOR_JFD_DECOLONIZATION',	4);

-- Provinces

CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null, -- ignore this
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,				DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'CIVILIZATION_SELKNAM',	DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_INCA';

-- Slavery

INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_SLAVERY');

INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,					Flavor)
VALUES	('LEADER_XOON',	'FLAVOR_JFD_SLAVERY',		4);

-- Exploration Continued Expanded

INSERT INTO Unit_FreePromotions
		(UnitType, 					PromotionType)
SELECT	'UNIT_KMAL',		'PROMOTION_JFD_SNOW_IMMUNITY'
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_SNOW_IMMUNITY');

-- Mercenaries

INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');

INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,					Flavor)
VALUES	('LEADER_XOON',		'FLAVOR_JFD_MERCENARY',		7);

-- Piety 

INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');

INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_XOON',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		3),
		('LEADER_XOON',	'FLAVOR_JFD_STATE_RELIGION',			8);

-- Prosperity

CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,			CurrencyType)
SELECT	'CIVILIZATION_SELKNAM',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_INCA';

-- Sovereignty

CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType	  					text 		 												default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,				LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight)
VALUES	('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_SELKNAM', 	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM', 	'GOVERNMENT_JFD_MONARCHY', 	50);

CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  											text 	REFERENCES Civilizations(Type) 				default null,
	HeadOfGovernmentName										text 	 											default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      			HeadOfGovernmentName)
VALUES  ('CIVILIZATION_SELKNAM',		'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_1'),
        ('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_2'),
        ('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_3'),
        ('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_4'),
        ('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_5'),
        ('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_6'),
        ('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_7'),
        ('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_8'),
        ('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_9'),
        ('CIVILIZATION_SELKNAM',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_SELKNAM_10');

CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  											text 	REFERENCES Civilizations(Type) 				default null,
	ReligionType												text 	REFERENCES Religions(Type) 					default null,
	DefaultTitle												text 		 										default null,
	UniqueTitle													text 		 										default null,
	UseAdjective												boolean												default 0);	

INSERT INTO Civilization_JFD_Titles
        (CivilizationType,				DefaultTitle,										UniqueTitle)
VALUES  ('CIVILIZATION_SELKNAM',		'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_GOVERNMENT',	'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_GOVERNMENT_SELKNAM'),
		('CIVILIZATION_SELKNAM',		'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER',		'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER_SELKNAM'),
		('CIVILIZATION_SELKNAM',		'TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_LEADER',	'TXT_KEY_GOVERNMENT_JFD_PRINCIPALITY_TITLE_LEADER_SELKNAM'),
		('CIVILIZATION_SELKNAM',		'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER',		'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_LEADER_SELKNAM'),
		('CIVILIZATION_SELKNAM',		'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_GOVERNMENT',	'TXT_KEY_GOVERNMENT_JFD_MONARCHY_TITLE_GOVERNMENT_SELKNAM'),
		('CIVILIZATION_SELKNAM',		'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER',		'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER_SELKNAM'),
		('CIVILIZATION_SELKNAM',		'TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_LEADER',	'TXT_KEY_GOVERNMENT_JFD_DICTATORSHIP_TITLE_LEADER_SELKNAM');

CREATE TABLE IF NOT EXISTS 
	MinorCivilization_JFD_Titles (
	MinorCivilizationType  				text 		REFERENCES MinorCivilizations(Type)			default null,
	ReligionType						text 		REFERENCES Religions(Type) 					default null,
	UniqueGovernmentTitle				text 		 											default null,
	UniqueLeaderTitle					text 		 											default null);	
	
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,					UniqueGovernmentTitle,							UniqueLeaderTitle)
VALUES	('CIVILIZATION_SELKNAM',		'TXT_KEY_GOVERNMENT_SELKNAM_TRIBE_TITLE_LEADER',	'TXT_KEY_GOVERNMENT_JFD_TRIBE_TITLE_LEADER_SELKNAM');

CREATE TABLE IF NOT EXISTS 
	JFD_PrivyCouncillor_UniqueNames (
	PrivyCouncillorType  				text 										 	default null,
	PolicyType  						text 	REFERENCES Policies(Type) 				default null,
	CivilizationType					text	REFERENCES Civilizations(Type) 			default	null,
	CultureType							text											default	null,
	GovernmentType  					text 	 										default null,
	ReligionType						text	REFERENCES Religions(Type) 				default	null,
	UniqueName							text											default	null);

INSERT INTO JFD_PrivyCouncillor_UniqueNames	
		(PrivyCouncillorType,				CivilizationType,							UniqueName)
VALUES	('COUNCILLOR_JFD_CHANCELLOR',		'CIVILIZATION_SELKNAM',				'TXT_KEY_COUNCILLOR_JFD_CHANCELLOR_DESC_SELKNAM'),
		('COUNCILLOR_JFD_CHAPLAIN',			'CIVILIZATION_SELKNAM',				'TXT_KEY_COUNCILLOR_JFD_CHAPLAIN_DESC_SELKNAM'),
		('COUNCILLOR_JFD_MARSHAL',			'CIVILIZATION_SELKNAM',				'TXT_KEY_COUNCILLOR_JFD_MARSHAL_DESC_SELKNAM'),
		('COUNCILLOR_JFD_HERALD',			'CIVILIZATION_SELKNAM',				'TXT_KEY_COUNCILLOR_JFD_HERALD_DESC_SELKNAM'),
		('COUNCILLOR_JFD_STEWARD',			'CIVILIZATION_SELKNAM',				'TXT_KEY_COUNCILLOR_JFD_STEWARD_DESC_SELKNAM');

-- Politics and Reforms

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, 				UniqueName)
VALUES	('CIVILIZATION_SELKNAM',		'PARTY_JFD_NATIONALIST',	'TXT_KEY_JFD_PARTY_CHARRUA_SELKNAM');

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

INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,							Flavor)
VALUES	('LEADER_XOON',	'FLAVOR_JFD_REFORM_GOVERNMENT',		2),
		('LEADER_XOON',	'FLAVOR_JFD_REFORM_LEGAL',			3),
		('LEADER_XOON',	'FLAVOR_JFD_REFORM_CULTURE',		8),
		('LEADER_XOON',	'FLAVOR_JFD_REFORM_ECONOMIC',		4),
		('LEADER_XOON',	'FLAVOR_JFD_REFORM_FOREIGN',		7),
		('LEADER_XOON',	'FLAVOR_JFD_REFORM_INDUSTRY',		5),
		('LEADER_XOON',	'FLAVOR_JFD_REFORM_MILITARY',		6),
		('LEADER_XOON',	'FLAVOR_JFD_REFORM_RELIGION',		8);

CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  												text 	REFERENCES Leaders(Type) 				default	null,
	ReformType													text											default	null);

INSERT INTO Leader_Flavors
		(LeaderType,			ReformType)
VALUES	('LEADER_XOON',	'REFORM_JFD_CONFLICT_OFFENSE');

-- Inventions

CREATE TABLE IF NOT EXISTS 
    Civilization_JFD_Inventions (
    CivilizationType                                               text     REFERENCES Civilizations(Type)               default null,
    InventionType                                                  text                                                  default null,
    InventionPreference                                            text                                                  default null);
    
INSERT INTO Civilization_JFD_Inventions
        (CivilizationType,			InventionType,              InventionPreference)
SELECT  ('CIVILIZATION_SELKNAM'),InventionType,              InventionPreference)
FROM Civilization_JFD_Inventions WHERE CivilizationType = 'CIVILIZATION_INCA'; 

-- Dynamic Top Panel
CREATE TABLE IF NOT EXISTS 
	JFD_TopPanelIncludes (
	FileName				text		default null);
	
INSERT INTO JFD_TopPanelIncludes
		(FileName)
VALUES	('DMS_TangutDynamicTopPanelSupport.lua');                                          

                                         -- Sukritact's Mods --

-- Modular City Info Stack




-- Events and Decisions

CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('SELKNAM_Decisions.lua');

INSERT INTO Policies
		(Type,											PolicyCostModifier,		Description)
VALUES	('POLICY_DECISIONS_HOLD_HAIN',	-15,					'TXT_KEY_DECISIONS_HOLD_HAIN'),
		('POLICY_DECISIONS_HUNT_GUANACO',		0,						'TXT_KEY_DECISIONS_HUNT_GUANACO');
		
		                                  -- Gazebo's Mods --

-- Community Patch

CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);

UPDATE Buildings 
SET Help = 'TXT_KEY_BUILDING_HAIN_HUT_HELP_CBO'
WHERE Type = 'BUILDING_HAIN_HUT'
AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value = 1);

INSERT INTO Building_ResourceQuantityRequirements 	
		(BuildingType, 						ResourceType, Cost)
SELECT	'BUILDING_HAIN_HUT',		ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_SHRINE';	

                                          -- Pouakai's Mods --



	