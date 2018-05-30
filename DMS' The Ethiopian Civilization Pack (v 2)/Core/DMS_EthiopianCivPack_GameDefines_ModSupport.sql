--==========================================================================================================================
-- USER SETTINGS (THIS IS NEEDED IN MOST CASES)
--==========================================================================================================================
-- JFD_GlobalUserSettings
--------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
    Type                text            default null,
    Value               integer         default 1);

--==========================================================================================================================
-- SUKRITACT'S DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
--------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('DMS_Ethiopia_Decisions.lua');
--------------------------------
-- Policies
--------------------------------
INSERT INTO Policies 
		(Type,												Description) 
VALUES	('POLICY_DECISIONS_DMS_AKSUM_COINAGE',				'TXT_KEY_POLICY_DECISIONS_DMS_AKSUM_COINAGE'),
		('POLICY_DECISIONS_DMS_DUNGUR_PALACE',				'TXT_KEY_POLICY_DECISIONS_DMS_DUNGUR_PALACE'),
		('POLICY_DECISIONS_DMS_CENTRALIZATION_REFORMS',		'TXT_KEY_POLICY_DECISIONS_DMS_CENTRALIZATION_REFORMS');

UPDATE Policies
	SET SeaTradeRouteGoldChange = 200, LandTradeRouteGoldChange = 200
	WHERE Type = 'POLICY_DECISIONS_DMS_AKSUM_COINAGE';
--------------------------------
-- Policy_BuildingClassYieldChanges
--------------------------------
INSERT INTO Policy_BuildingClassYieldChanges 
		(PolicyType, 										BuildingClassType,			YieldType, 				YieldChange)
VALUES 	('POLICY_DECISIONS_DMS_AKSUM_COINAGE', 				'BUILDINGCLASS_PALACE',		'YIELD_GOLD', 			2),
		('POLICY_DECISIONS_DMS_DUNGUR_PALACE', 				'BUILDINGCLASS_WALLS',		'YIELD_FAITH', 			1),
		('POLICY_DECISIONS_DMS_DUNGUR_PALACE', 				'BUILDINGCLASS_CASTLE',		'YIELD_FAITH', 			1),
		('POLICY_DECISIONS_DMS_DUNGUR_PALACE', 				'BUILDINGCLASS_ARSENAL',	'YIELD_FAITH', 			1);
--------------------------------
-- Policy_GreatWorkYieldChanges
--------------------------------
INSERT INTO Policy_GreatWorkYieldChanges 
		(PolicyType, 																	YieldType, 				Yield)
VALUES 	('POLICY_DECISIONS_DMS_CENTRALIZATION_REFORMS', 								'YIELD_GOLD', 			2);
--------------------------------
-- BuildingClasses
--------------------------------
INSERT INTO BuildingClasses 	
		(Type, 						 		 							DefaultBuilding, 											Description)
VALUES	('BUILDINGCLASS_DECISIONS_DMS_DUNGUR_PALACE', 					'BUILDING_DECISIONS_DMS_DUNGUR_PALACE', 					'TXT_KEY_BUILDING_DECISIONS_DMS_DUNGUR_PALACE'),
		('BUILDINGCLASS_DECISIONS_DMS_ZAGWE_DYNASTY',					'BUILDING_DECISIONS_DMS_ZAGWE_DYNASTY', 					'TXT_KEY_BUILDING_DECISIONS_DMS_ZAGWE_DYNASTY'),
		('BUILDINGCLASS_DECISIONS_DMS_ELDAD_HA_DANI', 					'BUILDING_DECISIONS_DMS_ELDAD_HA_DANI', 					'TXT_KEY_BUILDING_DECISIONS_DMS_ELDAD_HA_DANI'),
		('BUILDINGCLASS_DECISIONS_DMS_KEBRA_NAGAST_WRITER', 			'BUILDING_DECISIONS_DMS_KEBRA_NAGAST_WRITER', 				'TXT_KEY_BUILDING_DECISIONS_DMS_KEBRA_NAGAST_WRITER'),
		('BUILDINGCLASS_DECISIONS_DMS_THEOLOGICAL_WORK', 				'BUILDING_DECISIONS_DMS_THEOLOGICAL_WORK', 					'TXT_KEY_BUILDING_DECISIONS_DMS_THEOLOGICAL_WORK'),
		('BUILDINGCLASS_DECISIONS_DMS_CENTRALIZATION_REFORMS', 			'BUILDING_DECISIONS_DMS_CENTRALIZATION_REFORMS', 			'TXT_KEY_BUILDING_DECISIONS_DMS_CENTRALIZATION_REFORMS'),
		('BUILDINGCLASS_DECISIONS_DMS_BANK_OF_ETHIOPIA', 				'BUILDING_DECISIONS_DMS_BANK_OF_ETHIOPIA', 					'TXT_KEY_BUILDING_DECISIONS_DMS_BANK_OF_ETHIOPIA'),
		('BUILDINGCLASS_DECISIONS_DMS_REWRITE_THE_CONSTITUTION', 		'BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION', 			'TXT_KEY_BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION'),
		('BUILDINGCLASS_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_CAPITAL','BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_CAPITAL', 	'TXT_KEY_BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_CAPITAL');
--------------------------------
-- Buildings
--------------------------------
INSERT INTO Buildings 	
		(Type, 						 								BuildingClass, 													Description,														GreatWorkCount, Cost, FaithCost, PrereqTech, 	NeverCapture)
