--==========================================================================================================================
-- Improvements
--==========================================================================================================================
INSERT INTO Improvements
			(Type,												SpecificCivRequired,	RequiresFeature,	UpgradeTime,	CivilizationType,				GoldMaintenance,	NoTwoAdjacent,	Description,							Civilopedia,										ArtDefineTag,						DestroyedWhenPillaged,	Permanent,	PillageGold,	BuildableOnResources,	PortraitIndex,	IconAtlas)
VALUES		('IMPROVEMENT_SENSHI_SHEVENCHEDEK_TUNDRA',			1,						0,					50,				'CIVILIZATION_SENSHI_EVENKS',	0,					0,				'TXT_KEY_IMPROVEMENT_SENSHI_SHEVENCHEDEK',			'TXT_KEY_IMPROVEMENT_SENSHI_SHEVENCHEDEK_PEDIA',				'ART_DEF_IMPROVEMENT_SHEVENCHEDEK', 	0,						1,			100,			0,						3,				'SENSHI_EVENKS_ATLAS'),
			('IMPROVEMENT_SENSHI_SHEVENCHEDEK_FOREST',			1,						1,					50,				'CIVILIZATION_SENSHI_EVENKS',	0,					0,				'TXT_KEY_IMPROVEMENT_SENSHI_SHEVENCHEDEK',			'TXT_KEY_IMPROVEMENT_SENSHI_SHEVENCHEDEK_PEDIA',				'ART_DEF_IMPROVEMENT_SHEVENCHEDEK', 	0,						1,			100,			0,						3,				'SENSHI_EVENKS_ATLAS');


INSERT INTO Improvements
			(Type,												SpecificCivRequired,	RequiresFeature,	UpgradeTime,	GoldMaintenance,	NoTwoAdjacent,	Description,							Civilopedia,										ArtDefineTag,						DestroyedWhenPillaged,	Permanent,	PillageGold,	BuildableOnResources,	PortraitIndex,	IconAtlas)
VALUES		('IMPROVEMENT_SENSHI_BUGADYL',						0,						0,					50,				0,					0,				'TXT_KEY_TRAIT_SENSHI_EVENKS_IMPROVEMENT',	'TXT_KEY_TRAIT_SENSHI_EVENKS',						'ART_DEF_IMPROVEMENT_BUGADYL',			1,						1,			100,			0,						3,				'SENSHI_EVENKS_ATLAS');
--==========================================================================================================================
-- Improvement_ValidTerrains
--==========================================================================================================================
INSERT INTO Improvement_ValidTerrains
			(ImprovementType,				TerrainType)
VALUES		('IMPROVEMENT_SENSHI_SHEVENCHEDEK_TUNDRA',	'TERRAIN_TUNDRA'),
			('IMPROVEMENT_SENSHI_SHEVENCHEDEK_TUNDRA',	'TERRAIN_SNOW');
--==========================================================================================================================
-- Improvement_ValidFeatures
--==========================================================================================================================
INSERT INTO Improvement_ValidFeatures
			(ImprovementType,				FeatureType)
VALUES		('IMPROVEMENT_SENSHI_SHEVENCHEDEK_FOREST',	'FEATURE_FOREST');
--==========================================================================================================================
-- Improvement_Yields
--==========================================================================================================================
INSERT INTO Improvement_Yields
			(ImprovementType,							YieldType,			Yield)
VALUES		('IMPROVEMENT_SENSHI_SHEVENCHEDEK_FOREST',	'YIELD_FOOD',		2),
			('IMPROVEMENT_SENSHI_SHEVENCHEDEK_FOREST',	'YIELD_FAITH',		1),
			('IMPROVEMENT_SENSHI_SHEVENCHEDEK_TUNDRA',	'YIELD_FOOD',		2),
			('IMPROVEMENT_SENSHI_SHEVENCHEDEK_TUNDRA',	'YIELD_FAITH',		1),
			('IMPROVEMENT_SENSHI_SHEVENCHEDEK_TUNDRA',	'YIELD_PRODUCTION',	1),
			('IMPROVEMENT_SENSHI_BUGADYL',				'YIELD_FAITH',		2);
--==========================================================================================================================
-- Builds
--==========================================================================================================================
INSERT INTO Builds
			(Type,									PrereqTech,					Time,			ImprovementType,								Description,								Help,												Recommendation,								EntityEvent,				HotKey,		OrderPriority,	CtrlDown,	IconIndex,	IconAtlas)
VALUES		('BUILD_SENSHI_SHEVENCHEDEK_FOREST',	'TECH_PHILOSOPHY',			700,            'IMPROVEMENT_SENSHI_SHEVENCHEDEK_FOREST',		'TXT_KEY_BUILD_SENSHI_SHEVENCHEDEK',		'TXT_KEY_BUILD_SENSHI_SHEVENCHEDEK_HELP',			'TXT_KEY_BUILD_SENSHI_SHEVENCHEDEK_REC',	'ENTITY_EVENT_CHOP',		'K',		96,				1,			4,		'SENSHI_EVENKS_ATLAS'),
			('BUILD_SENSHI_SHEVENCHEDEK_TUNDRA',	'TECH_PHILOSOPHY',			700,            'IMPROVEMENT_SENSHI_SHEVENCHEDEK_TUNDRA',		'TXT_KEY_BUILD_SENSHI_SHEVENCHEDEK',		'TXT_KEY_BUILD_SENSHI_SHEVENCHEDEK_HELP',			'TXT_KEY_BUILD_SENSHI_SHEVENCHEDEK_REC',	'ENTITY_EVENT_CHOP',		'K',		96,				1,			4,		'SENSHI_EVENKS_ATLAS');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds
			(UnitType,		BuildType)
VALUES		('UNIT_WORKER',	'BUILD_SENSHI_SHEVENCHEDEK_FOREST'),
			('UNIT_WORKER',	'BUILD_SENSHI_SHEVENCHEDEK_TUNDRA');
--==========================================================================================================================
--==========================================================================================================================