--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------
INSERT OR REPLACE INTO BuildingClasses 
		(DefaultBuilding, 								Type, 												Description)
VALUES	('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_1',		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_1', 		'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING'),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_2',		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_2', 		'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING'),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_3',		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_3', 		'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING'),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_4',		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_4', 		'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING'),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_5',		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_5', 		'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING'),
		('BUILDING_DMS_ZY_RELIGIOUS_PRESSURE',			'BUILDINGCLASS_DMS_ZY_RELIGIOUS_PRESSURE', 			'TXT_KEY_BUILDING_DMS_ZY_RELIGIOUS_PRESSURE'),
		('BUILDING_DMS_ZY_DEFENSE',						'BUILDINGCLASS_DMS_ZY_DEFENSE', 					'TXT_KEY_BUILDING_DMS_ZY_DEFENSE'),
		('BUILDING_DMS_HS_DELEGATE_TENET',				'BUILDINGCLASS_DMS_HS_DELEGATE_TENET', 				'TXT_KEY_BUILDING_DMS_HS_DELEGATE_TENET'),
		('BUILDING_DMS_AS_FREE_COURTHOUSE',				'BUILDINGCLASS_DMS_AS_FREE_COURTHOUSE', 			'TXT_KEY_BUILDING_DMS_AS_FREE_COURTHOUSE'),
		('BUILDING_DMS_AS_WLTKD_DUMMY',					'BUILDINGCLASS_DMS_AS_WLTKD_DUMMY', 				'TXT_KEY_BUILDING_DMS_AS_WLTKD_DUMMY'),
		('BUILDING_DMS_TRADE_ROUTE_SLOT_DUMMY',			'BUILDINGCLASS_DMS_TRADE_ROUTE_SLOT_DUMMY', 		'TXT_KEY_BUILDING_DMS_TRADE_ROUTE_SLOT_DUMMY'),
		('BUILDING_DMS_TRADE_ROUTE_GROWTH_DUMMY',		'BUILDINGCLASS_DMS_TRADE_ROUTE_GROWTH_DUMMY', 		'TXT_KEY_BUILDING_DMS_TRADE_ROUTE_GROWTH_DUMMY'),
		('BUILDING_DMS_PILLAGE_IMPROVEMENT_FAITH',		'BUILDINGCLASS_DMS_PILLAGE_IMPROVEMENT_FAITH', 		'TXT_KEY_BUILDING_DMS_PILLAGE_IMPROVEMENT_FAITH'),
		('BUILDING_DMS_MASGID_PRODUCTION_DUMMY',		'BUILDINGCLASS_DMS_MASGID_PRODUCTION_DUMMY', 		'TXT_KEY_BUILDING_DMS_MASGID_PRODUCTION_DUMMY');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------
INSERT INTO Buildings
		(Type, 						 					BuildingClass, 										Cost,	FaithCost,	GreatWorkSlotType,				GreatWorkCount,	Defense,	ExtraCityHitPoints,	NumTradeRouteBonus,	ReligiousPressureModifier,	ExtraLeagueVotes,	PrereqTech,	MinAreaSize,	Description, 											Help,															MinAreaSize,	ConquestProb,	IconAtlas,						PortraitIndex)
VALUES	('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_1', 		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_1',		-1,		-1,			'GREAT_WORK_SLOT_LITERATURE',	1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING',	'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING_HELP',	-1,				100,			'DMS_MONOLITHIC_CHURCH_ATLAS',	0),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_2', 		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_2',		-1,		-1,			'GREAT_WORK_SLOT_LITERATURE',	1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING',	'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING_HELP',	-1,				100,			'DMS_MONOLITHIC_CHURCH_ATLAS',	0),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_3', 		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_3',		-1,		-1,			'GREAT_WORK_SLOT_LITERATURE',	1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING',	'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING_HELP',	-1,				100,			'DMS_MONOLITHIC_CHURCH_ATLAS',	0),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_4', 		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_4',		-1,		-1,			'GREAT_WORK_SLOT_LITERATURE',	1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING',	'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING_HELP',	-1,				100,			'DMS_MONOLITHIC_CHURCH_ATLAS',	0),
		('BUILDING_DMS_ZY_GREAT_WORKS_WRITING_5', 		'BUILDINGCLASS_DMS_ZY_GREAT_WORKS_WRITING_5',		-1,		-1,			'GREAT_WORK_SLOT_LITERATURE',	1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING',	'TXT_KEY_BUILDING_BUILDING_DMS_ZY_GREAT_WORKS_WRITING_HELP',	-1,				100,			'DMS_MONOLITHIC_CHURCH_ATLAS',	0),
		--('BUILDING_DMS_AS_FREE_COURTHOUSE', 			'BUILDINGCLASS_DMS_AS_FREE_COURTHOUSE',				-1,		-1,			NULL,							-1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_DMS_AS_FREE_COURTHOUSE',				'TXT_KEY_BUILDING_DMS_AS_FREE_COURTHOUSE_HELP',					-1,				0,				NULL,							-1),
		('BUILDING_DMS_ZY_RELIGIOUS_PRESSURE', 			'BUILDINGCLASS_DMS_ZY_RELIGIOUS_PRESSURE',			-1,		-1,			NULL,							-1,				0,			0,					0,					5,							0,					NULL,		-1,				'TXT_KEY_BUILDING_DMS_ZY_RELIGIOUS_PRESSURE',			'TXT_KEY_BUILDING_DMS_ZY_RELIGIOUS_PRESSURE_HELP',				-1,				0,				NULL,							-1),
		('BUILDING_DMS_ZY_DEFENSE', 					'BUILDINGCLASS_DMS_ZY_DEFENSE',						-1,		-1,			NULL,							-1,				200,		10,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_DMS_ZY_DEFENSE',						'TXT_KEY_BUILDING_DMS_ZY_DEFENSE_HELP',							-1,				0,				NULL,							-1),
		('BUILDING_DMS_HS_DELEGATE_TENET', 				'BUILDINGCLASS_DMS_HS_DELEGATE_TENET',				-1,		-1,			NULL,							-1,				0,			0,					0,					0,							1,					NULL,		-1,				'TXT_KEY_BUILDING_DMS_HS_DELEGATE_TENET',				'TXT_KEY_BUILDING_DMS_HS_DELEGATE_TENET_HELP',					-1,				0,				NULL,							-1),
		('BUILDING_DMS_AS_WLTKD_DUMMY', 				'BUILDINGCLASS_DMS_AS_WLTKD_DUMMY',					-1,		-1,			NULL,							-1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_DMS_AS_WLTKD_DUMMY',					'TXT_KEY_BUILDING_DMS_AS_WLTKD_DUMMY_HELP',						-1,				0,				NULL,							-1),
		('BUILDING_DMS_TRADE_ROUTE_SLOT_DUMMY', 		'BUILDINGCLASS_DMS_TRADE_ROUTE_SLOT_DUMMY',			-1,		-1,			NULL,							-1,				0,			0,					1,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_DMS_TRADE_ROUTE_SLOT_DUMMY',			'TXT_KEY_BUILDING_DMS_TRADE_ROUTE_SLOT_DUMMY_HELP',				-1,				0,				NULL,							-1),
		('BUILDING_DMS_TRADE_ROUTE_GROWTH_DUMMY', 		'BUILDINGCLASS_DMS_TRADE_ROUTE_GROWTH_DUMMY',		-1,		-1,			NULL,							-1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_DMS_TRADE_ROUTE_GROWTH_DUMMY',		'TXT_KEY_BUILDING_DMS_TRADE_ROUTE_GROWTH_DUMMY_HELP',			-1,				0,				NULL,							-1),
		('BUILDING_DMS_PILLAGE_IMPROVEMENT_FAITH', 		'BUILDINGCLASS_DMS_PILLAGE_IMPROVEMENT_FAITH',		-1,		-1,			NULL,							-1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_DMS_PILLAGE_IMPROVEMENT_FAITH',		'TXT_KEY_BUILDING_DMS_PILLAGE_IMPROVEMENT_FAITH_HELP',			-1,				0,				NULL,							-1),
		('BUILDING_DMS_MASGID_PRODUCTION_DUMMY', 		'BUILDINGCLASS_DMS_MASGID_PRODUCTION_DUMMY',		-1,		-1,			NULL,							-1,				0,			0,					0,					0,							0,					NULL,		-1,				'TXT_KEY_BUILDING_DMS_MASGID_PRODUCTION_DUMMY',			'TXT_KEY_BUILDING_DMS_MASGID_PRODUCTION_DUMMY_HELP',			-1,				0,				NULL,							-1);

INSERT INTO Buildings
		(Type, 									BuildingClass,								Cost,	GoldMaintenance,	PrereqTech,	Help,	Description,	Civilopedia,	Strategy,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	NoOccupiedUnhappiness,	IconAtlas,	PortraitIndex)
SELECT	('BUILDING_DMS_AS_FREE_COURTHOUSE'),	('BUILDINGCLASS_DMS_AS_FREE_COURTHOUSE'),	-1,		0,					NULL,		Help,	Description,	Civilopedia,	Strategy,	ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	NoOccupiedUnhappiness,	IconAtlas,	PortraitIndex
FROM Buildings WHERE Type = 'BUILDING_COURTHOUSE';

INSERT INTO Buildings
		(Type, 						BuildingClass,	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech,	Defense,	Description, 						Help,									Civilopedia,								Strategy,									ArtDefineTag,	MinAreaSize,	ConquestProb,	HurryCostModifier,	IconAtlas,				PortraitIndex)
SELECT	('BUILDING_DMS_MASGID'),	BuildingClass,	MaxStartEra,	Cost,	GoldMaintenance,	PrereqTech,	300,		('TXT_KEY_BUILDING_DMS_MASGID'),	('TXT_KEY_BUILDING_DMS_MASGID_HELP'),	('TXT_KEY_CIV5_BUILDINGS_DMS_MASGID_TEXT'),	('TXT_KEY_BUILDING_DMS_MASGID_STRATEGY'),	ArtDefineTag,	MinAreaSize,	0,				HurryCostModifier,	('DMS_SEMIEN_ATLAS'),	3
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';
------------------------------
-- Building_YieldChanges
------------------------------
INSERT INTO Building_YieldChanges
		(BuildingType, 							YieldType,		Yield)
SELECT	('BUILDING_DMS_MASGID'),				YieldType,		Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_TEMPLE';

INSERT INTO Building_YieldChanges
		(BuildingType, 						 			YieldType, 			Yield)
VALUES	('BUILDING_DMS_PILLAGE_IMPROVEMENT_FAITH',		'YIELD_FAITH',		1);

INSERT INTO Building_YieldChanges
		(BuildingType, 						 			YieldType, 			Yield)
VALUES	('BUILDING_DMS_MASGID_PRODUCTION_DUMMY',		'YIELD_PRODUCTION',	1);
------------------------------	
-- Building_YieldModifiers
------------------------------
INSERT INTO Building_YieldModifiers
		(BuildingType, 						 			YieldType, 			Yield)
VALUES	('BUILDING_DMS_TRADE_ROUTE_GROWTH_DUMMY',		'YIELD_FOOD',		5);
------------------------------	
-- Building_FeatureYieldChanges
------------------------------
------------------------------	
-- Building_Flavors
------------------------------
INSERT INTO Building_Flavors
		(BuildingType, 							FlavorType,		Flavor)
SELECT	('BUILDING_DMS_AS_FREE_COURTHOUSE'),	FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_COURTHOUSE';

INSERT INTO Building_Flavors
		(BuildingType, 							FlavorType,		Flavor)
SELECT	('BUILDING_DMS_MASGID'),				FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_TEMPLE';
------------------------------	
-- Building_ClassesNeededInCity
------------------------------
INSERT INTO Building_ClassesNeededInCity
		(BuildingType, 				BuildingClassType)
SELECT	('BUILDING_DMS_MASGID'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_TEMPLE';
------------------------------	
-- Building_DomainProductionModifiers
------------------------------
INSERT INTO Building_DomainProductionModifiers
		(BuildingType, 						 	DomainType, 		Modifier)
VALUES	('BUILDING_DMS_AS_FREE_COURTHOUSE',		'DOMAIN_SEA',		25),
		('BUILDING_DMS_AS_FREE_COURTHOUSE',		'DOMAIN_LAND',		25);
--==========================================================================================================================
-- BUILDS
--==========================================================================================================================
-- Builds
------------------------------
INSERT INTO Builds
		(Type,								PrereqTech,			ImprovementType, 						Time,	Recommendation,								Description,						Help,											CtrlDown,	OrderPriority,	IconIndex,	IconAtlas,									HotKey,		EntityEvent)
VALUES	('BUILD_DMS_MONOLITHIC_CHURCH',		'TECH_THEOLOGY',	'IMPROVEMENT_DMS_MONOLITHIC_CHURCH',	1000,	'TXT_KEY_BUILD_DMS_MONOLITHIC_CHURCH_REC',	'TXT_KEY_DMS_MONOLITHIC_CHURCH',	'TXT_KEY_BUILD_DMS_MONOLITHIC_CHURCH_HELP',		1,			96,				1,			'DMS_MONOLITHIC_CHURCH_ATLAS',				'KB_T',		'ENTITY_EVENT_BUILD');
------------------------------
-- BuildFeatures
------------------------------
INSERT INTO BuildFeatures
		(BuildType, 						FeatureType,	PrereqTech,	Time,	Remove)
SELECT	('BUILD_DMS_MONOLITHIC_CHURCH'),	FeatureType,	PrereqTech,	Time,	0
FROM BuildFeatures WHERE BuildType = 'BUILD_FORT';
--==========================================================================================================================
-- POLICIES
--==========================================================================================================================
-- Policy_BuildingClassHappiness
------------------------------
INSERT INTO Policy_BuildingClassHappiness
		(PolicyType, 				BuildingClassType, 				Happiness)
VALUES	('POLICY_POLICE_STATE',		'BUILDINGCLASS_COURTHOUSE',		5);
--==========================================================================================================================
-- Improvements
--==========================================================================================================================
-- Improvements
--------------------------------
INSERT INTO Improvements
		(Type,											Description,									Civilopedia, 										Help,												ArtDefineTag,								SpecificCivRequired,	CivilizationType,					HillsMakesValid,	BuildableOnResources,	Permanent,	NoTwoAdjacent,	IconAtlas,						PortraitIndex)
VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH',			'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_TEXT',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_HELP',	'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	1,						'CIVILIZATION_DMS_ETHIOPIA_YAQOB',	1,					0,						1,			1,				'DMS_MONOLITHIC_CHURCH_ATLAS',	0);

INSERT INTO Improvements
		(Type,											Description,									Civilopedia, 										Help,												ArtDefineTag,								SpecificCivRequired,	CivilizationType,					HillsMakesValid,	BuildableOnResources,	Permanent,	NoTwoAdjacent,	IconAtlas,						PortraitIndex)
VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1',			'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_TEXT',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_HELP',	'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	0,						NULL,								1,					0,						1,			1,				'DMS_MONOLITHIC_CHURCH_ATLAS',	0);

INSERT INTO Improvements
		(Type,											Description,									Civilopedia, 										Help,												ArtDefineTag,								SpecificCivRequired,	CivilizationType,					HillsMakesValid,	BuildableOnResources,	Permanent,	NoTwoAdjacent,	IconAtlas,						PortraitIndex)
VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2',			'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_TEXT',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_HELP',	'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	0,						NULL,								1,					0,						1,			1,				'DMS_MONOLITHIC_CHURCH_ATLAS',	0);

INSERT INTO Improvements
		(Type,											Description,									Civilopedia, 										Help,												ArtDefineTag,								SpecificCivRequired,	CivilizationType,					HillsMakesValid,	BuildableOnResources,	Permanent,	NoTwoAdjacent,	IconAtlas,						PortraitIndex)
VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3',			'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_TEXT',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_HELP',	'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	0,						NULL,								1,					0,						1,			1,				'DMS_MONOLITHIC_CHURCH_ATLAS',	0);

INSERT INTO Improvements
		(Type,											Description,									Civilopedia, 										Help,												ArtDefineTag,								SpecificCivRequired,	CivilizationType,					HillsMakesValid,	BuildableOnResources,	Permanent,	NoTwoAdjacent,	IconAtlas,						PortraitIndex)
VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4',			'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_TEXT',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_HELP',	'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	0,						NULL,								1,					0,						1,			1,				'DMS_MONOLITHIC_CHURCH_ATLAS',	0);

INSERT INTO Improvements
		(Type,											Description,									Civilopedia, 										Help,												ArtDefineTag,								SpecificCivRequired,	CivilizationType,					HillsMakesValid,	BuildableOnResources,	Permanent,	NoTwoAdjacent,	IconAtlas,						PortraitIndex)
VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5',			'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_TEXT',	'TXT_KEY_IMPROVEMENT_DMS_MONOLITHIC_CHURCH_HELP',	'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	0,						NULL,								1,					0,						1,			1,				'DMS_MONOLITHIC_CHURCH_ATLAS',	0);
--------------------------------
-- Improvement_Yields
--------------------------------
INSERT INTO Improvement_Yields
		(ImprovementType,								YieldType,			Yield)
VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH',			'YIELD_FAITH',		2),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH',			'YIELD_PRODUCTION',	1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1',			'YIELD_FAITH',		3),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1',			'YIELD_PRODUCTION',	2),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2',			'YIELD_FAITH',		4),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2',			'YIELD_PRODUCTION',	3),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3',			'YIELD_FAITH',		5),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3',			'YIELD_PRODUCTION',	4),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4',			'YIELD_FAITH',		6),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4',			'YIELD_PRODUCTION',	5),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5',			'YIELD_FAITH',		7),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5',			'YIELD_PRODUCTION',	6);
--------------------------------
-- Improvement_ValidTerrains
--------------------------------
--INSERT INTO Improvement_ValidTerrains
--		(ImprovementType,								TerrainType)
--VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH',			'TERRAIN_HILL'),
--		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1',			'TERRAIN_HILL'),
--		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2',			'TERRAIN_HILL'),
--		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3',			'TERRAIN_HILL'),
--		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4',			'TERRAIN_HILL'),
--		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5',			'TERRAIN_HILL');
--------------------------------
-- Improvement_ResourceTypes
--------------------------------
INSERT INTO Improvement_ResourceTypes
		(ImprovementType,								ResourceType,			ResourceMakesValid)
VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH',			'RESOURCE_MARBLE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH',			'RESOURCE_STONE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1',			'RESOURCE_MARBLE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1',			'RESOURCE_STONE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2',			'RESOURCE_MARBLE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2',			'RESOURCE_STONE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3',			'RESOURCE_MARBLE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3',			'RESOURCE_STONE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4',			'RESOURCE_MARBLE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4',			'RESOURCE_STONE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5',			'RESOURCE_MARBLE',		1),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5',			'RESOURCE_STONE',		1);
--------------------------------
-- Improvement_Flavors
--------------------------------
INSERT INTO Improvement_Flavors
		(ImprovementType,								FlavorType,				Flavor)
VALUES	('IMPROVEMENT_DMS_MONOLITHIC_CHURCH',			'FLAVOR_RELIGION',		75),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH',			'FLAVOR_PRODUCTION',	15),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH',			'FLAVOR_GREAT_PEOPLE',	10),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1',			'FLAVOR_RELIGION',		75),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1',			'FLAVOR_PRODUCTION',	15),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_1',			'FLAVOR_GREAT_PEOPLE',	10),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2',			'FLAVOR_RELIGION',		75),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2',			'FLAVOR_PRODUCTION',	15),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_2',			'FLAVOR_GREAT_PEOPLE',	10),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3',			'FLAVOR_RELIGION',		75),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3',			'FLAVOR_PRODUCTION',	15),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_3',			'FLAVOR_GREAT_PEOPLE',	10),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4',			'FLAVOR_RELIGION',		75),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4',			'FLAVOR_PRODUCTION',	15),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_4',			'FLAVOR_GREAT_PEOPLE',	10),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5',			'FLAVOR_RELIGION',		75),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5',			'FLAVOR_PRODUCTION',	15),
		('IMPROVEMENT_DMS_MONOLITHIC_CHURCH_5',			'FLAVOR_GREAT_PEOPLE',	10);