VALUES	('BUILDING_DECISIONS_DMS_DUNGUR_PALACE', 					'BUILDINGCLASS_DECISIONS_DMS_DUNGUR_PALACE',					'TXT_KEY_BUILDING_DECISIONS_DMS_DUNGUR_PALACE',						-1, 			-1,   -1, 		 null,			1),
		('BUILDING_DECISIONS_DMS_ZAGWE_DYNASTY', 					'BUILDINGCLASS_DECISIONS_DMS_ZAGWE_DYNASTY',					'TXT_KEY_BUILDING_DECISIONS_DMS_ZAGWE_DYNASTY',						-1, 			-1,   -1, 		 null,			1),
		('BUILDING_DECISIONS_DMS_ELDAD_HA_DANI', 					'BUILDINGCLASS_DECISIONS_DMS_ELDAD_HA_DANI',					'TXT_KEY_BUILDING_DECISIONS_DMS_ELDAD_HA_DANI',						-1, 			-1,   -1, 		 null,			1),
		('BUILDING_DECISIONS_DMS_KEBRA_NAGAST_WRITER', 				'BUILDINGCLASS_DECISIONS_DMS_KEBRA_NAGAST_WRITER',				'TXT_KEY_BUILDING_DECISIONS_DMS_KEBRA_NAGAST_WRITER',				-1, 			-1,   -1, 		 null,			1),
		('BUILDING_DECISIONS_DMS_THEOLOGICAL_WORK', 				'BUILDINGCLASS_DECISIONS_DMS_THEOLOGICAL_WORK',					'TXT_KEY_BUILDING_DECISIONS_DMS_THEOLOGICAL_WORK',					-1, 			-1,   -1, 		 null,			1),
		('BUILDING_DECISIONS_DMS_CENTRALIZATION_REFORMS', 			'BUILDINGCLASS_DECISIONS_DMS_CENTRALIZATION_REFORMS',			'TXT_KEY_BUILDING_DECISIONS_DMS_CENTRALIZATION_REFORMS',			-1, 			-1,   -1, 		 null,			1),
		('BUILDING_DECISIONS_DMS_BANK_OF_ETHIOPIA', 				'BUILDINGCLASS_DECISIONS_DMS_BANK_OF_ETHIOPIA',					'TXT_KEY_BUILDING_DECISIONS_DMS_BANK_OF_ETHIOPIA',					-1, 			-1,   -1, 		 null,			1),
		('BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION',			'BUILDINGCLASS_DECISIONS_DMS_REWRITE_THE_CONSTITUTION',			'TXT_KEY_BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION',			-1, 			-1,   -1, 		 null,			1),
		('BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_CAPITAL', 'BUILDINGCLASS_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_CAPITAL',	'TXT_KEY_BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_CAPITAL',	-1, 			-1,   -1, 		 null,			1);

INSERT INTO Buildings
		(Type, 											BuildingClass,	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech,	Description,	Civilopedia,	Strategy,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,	PortraitIndex)
SELECT	('BUILDING_DECISIONS_DMS_KEBRA_NAGAST_TEMPLE'),	BuildingClass,	NULL,			-1,		0,					NULL,		Description,	Civilopedia,	Strategy,	ArtDefineTag,	MinAreaSize,	0,				HurryCostModifier,	IconAtlas,	PortraitIndex
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';

UPDATE Buildings
	SET ExtraMissionarySpreads = 1
	WHERE Type = 'BUILDING_DECISIONS_DMS_ELDAD_HA_DANI';

UPDATE Buildings
	SET BuildingProductionModifier = 10
	WHERE Type = 'BUILDING_DECISIONS_DMS_DUNGUR_PALACE';

UPDATE Buildings
	SET CultureRateModifier = 10
	WHERE Type = 'BUILDING_DECISIONS_DMS_ZAGWE_DYNASTY';
	
UPDATE Buildings
	SET Happiness = 4
	WHERE Type = 'BUILDING_DECISIONS_DMS_CENTRALIZATION_REFORMS';
	
UPDATE Buildings
	SET Happiness = 2
	WHERE Type = 'BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_CAPITAL';
------------------------------	
-- Building_Flavors
------------------------------
INSERT INTO Building_Flavors
		(BuildingType, 									FlavorType,		Flavor)
SELECT	('BUILDING_DECISIONS_DMS_KEBRA_NAGAST_TEMPLE'),	FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_TEMPLE';
------------------------------
-- Building_YieldChanges
------------------------------
INSERT INTO Building_YieldChanges
		(BuildingType, 									YieldType,		Yield)
SELECT	('BUILDING_DECISIONS_DMS_KEBRA_NAGAST_TEMPLE'),	YieldType,		Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_TEMPLE';
--------------------------------
-- Building_SpecialistYieldChanges
--------------------------------
INSERT INTO Building_SpecialistYieldChanges 
		(BuildingType, 										SpecialistType,				YieldType, 				Yield)
VALUES 	('BUILDING_DECISIONS_DMS_KEBRA_NAGAST_WRITER', 		'SPECIALIST_WRITER',		'YIELD_FAITH', 			2);
--------------------------------
-- Building_YieldModifiers
--------------------------------
INSERT INTO Building_YieldModifiers 
		(BuildingType, 																	YieldType, 				Yield)
VALUES 	('BUILDING_DECISIONS_DMS_BANK_OF_ETHIOPIA', 									'YIELD_GOLD', 			10);
--------------------------------
-- Building_YieldChangesPerPop
--------------------------------
INSERT INTO Building_YieldChangesPerPop 
		(BuildingType, 																	YieldType, 				Yield)
VALUES 	('BUILDING_DECISIONS_DMS_BANK_OF_ETHIOPIA', 									'YIELD_SCIENCE', 		25);
--------------------------------
-- Promotions
--------------------------------
INSERT INTO UnitPromotions 	
		(Type, 										Description,										Help,													Sound,				PortraitIndex,	IconAtlas,				PediaType,			PediaEntry,												CannotBeChosen)
