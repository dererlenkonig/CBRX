--==========================================================================================================================
-- Builds
--==========================================================================================================================
INSERT INTO Builds
		(Type,							PrereqTech,	ImprovementType, 						Time, Recommendation,			Description,																Help,													CtrlDown,	OrderPriority,	IconIndex,	IconAtlas,					HotKey, EntityEvent, Kill)
SELECT	'BUILD_JMANGELO_MARKAZ_QIADA',	PrereqTech,	'IMPROVEMENT_JMANGELO_MARKAZ_QIADA',	Time, 'TXT_KEY_BUILD_FORT_REC',	'Construct a [LINK=IMPROVEMENT_JMANGELO_MARKAZ_QIADA]Markaz Qiada[\LINK]',	'TXT_KEY_CIV5_IMPROVEMENTS_JMANGELO_MARKAZ_QIADA_TEXT',	CtrlDown,	OrderPriority,	1,			'JMANGELO_MARKAS_ATLAS',	HotKey,	EntityEvent, Kill
FROM Builds WHERE Type = 'BUILD_CITADEL';
--==========================================================================================================================
-- BuildFeatures
--==========================================================================================================================
INSERT INTO BuildFeatures
		(BuildType, 					FeatureType,		PrereqTech,				Production, Remove)
VALUES	('BUILD_JMANGELO_MARKAZ_QIADA',	'FEATURE_JUNGLE',	'TECH_BRONZE_WORKING',	0,			1),
		('BUILD_JMANGELO_MARKAZ_QIADA',	'FEATURE_FOREST',	'TECH_MINING',			20,			1),
		('BUILD_JMANGELO_MARKAZ_QIADA',	'FEATURE_MARSH',	'TECH_MASONRY',			0,			1);

--==========================================================================================================================
-- Improvements
--==========================================================================================================================
-- Improvements
--------------------------------
INSERT INTO Improvements
		(Type,										SpecificCivRequired,	CivilizationType,						GoldMaintenance,	NoTwoAdjacent,	HillsMakesValid,	Description,									Civilopedia,											ArtDefineTag,					BuildableOnResources,	DestroyedWhenPillaged,	Permanent,	PillageGold,	DefenseModifier,	NearbyEnemyDamage, CultureBombRadius, CreatedByGreatPerson, InAdjacentFriendly, 	PortraitIndex,	IconAtlas)
SELECT	'IMPROVEMENT_JMANGELO_MARKAZ_QIADA',		1,						'CIVILIZATION_JMANGELO_SENUSI_LIBYA',	GoldMaintenance,	NoTwoAdjacent,	HillsMakesValid,	'TXT_KEY_IMPROVEMENT_JMANGELO_MARKAZ_QIADA',	'TXT_KEY_CIV5_IMPROVEMENTS_JMANGELO_MARKAZ_QIADA_TEXT',	'ART_DEF_IMPROVEMENT_CITADEL', 	BuildableOnResources,	DestroyedWhenPillaged,	Permanent,	PillageGold,	DefenseModifier,	NearbyEnemyDamage, CultureBombRadius, CreatedByGreatPerson, InAdjacentFriendly, 	0,				'JMANGELO_MARKAS_ATLAS'
FROM Improvements WHERE Type = 'IMPROVEMENT_CITADEL';
--------------------------------
-- Improvement_Yields
--------------------------------
INSERT INTO Improvement_Yields
		(ImprovementType,						YieldType,			Yield)
VALUES	('IMPROVEMENT_JMANGELO_MARKAZ_QIADA', 	'YIELD_FOOD',		1);
--------------------------------
-- Improvement_TechYieldChanges
--------------------------------
INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType,	YieldType,	Yield)
SELECT	'IMPROVEMENT_JMANGELO_MARKAZ_QIADA', 	TechType,	YieldType,	Yield
FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_CITADEL';
--------------------------------
-- Improvement_ValidTerrains
--------------------------------
INSERT INTO Improvement_ValidTerrains
		(ImprovementType,							TerrainType)
VALUES	('IMPROVEMENT_JMANGELO_MARKAZ_QIADA',		'TERRAIN_DESERT');
--------------------------------
-- Improvement_Flavors
--------------------------------
INSERT INTO Improvement_Flavors
		(ImprovementType,						FlavorType,		Flavor)
SELECT	'IMPROVEMENT_JMANGELO_MARKAZ_QIADA', 	FlavorType,		Flavor
FROM Improvement_Flavors WHERE ImprovementType = 'IMPROVEMENT_CITADEL';
--------------------------------
-- Improvement_Flavors
--------------------------------
INSERT INTO Improvement_ResourceTypes
		   (ImprovementType, 	ResourceType, ResourceMakesValid, ResourceTrade,  DiscoveryRand, QuantityRequirement)
SELECT 		ImprovementType, 	ResourceType, ResourceMakesValid, ResourceTrade,  DiscoveryRand, QuantityRequirement
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_CITADEL';

--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
INSERT INTO Units 	
		(Type, 				 		ExtraMaintenanceCost,	Class, PurchaseOnly,	Cost,	Moves,	PrereqTech,	FaithCost,	CivilianAttackPriority, Special, MoveAfterPurchase, Domain, DefaultUnitAI, Description, 						Civilopedia, 								Help, 							Strategy,									AdvancedStartCost,	WorkRate, CombatLimit, DontShowYields, UnitArtInfoEraVariation,	UnitArtInfo, 						UnitFlagIconOffset,	UnitFlagAtlas,						MoveRate, PortraitIndex, 	IconAtlas)
SELECT	'UNIT_JMANGELO_AL_QAYID',	ExtraMaintenanceCost,	Class, PurchaseOnly,	Cost,	Moves,	PrereqTech,	FaithCost,	CivilianAttackPriority, Special, MoveAfterPurchase,	Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JMANGELO_AL_QAYID', 	'TXT_KEY_CIV5_JMANGELO_AL_QAYID_PEDIA', 	'TXT_KEY_UNIT_HELP_AL_QAYID', 	'TXT_KEY_UNIT_JMANGELO_AL_QAYID_STRATEGY',	AdvancedStartCost, 	WorkRate, CombatLimit, DontShowYields, 0,						'ART_DEF_UNIT_JMANGELO_AL_QAYID',	0,					'JMANGELO_LIBYA_FLAG_ART_ATLAS',	MoveRate, 5, 				'JMANGELO_LIBYA_ATLAS'
FROM Units WHERE Type = 'UNIT_GREAT_GENERAL';	
--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JMANGELO_AL_QAYID', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_GREAT_GENERAL';	
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_JMANGELO_AL_QAYID', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_GREAT_GENERAL';
--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_JMANGELO_AL_QAYID', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_GREAT_GENERAL';
--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	'UNIT_JMANGELO_AL_QAYID',	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_GREAT_GENERAL';
--------------------------------
-- Unit_Builds
--------------------------------
INSERT INTO Unit_Builds 	
		(UnitType, 					BuildType)
VALUES	('UNIT_JMANGELO_AL_QAYID',	'BUILD_JMANGELO_MARKAZ_QIADA');
