--==========================================================================================================================	
-- BUILDINGCLASSES
--==========================================================================================================================	
-- BuildingClasses
------------------------------
INSERT INTO BuildingClasses 
		(DefaultBuilding, 						Type, 										Description)
VALUES	('BUILDING_DMS_ROVA_EXPEND_COUNTER',	'BUILDINGCLASS_DMS_ROVA_EXPEND_COUNTER', 	'TXT_KEY_BUILDING_DMS_ROVA_EXPEND_COUNTER');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------
INSERT INTO Buildings
		(Type, 						 			BuildingClass, 								GreatWorkCount,	Cost,	FaithCost,	PrereqTech,	MinAreaSize,	Description, 								Help)
VALUES	('BUILDING_DMS_ROVA_EXPEND_COUNTER',	'BUILDINGCLASS_DMS_ROVA_EXPEND_COUNTER',	-1,				-1,		-1,			null,		-1,				'TXT_KEY_BUILDING_DMS_ROVA_EXPEND_COUNTER',	'TXT_KEY_BUILDING_DMS_ROVA_EXPEND_COUNTER_HELP');
--==========================================================================================================================
-- Builds
--==========================================================================================================================
INSERT INTO Builds
		(Type,					PrereqTech,			ImprovementType, 			Time, Recommendation,					Description,					Help,								CtrlDown,	OrderPriority,	IconIndex,	IconAtlas,						HotKey, EntityEvent)
VALUES	('BUILD_DMS_CL_ROVA',	'TECH_PHYSICS',		'IMPROVEMENT_DMS_CL_ROVA',	1000, 'TXT_KEY_BUILD_DMS_CL_ROVA_REC',	'TXT_KEY_BUILD_DMS_CL_ROVA',	'TXT_KEY_BUILD_DMS_CL_ROVA_HELP',	1,			96,				1,			'DMS_CL_IMERINA_ROVA_ATLAS',	'KB_T',	'ENTITY_EVENT_BUILD');
--==========================================================================================================================
-- BuildFeatures
--==========================================================================================================================
INSERT INTO BuildFeatures
		(BuildType, 			FeatureType, PrereqTech, Time, Remove)
SELECT	('BUILD_DMS_CL_ROVA'),	FeatureType, PrereqTech, Time, 0
FROM BuildFeatures WHERE BuildType = 'BUILD_FORT';
--==========================================================================================================================
-- Improvements
--==========================================================================================================================
-- Improvements
--------------------------------
INSERT INTO Improvements
		(Type,							SpecificCivRequired,	CivilizationType,				GoldMaintenance,	NoTwoAdjacent,	HillsMakesValid,	Description,						Civilopedia,									ArtDefineTag,						BuildableOnResources,	DestroyedWhenPillaged,	Permanent,	PillageGold,	DefenseModifier,	PortraitIndex,	IconAtlas)
VALUES	('IMPROVEMENT_DMS_CL_ROVA',		1,						'CIVILIZATION_DMS_CL_IMERINA',	0,					1,				1,					'TXT_KEY_IMPROVEMENT_DMS_CL_ROVA',	'TXT_KEY_CIV5_IMPROVEMENT_DMS_CL_ROVA_TEXT',	'ART_DEF_IMPROVEMENT_DMS_CL_ROVA', 	1,						0,						0,			50,				0,					0,				'DMS_CL_IMERINA_ROVA_ATLAS');
--------------------------------
-- Improvement_Yields
--------------------------------
INSERT INTO Improvement_Yields
		(ImprovementType,				YieldType,			Yield)
VALUES	('IMPROVEMENT_DMS_CL_ROVA', 	'YIELD_PRODUCTION',	1),
		('IMPROVEMENT_DMS_CL_ROVA', 	'YIELD_CULTURE',	2);
--------------------------------
-- Improvement_TechYieldChanges
--------------------------------
INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,				TechType,					YieldType,			Yield)
VALUES	('IMPROVEMENT_DMS_CL_ROVA', 	'TECH_INDUSTRIALIZATION',	'YIELD_PRODUCTION',	1);
--------------------------------
-- Improvement_ValidTerrains
--------------------------------
--INSERT INTO Improvement_ValidTerrains
--		(ImprovementType,				TerrainType)
--SELECT	('IMPROVEMENT_DMS_CL_ROVA'),	TerrainType
--FROM Improvement_ValidTerrains WHERE ImprovementType = 'IMPROVEMENT_FORT';
--------------------------------
-- Improvement_Flavors
--------------------------------
INSERT INTO Improvement_Flavors
		(ImprovementType,				FlavorType,				Flavor)