VALUES	('PROMOTION_DECISIONS_DMS_QESTE_NIHB',		'TXT_KEY_PROMOTION_DECISIONS_DMS_QESTE_NIHB',		'TXT_KEY_PROMOTION_DECISIONS_DMS_QESTE_NIHB_HELP',		'AS2D_IF_LEVELUP',	33,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DECISIONS_DMS_QESTE_NIHB_HELP',		1),
		('PROMOTION_DECISIONS_DMS_HAREB_GONDA',		'TXT_KEY_PROMOTION_DECISIONS_DMS_HAREB_GONDA',		'TXT_KEY_PROMOTION_DECISIONS_DMS_HAREB_GONDA_HELP',		'AS2D_IF_LEVELUP',	33,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DECISIONS_DMS_HAREB_GONDA_HELP',		1),
		('PROMOTION_DECISIONS_DMS_TEKULA',			'TXT_KEY_PROMOTION_DECISIONS_DMS_TEKULA',			'TXT_KEY_PROMOTION_DECISIONS_DMS_TEKULA_HELP',			'AS2D_IF_LEVELUP',	33,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DECISIONS_DMS_TEKULA_HELP',			1),
		('PROMOTION_DECISIONS_DMS_AXUARAT_AXUARAI',	'TXT_KEY_PROMOTION_DECISIONS_DMS_AXUARAT_AXUARAI',	'TXT_KEY_PROMOTION_DECISIONS_DMS_AXUARAT_AXUARAI_HELP',	'AS2D_IF_LEVELUP',	33,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DECISIONS_DMS_AXUARAT_AXUARAI_HELP',	1);
-------------------------------- 
-- UnitPromotions_UnitCombats
--------------------------------
INSERT INTO UnitPromotions_UnitCombats 	
		(PromotionType, 							UnitCombatType)
VALUES	('PROMOTION_DECISIONS_DMS_QESTE_NIHB',		'UNITCOMBAT_ARCHER'),
		('PROMOTION_DECISIONS_DMS_QESTE_NIHB',		'UNITCOMBAT_SIEGE'),
		('PROMOTION_DECISIONS_DMS_HAREB_GONDA',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DECISIONS_DMS_TEKULA',			'UNITCOMBAT_RECON'),
		('PROMOTION_DECISIONS_DMS_AXUARAT_AXUARAI',	'UNITCOMBAT_SIEGE'),
		('PROMOTION_DECISIONS_DMS_AXUARAT_AXUARAI',	'UNITCOMBAT_GUN');
-------------------------------- 
-- Units
--------------------------------
INSERT INTO Units
		(Class, Type, 										Cost,	Moves,	CivilianAttackPriority,	Special,	Domain,	DefaultUnitAI,	Description,	Civilopedia,	Strategy,	AdvancedStartCost,	WorkRate,	CombatLimit,	BaseCultureTurnsToCount,	UnitArtInfo,	UnitArtInfoEraVariation,	UnitFlagAtlas,	UnitFlagIconOffset,	IconAtlas,	PortraitIndex,	MoveRate)
SELECT	Class,	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_1'),	-1,		Moves,	CivilianAttackPriority,	Special,	Domain,	DefaultUnitAI,	Description,	Civilopedia,	Strategy,	AdvancedStartCost,	WorkRate,	CombatLimit,	BaseCultureTurnsToCount,	UnitArtInfo,	UnitArtInfoEraVariation,	UnitFlagAtlas,	UnitFlagIconOffset,	IconAtlas,	PortraitIndex,	MoveRate
FROM Units WHERE (Type = 'UNIT_WRITER');

INSERT INTO Units
		(Class, Type, 										Cost,	Moves,	CivilianAttackPriority,	Special,	Domain,	DefaultUnitAI,	Description,	Civilopedia,	Strategy,	AdvancedStartCost,	WorkRate,	CombatLimit,	BaseCultureTurnsToCount,	UnitArtInfo,	UnitArtInfoEraVariation,	UnitFlagAtlas,	UnitFlagIconOffset,	IconAtlas,	PortraitIndex,	MoveRate)
SELECT	Class,	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_2'),	-1,		Moves,	CivilianAttackPriority,	Special,	Domain,	DefaultUnitAI,	Description,	Civilopedia,	Strategy,	AdvancedStartCost,	WorkRate,	CombatLimit,	BaseCultureTurnsToCount,	UnitArtInfo,	UnitArtInfoEraVariation,	UnitFlagAtlas,	UnitFlagIconOffset,	IconAtlas,	PortraitIndex,	MoveRate
FROM Units WHERE (Type = 'UNIT_WRITER');

INSERT INTO Units
		(Class, Type, 										Cost,	Moves,	CivilianAttackPriority,	Special,	Domain,	DefaultUnitAI,	Description,	Civilopedia,	Strategy,	AdvancedStartCost,	WorkRate,	CombatLimit,	BaseCultureTurnsToCount,	UnitArtInfo,	UnitArtInfoEraVariation,	UnitFlagAtlas,	UnitFlagIconOffset,	IconAtlas,	PortraitIndex,	MoveRate)
SELECT	Class,	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_3'),	-1,		Moves,	CivilianAttackPriority,	Special,	Domain,	DefaultUnitAI,	Description,	Civilopedia,	Strategy,	AdvancedStartCost,	WorkRate,	CombatLimit,	BaseCultureTurnsToCount,	UnitArtInfo,	UnitArtInfoEraVariation,	UnitFlagAtlas,	UnitFlagIconOffset,	IconAtlas,	PortraitIndex,	MoveRate
FROM Units WHERE (Type = 'UNIT_WRITER');
-------------------------------- 
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 									SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_1'),	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WRITER');

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 									SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_2'),	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WRITER');

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 									SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_3'),	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WRITER');
------------------------------
-- Unit_Flavors
------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 									FlavorType, Flavor)
SELECT	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_1'),	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WRITER');

INSERT INTO Unit_Flavors 	
		(UnitType, 									FlavorType, Flavor)
SELECT	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_2'),	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WRITER');

INSERT INTO Unit_Flavors 	
		(UnitType, 									FlavorType, Flavor)
SELECT	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_3'),	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WRITER');
------------------------------
-- Unit_UniqueNames
------------------------------
INSERT INTO Unit_UniqueNames 
		(UnitType, 									UniqueName,							GreatWorkType)
VALUES	('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_1', 	'TXT_KEY_UNIT_GREAT_WRITER_DMS_ZY',	'GREAT_WORK_DMS_MAHSAFA_BERHA'),
		('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_2', 	'TXT_KEY_UNIT_GREAT_WRITER_DMS_ZY',	'GREAT_WORK_DMS_MAHSAFA_MILAD'),
		('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_3', 	'TXT_KEY_UNIT_GREAT_WRITER_DMS_ZY',	'GREAT_WORK_DMS_MAHSAFA_SELASSIE');
------------------------------	
-- GreatWorks
------------------------------
INSERT INTO GreatWorks 
		(Type, 								GreatWorkClassType,			Description,								Quote,												Audio,							Image)
VALUES	('GREAT_WORK_DMS_MAHSAFA_BERHA', 	'GREAT_WORK_LITERATURE',	'TXT_KEY_GREAT_WORK_DMS_MAHSAFA_BERHA',		'TXT_KEY_GREAT_WORK_QUOTE_DMS_MAHSAFA_BERHA',		'AS2D_GREAT_ARTIST_ARTWORK',	'MahsafaBerhan_Background.dds'),
		('GREAT_WORK_DMS_MAHSAFA_MILAD', 	'GREAT_WORK_LITERATURE',	'TXT_KEY_GREAT_WORK_DMS_MAHSAFA_MILAD',		'TXT_KEY_GREAT_WORK_QUOTE_DMS_MAHSAFA_MILAD',		'AS2D_GREAT_ARTIST_ARTWORK',	'MahsafaMilad_Background.dds'),
		('GREAT_WORK_DMS_MAHSAFA_SELASSIE', 'GREAT_WORK_LITERATURE',	'TXT_KEY_GREAT_WORK_DMS_MAHSAFA_SELASSIE',	'TXT_KEY_GREAT_WORK_QUOTE_DMS_MAHSAFA_SELASSIE',	'AS2D_GREAT_ARTIST_ARTWORK',	'MahsafaSelassie_Background.dds');