--==========================================================================================================================
-- UNITCLASSES
--==========================================================================================================================
-- UnitClasses
--------------------------------
INSERT INTO UnitClasses 
		(Type,									Description,					DefaultUnit) 
VALUES	('UNITCLASS_DMS_SARAWIT_CHEAP_1',		'TXT_KEY_UNIT_DMS_SARAWIT',		'UNIT_DMS_SARAWIT_CHEAP_1'),
		('UNITCLASS_DMS_SARAWIT_CHEAP_2',		'TXT_KEY_UNIT_DMS_SARAWIT',		'UNIT_DMS_SARAWIT_CHEAP_2'),
		('UNITCLASS_DMS_SARAWIT_CHEAP_3',		'TXT_KEY_UNIT_DMS_SARAWIT',		'UNIT_DMS_SARAWIT_CHEAP_3'),
		('UNITCLASS_DMS_SARAWIT_CHEAP_4',		'TXT_KEY_UNIT_DMS_SARAWIT',		'UNIT_DMS_SARAWIT_CHEAP_4'),
		('UNITCLASS_DMS_SARAWIT_CHEAP_5',		'TXT_KEY_UNIT_DMS_SARAWIT',		'UNIT_DMS_SARAWIT_CHEAP_5'),
		('UNITCLASS_DMS_SARAWIT_CHEAP_6',		'TXT_KEY_UNIT_DMS_SARAWIT',		'UNIT_DMS_SARAWIT_CHEAP_6'),
		('UNITCLASS_DMS_SARAWIT_CHEAP_7',		'TXT_KEY_UNIT_DMS_SARAWIT',		'UNIT_DMS_SARAWIT_CHEAP_7'),
		('UNITCLASS_DMS_SARAWIT_CHEAP_8',		'TXT_KEY_UNIT_DMS_SARAWIT',		'UNIT_DMS_SARAWIT_CHEAP_8');
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 							Class,	PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	ExtraMaintenanceCost,	UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_SARAWIT'),			Class,	PrereqTech,				Combat+1,				56,		FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SARAWIT'),		('TXT_KEY_CIV5_DMS_SARAWIT_TEXT'),		('TXT_KEY_UNIT_DMS_SARAWIT_STRATEGY'),		('TXT_KEY_UNIT_DMS_SARAWIT_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	2,						('ART_DEF_UNIT_DMS_SARAWIT'),											0,					('DMS_SARAWIT_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	10
FROM Units WHERE Type = 'UNIT_SPEARMAN';

INSERT INTO Units 	
		(Type, 							Class,								PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	ExtraMaintenanceCost,	UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_1'),	('UNITCLASS_DMS_SARAWIT_CHEAP_1'),	null,					Combat+1,				52,		FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SARAWIT'),		('TXT_KEY_CIV5_DMS_SARAWIT_TEXT'),		('TXT_KEY_UNIT_DMS_SARAWIT_STRATEGY'),		('TXT_KEY_UNIT_DMS_SARAWIT_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	2,						('ART_DEF_UNIT_DMS_SARAWIT'),											0,					('DMS_SARAWIT_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	10
FROM Units WHERE Type = 'UNIT_DMS_SARAWIT';

INSERT INTO Units 	
		(Type, 							Class,								PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	ExtraMaintenanceCost,	UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_2'),	('UNITCLASS_DMS_SARAWIT_CHEAP_2'),	null,					Combat+1,				47,		FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SARAWIT'),		('TXT_KEY_CIV5_DMS_SARAWIT_TEXT'),		('TXT_KEY_UNIT_DMS_SARAWIT_STRATEGY'),		('TXT_KEY_UNIT_DMS_SARAWIT_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	2,						('ART_DEF_UNIT_DMS_SARAWIT'),											0,					('DMS_SARAWIT_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	10
FROM Units WHERE Type = 'UNIT_DMS_SARAWIT';

INSERT INTO Units 	
		(Type, 							Class,								PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	ExtraMaintenanceCost,	UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_3'),	('UNITCLASS_DMS_SARAWIT_CHEAP_3'),	null,					Combat+1,				43,		FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SARAWIT'),		('TXT_KEY_CIV5_DMS_SARAWIT_TEXT'),		('TXT_KEY_UNIT_DMS_SARAWIT_STRATEGY'),		('TXT_KEY_UNIT_DMS_SARAWIT_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	2,						('ART_DEF_UNIT_DMS_SARAWIT'),											0,					('DMS_SARAWIT_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	10
FROM Units WHERE Type = 'UNIT_DMS_SARAWIT';

INSERT INTO Units 	
		(Type, 							Class,								PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	ExtraMaintenanceCost,	UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_4'),	('UNITCLASS_DMS_SARAWIT_CHEAP_4'),	null,					Combat+1,				38,		FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SARAWIT'),		('TXT_KEY_CIV5_DMS_SARAWIT_TEXT'),		('TXT_KEY_UNIT_DMS_SARAWIT_STRATEGY'),		('TXT_KEY_UNIT_DMS_SARAWIT_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	2,						('ART_DEF_UNIT_DMS_SARAWIT'),											0,					('DMS_SARAWIT_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	10
FROM Units WHERE Type = 'UNIT_DMS_SARAWIT';

INSERT INTO Units 	
		(Type, 							Class,								PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	ExtraMaintenanceCost,	UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_5'),	('UNITCLASS_DMS_SARAWIT_CHEAP_5'),	null,					Combat+1,				34,		FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SARAWIT'),		('TXT_KEY_CIV5_DMS_SARAWIT_TEXT'),		('TXT_KEY_UNIT_DMS_SARAWIT_STRATEGY'),		('TXT_KEY_UNIT_DMS_SARAWIT_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	2,						('ART_DEF_UNIT_DMS_SARAWIT'),											0,					('DMS_SARAWIT_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	10
FROM Units WHERE Type = 'UNIT_DMS_SARAWIT';

INSERT INTO Units 	
		(Type, 							Class,								PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	ExtraMaintenanceCost,	UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_6'),	('UNITCLASS_DMS_SARAWIT_CHEAP_6'),	null,					Combat+1,				29,		FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SARAWIT'),		('TXT_KEY_CIV5_DMS_SARAWIT_TEXT'),		('TXT_KEY_UNIT_DMS_SARAWIT_STRATEGY'),		('TXT_KEY_UNIT_DMS_SARAWIT_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	2,						('ART_DEF_UNIT_DMS_SARAWIT'),											0,					('DMS_SARAWIT_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	10
FROM Units WHERE Type = 'UNIT_DMS_SARAWIT';

INSERT INTO Units 	
		(Type, 							Class,								PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	ExtraMaintenanceCost,	UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_7'),	('UNITCLASS_DMS_SARAWIT_CHEAP_7'),	null,					Combat+1,				25,		FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SARAWIT'),		('TXT_KEY_CIV5_DMS_SARAWIT_TEXT'),		('TXT_KEY_UNIT_DMS_SARAWIT_STRATEGY'),		('TXT_KEY_UNIT_DMS_SARAWIT_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	2,						('ART_DEF_UNIT_DMS_SARAWIT'),											0,					('DMS_SARAWIT_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	10
FROM Units WHERE Type = 'UNIT_DMS_SARAWIT';

INSERT INTO Units 	
		(Type, 							Class,								PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	ExtraMaintenanceCost,	UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_8'),	('UNITCLASS_DMS_SARAWIT_CHEAP_8'),	null,					Combat+1,				20,		FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SARAWIT'),		('TXT_KEY_CIV5_DMS_SARAWIT_TEXT'),		('TXT_KEY_UNIT_DMS_SARAWIT_STRATEGY'),		('TXT_KEY_UNIT_DMS_SARAWIT_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,	2,						('ART_DEF_UNIT_DMS_SARAWIT'),											0,					('DMS_SARAWIT_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	10
FROM Units WHERE Type = 'UNIT_DMS_SARAWIT';

INSERT INTO Units 	
		(Type, 							Class,	PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,											UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex,	MoveRate)
SELECT	('UNIT_DMS_KOREM'),				Class,	('TECH_METAL_CASTING'),	Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves+1,							CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_KOREM'),			('TXT_KEY_CIV5_DMS_KOREM_TEXT'),		('TXT_KEY_UNIT_DMS_KOREM_STRATEGY'),		('TXT_KEY_UNIT_DMS_KOREM_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,											('ART_DEF_UNIT_DMS_KOREM'),												0,					('DMS_KOREM_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	16,				MoveRate
FROM Units WHERE Type = 'UNIT_KNIGHT';

INSERT INTO Units 	
		(Type, 							Class,	PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,			HurryCostModifier,	CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,							UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex,	MoveRate)
SELECT	('UNIT_DMS_SHOTELAI'),			Class,	PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,			HurryCostModifier,	CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SHOTELAI'),		('TXT_KEY_CIV5_DMS_SHOTELAI_TEXT'),		('TXT_KEY_UNIT_DMS_SHOTELAI_STRATEGY'),		('TXT_KEY_UNIT_DMS_SHOTELAI_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,							('ART_DEF_UNIT_DMS_SHOTELAI'),											0,					('DMS_SHOTELAI_FLAG_ART_ATLAS'),	('DMS_ETHIOPIA_ATLAS'),	11,				MoveRate
FROM Units WHERE Type = 'UNIT_SWORDSMAN';

INSERT INTO Units 	
		(Type, 							Class,													Cost,												Moves,													Capture,	CivilianAttackPriority,	Special,	Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,																																										AdvancedStartCost,	WorkRate,	CombatLimit,	FoundReligion,	SpreadReligion,	ReligionSpreads,	ReligiousStrength,																																			UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_DEBTERA'),			Class,													Cost,												Moves,													Capture,	CivilianAttackPriority,	Special,	Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_DEBTERA'),		('TXT_KEY_CIV5_DMS_DEBTERA_TEXT'),		('TXT_KEY_UNIT_DMS_DEBTERA_STRATEGY'),		('TXT_KEY_UNIT_DMS_DEBTERA_HELP'),																																			AdvancedStartCost,	WorkRate,	CombatLimit,	FoundReligion,	SpreadReligion,	ReligionSpreads,	ReligiousStrength,																																			('ART_DEF_UNIT_DMS_DEBTERA'),											0,					('DMS_DEBTERA_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	12
FROM Units WHERE Type = 'UNIT_PROPHET';

INSERT INTO Units 	
		(Type, 							Class,	PrereqTech,				Combat,	RangedCombat,	Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	Range,						CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,	Mechanized,					IgnoreBuildingDefense,	GoodyHutUpgradeUnitClass,	AdvancedStartCost,				CombatLimit,																																			XPValueAttack,	XPValueDefense,											UnitArtInfo,								UnitArtInfoEraVariation,	UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex,	MoveRate)
SELECT	('UNIT_DMS_SEBASTOPOL'),		Class,	PrereqTech,				21,		28,				312,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	Range,						CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_SEBASTOPOL'),	('TXT_KEY_CIV5_DMS_SEBASTOPOL_TEXT'),	('TXT_KEY_UNIT_DMS_SEBASTOPOL_STRATEGY'),	('TXT_KEY_UNIT_DMS_SEBASTOPOL_HELP'),	1,					1,					1,			Mechanized,					1,						GoodyHutUpgradeUnitClass,	AdvancedStartCost,				CombatLimit,																																			XPValueAttack,	XPValueDefense,											('ART_DEF_UNIT_DMS_SEBASTOPOL'),			0,							0,					('DMS_SEBASTOPOL_FLAG_ART_ATLAS'),	('DMS_ETHIOPIA_ATLAS'),	18,				('ARTILLERY')
FROM Units WHERE Type = 'UNIT_ARTILLERY';

INSERT INTO Units 	
		(Type, 							Class,	PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,	IgnoreBuildingDefense,	GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,							UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_KAGNEW'),			Class,	PrereqTech,				Combat,					Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,								CombatClass,														Domain,											DefaultUnitAI,	('TXT_KEY_UNIT_DMS_KAGNEW'),		('TXT_KEY_CIV5_DMS_KAGNEW_TEXT'),		('TXT_KEY_UNIT_DMS_KAGNEW_STRATEGY'),		('TXT_KEY_UNIT_DMS_KAGNEW_HELP'),		MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,	IgnoreBuildingDefense,	GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,	Conscription,							('ART_DEF_UNIT_DMS_KAGNEW'),											0,					('DMS_KAGNEW_FLAG_ART_ATLAS'),		('DMS_ETHIOPIA_ATLAS'),	14
FROM Units WHERE Type = 'UNIT_INFANTRY';

INSERT INTO Units 	
		(Type, 							Class,	PrereqTech,						RangedCombat,	Cost,												Moves,								CombatClass,											Special,	Domain,	Immobile,	Range,	AirInterceptRange,	DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,				Mechanized,	ObsoleteTech,	IgnoreBuildingDefense,								AdvancedStartCost,																														AirUnitCap,	RangedCombatLimit,	CombatLimit,	XPValueAttack,	XPValueDefense,											UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex,	MoveRate)
SELECT	('UNIT_DMS_MAKONNEN'),			Class,	PrereqTech,						RangedCombat-4,	Cost,												Moves,								CombatClass,											NULL,		Domain,	Immobile,	Range,	AirInterceptRange,	DefaultUnitAI,	('TXT_KEY_UNIT_DMS_MAKONNEN'),		('TXT_KEY_CIV5_DMS_MAKONNEN_TEXT'),		('TXT_KEY_UNIT_DMS_MAKONNEN_STRATEGY'),		('TXT_KEY_UNIT_DMS_MAKONNEN_HELP'),		MilitarySupport,	MilitaryProduction,				Mechanized,	ObsoleteTech,	IgnoreBuildingDefense,								AdvancedStartCost,																														AirUnitCap,	RangedCombatLimit,	CombatLimit,	XPValueAttack,	XPValueDefense,											('ART_DEF_UNIT_DMS_MAKONNEN'),											0,					('DMS_MAKONNEN_FLAG_ART_ATLAS'),	('DMS_ETHIOPIA_ATLAS'),	19,				MoveRate
FROM Units WHERE Type = 'UNIT_TRIPLANE';

INSERT INTO Units 	
		(Type, 							Class,	PrereqTech,						RangedCombat,	Cost,												Moves,								CombatClass,											Special,	Domain,	Immobile,	Range,	AirInterceptRange,	DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,				Mechanized,	ObsoleteTech,	IgnoreBuildingDefense,								AdvancedStartCost,																														AirUnitCap,	RangedCombatLimit,	CombatLimit,	XPValueAttack,	XPValueDefense,											UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex,	MoveRate)
SELECT	('UNIT_DMS_MAKONNEN_NO_OIL'),	Class,	NULL,							RangedCombat-4,	-1,													Moves,								CombatClass,											NULL,		Domain,	Immobile,	Range,	AirInterceptRange,	DefaultUnitAI,	('TXT_KEY_UNIT_DMS_MAKONNEN'),		('TXT_KEY_CIV5_DMS_MAKONNEN_TEXT'),		('TXT_KEY_UNIT_DMS_MAKONNEN_STRATEGY'),		('TXT_KEY_UNIT_DMS_MAKONNEN_HELP'),		MilitarySupport,	MilitaryProduction,				Mechanized,	ObsoleteTech,	IgnoreBuildingDefense,								AdvancedStartCost,																														AirUnitCap,	RangedCombatLimit,	CombatLimit,	XPValueAttack,	XPValueDefense,											('ART_DEF_UNIT_DMS_MAKONNEN'),											0,					('DMS_MAKONNEN_FLAG_ART_ATLAS'),	('DMS_ETHIOPIA_ATLAS'),	19,				MoveRate
FROM Units WHERE Type = 'UNIT_DMS_MAKONNEN';

INSERT INTO Units 	
		(Type, 							Class,	PrereqTech,				Combat,	RangedCombat,	Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	Range,						CombatClass,														Domain,				Range,						DefaultUnitAI,	Description,						Civilopedia,							Strategy,									Help,									MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,											UnitArtInfo,															UnitFlagIconOffset,	UnitFlagAtlas,						IconAtlas,				PortraitIndex)
SELECT	('UNIT_DMS_AGAW_BOUDA'),		Class,	PrereqTech,				Combat,	RangedCombat-3,	Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	Range+1,					CombatClass,														Domain,				Range,						DefaultUnitAI,	('TXT_KEY_UNIT_DMS_AGAW_BOUDA'),	('TXT_KEY_CIV5_DMS_AGAW_BOUDA_TEXT'),	('TXT_KEY_UNIT_DMS_AGAW_BOUDA_STRATEGY'),	('TXT_KEY_UNIT_DMS_AGAW_BOUDA_HELP'),	MilitarySupport,	MilitaryProduction,	Pillage,				ObsoleteTech,							GoodyHutUpgradeUnitClass,	AdvancedStartCost,																																										XPValueAttack,	XPValueDefense,											('ART_DEF_UNIT_DMS_AGAW_BOUDA'),										0,					('DMS_AGAW_BOUDA_FLAG_ART_ATLAS'),	('DMS_SEMIEN_ATLAS'),	2
FROM Units WHERE Type = 'UNIT_COMPOSITE_BOWMAN';
--------------------------------
-- Unit_TechTypes
--------------------------------
INSERT INTO Unit_TechTypes 	
		(UnitType, 						TechType)
VALUES	('UNIT_DMS_SARAWIT_CHEAP_1', 	'TECH_BRONZE_WORKING'),
		('UNIT_DMS_SARAWIT_CHEAP_2', 	'TECH_BRONZE_WORKING'),
		('UNIT_DMS_SARAWIT_CHEAP_3', 	'TECH_BRONZE_WORKING'),
		('UNIT_DMS_SARAWIT_CHEAP_4', 	'TECH_BRONZE_WORKING'),
		('UNIT_DMS_SARAWIT_CHEAP_5', 	'TECH_BRONZE_WORKING'),
		('UNIT_DMS_SARAWIT_CHEAP_6', 	'TECH_BRONZE_WORKING'),
		('UNIT_DMS_SARAWIT_CHEAP_7',	'TECH_BRONZE_WORKING'),
		('UNIT_DMS_SARAWIT_CHEAP_8', 	'TECH_BRONZE_WORKING');
--------------------------------
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SARAWIT'), 				SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SPEARMAN');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_1'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_DMS_SARAWIT');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_2'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_DMS_SARAWIT');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_3'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_DMS_SARAWIT');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_4'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_DMS_SARAWIT');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_5'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_DMS_SARAWIT');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_6'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_DMS_SARAWIT');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_7'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_DMS_SARAWIT');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_8'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_DMS_SARAWIT');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_KOREM'), 				SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_KNIGHT');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SHOTELAI'), 				SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SWORDSMAN');
	
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_DEBTERA'), 				SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_PROPHET');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_SEBASTOPOL'), 			SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_GENERAL');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_KAGNEW'), 				SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_INFANTRY');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_MAKONNEN'), 				SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_TRIPLANE');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_MAKONNEN_NO_OIL'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_DMS_MAKONNEN');	

INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_AGAW_BOUDA'), 			SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');	
--------------------------------
-- Unit_AITypes
--------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SARAWIT'), 				UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_1'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_2'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_3'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_4'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_5'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_6'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_7'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_8'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_KOREM'), 				UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_KNIGHT');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SHOTELAI'), 				UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SWORDSMAN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_DEBTERA'), 				UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNITAI_PROPHET');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_SEBASTOPOL'), 			UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_ARTILLERY');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
VALUES	('UNIT_DMS_SEBASTOPOL', 			'UNITAI_GENERAL');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_KAGNEW'), 				UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_INFANTRY');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_MAKONNEN'), 				UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_TRIPLANE');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_MAKONNEN_NO_OIL'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_DMS_MAKONNEN');

INSERT INTO Unit_AITypes 	
		(UnitType, 							UnitAIType)
SELECT	('UNIT_DMS_AGAW_BOUDA'), 			UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');
--------------------------------
-- Unit_Flavors
-------------------------------- 
INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SARAWIT'), 				FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_1'), 		FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_2'), 		FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_3'), 		FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_4'), 		FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_5'), 		FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_6'), 		FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_7'), 		FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_8'), 		FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_KOREM'), 				FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_KNIGHT');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SHOTELAI'), 				FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SWORDSMAN');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_DEBTERA'), 				FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_PROPHET');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SEBASTOPOL'), 			FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_ARTILLERY');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_SEBASTOPOL'), 			FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_GENERAL');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_KAGNEW'), 				FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_INFANTRY');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_MAKONNEN'), 				FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_TRIPLANE');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_MAKONNEN_NO_OIL'), 		FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_DMS_MAKONNEN');