VALUES	('IMPROVEMENT_DMS_CL_ROVA', 	'FLAVOR_RELIGION',		10),
		('IMPROVEMENT_DMS_CL_ROVA', 	'FLAVOR_CULTURE',		25),
		('IMPROVEMENT_DMS_CL_ROVA', 	'FLAVOR_PRODUCTION',	25);
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 						Class, 	PrereqTech,	Combat,		Cost,		FaithCost,		RequiresFaithPurchaseEnabled,	Moves,	CombatClass, Domain, DefaultUnitAI,		Description, 					Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, Pillage, XPValueDefense, UnitArtInfoEraVariation, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT	('UNIT_DMS_CL_TAFIKA'),		Class,	PrereqTech, Combat-2,	Cost-10,	FaithCost-20,	RequiresFaithPurchaseEnabled,	Moves,	CombatClass, Domain, ('UNITAI_ATTACK'), ('TXT_KEY_UNIT_DMS_CL_TAFIKA'),	('TXT_KEY_CIV5_DMS_CL_TAFIKA_TEXT'),	('TXT_KEY_UNIT_DMS_CL_TAFIKA_STRATEGY'),	('TXT_KEY_UNIT_DMS_CL_TAFIKA_HELP'),	MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, Pillage, XPValueDefense, UnitArtInfoEraVariation, ('ART_DEF_UNIT_DMS_CL_TAFIKA'), 	0,					('DMS_CL_TAFIKA_FLAG_ART_ATLAS'),	2,				('DMS_CL_IMERINA_ATLAS')
FROM Units WHERE (Type = 'UNIT_PIKEMAN');
--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_CL_TAFIKA'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_PIKEMAN');	
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	('UNIT_DMS_CL_TAFIKA'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_PIKEMAN');
--------------------------------
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType,			Flavor)
SELECT	('UNIT_DMS_CL_TAFIKA'), 	FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_PIKEMAN');

INSERT INTO Unit_Flavors
		(UnitType, 					FlavorType,				Flavor)
VALUES	('UNIT_DMS_CL_TAFIKA',		'FLAVOR_OFFENSE',		20),
		('UNIT_DMS_CL_TAFIKA',		'FLAVOR_CULTURE',		10),
		('UNIT_DMS_CL_TAFIKA',		'FLAVOR_PRODUCTION',	10);
--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	('UNIT_DMS_CL_TAFIKA'),		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_PIKEMAN');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
VALUES	('UNIT_DMS_CL_TAFIKA', 		'PROMOTION_DMS_TAFIKA');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
VALUES	('UNIT_DMS_CL_TAFIKA',	'UNITCLASS_MUSKETMAN');
--------------------------------
-- Unit_Builds
--------------------------------
INSERT INTO Unit_Builds 	
		(UnitType, 			BuildType)
VALUES	('UNIT_WORKER', 	'BUILD_DMS_CL_ROVA');
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- Promotions
--------------------------------
INSERT INTO UnitPromotions 	
		(Type, 									Description,									Help,													Sound,				HasPostCombatPromotions,	PortraitIndex,	IconAtlas,				PediaType,			PediaEntry,											CannotBeChosen)