--==========================================================================================================================
-- SUKRITACT'S EVENTS
--==========================================================================================================================
-- EventsAddin_Support
--------------------------------
--CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
--INSERT INTO EventsAddin_Support (FileName) VALUES ('DMS_Ethiopia_Events.lua');
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
VALUES	('POLICY_DECISIONS_DMS_AKSUM_COINAGE'),
		('POLICY_DECISIONS_DMS_DUNGUR_PALACE'),
		('POLICY_DECISIONS_DMS_CENTRALIZATION_REFORMS'),
		('BUILDING_DECISIONS_DMS_DUNGUR_PALACE'),
		('BUILDING_DECISIONS_DMS_ZAGWE_DYNASTY'),
		('BUILDING_DECISIONS_DMS_ELDAD_HA_DANI'),
		('BUILDING_DECISIONS_DMS_KEBRA_NAGAST_WRITER'),
		('BUILDING_DECISIONS_DMS_THEOLOGICAL_WORK'),
		('BUILDING_DECISIONS_DMS_CENTRALIZATION_REFORMS'),
		('BUILDING_DECISIONS_DMS_BANK_OF_ETHIOPIA'),
		('BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION'),
		('BUILDING_DECISIONS_DMS_REWRITE_THE_CONSTITUTION_CAP'),
		('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_1'),
		('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_2'),
		('UNIT_DECISIONS_DMS_THEOLOGICAL_WORK_3'),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_1'),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_2'),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_3'),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_4'),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_5'),
		('BUILDING_DMS_ZY_RELIGIOUS_PRESSURE'),
		('BUILDING_DMS_ZY_DEFENSE'),
		('BUILDING_DMS_HS_DELEGATE_TENET'),
		('BUILDING_DMS_AS_FREE_COURTHOUSE'),
		('BUILDING_DMS_AS_WLTKD_DUMMY'),
		('BUILDING_DMS_TRADE_ROUTE_SLOT_DUMMY'),
		('BUILDING_DMS_TRADE_ROUTE_GROWTH_DUMMY'),
		('BUILDING_DMS_PILLAGE_IMPROVEMENT_FAITH'),
		('BUILDING_DMS_MASGID_PRODUCTION_DUMMY'),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1'),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2'),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3'),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4'),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5'),
		('UNIT_DMS_SARAWIT_CHEAP_1'),
		('UNIT_DMS_SARAWIT_CHEAP_2'),
		('UNIT_DMS_SARAWIT_CHEAP_3'),
		('UNIT_DMS_SARAWIT_CHEAP_4'),
		('UNIT_DMS_SARAWIT_CHEAP_5'),
		('UNIT_DMS_SARAWIT_CHEAP_6'),
		('UNIT_DMS_SARAWIT_CHEAP_7'),
		('UNIT_DMS_SARAWIT_CHEAP_8'),
		('UNIT_DMS_MAKONNEN_NO_OIL'),
		('PROMOTION_DMS_SEED_OF_JACOB_1'),
		('PROMOTION_DMS_SEED_OF_JACOB_2'),
		('PROMOTION_DMS_SEED_OF_JACOB_3'),
		('PROMOTION_DMS_SEED_OF_JACOB_4'),
		('PROMOTION_DMS_SEED_OF_JACOB_5'),
		('PROMOTION_DMS_SEED_OF_JACOB_6'),
		('PROMOTION_DMS_SEED_OF_JACOB_7'),
		('PROMOTION_DMS_SEED_OF_JACOB_8'),
		('PROMOTION_DMS_SEED_OF_JACOB_9'),
		('PROMOTION_DMS_SEED_OF_JACOB_10'),
		('PROMOTION_DMS_SEED_OF_JACOB_11'),
		('PROMOTION_DMS_SEED_OF_JACOB_12'),
		('PROMOTION_DMS_SEED_OF_JACOB_13'),
		('PROMOTION_DMS_SEED_OF_JACOB_14'),
		('PROMOTION_DMS_SEED_OF_JACOB_15'),
		('PROMOTION_DMS_SEED_OF_JACOB_16'),
		('PROMOTION_DMS_SEED_OF_JACOB_17'),
		('PROMOTION_DMS_SEED_OF_JACOB_18'),
		('PROMOTION_DMS_SEED_OF_JACOB_19'),
		('PROMOTION_DMS_SEED_OF_JACOB_20'),
		('PROMOTION_DMS_SEED_OF_JACOB_21'),
		('PROMOTION_DMS_SEED_OF_JACOB_22'),
		('PROMOTION_DMS_SEED_OF_JACOB_23'),
		('PROMOTION_DMS_SEED_OF_JACOB_24'),
		('PROMOTION_DMS_SEED_OF_JACOB_25'),
		('PROMOTION_DMS_GREAT_MOTAR_1_GG'),
		('PROMOTION_DMS_GREAT_MOTAR_2_GG'),
		('PROMOTION_DMS_GREAT_MOTAR_3_GG'),
		('PROMOTION_DMS_GREAT_MOTAR_4_GG'),
		('PROMOTION_DMS_GREAT_MOTAR_5_GG'),
		('PROMOTION_DMS_GREAT_MOTAR_DEPLETED'),
		('PROMOTION_DMS_ZEBENYA_1_STRENGTH'),
		('PROMOTION_DMS_ZEBENYA_2_STRENGTH'),
		('PROMOTION_DMS_ZEBENYA_3_STRENGTH'),
		('PROMOTION_DMS_ZEBENYA_4_STRENGTH'),
		('PROMOTION_DMS_ZEBENYA_5_STRENGTH'),
		('PROMOTION_DMS_AFTERRANDOM');
--==========================================================================================================================
-- JFD's CITIES IN DEVELOPMENT (10e9728f-d61c-4317-be4f-7d52d6bae6f4)
-- Please Note: it is NOT necessary to make any changes to this if you had supported Colony Names under the ExCE ID. 
-- You will only need to add support for Claims if you wish some of your Decisions to cost Dignitaries instead of Magistrates. Examples TBD.
--==========================================================================================================================
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
	
INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 							ColonyName,								LinguisticType)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB', 			null,									'JFD_Semitic'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		null,									'JFD_Semitic'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		null,									'JFD_Semitic'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	null,									'JFD_Semitic'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			null,									'JFD_Semitic');
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
VALUES	('LEADER_DMS_KALEB',	'FLAVOR_JFD_DECOLONIZATION',	7),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_DECOLONIZATION',	8),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_DECOLONIZATION',	7),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_DECOLONIZATION',	5),
		('LEADER_DMS_MENELIK_II','FLAVOR_JFD_DECOLONIZATION',	6);
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

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'LEADER_DMS_KALEB',			DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'LEADER_DMS_GUDIT',			DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'LEADER_DMS_SEYON_I',		DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'LEADER_DMS_YAQOB',			DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'LEADER_DMS_MENELIK_II',	DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
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
VALUES	('LEADER_DMS_KALEB',	'FLAVOR_JFD_SLAVERY',		6),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_SLAVERY',		5),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_SLAVERY',		9),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_SLAVERY',		7),
		('LEADER_DMS_MENELIK_II','FLAVOR_JFD_SLAVERY',		5);
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

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,							ArtDefineTag,	CultureType,			IdealsTag,		SplashScreenTag,		SoundtrackTag,			UnitDialogueTag)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',			'_JFD_SEMITIC', 'CULTURE_JFD_SEMITIC',	'JFD_Semitic',	'JFD_SemiticEthiopic',	'JFD_SemiticEthiopic',	'AS2D_SOUND_JFD_ETHIOPIAN'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'_JFD_SEMITIC', 'CULTURE_JFD_SEMITIC',	'JFD_Semitic',	'JFD_SemiticEthiopic',	'JFD_SemiticEthiopic',	'AS2D_SOUND_JFD_ETHIOPIAN'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'_JFD_SEMITIC', 'CULTURE_JFD_SEMITIC',	'JFD_Semitic',	'JFD_SemiticEthiopic',	'JFD_SemiticEthiopic',	'AS2D_SOUND_JFD_ETHIOPIAN'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II',	'_JFD_SEMITIC', 'CULTURE_JFD_SEMITIC',	'JFD_Semitic',	'JFD_SemiticEthiopic',	'JFD_SemiticEthiopic',	'AS2D_SOUND_JFD_ETHIOPIAN'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',			'_JFD_SEMITIC', 'CULTURE_JFD_SEMITIC',	'JFD_Semitic',	'JFD_SemiticEthiopic',	'JFD_SemiticEthiopic',	'AS2D_SOUND_JFD_ETHIOPIAN');

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_SemiticEthiopic'
WHERE Type = 'CIVILIZATION_DMS_AKSUM_KALEB'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_SemiticEthiopic');

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_SemiticEthiopic'
WHERE Type = 'CIVILIZATION_DMS_ETHIOPIA_SEYON_I'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_SemiticEthiopic');

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_SemiticEthiopic'
WHERE Type = 'CIVILIZATION_DMS_ETHIOPIA_YAQOB'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_SemiticEthiopic');

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_SemiticEthiopic'
WHERE Type = 'CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_SemiticEthiopic');

UPDATE Civilizations 
SET SoundtrackTag = 'JFD_SemiticEthiopic'
WHERE Type = 'CIVILIZATION_DMS_SEMIEN_GUDIT'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_SemiticEthiopic');
--==========================================================================================================================
-- JFD's EXPLORATION CONTINUED EXPANDED (6676902b-b907-45f1-8db5-32dcb2135eee)
--==========================================================================================================================
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
VALUES	('LEADER_DMS_KALEB',		'FLAVOR_JFD_MERCENARY',		5),
		('LEADER_DMS_SEYON_I',		'FLAVOR_JFD_MERCENARY',		7),
		('LEADER_DMS_YAQOB',		'FLAVOR_JFD_MERCENARY',		5),
		('LEADER_DMS_MENELIK_II',	'FLAVOR_JFD_MERCENARY',		2),
		('LEADER_DMS_GUDIT',		'FLAVOR_JFD_MERCENARY',		7);
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
VALUES	('LEADER_DMS_KALEB',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		8),
		('LEADER_DMS_KALEB',	'FLAVOR_JFD_STATE_RELIGION',			9),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		7),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_STATE_RELIGION',			7),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		9),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_STATE_RELIGION',			10),
		('LEADER_DMS_MENELIK_II','FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	3),
		('LEADER_DMS_MENELIK_II','FLAVOR_JFD_STATE_RELIGION',			6),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		8),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_STATE_RELIGION',			8);
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
		(CivilizationType,				CurrencyType)
SELECT	'CIVILIZATION_DMS_AKSUM_KALEB',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';	

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,				CurrencyType)
SELECT	'CIVILIZATION_DMS_ETHIOPIA_SEYON_I',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';	

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,				CurrencyType)
SELECT	'CIVILIZATION_DMS_ETHIOPIA_YAQOB',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';	

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,				CurrencyType)
SELECT	'CIVILIZATION_DMS_ETHIOPIA_MENELIK_II',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';	

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,				CurrencyType)
SELECT	'CIVILIZATION_DMS_SEMIEN_GUDIT',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
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
		(CivilizationType,					LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight)
SELECT	'CIVILIZATION_DMS_AKSUM_KALEB',		LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight)
SELECT	'CIVILIZATION_DMS_ETHIOPIA_SEYON_I',LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight)
SELECT	'CIVILIZATION_DMS_ETHIOPIA_YAQOB',	LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight)
SELECT	'CIVILIZATION_DMS_ETHIOPIA_MENELIK_II',	LegislatureName, 										OfficeTitle, 														GovernmentType, 			Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight)
SELECT	'CIVILIZATION_DMS_SEMIEN_GUDIT',	LegislatureName, 											OfficeTitle, 														GovernmentType, 			Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
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
        (CivilizationType,      			HeadOfGovernmentName)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),	HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      			HeadOfGovernmentName)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      			HeadOfGovernmentName)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      			HeadOfGovernmentName)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      			HeadOfGovernmentName)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),	HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');
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

INSERT INTO Civilization_JFD_Titles
		(CivilizationType,					DefaultTitle,									UniqueTitle)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),	DefaultTitle,									UniqueTitle
FROM Civilization_JFD_Titles WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_Titles
		(CivilizationType,					DefaultTitle,									UniqueTitle)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	DefaultTitle,									UniqueTitle
FROM Civilization_JFD_Titles WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_Titles
		(CivilizationType,					DefaultTitle,									UniqueTitle)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	DefaultTitle,									UniqueTitle
FROM Civilization_JFD_Titles WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_Titles
		(CivilizationType,					DefaultTitle,									UniqueTitle)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	DefaultTitle,									UniqueTitle
FROM Civilization_JFD_Titles WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_Titles
		(CivilizationType,					DefaultTitle,									UniqueTitle)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),	DefaultTitle,									UniqueTitle