INSERT INTO Unit_Flavors 	
		(UnitType, 							FlavorType,			Flavor)
SELECT	('UNIT_DMS_AGAW_BOUDA'), 			FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');
--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SARAWIT'),				PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_1'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_2'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_3'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_4'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_5'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_6'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_7'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_8'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_KOREM'),					PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_KNIGHT');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SHOTELAI'),				PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_SWORDSMAN');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_DEBTERA'),				PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_PROPHET');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SEBASTOPOL'),			PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_ARTILLEY');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_SEBASTOPOL'),			PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_ARTILLEY');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_KAGNEW'),				PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_INFANTRY');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_MAKONNEN'),				PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_TRIPLANE');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_MAKONNEN_NO_OIL'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_DMS_MAKONNEN');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
SELECT	('UNIT_DMS_AGAW_BOUDA'),			PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 							PromotionType)
VALUES	('UNIT_DMS_KAGNEW', 				'PROMOTION_DRILL_1'),
		('UNIT_DMS_KAGNEW', 				'PROMOTION_DMS_ZEBENYA'),
		('UNIT_DMS_KOREM', 					'PROMOTION_DMS_KOREM'),
		('UNIT_DMS_SHOTELAI', 				'PROMOTION_DMS_SHOTEL'),
		('UNIT_DMS_SEBASTOPOL', 			'PROMOTION_TEWODROS_LEGACY'),
		('UNIT_DMS_MAKONNEN', 				'PROMOTION_DMS_IMPERIAL_AIRFORCE'),
		('UNIT_DMS_MAKONNEN_NO_OIL',		'PROMOTION_DMS_IMPERIAL_AIRFORCE'),
		('UNIT_DMS_AGAW_BOUDA',				'PROMOTION_DMS_QEST');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SARAWIT'),				UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_1'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_2'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_3'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_4'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_5'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_6'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_7'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SARAWIT_CHEAP_8'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_DMS_SARAWIT');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_KOREM'),					UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_KNIGHT');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SHOTELAI'),				UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_SWORDSMAN');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_SEBASTOPOL'),			UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_ARTILLEY');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_KAGNEW'),				UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_INFANTRY');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_MAKONNEN'),				UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_TRIPLANE');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_MAKONNEN_NO_OIL'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_DMS_MAKONNEN');

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 							UnitClassType)
SELECT	('UNIT_DMS_AGAW_BOUDA'),			UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_COMPOSITE_BOWMAN');
-------------------------------- 
-- Unit_Builds
--------------------------------
INSERT INTO Unit_Builds 	
		(UnitType, 				BuildType)
SELECT	('UNIT_DMS_DEBTERA'),	BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_PROPHET');

INSERT INTO Unit_Builds 	
		(UnitType, 				BuildType)
VALUES	('UNIT_WORKER', 		'BUILD_DMS_MONOLITHIC_CHURCH');
--------------------------------
-- Unit_ResourceQuantityRequirements
--------------------------------	
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 						ResourceType)
SELECT	('UNIT_DMS_KOREM'),				ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_KNIGHT');

INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 						ResourceType)
SELECT	('UNIT_DMS_SHOTELAI'),			ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_SWORDSMAN');

INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 						ResourceType)
SELECT	('UNIT_DMS_MAKONNEN'),			ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_TRIPLANE');
--==========================================================================================================================
-- GreatWorks
--==========================================================================================================================
-- GreatWorks
--------------------------------
--==========================================================================================================================
-- PROMOTIONS
--==========================================================================================================================
-- Promotions
--------------------------------
INSERT INTO UnitPromotions 	
		(Type, 									Description,									Help,													Sound,				CityAttack,		GreatGeneral,		CombatPercent,	PortraitIndex,	IconAtlas,				PediaType,			PediaEntry,											CannotBeChosen)