VALUES	('PROMOTION_DMS_TAFIKA',				'TXT_KEY_PROMOTION_DMS_TAFIKA',					'TXT_KEY_PROMOTION_DMS_TAFIKA_HELP',					'AS2D_IF_LEVELUP',	1,							59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_TAFIKA_HELP',				1),
		('PROMOTION_DMS_IMERINA_AFTERRANDOM',	'TXT_KEY_PROMOTION_DMS_IMERINA_AFTERRANDOM',	'TXT_KEY_PROMOTION_DMS_IMERINA_AFTERRANDOM_HELP',		'AS2D_IF_LEVELUP',	0,							59,				'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_DMS_IMERINA_AFTERRANDOM_HELP',	1);
-------------------------------- 
-- UnitPromotions_PostCombatRandomPromotion
--------------------------------
INSERT INTO UnitPromotions_PostCombatRandomPromotion 	
		(PromotionType, 						NewPromotion)
VALUES	('PROMOTION_DMS_TAFIKA',				'PROMOTION_DMS_IMERINA_AFTERRANDOM');
-------------------------------- 
-- UnitPromotions_UnitCombats
--------------------------------
INSERT INTO UnitPromotions_UnitCombats 	
		(PromotionType, 						UnitCombatType)
VALUES	('PROMOTION_DMS_TAFIKA',				'UNITCOMBAT_MELEE'),
		('PROMOTION_DMS_IMERINA_AFTERRANDOM',	'UNITCOMBAT_MELEE');
--==========================================================================================================================	
-- MINOR CIVILIZATIONS
--==========================================================================================================================		
-- MinorCivilizations
--------------------------------	
UPDATE MinorCivilizations
SET Description = 'TXT_KEY_CITYSTATE_DMS_CL_GEDI_DESC', ShortDescription = 'TXT_KEY_CITYSTATE_DMS_GEDI_SHORT_DESC', Adjective = 'TXT_KEY_CITYSTATE_DMS_GEDI_ADJECTIVE', Civilopedia = 'TXT_KEY_CIV5_DMS_GEDI_TEXT_1'
WHERE Type = 'MINOR_CIV_ANTANANARIVO';
--------------------------------	
-- MinorCivilization_CityNames
--------------------------------		
UPDATE MinorCivilization_CityNames
SET CityName = 'TXT_KEY_CITYSTATE_DMS_GEDI_CITY_NAME_01'
WHERE MinorCivType = 'MINOR_CIV_ANTANANARIVO';
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 								Description, 							Civilopedia, 								CivilopediaTag, 									ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES	('LEADER_DMS_CL_RANAVALONA_I', 		'TXT_KEY_LEADER_DMS_CL_RANAVALONA_I', 	'TXT_KEY_LEADER_DMS_CL_RANAVALONA_I_PEDIA', 'TXT_KEY_CIVILOPEDIA_LEADERS_DMS_CL_RANAVALONA_I', 	'Ranavalona_Scene.xml',		6, 						4, 						5, 							8, 			3, 				4, 				7, 						5, 				4, 			4, 			2, 				5, 			9, 			'DMS_CL_IMERINA_ATLAS',		1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 						MajorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_CL_RANAVALONA_I', 		'MAJOR_CIV_APPROACH_WAR', 			6),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MAJOR_CIV_APPROACH_HOSTILE', 		9),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	10),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MAJOR_CIV_APPROACH_GUARDED', 		9),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MAJOR_CIV_APPROACH_AFRAID', 		6),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 						MinorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_CL_RANAVALONA_I', 		'MINOR_CIV_APPROACH_IGNORE', 		5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MINOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MINOR_CIV_APPROACH_CONQUEST', 		6),
		('LEADER_DMS_CL_RANAVALONA_I', 		'MINOR_CIV_APPROACH_BULLY', 		9);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 						FlavorType, 						Flavor)
VALUES	('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_OFFENSE', 					7),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_DEFENSE', 					8),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_CITY_DEFENSE', 				7),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_MILITARY_TRAINING', 		9),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_RECON', 					7),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_RANGED', 					6),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_MOBILE', 					5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_NAVAL', 					6),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_NAVAL_RECON', 				7),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_NAVAL_GROWTH', 				5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_AIR', 						6),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_EXPANSION', 				8),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_GROWTH', 					5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_TILE_IMPROVEMENT', 			7),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_PRODUCTION', 				9),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_GOLD', 						6),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_SCIENCE', 					5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_CULTURE', 					7),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_HAPPINESS', 				4),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_GREAT_PEOPLE', 				5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_WONDER', 					4),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_RELIGION', 					8),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_DIPLOMACY', 				2),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_SPACESHIP', 				4),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_WATER_CONNECTION', 			6),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_NUKE', 						8),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_USE_NUKE', 					9),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_ESPIONAGE', 				7),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_AIRLIFT', 					5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_DMS_CL_RANAVALONA_I', 		'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 						TraitType)
VALUES	('LEADER_DMS_CL_RANAVALONA_I', 		'TRAIT_DMS_CL_TANGUENA_ORDEAL');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 								Description, 								ShortDescription)
VALUES	('TRAIT_DMS_CL_TANGUENA_ORDEAL', 	'TXT_KEY_TRAIT_DMS_CL_TANGUENA_ORDEAL', 	'TXT_KEY_TRAIT_DMS_CL_TANGUENA_ORDEAL_SHORT');	
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 
		(Type, 								Description, 								ShortDescription,								Adjective,											CivilopediaTag,											DefaultPlayerColor,				ArtDefineTag,	ArtStyleType,	ArtStyleSuffix,	ArtStylePrefix,	PortraitIndex,	IconAtlas,					AlphaIconAtlas,					SoundtrackTag, 	MapImage,				DawnOfManQuote,								DawnOfManImage)