FROM Civilization_JFD_Titles WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, 				UniqueName)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),	PoliticsType, 				UniqueName
FROM Civilization_JFD_Politics WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, 				UniqueName)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	PoliticsType, 				UniqueName
FROM Civilization_JFD_Politics WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, 				UniqueName)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	PoliticsType, 				UniqueName
FROM Civilization_JFD_Politics WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, 				UniqueName)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	PoliticsType, 				UniqueName
FROM Civilization_JFD_Politics WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					PoliticsType, 				UniqueName)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),	PoliticsType, 				UniqueName
FROM Civilization_JFD_Politics WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');
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
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,							Flavor)
VALUES	('LEADER_DMS_KALEB',	'FLAVOR_JFD_REFORM_GOVERNMENT',		7),
		('LEADER_DMS_KALEB',	'FLAVOR_JFD_REFORM_LEGAL',			7),
		('LEADER_DMS_KALEB',	'FLAVOR_JFD_REFORM_CULTURE',		4),
		('LEADER_DMS_KALEB',	'FLAVOR_JFD_REFORM_ECONOMIC',		6),
		('LEADER_DMS_KALEB',	'FLAVOR_JFD_REFORM_FOREIGN',		4),
		('LEADER_DMS_KALEB',	'FLAVOR_JFD_REFORM_INDUSTRY',		6),
		('LEADER_DMS_KALEB',	'FLAVOR_JFD_REFORM_MILITARY',		6),
		('LEADER_DMS_KALEB',	'FLAVOR_JFD_REFORM_RELIGION',		8),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_REFORM_GOVERNMENT',		8),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_REFORM_LEGAL',			8),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_REFORM_CULTURE',		5),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_REFORM_ECONOMIC',		5),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_REFORM_FOREIGN',		8),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_REFORM_INDUSTRY',		7),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_REFORM_MILITARY',		9),
		('LEADER_DMS_SEYON_I',	'FLAVOR_JFD_REFORM_RELIGION',		6),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_REFORM_GOVERNMENT',		5),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_REFORM_LEGAL',			8),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_REFORM_CULTURE',		3),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_REFORM_ECONOMIC',		5),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_REFORM_FOREIGN',		5),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_REFORM_INDUSTRY',		5),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_REFORM_MILITARY',		6),
		('LEADER_DMS_YAQOB',	'FLAVOR_JFD_REFORM_RELIGION',		10),
		('LEADER_DMS_MENELIK_II',	'FLAVOR_JFD_REFORM_GOVERNMENT',	7),
		('LEADER_DMS_MENELIK_II',	'FLAVOR_JFD_REFORM_LEGAL',		6),
		('LEADER_DMS_MENELIK_II',	'FLAVOR_JFD_REFORM_CULTURE',	4),
		('LEADER_DMS_MENELIK_II',	'FLAVOR_JFD_REFORM_ECONOMIC',	6),
		('LEADER_DMS_MENELIK_II',	'FLAVOR_JFD_REFORM_FOREIGN',	3),
		('LEADER_DMS_MENELIK_II',	'FLAVOR_JFD_REFORM_INDUSTRY',	4),
		('LEADER_DMS_MENELIK_II',	'FLAVOR_JFD_REFORM_MILITARY',	5),
		('LEADER_DMS_MENELIK_II',	'FLAVOR_JFD_REFORM_RELIGION',	5),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_REFORM_GOVERNMENT',		7),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_REFORM_LEGAL',			9),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_REFORM_CULTURE',		5),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_REFORM_ECONOMIC',		7),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_REFORM_FOREIGN',		8),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_REFORM_INDUSTRY',		5),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_REFORM_MILITARY',		8),
		('LEADER_DMS_GUDIT',	'FLAVOR_JFD_REFORM_RELIGION',		8);
--------------------------------
-- Policy_JFD_CivilizationNames
--------------------------------
-- ?
--==========================================================================================================================
-- TOMATEKH'S HISTORICAL RELIGIONS
--==========================================================================================================================
-- Civilization_Religions
------------------------------------------------------------
-- Kaleb
DELETE FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_DMS_AKSUM_KALEB';
INSERT INTO Civilization_Religions 
		        (CivilizationType,	ReligionType)
SELECT		Type,			('RELIGION_CHRISTIANITY')
FROM Civilizations WHERE Type = 'CIVILIZATION_DMS_AKSUM_KALEB';

UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX' )
		THEN 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX'
		ELSE 'RELIGION_CHRISTIANITY' END 
	) WHERE CivilizationType = 'CIVILIZATION_DMS_AKSUM_KALEB';

CREATE TRIGGER CivilizationTierAksumKaleb
AFTER INSERT ON Civilization_Religions WHEN 'CIVILIZATION_DMS_AKSUM_KALEB' = NEW.CivilizationType
BEGIN
	UPDATE Civilization_Religions SET ReligionType = 
		( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX' )
			THEN 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX'
			ELSE 'RELIGION_CHRISTIANITY' END 
		) WHERE CivilizationType = 'CIVILIZATION_DMS_AKSUM_KALEB';
END;
-- Amda Seyon
DELETE FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_DMS_ETHIOPIA_SEYON_I';
INSERT INTO Civilization_Religions 
		        (CivilizationType,	ReligionType)
SELECT		Type,			('RELIGION_CHRISTIANITY')
FROM Civilizations WHERE Type = 'CIVILIZATION_DMS_ETHIOPIA_SEYON_I';

UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX' )
		THEN 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX'
		ELSE 'RELIGION_CHRISTIANITY' END 
	) WHERE CivilizationType = 'CIVILIZATION_DMS_ETHIOPIA_SEYON_I';

CREATE TRIGGER CivilizationTierEthiopiaAmdaSeyon
AFTER INSERT ON Civilization_Religions WHEN 'CIVILIZATION_DMS_ETHIOPIA_SEYON_I' = NEW.CivilizationType
BEGIN
	UPDATE Civilization_Religions SET ReligionType = 
		( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX' )
			THEN 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX'
			ELSE 'RELIGION_CHRISTIANITY' END 
		) WHERE CivilizationType = 'CIVILIZATION_DMS_ETHIOPIA_SEYON_I';
END;
-- Zara Yaqob
DELETE FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_DMS_ETHIOPIA_YAQOB';
INSERT INTO Civilization_Religions 
		        (CivilizationType,	ReligionType)
SELECT		Type,			('RELIGION_CHRISTIANITY')
FROM Civilizations WHERE Type = 'CIVILIZATION_DMS_ETHIOPIA_YAQOB';

UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX' )
		THEN 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX'
		ELSE 'RELIGION_CHRISTIANITY' END 
	) WHERE CivilizationType = 'CIVILIZATION_DMS_ETHIOPIA_YAQOB';

CREATE TRIGGER CivilizationTierEthiopiaZaraYaqob
AFTER INSERT ON Civilization_Religions WHEN 'CIVILIZATION_DMS_ETHIOPIA_YAQOB' = NEW.CivilizationType
BEGIN
	UPDATE Civilization_Religions SET ReligionType = 
		( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX' )
			THEN 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX'
			ELSE 'RELIGION_CHRISTIANITY' END 
		) WHERE CivilizationType = 'CIVILIZATION_DMS_ETHIOPIA_YAQOB';