VALUES	('PROMOTION_DMS_KOREM',					'TXT_KEY_PROMOTION_DMS_KOREM',					'TXT_KEY_PROMOTION_DMS_KOREM_HELP',						'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_KOREM_HELP',					1),
		('PROMOTION_DMS_SHOTEL',				'TXT_KEY_PROMOTION_DMS_SHOTEL',					'TXT_KEY_PROMOTION_DMS_SHOTEL_HELP',					'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SHOTEL_HELP',				1),
		('PROMOTION_DMS_SEED_OF_JACOB_1',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_1',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_1_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_1_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_2',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_2',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_2_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_2_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_3',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_3',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_3_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_3_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_4',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_4',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_4_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_4_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_5',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_5',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_5_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_5_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_6',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_6',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_6_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_6_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_7',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_7',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_7_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_7_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_8',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_8',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_8_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_8_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_9',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_9',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_9_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_9_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_10',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_10',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_10_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_10_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_11',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_11',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_11_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_11_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_12',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_12',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_12_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_12_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_13',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_13',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_13_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_13_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_14',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_14',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_14_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_14_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_15',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_15',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_15_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_15_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_16',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_16',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_16_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_16_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_17',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_17',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_17_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_17_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_18',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_18',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_18_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_18_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_19',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_19',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_19_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_19_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_20',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_20',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_20_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_20_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_21',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_21',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_21_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_21_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_22',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_22',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_22_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_22_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_23',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_23',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_23_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_23_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_24',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_24',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_24_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_24_HELP',		1),
		('PROMOTION_DMS_SEED_OF_JACOB_25',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_25',		'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_25_HELP',			'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_SEED_OF_JACOB_25_HELP',		1),
		('PROMOTION_TEWODROS_LEGACY',			'TXT_KEY_PROMOTION_TEWODROS_LEGACY',			'TXT_KEY_PROMOTION_TEWODROS_LEGACY_HELP',				'AS2D_IF_LEVELUP',	50,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_TEWODROS_LEGACY_HELP',			1),
		('PROMOTION_DMS_GREAT_MOTAR_1_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_1_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_1_GG_HELP',			'AS2D_IF_LEVELUP',	0,				1,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_1_GG_HELP',		1),
		('PROMOTION_DMS_GREAT_MOTAR_2_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_2_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_2_GG_HELP',			'AS2D_IF_LEVELUP',	0,				1,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_2_GG_HELP',		1),
		('PROMOTION_DMS_GREAT_MOTAR_3_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_3_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_3_GG_HELP',			'AS2D_IF_LEVELUP',	0,				1,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_3_GG_HELP',		1),
		('PROMOTION_DMS_GREAT_MOTAR_4_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_4_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_4_GG_HELP',			'AS2D_IF_LEVELUP',	0,				1,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_4_GG_HELP',		1),
		('PROMOTION_DMS_GREAT_MOTAR_5_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_5_GG',		'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_5_GG_HELP',			'AS2D_IF_LEVELUP',	0,				1,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_5_GG_HELP',		1),
		('PROMOTION_DMS_GREAT_MOTAR_DEPLETED',	'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_DEPLETED',	'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_DEPLETED_HELP',		'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_GREAT_MOTAR_DEPLETED_HELP',	1),
		('PROMOTION_DMS_ZEBENYA',				'TXT_KEY_PROMOTION_DMS_ZEBENYA',				'TXT_KEY_PROMOTION_DMS_ZEBENYA_HELP',					'AS2D_IF_LEVELUP',	0,				0,					0,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_HELP',				1),
		('PROMOTION_DMS_ZEBENYA_1_STRENGTH',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_1_STRENGTH',		'TXT_KEY_PROMOTION_DMS_ZEBENYA_1_STRENGTH_HELP',		'AS2D_IF_LEVELUP',	0,				0,					5,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_1_STRENGTH_HELP',	1),
		('PROMOTION_DMS_ZEBENYA_2_STRENGTH',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_2_STRENGTH',		'TXT_KEY_PROMOTION_DMS_ZEBENYA_2_STRENGTH_HELP',		'AS2D_IF_LEVELUP',	0,				0,					10,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_2_STRENGTH_HELP',	1),
		('PROMOTION_DMS_ZEBENYA_3_STRENGTH',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_3_STRENGTH',		'TXT_KEY_PROMOTION_DMS_ZEBENYA_3_STRENGTH_HELP',		'AS2D_IF_LEVELUP',	0,				0,					15,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_3_STRENGTH_HELP',	1),
		('PROMOTION_DMS_ZEBENYA_4_STRENGTH',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_4_STRENGTH',		'TXT_KEY_PROMOTION_DMS_ZEBENYA_4_STRENGTH_HELP',		'AS2D_IF_LEVELUP',	0,				0,					20,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_4_STRENGTH_HELP',	1),
		('PROMOTION_DMS_ZEBENYA_5_STRENGTH',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_5_STRENGTH',		'TXT_KEY_PROMOTION_DMS_ZEBENYA_5_STRENGTH_HELP',		'AS2D_IF_LEVELUP',	0,				0,					25,				59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_ZEBENYA_5_STRENGTH_HELP',	1);

INSERT INTO UnitPromotions 	
		(Type, 									Description,									Help,													Sound,				HasPostCombatPromotions,	PortraitIndex,	IconAtlas,				PediaType,			PediaEntry,											CannotBeChosen)
VALUES	('PROMOTION_DMS_QEST',					'TXT_KEY_PROMOTION_DMS_QEST',					'TXT_KEY_PROMOTION_DMS_QEST_HELP',						'AS2D_IF_LEVELUP',	1,							59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_QEST_HELP',					1),
		('PROMOTION_DMS_AFTERRANDOM',			'TXT_KEY_PROMOTION_DMS_AFTERRANDOM',			'TXT_KEY_PROMOTION_DMS_AFTERRANDOM_HELP',				'AS2D_IF_LEVELUP',	0,							59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_AFTERRANDOM_HELP',			1);

INSERT INTO UnitPromotions 	
		(Type, 									Description,									Help,													Sound,				EnemyHealChange,		NeutralHealChange,		FriendlyHealChange,	PortraitIndex,	IconAtlas,				PediaType,			PediaEntry,											CannotBeChosen)
VALUES	('PROMOTION_DMS_IMPERIAL_AIRFORCE',		'TXT_KEY_PROMOTION_DMS_IMPERIAL_AIRFORCE',		'TXT_KEY_PROMOTION_DMS_IMPERIAL_AIRFORCE_HELP',			'AS2D_IF_LEVELUP',	15,						15,						15,					59,				'ABILITY_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_IMPERIAL_AIRFORCE_HELP',		1);
-------------------------------- 
-- UnitPromotions_PostCombatRandomPromotion
--------------------------------
INSERT INTO UnitPromotions_PostCombatRandomPromotion 	
		(PromotionType, 						NewPromotion)
VALUES	('PROMOTION_DMS_QEST',					'PROMOTION_DMS_AFTERRANDOM');
-------------------------------- 
-- UnitPromotions_UnitCombats
--------------------------------
INSERT INTO UnitPromotions_UnitCombats 	
		(PromotionType, 						UnitCombatType)
VALUES	('PROMOTION_DMS_KOREM',					'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SHOTEL',				'UNITCOMBAT_MELEE'),
		('PROMOTION_TEWODROS_LEGACY',			'UNITCOMBAT_SIEGE'),
		('PROMOTION_DMS_GREAT_MOTAR_1_GG',		'UNITCOMBAT_SIEGE'),
		('PROMOTION_DMS_GREAT_MOTAR_2_GG',		'UNITCOMBAT_SIEGE'),
		('PROMOTION_DMS_GREAT_MOTAR_3_GG',		'UNITCOMBAT_SIEGE'),
		('PROMOTION_DMS_GREAT_MOTAR_4_GG',		'UNITCOMBAT_SIEGE'),
		('PROMOTION_DMS_GREAT_MOTAR_5_GG',		'UNITCOMBAT_SIEGE'),
		('PROMOTION_DMS_GREAT_MOTAR_DEPLETED',	'UNITCOMBAT_SIEGE'),
		('PROMOTION_DMS_ZEBENYA',				'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_ZEBENYA_1_STRENGTH',	'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_ZEBENYA_2_STRENGTH',	'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_ZEBENYA_3_STRENGTH',	'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_ZEBENYA_4_STRENGTH',	'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_ZEBENYA_5_STRENGTH',	'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_1',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_1',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_1',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_1',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_1',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_2',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_2',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_2',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_2',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_2',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_3',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_3',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_3',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_3',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_3',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_4',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_4',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_4',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_4',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_4',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_5',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_5',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_5',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_5',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_5',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_6',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_6',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_6',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_6',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_6',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_7',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_7',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_7',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_7',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_7',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_8',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_8',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_8',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_8',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_8',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_9',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_9',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_9',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_9',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_9',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_10',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_10',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_10',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_10',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_10',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_11',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_11',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_11',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_11',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_11',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_12',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_12',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_12',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_12',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_12',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_13',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_13',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_13',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_13',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_13',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_14',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_14',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_14',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_14',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_14',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_15',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_15',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_15',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_15',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_15',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_16',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_16',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_16',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_16',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_16',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_17',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_17',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_17',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_17',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_17',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_18',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_18',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_18',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_18',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_18',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_19',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_19',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_19',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_19',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_19',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_20',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_20',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_20',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_20',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_20',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_21',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_21',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_21',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_21',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_21',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_22',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_22',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_22',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_22',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_22',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_23',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_23',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_23',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_23',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_23',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_24',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_24',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_24',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_24',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_24',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_SEED_OF_JACOB_25',		'UNITCOMBAT_RECON'),
		('PROMOTION_DMS_SEED_OF_JACOB_25',		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_DMS_SEED_OF_JACOB_25',		'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_SEED_OF_JACOB_25',		'UNITCOMBAT_GUN'),
		('PROMOTION_DMS_SEED_OF_JACOB_25',		'UNITCOMBAT_ARMOR'),
		('PROMOTION_DMS_IMPERIAL_AIRFORCE',		'UNITCOMBAT_FIGHTER'),
		('PROMOTION_DMS_QEST',					'UNITCOMBAT_ARCHER'),
		('PROMOTION_DMS_AFTERRANDOM',			'UNITCOMBAT_ARCHER');		
--==========================================================================================================================
-- LEADERS
--==========================================================================================================================
-- Leaders
--------------------------------
INSERT INTO Leaders 
		(Type, 								Description, 							Civilopedia, 							CivilopediaTag, 									ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES	('LEADER_DMS_KALEB', 				'TXT_KEY_LEADER_DMS_KALEB', 			'TXT_KEY_LEADER_DMS_KALEB_PEDIA', 		'TXT_KEY_CIVILOPEDIA_LEADERS_DMS_KALEB', 			'Kaleb_Diplo.xml',				6, 						6, 						4, 							6, 			7, 				6, 				3, 						7, 				5, 			4, 			6, 				5, 			4, 			'DMS_ETHIOPIA_ATLAS',		5),
		('LEADER_DMS_SEYON_I', 				'TXT_KEY_LEADER_DMS_SEYON_I', 			'TXT_KEY_LEADER_DMS_SEYON_I_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_DMS_SEYON_I', 			'AmdaSeyonI_Diplo.xml',			7, 						4, 						6, 							8, 			6, 				5, 				7, 						4, 				5, 			3, 			2, 				3, 			8, 			'DMS_ETHIOPIA_ATLAS',		6),
		('LEADER_DMS_YAQOB', 				'TXT_KEY_LEADER_DMS_YAQOB', 			'TXT_KEY_LEADER_DMS_YAQOB_PEDIA', 		'TXT_KEY_CIVILOPEDIA_LEADERS_DMS_YAQOB', 			'ZaraYaqob_Diplo.xml',			5, 						7, 						5, 							6, 			6, 				7, 				7, 						6, 				4, 			7, 			7, 				6, 			6, 			'DMS_ETHIOPIA_ATLAS',		7),
		('LEADER_DMS_MENELIK_II', 			'TXT_KEY_LEADER_DMS_MENELIK_II', 		'TXT_KEY_LEADER_DMS_MENELIK_II_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_DMS_MENELIK_II', 		'MenelikII_Diplo.xml',			8, 						6, 						6, 							8, 			5, 				6, 				6, 						7, 				4, 			5, 			5, 				4, 			6, 			'DMS_ETHIOPIA_ATLAS',		8),
		('LEADER_DMS_GUDIT', 				'TXT_KEY_LEADER_DMS_GUDIT', 			'TXT_KEY_LEADER_DMS_GUDIT_PEDIA', 		'TXT_KEY_CIVILOPEDIA_LEADERS_DMS_GUDIT', 			'Gudit_Diplo.xml',				8, 						3, 						5, 							10, 		2, 				2, 				5, 						5, 				6, 			4, 			2, 				5, 			7, 			'DMS_SEMIEN_ATLAS',			1);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_KALEB', 			'MAJOR_CIV_APPROACH_WAR', 			4),
		('LEADER_DMS_KALEB', 			'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_DMS_KALEB', 			'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
		('LEADER_DMS_KALEB', 			'MAJOR_CIV_APPROACH_GUARDED', 		4),
		('LEADER_DMS_KALEB',			'MAJOR_CIV_APPROACH_AFRAID', 		3),
		('LEADER_DMS_KALEB', 			'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_DMS_KALEB', 			'MAJOR_CIV_APPROACH_NEUTRAL', 		5),
		('LEADER_DMS_SEYON_I', 			'MAJOR_CIV_APPROACH_WAR', 			7),
		('LEADER_DMS_SEYON_I', 			'MAJOR_CIV_APPROACH_HOSTILE', 		5),
		('LEADER_DMS_SEYON_I', 			'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
		('LEADER_DMS_SEYON_I', 			'MAJOR_CIV_APPROACH_GUARDED', 		5),
		('LEADER_DMS_SEYON_I', 			'MAJOR_CIV_APPROACH_AFRAID', 		2),
		('LEADER_DMS_SEYON_I', 			'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
		('LEADER_DMS_SEYON_I', 			'MAJOR_CIV_APPROACH_NEUTRAL', 		4),
		('LEADER_DMS_YAQOB', 			'MAJOR_CIV_APPROACH_WAR', 			5),
		('LEADER_DMS_YAQOB', 			'MAJOR_CIV_APPROACH_HOSTILE', 		6),
		('LEADER_DMS_YAQOB', 			'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
		('LEADER_DMS_YAQOB', 			'MAJOR_CIV_APPROACH_GUARDED', 		8),
		('LEADER_DMS_YAQOB', 			'MAJOR_CIV_APPROACH_AFRAID', 		8),
		('LEADER_DMS_YAQOB', 			'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
		('LEADER_DMS_YAQOB', 			'MAJOR_CIV_APPROACH_NEUTRAL', 		2),
		('LEADER_DMS_MENELIK_II', 		'MAJOR_CIV_APPROACH_WAR', 			5),
		('LEADER_DMS_MENELIK_II', 		'MAJOR_CIV_APPROACH_HOSTILE', 		7),
		('LEADER_DMS_MENELIK_II', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
		('LEADER_DMS_MENELIK_II', 		'MAJOR_CIV_APPROACH_GUARDED', 		7),
		('LEADER_DMS_MENELIK_II', 		'MAJOR_CIV_APPROACH_AFRAID', 		6),
		('LEADER_DMS_MENELIK_II', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_DMS_MENELIK_II', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		8),
		('LEADER_DMS_GUDIT', 			'MAJOR_CIV_APPROACH_WAR', 			7),
		('LEADER_DMS_GUDIT', 			'MAJOR_CIV_APPROACH_HOSTILE', 		8),
		('LEADER_DMS_GUDIT', 			'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
		('LEADER_DMS_GUDIT', 			'MAJOR_CIV_APPROACH_GUARDED', 		4),
		('LEADER_DMS_GUDIT', 			'MAJOR_CIV_APPROACH_AFRAID', 		3),
		('LEADER_DMS_GUDIT', 			'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_DMS_GUDIT', 			'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------					
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 					MinorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_KALEB', 			'MINOR_CIV_APPROACH_IGNORE', 		3),
		('LEADER_DMS_KALEB', 			'MINOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_DMS_KALEB', 			'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
		('LEADER_DMS_KALEB', 			'MINOR_CIV_APPROACH_CONQUEST', 		2),
		('LEADER_DMS_KALEB', 			'MINOR_CIV_APPROACH_BULLY', 		6),
		('LEADER_DMS_SEYON_I', 			'MINOR_CIV_APPROACH_IGNORE', 		3),
		('LEADER_DMS_SEYON_I', 			'MINOR_CIV_APPROACH_FRIENDLY', 		2),
		('LEADER_DMS_SEYON_I', 			'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
		('LEADER_DMS_SEYON_I', 			'MINOR_CIV_APPROACH_CONQUEST', 		7),
		('LEADER_DMS_SEYON_I', 			'MINOR_CIV_APPROACH_BULLY', 		5),
		('LEADER_DMS_YAQOB', 			'MINOR_CIV_APPROACH_IGNORE', 		6),
		('LEADER_DMS_YAQOB', 			'MINOR_CIV_APPROACH_FRIENDLY', 		7),
		('LEADER_DMS_YAQOB', 			'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
		('LEADER_DMS_YAQOB', 			'MINOR_CIV_APPROACH_CONQUEST', 		5),
		('LEADER_DMS_YAQOB', 			'MINOR_CIV_APPROACH_BULLY', 		2),
		('LEADER_DMS_MENELIK_II', 		'MINOR_CIV_APPROACH_IGNORE', 		4),
		('LEADER_DMS_MENELIK_II', 		'MINOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_DMS_MENELIK_II', 		'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
		('LEADER_DMS_MENELIK_II', 		'MINOR_CIV_APPROACH_CONQUEST', 		6),
		('LEADER_DMS_MENELIK_II', 		'MINOR_CIV_APPROACH_BULLY', 		4),
		('LEADER_DMS_GUDIT', 			'MINOR_CIV_APPROACH_IGNORE', 		5),
		('LEADER_DMS_GUDIT', 			'MINOR_CIV_APPROACH_FRIENDLY', 		7),
		('LEADER_DMS_GUDIT', 			'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
		('LEADER_DMS_GUDIT', 			'MINOR_CIV_APPROACH_CONQUEST', 		4),
		('LEADER_DMS_GUDIT', 			'MINOR_CIV_APPROACH_BULLY', 		6);
--------------------------------
-- Leader_Flavors
--------------------------------
INSERT INTO Leader_Flavors 
		(LeaderType, 					FlavorType, 						Flavor)
VALUES	('LEADER_DMS_KALEB', 			'FLAVOR_OFFENSE', 					5),
		('LEADER_DMS_KALEB', 			'FLAVOR_DEFENSE', 					6),
		('LEADER_DMS_KALEB', 			'FLAVOR_CITY_DEFENSE', 				7),
		('LEADER_DMS_KALEB', 			'FLAVOR_MILITARY_TRAINING', 		6),
		('LEADER_DMS_KALEB', 			'FLAVOR_RECON', 					8),
		('LEADER_DMS_KALEB', 			'FLAVOR_RANGED', 					7),
		('LEADER_DMS_KALEB', 			'FLAVOR_MOBILE', 					5),
		('LEADER_DMS_KALEB', 			'FLAVOR_NAVAL', 					5),
		('LEADER_DMS_KALEB', 			'FLAVOR_NAVAL_RECON', 				8),
		('LEADER_DMS_KALEB', 			'FLAVOR_NAVAL_GROWTH', 				6),
		('LEADER_DMS_KALEB', 			'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_DMS_KALEB', 			'FLAVOR_AIR', 						5),
		('LEADER_DMS_KALEB', 			'FLAVOR_EXPANSION', 				6),
		('LEADER_DMS_KALEB', 			'FLAVOR_GROWTH', 					7),
		('LEADER_DMS_KALEB', 			'FLAVOR_TILE_IMPROVEMENT', 			5),
		('LEADER_DMS_KALEB', 			'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_DMS_KALEB', 			'FLAVOR_PRODUCTION', 				6),
		('LEADER_DMS_KALEB', 			'FLAVOR_GOLD', 						9),
		('LEADER_DMS_KALEB', 			'FLAVOR_SCIENCE', 					6),
		('LEADER_DMS_KALEB', 			'FLAVOR_CULTURE', 					6),
		('LEADER_DMS_KALEB', 			'FLAVOR_HAPPINESS', 				5),
		('LEADER_DMS_KALEB', 			'FLAVOR_GREAT_PEOPLE', 				5),
		('LEADER_DMS_KALEB', 			'FLAVOR_WONDER', 					6),
		('LEADER_DMS_KALEB', 			'FLAVOR_RELIGION', 					10),
		('LEADER_DMS_KALEB', 			'FLAVOR_DIPLOMACY', 				8),
		('LEADER_DMS_KALEB', 			'FLAVOR_SPACESHIP', 				6),
		('LEADER_DMS_KALEB', 			'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_DMS_KALEB', 			'FLAVOR_NUKE', 						5),
		('LEADER_DMS_KALEB', 			'FLAVOR_USE_NUKE', 					5),
		('LEADER_DMS_KALEB', 			'FLAVOR_ESPIONAGE', 				9),
		('LEADER_DMS_KALEB', 			'FLAVOR_AIRLIFT', 					5),
		('LEADER_DMS_KALEB', 			'FLAVOR_I_TRADE_DESTINATION', 		8),
		('LEADER_DMS_KALEB', 			'FLAVOR_I_TRADE_ORIGIN', 			8),
		('LEADER_DMS_KALEB', 			'FLAVOR_I_SEA_TRADE_ROUTE', 		8),
		('LEADER_DMS_KALEB', 			'FLAVOR_I_LAND_TRADE_ROUTE', 		8),
		('LEADER_DMS_KALEB', 			'FLAVOR_ARCHAEOLOGY', 				8),
		('LEADER_DMS_KALEB', 			'FLAVOR_AIR_CARRIER', 				4),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_OFFENSE', 					9),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_DEFENSE', 					8),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_MILITARY_TRAINING', 		9),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_RECON', 					6),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_RANGED', 					5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_MOBILE', 					5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_NAVAL', 					3),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_NAVAL_RECON', 				4),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_NAVAL_GROWTH', 				3),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_AIR', 						5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_EXPANSION', 				8),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_GROWTH', 					5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_INFRASTRUCTURE', 			4),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_PRODUCTION', 				7),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_GOLD', 						3),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_SCIENCE', 					6),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_CULTURE', 					5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_HAPPINESS', 				5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_GREAT_PEOPLE', 				3),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_WONDER', 					4),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_RELIGION', 					6),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_DIPLOMACY', 				5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_SPACESHIP', 				6),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_NUKE', 						8),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_USE_NUKE', 					9),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_ESPIONAGE', 				3),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_AIRLIFT', 					4),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_ARCHAEOLOGY', 				8),
		('LEADER_DMS_SEYON_I', 			'FLAVOR_AIR_CARRIER', 				4),
		('LEADER_DMS_YAQOB', 			'FLAVOR_OFFENSE', 					6),
		('LEADER_DMS_YAQOB', 			'FLAVOR_DEFENSE', 					5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_CITY_DEFENSE', 				8),
		('LEADER_DMS_YAQOB', 			'FLAVOR_MILITARY_TRAINING', 		5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_RECON', 					9),
		('LEADER_DMS_YAQOB', 			'FLAVOR_RANGED', 					4),
		('LEADER_DMS_YAQOB', 			'FLAVOR_MOBILE', 					4),
		('LEADER_DMS_YAQOB', 			'FLAVOR_NAVAL', 					5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_NAVAL_RECON', 				8),
		('LEADER_DMS_YAQOB', 			'FLAVOR_NAVAL_GROWTH', 				5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_AIR', 						5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_EXPANSION', 				6),
		('LEADER_DMS_YAQOB', 			'FLAVOR_GROWTH', 					8),
		('LEADER_DMS_YAQOB', 			'FLAVOR_TILE_IMPROVEMENT', 			5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_INFRASTRUCTURE', 			7),
		('LEADER_DMS_YAQOB', 			'FLAVOR_PRODUCTION', 				5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_GOLD', 						5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_SCIENCE', 					6),
		('LEADER_DMS_YAQOB', 			'FLAVOR_CULTURE', 					7),
		('LEADER_DMS_YAQOB', 			'FLAVOR_HAPPINESS', 				6),
		('LEADER_DMS_YAQOB', 			'FLAVOR_GREAT_PEOPLE', 				8),
		('LEADER_DMS_YAQOB', 			'FLAVOR_WONDER', 					5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_RELIGION', 					10),
		('LEADER_DMS_YAQOB', 			'FLAVOR_DIPLOMACY', 				6),
		('LEADER_DMS_YAQOB', 			'FLAVOR_SPACESHIP', 				5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_NUKE', 						4),
		('LEADER_DMS_YAQOB', 			'FLAVOR_USE_NUKE', 					8),
		('LEADER_DMS_YAQOB', 			'FLAVOR_ESPIONAGE', 				9),
		('LEADER_DMS_YAQOB', 			'FLAVOR_AIRLIFT', 					5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_DMS_YAQOB', 			'FLAVOR_ARCHAEOLOGY', 				8),
		('LEADER_DMS_YAQOB', 			'FLAVOR_AIR_CARRIER', 				4),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_OFFENSE', 					6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_DEFENSE', 					9),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_CITY_DEFENSE', 				8),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_MILITARY_TRAINING', 		6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_RECON', 					5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_RANGED', 					7),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_MOBILE', 					6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_NAVAL', 					3),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_NAVAL_RECON', 				3),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_NAVAL_GROWTH', 				5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_AIR', 						6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_EXPANSION', 				5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_GROWTH', 					6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_TILE_IMPROVEMENT', 			6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_INFRASTRUCTURE', 			9),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_PRODUCTION', 				8),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_GOLD', 						5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_SCIENCE', 					8),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_CULTURE', 					6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_HAPPINESS', 				5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_GREAT_PEOPLE', 				4),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_WONDER', 					3),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_RELIGION', 					5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_DIPLOMACY', 				7),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_SPACESHIP', 				6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_NUKE', 						6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_USE_NUKE', 					6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_ESPIONAGE', 				5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_AIRLIFT', 					7),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_ARCHAEOLOGY', 				6),
		('LEADER_DMS_MENELIK_II', 		'FLAVOR_AIR_CARRIER', 				5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_OFFENSE', 					8),
		('LEADER_DMS_GUDIT', 			'FLAVOR_DEFENSE', 					6),
		('LEADER_DMS_GUDIT', 			'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_MILITARY_TRAINING', 		6),
		('LEADER_DMS_GUDIT', 			'FLAVOR_RECON', 					8),
		('LEADER_DMS_GUDIT', 			'FLAVOR_RANGED', 					7),
		('LEADER_DMS_GUDIT', 			'FLAVOR_MOBILE', 					5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_NAVAL', 					4),
		('LEADER_DMS_GUDIT', 			'FLAVOR_NAVAL_RECON', 				6),
		('LEADER_DMS_GUDIT', 			'FLAVOR_NAVAL_GROWTH', 				4),
		('LEADER_DMS_GUDIT', 			'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_AIR', 						6),
		('LEADER_DMS_GUDIT', 			'FLAVOR_EXPANSION', 				8),
		('LEADER_DMS_GUDIT', 			'FLAVOR_GROWTH', 					6),
		('LEADER_DMS_GUDIT', 			'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_DMS_GUDIT', 			'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_PRODUCTION', 				7),
		('LEADER_DMS_GUDIT', 			'FLAVOR_GOLD', 						4),
		('LEADER_DMS_GUDIT', 			'FLAVOR_SCIENCE', 					7),
		('LEADER_DMS_GUDIT', 			'FLAVOR_CULTURE', 					7),
		('LEADER_DMS_GUDIT', 			'FLAVOR_HAPPINESS', 				4),
		('LEADER_DMS_GUDIT', 			'FLAVOR_GREAT_PEOPLE', 				3),
		('LEADER_DMS_GUDIT', 			'FLAVOR_WONDER', 					2),
		('LEADER_DMS_GUDIT', 			'FLAVOR_RELIGION', 					8),
		('LEADER_DMS_GUDIT', 			'FLAVOR_DIPLOMACY', 				4),
		('LEADER_DMS_GUDIT', 			'FLAVOR_SPACESHIP', 				4),
		('LEADER_DMS_GUDIT', 			'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_NUKE', 						7),
		('LEADER_DMS_GUDIT', 			'FLAVOR_USE_NUKE', 					7),
		('LEADER_DMS_GUDIT', 			'FLAVOR_ESPIONAGE', 				8),
		('LEADER_DMS_GUDIT', 			'FLAVOR_AIRLIFT', 					5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_DMS_GUDIT', 			'FLAVOR_AIR_CARRIER', 				5);
--------------------------------
-- Leader_Traits
--------------------------------
DELETE FROM Leader_Traits WHERE LeaderType = 'LEADER_SELASSIE';

INSERT INTO Leader_Traits 
		(LeaderType, 					TraitType)
VALUES	('LEADER_DMS_KALEB', 			'TRAIT_DMS_SAINT_ELESBAAN'),
		('LEADER_DMS_SEYON_I', 			'TRAIT_DMS_PILLAR_OF_ZION'),
		('LEADER_DMS_YAQOB', 			'TRAIT_DMS_SEED_OF_JACOB'),
		('LEADER_DMS_MENELIK_II', 		'TRAIT_BONUS_AGAINST_TECH'), -- vanilla ethiopia trait
		('LEADER_SELASSIE', 			'TRAIT_DMS_THE_LION_OF_JUDAH'), -- vanilla ethiopia trait
		('LEADER_DMS_GUDIT', 			'TRAIT_DMS_FIELDS_OF_JUDITH'); -- vanilla ethiopia leader
--==========================================================================================================================
-- TRAITS
--==========================================================================================================================
-- Traits
--------------------------------
INSERT INTO Traits 
		(Type, 									Description, 									ShortDescription)
VALUES	('TRAIT_DMS_SAINT_ELESBAAN',			'TXT_KEY_TRAIT_DMS_SAINT_ELESBAAN', 			'TXT_KEY_TRAIT_DMS_SAINT_ELESBAAN_SHORT'),
		('TRAIT_DMS_PILLAR_OF_ZION',			'TXT_KEY_TRAIT_DMS_PILLAR_OF_ZION', 			'TXT_KEY_TRAIT_DMS_PILLAR_OF_ZION_SHORT'),
		('TRAIT_DMS_SEED_OF_JACOB',				'TXT_KEY_TRAIT_DMS_SEED_OF_JACOB', 				'TXT_KEY_TRAIT_DMS_SEED_OF_JACOB_SHORT'),
		('TRAIT_DMS_THE_LION_OF_JUDAH',			'TXT_KEY_TRAIT_DMS_THE_LION_OF_JUDAH',			'TXT_KEY_TRAIT_DMS_THE_LION_OF_JUDAH_SHORT'),
		('TRAIT_DMS_FIELDS_OF_JUDITH',			'TXT_KEY_TRAIT_DMS_FIELDS_OF_JUDITH',			'TXT_KEY_TRAIT_DMS_FIELDS_OF_JUDITH_SHORT');	
--==========================================================================================================================
-- CIVILIZATIONS
--==========================================================================================================================
-- Civilizations
-------------------------------- 
INSERT INTO Civilizations 	
		(Type, 										DerivativeCiv,						Description, 											ShortDescription, 											Adjective, 													Civilopedia, 										CivilopediaTag, 							DefaultPlayerColor, 					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 										DawnOfManQuote, 							DawnOfManImage)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'), 			('CIVILIZATION_ETHIOPIA'),			('TXT_KEY_CIVILIZATION_DMS_AKSUM_KALEB_DESC'), 			('TXT_KEY_CIVILIZATION_DMS_AKSUM_KALEB_SHORT_DESC'), 		('TXT_KEY_CIVILIZATION_DMS_AKSUM_KALEB_ADJECTIVE'), 		('TXT_KEY_CIV5_DMS_AKSUM_KALEB_TEXT_1'), 			('TXT_KEY_CIV5_DMS_AKSUM_KALEB'), 			('PLAYERCOLOR_DMS_AKSUM_KALEB'), 		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('DMS_ETHIOPIA_ATLAS'), 	0,				('DMS_ETHIOPIA_ALPHA_ATLAS'), 	SoundtrackTag, 	('DMS_AksumMap_512.dds'), 						('TXT_KEY_DOM_DMS_KALEB_AKSUM'), 			('DMS_DOM_Kaleb.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilizations 	
		(Type, 										DerivativeCiv,						Description, 											ShortDescription, 											Adjective, 													Civilopedia, 										CivilopediaTag, 							DefaultPlayerColor, 					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 										DawnOfManQuote, 							DawnOfManImage)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'), 		('CIVILIZATION_ETHIOPIA'),			('TXT_KEY_CIVILIZATION_ETHIOPIA_SEYON_I_DESC'), 		('TXT_KEY_CIVILIZATION_ETHIOPIA_SEYON_I_SHORT_DESC'),		('TXT_KEY_CIVILIZATION_ETHIOPIA_SEYON_I_ADJECTIVE'),		Civilopedia, 										CivilopediaTag, 							('PLAYERCOLOR_DMS_ETHIOPIA_SEYON_I'), 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('DMS_ETHIOPIA_ATLAS'), 	1,				('DMS_ETHIOPIA_ALPHA_ATLAS'), 	SoundtrackTag, 	('DMS_EthiopiaAmdaSeyonIMap_512.dds'),			('TXT_KEY_DOM_DMS_AMDA_SEYON_ETHIOPIA'), 	('DMS_DOM_AmdaSeyon.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilizations 	
		(Type, 										DerivativeCiv,						Description, 											ShortDescription, 											Adjective, 													Civilopedia, 										CivilopediaTag, 							DefaultPlayerColor, 					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 										DawnOfManQuote, 							DawnOfManImage)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'), 		('CIVILIZATION_ETHIOPIA'),			('TXT_KEY_CIVILIZATION_ETHIOPIA_YAQOB_DESC'), 			('TXT_KEY_CIVILIZATION_ETHIOPIA_YAQOB_SHORT_DESC'),			('TXT_KEY_CIVILIZATION_ETHIOPIA_YAQOB_ADJECTIVE'),			Civilopedia, 										CivilopediaTag, 							('PLAYERCOLOR_DMS_ETHIOPIA_YAQOB'), 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('DMS_ETHIOPIA_ATLAS'), 	2,				('DMS_ETHIOPIA_ALPHA_ATLAS'), 	SoundtrackTag, 	('DMS_EthiopiaZaraYaqobMap_512.dds'),			('TXT_KEY_DOM_DMS_ZARA_YAQOB_ETHIOPIA'), 	('DMS_DOM_ZaraYaqob.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilizations 	
		(Type, 										DerivativeCiv,						Description, 											ShortDescription, 											Adjective, 													Civilopedia, 										CivilopediaTag, 							DefaultPlayerColor, 					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 										DawnOfManQuote, 							DawnOfManImage)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'), 	('CIVILIZATION_ETHIOPIA'),			('TXT_KEY_CIVILIZATION_ETHIOPIA_MENELIK_II_DESC'), 		('TXT_KEY_CIVILIZATION_ETHIOPIA_MENELIK_II_SHORT_DESC'),	('TXT_KEY_CIVILIZATION_ETHIOPIA_MENELIK_II_ADJECTIVE'),		Civilopedia, 										CivilopediaTag, 							('PLAYERCOLOR_DMS_ETHIOPIA_MENELIK_II'),ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('DMS_ETHIOPIA_ATLAS'), 	3,				('DMS_ETHIOPIA_ALPHA_ATLAS'), 	SoundtrackTag, 	('DMS_EthiopiaMenelikIIMap_512.dds'), 			('TXT_KEY_DOM_DMS_MENELIK_ETHIOPIA'), 		('DMS_DOM_Menelik.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilizations 	
		(Type, 										DerivativeCiv,						Description, 											ShortDescription, 											Adjective, 													Civilopedia, 										CivilopediaTag, 							DefaultPlayerColor, 					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas, 				SoundtrackTag, 	MapImage, 										DawnOfManQuote, 							DawnOfManImage)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'), 			('CIVILIZATION_ETHIOPIA'),			('TXT_KEY_CIVILIZATION_DMS_SEMIEN_GUDIT_DESC'), 		('TXT_KEY_CIVILIZATION_DMS_SEMIEN_GUDIT_SHORT_DESC'),		('TXT_KEY_CIVILIZATION_DMS_SEMIEN_GUDIT_ADJECTIVE'),		('TXT_KEY_CIV5_DMS_SEMIEN_GUDIT_TEXT_1'), 			('TXT_KEY_CIV5_SEMIEN_GUDIT'), 				('PLAYERCOLOR_DMS_SEMIEN_GUDIT'),		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('DMS_SEMIEN_ATLAS'), 		0,				('DMS_SEMIEN_ALPHA_ATLAS'), 	SoundtrackTag, 	('DMS_SemienMap_512.dds'), 						('TXT_KEY_DOM_DMS_GUDIT'), 	 				('DMS_DOM_Gudit.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ETHIOPIA');
--------------------------------
-- Civilization_CityNames
--------------------------------
DELETE FROM Civilization_CityNames WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_CityNames 
		(CivilizationType, 							CityName)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_0'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_1'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_2'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_3'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_4'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_5'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_6'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_7'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_8'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_9'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_10'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_11'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_12'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_13'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_14'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_15'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_16'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_17'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_18'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_19'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_20'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_21'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_22'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_23'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_24'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_25'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_26'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_27'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_28'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_29'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_30'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_31'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_32'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_33'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_34'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_35'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_36'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_37'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_38'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_CITY_NAME_DMS_AKSUM_KALEB_39'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_0'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_1'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_2'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_3'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_4'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_5'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_6'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_7'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_8'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_9'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_10'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_11'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_12'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_13'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_14'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_15'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_16'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_17'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_18'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_19'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_20'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_21'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_22'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_23'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_24'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_25'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_26'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_27'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_28'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_29'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_30'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_31'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_32'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_33'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_34'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_35'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_36'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_37'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_38'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_SEYON_I_39'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_0'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_1'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_2'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_3'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_4'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_5'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_6'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_7'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_8'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_9'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_10'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_11'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_12'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_13'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_14'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_15'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_16'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_17'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_18'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_19'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_20'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_21'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_22'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_23'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_24'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_25'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_26'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_27'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_28'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_29'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_30'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_31'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_32'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_33'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_34'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_35'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_36'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_37'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_38'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_YAQOB_39'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_0'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_1'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_2'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_3'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_4'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_5'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_6'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_7'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_8'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_9'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_10'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_11'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_12'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_13'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_14'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_15'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_16'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_17'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_18'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_19'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_20'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_21'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_22'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_23'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_24'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_25'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_26'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_27'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_28'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_29'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_30'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_31'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_32'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_33'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_34'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_35'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_36'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_37'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_38'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_MENELIK_II_39'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_0'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_1'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_2'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_3'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_4'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_5'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_6'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_7'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_8'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_9'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_10'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_11'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_12'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_13'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_14'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_15'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_16'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_17'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_18'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_19'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_20'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_21'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_22'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_23'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_24'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_25'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_26'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_27'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_28'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_29'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_30'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_31'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_32'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_33'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_34'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_35'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_36'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_37'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_38'),
		('CIVILIZATION_ETHIOPIA',					'TXT_KEY_CITY_NAME_DMS_ETHIOPIA_39'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_0'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_1'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_2'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_3'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_4'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_5'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_6'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_7'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_8'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_9'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_10'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_11'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_12'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_13'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_14'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_15'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_16'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_17'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_18'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_19'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_20'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_21'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_22'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_23'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_24'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_25'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_26'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_27'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_28'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_29'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_30'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_31'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_32'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_33'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_34'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_35'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_36'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_37'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_38'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_CITY_NAME_DMS_SEMIEN_GUDIT_39');	
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------	
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 							BuildingClassType)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'), 			BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');		

INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 							BuildingClassType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'), 		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');		

INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 							BuildingClassType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'), 		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');		

INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 							BuildingClassType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');		

INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 							BuildingClassType)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'), 			BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');	
--------------------------------	
-- Civilization_FreeTechs
--------------------------------
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 							TechType)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'), 			TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 							TechType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 							TechType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'), 		TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 							TechType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 							TechType)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'), 			TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'),			UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');		

INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');	

INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'),		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');		

INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'),	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');	

INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_DMS_SEMIEN_GUDIT'),			UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');	
--------------------------------	
-- Civilization_Leaders
--------------------------------
INSERT INTO Civilization_Leaders 
		(CivilizationType, 							LeaderheadType)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',			'LEADER_DMS_KALEB'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'LEADER_DMS_SEYON_I'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'LEADER_DMS_YAQOB'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II',	'LEADER_DMS_MENELIK_II'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',			'LEADER_DMS_GUDIT');
--------------------------------
-- Delete ClassOverrides
--------------------------------
DELETE FROM Civilization_UnitClassOverrides WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
DELETE FROM Civilization_BuildingClassOverrides WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 							UnitClassType,					UnitType)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB',			'UNITCLASS_SPEARMAN',			'UNIT_DMS_SARAWIT'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'UNITCLASS_KNIGHT',				'UNIT_DMS_KOREM'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I',		'UNITCLASS_SWORDSMAN',			'UNIT_DMS_SHOTELAI'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB',			'UNITCLASS_PROPHET',			'UNIT_DMS_DEBTERA'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II',	'UNITCLASS_RIFLEMAN',			'UNIT_ETHIOPIAN_MEHAL_SEFARI'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II',	'UNITCLASS_ARTILLERY',			'UNIT_DMS_SEBASTOPOL'),
		('CIVILIZATION_ETHIOPIA',					'UNITCLASS_INFANTRY',			'UNIT_DMS_KAGNEW'),
		('CIVILIZATION_ETHIOPIA',					'UNITCLASS_TRIPLANE',			'UNIT_DMS_MAKONNEN'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT',			'UNITCLASS_COMPOSITE_BOWMAN',	'UNIT_DMS_AGAW_BOUDA');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 							BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB', 			'BUILDINGCLASS_MONUMENT',	'BUILDING_STELE');

INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 							BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'BUILDINGCLASS_TEMPLE',		'BUILDING_DMS_MASGID');
--------------------------------	
-- Civilization_Religions
--------------------------------
INSERT INTO Civilization_Religions 
		(CivilizationType, 							ReligionType)
SELECT	('CIVILIZATION_DMS_AKSUM_KALEB'), 			ReligionType			
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_Religions 
		(CivilizationType, 							ReligionType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_SEYON_I'),		ReligionType			
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_Religions 
		(CivilizationType, 							ReligionType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_YAQOB'), 		ReligionType			
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_Religions 
		(CivilizationType, 							ReligionType)
SELECT	('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II'), 	ReligionType			
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ETHIOPIA');

INSERT INTO Civilization_Religions 
		(CivilizationType, 							ReligionType)
VALUES	('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'RELIGION_JUDAISM');
--------------------------------	
-- Civilization_SpyNames
--------------------------------
DELETE FROM Civilization_SpyNames WHERE CivilizationType = 'CIVILIZATION_ETHIOPIA';

INSERT INTO Civilization_SpyNames 
		(CivilizationType, 							SpyName)
VALUES	('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_0'),	
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_1'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_2'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_3'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_4'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_5'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_6'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_7'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_8'),
		('CIVILIZATION_DMS_AKSUM_KALEB', 			'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_9'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_0'),	
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_1'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_2'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_3'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_4'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_5'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_6'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_7'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_8'),
		('CIVILIZATION_DMS_ETHIOPIA_SEYON_I', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_9'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_0'),	
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_1'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_2'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_3'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_4'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_5'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_6'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_7'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_8'),
		('CIVILIZATION_DMS_ETHIOPIA_YAQOB', 		'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_9'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_0'),	
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_1'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_2'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_3'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_4'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_5'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_6'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_7'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_8'),
		('CIVILIZATION_DMS_ETHIOPIA_MENELIK_II', 	'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_9'),
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_0'),	
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_1'),
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_2'),
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_3'),
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_4'),
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_5'),
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_6'),
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_7'),
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_8'),
		('CIVILIZATION_ETHIOPIA', 					'TXT_KEY_SPY_NAME_DMS_ETHIOPIA_9'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_0'),	
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_1'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_2'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_3'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_4'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_5'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_6'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_7'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_8'),
		('CIVILIZATION_DMS_SEMIEN_GUDIT', 			'TXT_KEY_SPY_NAME_DMS_SEMIEN_GUDIT_9');
--==========================================================================================================================
--==========================================================================================================================