SELECT	('CIVILIZATION_DMS_CL_IMERINA'), 	('TXT_KEY_CIVILIZATION_DMS_CL_IMERINA'), 	('TXT_KEY_CIVILIZATION_DMS_CL_IMERINA_SHORT'),	('TXT_KEY_CIVILIZATION_DMS_CL_IMERINA_ADJECTIVE'),	('TXT_KEY_CIVILOPEDIA_CIVILIZATIONS_DMS_CL_IMERINA'),	('PLAYERCOLOR_DMS_CL_IMERINA'),	ArtDefineTag,	ArtStyleType,	ArtStyleSuffix,	ArtStylePrefix,	0,				('DMS_CL_IMERINA_ATLAS'),	('DMS_CL_IMERINA_ALPHA_ATLAS'),	('Songhai'), 	('ImerinaMap512.dds'),	('TXT_KEY_CIV5_DAWN_DMS_CL_IMERINA_TEXT'),	('RanavalonaI_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_ZULU');
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
        (CivilizationType,        CityName)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_1'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_2'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_3'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_4'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_5'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_6'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_7'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_8'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_9'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_10'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_11'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_12'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_13'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_14'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_15'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_16'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_17'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_18'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_19'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_20'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_21'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_22'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_23'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_24'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_25'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_26'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_27'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_28'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_29'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_30'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_31'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_32'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_33'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_34'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_35'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_36'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_37'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_38'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_39'),
        ('CIVILIZATION_DMS_CL_IMERINA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_CL_IMERINA_40');			
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 					BuildingClassType)
SELECT	('CIVILIZATION_DMS_CL_IMERINA'),	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ZULU');
--------------------------------	
-- Civilization_FreeTechs
--------------------------------		
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 					TechType)
SELECT	('CIVILIZATION_DMS_CL_IMERINA'),	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ZULU');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_DMS_CL_IMERINA'),	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ZULU');
--------------------------------	
-- Civilization_Leaders
--------------------------------
INSERT INTO Civilization_Leaders 
		(CivilizationType, 					LeaderheadType)
VALUES	('CIVILIZATION_DMS_CL_IMERINA',		'LEADER_DMS_CL_RANAVALONA_I');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 					UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_DMS_CL_IMERINA', 	'UNITCLASS_PIKEMAN',	'UNIT_DMS_CL_TAFIKA');
--------------------------------	
-- Civilization_Religions
--------------------------------		
INSERT INTO Civilization_Religions 
		(CivilizationType, 					ReligionType)
VALUES	('CIVILIZATION_DMS_CL_IMERINA', 	'RELIGION_CHRISTIANITY');
--------------------------------	
-- Civilization_SpyNames
--------------------------------
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 					SpyName)
VALUES	('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_0'),	
		('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_1'),
		('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_2'),
		('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_3'),
		('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_4'),
		('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_5'),
		('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_6'),
		('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_7'),
		('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_8'),
		('CIVILIZATION_DMS_CL_IMERINA', 	'TXT_KEY_SPY_NAME_DMS_CL_IMERINA_9');
--==========================================================================================================================
-- Civilization_Start_Region_Priority
--==========================================================================================================================	
INSERT INTO Civilization_Start_Region_Priority 
		(CivilizationType, 					RegionType)
VALUES	('CIVILIZATION_DMS_CL_IMERINA', 	'REGION_HILLS');
--==========================================================================================================================
--==========================================================================================================================