END;
-- Menelik
DELETE FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_DMS_ETHIOPIA_MENELIK_II';
INSERT INTO Civilization_Religions 
		        (CivilizationType,	ReligionType)
SELECT		Type,			('RELIGION_CHRISTIANITY')
FROM Civilizations WHERE Type = 'CIVILIZATION_DMS_ETHIOPIA_MENELIK_II';

UPDATE Civilization_Religions SET ReligionType = 
	( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX' )
		THEN 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX'
		ELSE 'RELIGION_CHRISTIANITY' END 
	) WHERE CivilizationType = 'CIVILIZATION_DMS_ETHIOPIA_MENELIK_II';

CREATE TRIGGER CivilizationTierEthiopiaMenelik
AFTER INSERT ON Civilization_Religions WHEN 'CIVILIZATION_DMS_ETHIOPIA_MENELIK_II' = NEW.CivilizationType
BEGIN
	UPDATE Civilization_Religions SET ReligionType = 
		( CASE WHEN EXISTS(SELECT Type FROM Religions WHERE Type = 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX' )
			THEN 'RELIGION_CHRISTIAN_ORIENTAL_ORTHODOX'
			ELSE 'RELIGION_CHRISTIANITY' END 
		) WHERE CivilizationType = 'CIVILIZATION_DMS_ETHIOPIA_MENELIK_II';
END;
-- Gudit
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');

INSERT INTO ML_CivCultures 	
		(CivType, 									CultureType, CultureEra)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),			CultureType, CultureEra
FROM ML_CivCultures WHERE (CivType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO ML_CivCultures 	
		(CivType, 									CultureType, CultureEra)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		CultureType, CultureEra
FROM ML_CivCultures WHERE (CivType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO ML_CivCultures 	
		(CivType, 									CultureType, CultureEra)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		CultureType, CultureEra
FROM ML_CivCultures WHERE (CivType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO ML_CivCultures 	
		(CivType, 									CultureType, CultureEra)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	CultureType, CultureEra
FROM ML_CivCultures WHERE (CivType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO ML_CivCultures 	
		(CivType, 									CultureType, CultureEra)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),			CultureType, CultureEra
FROM ML_CivCultures WHERE (CivType = 'CIVILIZATION_ETHIOPIA');
--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ETHIOPIA' )
	THEN '_ETHIOPIA'
	ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_DMS_AKSUM_KALEB';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ETHIOPIA' )
	THEN '_ETHIOPIA'
	ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_DMS_ETHIOPIA_SEYON_I';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ETHIOPIA' )
	THEN '_ETHIOPIA'
	ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_DMS_ETHIOPIA_YAQOB';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ETHIOPIA' )
	THEN '_ETHIOPIA'
	ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_DMS_ETHIOPIA_MENELIK_II';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ETHIOPIA' )
	THEN '_ETHIOPIA'
	ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_DMS_SEMIEN_GUDIT';
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
		(LeaderType,				 TraitOne,                  TraitTwo)
VALUES	('LEADER_DMS_KALEB',		'POLICY_FINANCIAL_X',		'POLICY_DIPLOMATIC_X'),
		('LEADER_DMS_SEYON_I',		'POLICY_AGGRESSIVE_X',		'POLICY_IMPERIALISTIC_X'),
		('LEADER_DMS_YAQOB',		'POLICY_PHILOSOPHICAL_X',	'POLICY_SPIRITUAL_X'),
		('LEADER_DMS_MENELIK_II',	'POLICY_CHARISMATIC_X',		'POLICY_DIPLOMATIC_X'),
		('LEADER_DMS_GUDIT',		'POLICY_AGGRESSIVE_X',		'POLICY_SPIRITUAL_X');
------------------------------
-- Leaders
------------------------------
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Kaleb [ICON_TRADE][ICON_INFLUENCE]'
	ELSE 'TXT_KEY_LEADER_DMS_KALEB' END) 
WHERE Type = 'LEADER_DMS_KALEB';

CREATE TRIGGER CivIVTraitsAksumKaleb
AFTER INSERT ON Leaders WHEN 'LEADER_DMS_KALEB' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Kaleb [ICON_TRADE][ICON_INFLUENCE]'
		ELSE 'TXT_KEY_LEADER_DMS_KALEB' END) 
	WHERE Type = 'LEADER_DMS_KALEB';
END;
------------------------------
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Gudit [ICON_WAR][ICON_PEACE]'
	ELSE 'TXT_KEY_LEADER_DMS_GUDIT' END) 
WHERE Type = 'LEADER_DMS_GUDIT';

CREATE TRIGGER CivIVTraitsSemienGudit
AFTER INSERT ON Leaders WHEN 'LEADER_DMS_GUDIT' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Gudit [ICON_WAR][ICON_PEACE]'
		ELSE 'TXT_KEY_LEADER_DMS_GUDIT' END) 
	WHERE Type = 'LEADER_DMS_GUDIT';
END;
------------------------------
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Amda Seyon I [ICON_WAR][ICON_CITY_STATE]'
	ELSE 'TXT_KEY_LEADER_DMS_SEYON_I' END) 
WHERE Type = 'LEADER_DMS_SEYON_I';

CREATE TRIGGER CivIVTraitsEthiopiaAmdaSeyon
AFTER INSERT ON Leaders WHEN 'LEADER_DMS_SEYON_I' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Amda Seyon I [ICON_WAR][ICON_CITY_STATE]'
		ELSE 'TXT_KEY_LEADER_DMS_SEYON_I' END) 
	WHERE Type = 'LEADER_DMS_SEYON_I';
END;
------------------------------
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Zara Yaqob [TXT_KEY_PHILOSOPHICAL_TRAIT][ICON_PEACE]'
	ELSE 'TXT_KEY_LEADER_DMS_YAQOB' END) 
WHERE Type = 'LEADER_DMS_YAQOB';

CREATE TRIGGER CivIVTraitsEthiopiaZaraYaqob
AFTER INSERT ON Leaders WHEN 'LEADER_DMS_YAQOB' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Zara Yaqob [TXT_KEY_PHILOSOPHICAL_TRAIT][ICON_PEACE]'
		ELSE 'TXT_KEY_LEADER_DMS_YAQOB' END) 
	WHERE Type = 'LEADER_DMS_YAQOB';
END;
------------------------------
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Menelik II [ICON_HAPPINESS_1][ICON_INFLUENCE]'
	ELSE 'TXT_KEY_LEADER_DMS_MENELIK_II' END) 
WHERE Type = 'LEADER_DMS_MENELIK_II';

CREATE TRIGGER CivIVTraitsEthiopiaMenelikII
AFTER INSERT ON Leaders WHEN 'LEADER_DMS_MENELIK_II' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Menelik II [ICON_HAPPINESS_1][ICON_INFLUENCE]'
		ELSE 'TXT_KEY_LEADER_DMS_MENELIK_II' END) 
	WHERE Type = 'LEADER_DMS_MENELIK_II';
END;

--==========================================================================================================================
-- GEDEMON's YNAEMP (+JFD's v23 / 24)
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',	18,		58,		null,	null),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',	18,		58,		null,	null);

INSERT INTO Civilizations_YagemStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	X,		Y,		AltX,	AltY
FROM Civilizations_YagemStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YagemStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	X,		Y,		AltX,	AltY
FROM Civilizations_YagemStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YagemStartPosition
		(Type,										X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	X,		Y,		AltX,	AltY
FROM Civilizations_YagemStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YagemRequestedResource
		(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YagemRequestedResource
		(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YagemRequestedResource
		(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YagemRequestedResource
		(Type, 									Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',	18,		58,		null,	null),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',	18,		58,		null,	null);

INSERT INTO Civilizations_YahemStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	X,		Y,		AltX,	AltY
FROM Civilizations_YahemStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YahemStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	X,		Y,		AltX,	AltY
FROM Civilizations_YahemStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YahemStartPosition
		(Type,										X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	X,		Y,		AltX,	AltY
FROM Civilizations_YahemStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',	18,		58,		null,	null),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',	18,		58,		null,	null);

INSERT INTO Civilizations_CordiformStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	X,		Y,		AltX,	AltY
FROM Civilizations_CordiformStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_CordiformStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	X,		Y,		AltX,	AltY
FROM Civilizations_CordiformStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_CordiformStartPosition
		(Type,										X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	X,		Y,		AltX,	AltY
FROM Civilizations_CordiformStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_CordiformRequestedResource (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_CordiformRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_CordiformRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_CordiformRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_CordiformRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',	18,		58,		null,	null),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',	18,		58,		null,	null);

INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	X,		Y,		AltX,	AltY
FROM Civilizations_GreatestEarthStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	X,		Y,		AltX,	AltY
FROM Civilizations_GreatestEarthStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,										X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	X,		Y,		AltX,	AltY
FROM Civilizations_GreatestEarthStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_AfricaLargeStartPosition (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfricaLargeStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',	18,		58,		null,	null),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',	18,		58,		null,	null);

INSERT INTO Civilizations_AfricaLargeStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfricaLargeStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfricaLargeStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfricaLargeStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfricaLargeStartPosition
		(Type,										X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfricaLargeStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_AfricaLargeRequestedResource (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfricaLargeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfricaLargeRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfricaLargeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfricaLargeRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfricaLargeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfricaLargeRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfricaLargeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfricaLargeRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfricaLargeRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfricaLargeRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_AfriAsiaAustStartPosition (AfriAsiaAust)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',	18,		58,		null,	null),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',	18,		58,		null,	null);

INSERT INTO Civilizations_AfriAsiaAustStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfriAsiaAustStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriAsiaAustStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfriAsiaAustStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriAsiaAustStartPosition
		(Type,										X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfriAsiaAustStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_AfriAsiaAustRequestedResource
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriAsiaAustRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriAsiaAustRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriAsiaAustRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriAsiaAustRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriAsiaAustRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriAsiaAustRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriAsiaAustRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriAsiaAustRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriAsiaAustRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriAsiaAustRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_AfriSouthEuroStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriSouthEuroStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',	18,		58,		null,	null),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',	18,		58,		null,	null);

INSERT INTO Civilizations_AfriSouthEuroStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfriSouthEuroStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriSouthEuroStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfriSouthEuroStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriSouthEuroStartPosition
		(Type,										X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfriSouthEuroStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_AfriSouthEuroRequestedResource
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriSouthEuroRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriSouthEuroRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriSouthEuroRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriSouthEuroRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriSouthEuroRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_AfriGiantStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriGiantStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',	18,		58,		null,	null),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',	18,		58,		null,	null);

INSERT INTO Civilizations_AfriGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfriGiantStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriGiantStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfriGiantStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriGiantStartPosition
		(Type,										X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	X,		Y,		AltX,	AltY
FROM Civilizations_AfriGiantStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_AfriGiantRequestedResource
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriGiantRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriGiantRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriGiantRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriGiantRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriGiantRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriGiantRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriGiantRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriGiantRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_AfriGiantRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriGiantRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_IndianOceanStartPosition
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndianOceanStartPosition
		(Type,								X,		Y,		AltX,	AltY)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',	18,		58,		null,	null),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',	18,		58,		null,	null);

INSERT INTO Civilizations_IndianOceanStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),	X,		Y,		AltX,	AltY
FROM Civilizations_IndianOceanStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_IndianOceanStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),	X,		Y,		AltX,	AltY
FROM Civilizations_IndianOceanStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_IndianOceanStartPosition
		(Type,									X,		Y,		AltX,	AltY)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	X,		Y,		AltX,	AltY
FROM Civilizations_IndianOceanStartPosition WHERE Type = 'CIVILIZATION_ETHIOPIA';
------------------------------------------------------------	
-- Civilizations_IndianOceanRequestedResource (Greatest Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_IndianOceanRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_IndianOceanRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_IndianOceanRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_IndianOceanRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilizations_IndianOceanRequestedResource
		(Type, 								Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AfriSouthEuroRequestedResource WHERE Type = 'CIVILIZATION_ETHIOPIA';
--==========================================================================================================================
-- EVENTS
--==========================================================================================================================
-- Player Events
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Events
		(Type,											Description,													Help,												EventArt,			IsOneShot,	IsCityState,	RequiresWar,	NumChoices,	RandomChance,	RandomChanceDelta,	EventCooldown,  MinimumNationalPopulation,	MinimumNumberCities,	RequiresHolyCity,	RequiredEra,		ObsoleteEra)
VALUES	('PLAYER_EVENT_DMS_ZEMENE_MESAFINT',			'TXT_KEY_PLAYER_EVENT_DMS_ZEMENE_MESAFINT_DESCRIPTION',			'TXT_KEY_PLAYER_EVENT_DMS_ZEMENE_MESAFINT_HELP',	'....dds',			1,			0,				0,				3,			20,				1,					0,				0,							0,						0,					'ERA_MEDIEVAL',		'ERA_INDUSTRIAL');
















--==========================================================================================================================
--==========================================================================================================================