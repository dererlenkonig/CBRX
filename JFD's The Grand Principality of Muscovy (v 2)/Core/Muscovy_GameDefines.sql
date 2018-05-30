--=======================================================================================================================
-- BUILDING CLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------	
INSERT INTO BuildingClasses 	
		(Type, 						 	DefaultBuilding, 			Description)
VALUES	('BUILDINGCLASS_JFD_MUSCOVY', 	'BUILDING_JFD_MUSCOVY', 	'TXT_KEY_BUILDING_JFD_MUSCOVY');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 								BuildingClass,					PrereqTech,				Cost,						GoldMaintenance,		MinAreaSize,	Description, 					Civilopedia, 					Help, 										Strategy,									ArtDefineTag,	PortraitIndex,	IconAtlas)
SELECT	'BUILDING_JFD_SOBOR',				BuildingClass,					PrereqTech,				Cost,						GoldMaintenance,		MinAreaSize,	'TXT_KEY_BUILDING_JFD_SOBOR', 	'TXT_KEY_CIV5_JFD_SOBOR_TEXT',	'TXT_KEY_BUILDING_JFD_SOBOR_HELP',			'TXT_KEY_BUILDING_JFD_SOBOR_STRATEGY',		ArtDefineTag,	3, 				'JFD_MUSCOVY_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';		

INSERT INTO Buildings 	
		(Type, 						 		BuildingClass, 					NoOccupiedUnhappiness,	PlotCultureCostModifier, 	PlotBuyCostModifier, 	GreatWorkCount, Cost, FaithCost, NeverCapture,	ConquestProb,					PrereqTech,									Description, 								Help)
VALUES	('BUILDING_JFD_MUSCOVY', 			'BUILDINGCLASS_JFD_MUSCOVY',	0,						0, 							0, 						-1, 			-1,   -1, 		 0,				100,							null, 										'TXT_KEY_BUILDING_JFD_MUSCOVY', 			'TXT_KEY_BUILDING_JFD_MUSCOVY_HELP'),
		('BUILDING_JFD_SOBOR_COURTHOUSE', 	'BUILDINGCLASS_JFD_MUSCOVY',	1,						0, 							0, 						-1, 			-1,   -1, 		 1,				0,								null, 										'TXT_KEY_BUILDING_JFD_SOBOR_COURTHOUSE', 	'TXT_KEY_BUILDING_JFD_SOBOR_COURTHOUSE_HELP'),
		('BUILDING_JFD_SOBOR_FAITH', 		'BUILDINGCLASS_JFD_MUSCOVY',	0,						-1, 						-1, 					-1, 			-1,   -1, 		 1,				0,								null, 										'TXT_KEY_BUILDING_JFD_SOBOR_FAITH', 		'TXT_KEY_BUILDING_JFD_SOBOR_FAITH_HELP');
--------------------------------	
-- Building_ResourceYieldChanges
--------------------------------	
INSERT INTO Building_ResourceYieldChanges 	
		(BuildingType, 			ResourceType,		YieldType,	Yield)
SELECT	'BUILDING_JFD_SOBOR',	ResourceType,		YieldType,	Yield
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_TEMPLE';	
------------------------------	
-- Building_YieldChanges
------------------------------	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 			YieldType,			Yield)
SELECT	'BUILDING_JFD_SOBOR',	YieldType,			Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_TEMPLE';		
------------------------------	
-- Building_Flavors
------------------------------	
INSERT INTO Building_Flavors 	
		(BuildingType, 			FlavorType,			Flavor)
SELECT	'BUILDING_JFD_SOBOR',	FlavorType,			Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_TEMPLE';

INSERT INTO Building_Flavors
		(BuildingType,			FlavorType,			Flavor)
VALUES	('BUILDING_JFD_SOBOR',	'FLAVOR_GROWTH',	10);
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 								Description, 						Help, 											Sound, 				EnemyRoute,	CanMoveAfterAttacking,	ExtraAttacks,	CannotBeChosen, PortraitIndex, 	IconAtlas, 						PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_STRELTSY', 			'TXT_KEY_PROMOTION_JFD_STRELTSY', 	'TXT_KEY_PROMOTION_JFD_STRELTSY_HELP',			'AS2D_IF_LEVELUP',	1,			0,						0,				1, 				59, 			'ABILITY_ATLAS', 				'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_STRELTSY'),
		('PROMOTION_JFD_STRELTSY_ACTIVE', 	'TXT_KEY_PROMOTION_JFD_STRELTSY',	'TXT_KEY_PROMOTION_JFD_STRELTSY_ACTIVE_HELP', 	'AS2D_IF_LEVELUP', 	1,			1,						1,				1, 				0, 				'JFD_MUSCOVY_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_STRELTSY');
--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
INSERT INTO Units 	
		(Type, 					PrereqTech, Class, Combat,	 Cost,		Moves, FaithCost,	 RequiresFaithPurchaseEnabled, CombatClass, Domain, DefaultUnitAI, 	Description, 					Civilopedia, 						Help, 								Strategy,								ObsoleteTech, 	GoodyHutUpgradeUnitClass, Conscription, XPValueDefense, XPValueAttack, MilitarySupport, MilitaryProduction, AdvancedStartCost, Pillage, IgnoreBuildingDefense, UnitArtInfo,					 UnitFlagIconOffset, UnitFlagAtlas,					 MoveRate,	PortraitIndex, 	IconAtlas)
SELECT	'UNIT_JFD_STRELTSY',	PrereqTech, Class, Combat-4, Cost-20,	Moves, FaithCost-40, RequiresFaithPurchaseEnabled, CombatClass, Domain,	DefaultUnitAI,	'TXT_KEY_UNIT_JFD_STRELTSY', 	'TXT_KEY_CIV5_JFD_STRELTSY_TEXT', 	'TXT_KEY_UNIT_JFD_STRELTSY_HELP', 	'TXT_KEY_UNIT_JFD_STRELTSY_STRATEGY',	ObsoleteTech,	GoodyHutUpgradeUnitClass, Conscription, XPValueDefense, XPValueAttack, MilitarySupport, MilitaryProduction, AdvancedStartCost, Pillage, IgnoreBuildingDefense, 'ART_DEF_UNIT_JFD_STRELTSY',  0,					 'JFD_UNIT_FLAG_STRELTSY_ATLAS', MoveRate,	2, 				'JFD_MUSCOVY_ATLAS'
FROM Units WHERE Type = 'UNIT_MUSKETMAN';	
--------------------------------
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_STRELTSY', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_MUSKETMAN';	
--------------------------------
-- Unit_AITypes
--------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_JFD_STRELTSY', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_MUSKETMAN';
--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 				FlavorType, Flavor)
SELECT	'UNIT_JFD_STRELTSY', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_MUSKETMAN';
--------------------------------
-- Unit_ClassUpgrades
--------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_JFD_STRELTSY', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_MUSKETMAN';
--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions
		(UnitType, 				PromotionType)
VALUES	('UNIT_JFD_STRELTSY', 	'PROMOTION_JFD_STRELTSY');	
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 					Description, 					Civilopedia, 										CivilopediaTag, 							ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_JFD_IVAN', 	'TXT_KEY_LEADER_JFD_IVAN', 		'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_IVAN_TEXT_1',		'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_IVAN',		'Janboruta_IvanIV_Scene.xml',	9, 						4, 						3, 							8, 			4, 				2, 				7, 						4, 				4, 			7, 			7, 				3, 			6, 			'JFD_MUSCOVY_ATLAS',	1);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------					
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_IVAN', 	'MAJOR_CIV_APPROACH_WAR', 			7),
		('LEADER_JFD_IVAN', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
		('LEADER_JFD_IVAN', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
		('LEADER_JFD_IVAN', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
		('LEADER_JFD_IVAN', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
		('LEADER_JFD_IVAN', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
		('LEADER_JFD_IVAN', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		7);
--------------------------------
-- Leader_MajorCivApproachBiases
--------------------------------					
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_IVAN', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
		('LEADER_JFD_IVAN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		3),
		('LEADER_JFD_IVAN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
		('LEADER_JFD_IVAN', 	'MINOR_CIV_APPROACH_CONQUEST', 		7),
		('LEADER_JFD_IVAN', 	'MINOR_CIV_APPROACH_BULLY', 		8);
--------------------------------
-- Leader_Flavors
--------------------------------					
INSERT INTO Leader_Flavors 
		(LeaderType, 			FlavorType, 						Flavor)
VALUES	('LEADER_JFD_IVAN', 	'FLAVOR_OFFENSE', 					8),
		('LEADER_JFD_IVAN', 	'FLAVOR_DEFENSE', 					3),
		('LEADER_JFD_IVAN', 	'FLAVOR_CITY_DEFENSE', 				2),
		('LEADER_JFD_IVAN', 	'FLAVOR_MILITARY_TRAINING', 		6),
		('LEADER_JFD_IVAN', 	'FLAVOR_RECON', 					3),
		('LEADER_JFD_IVAN', 	'FLAVOR_RANGED', 					2),
		('LEADER_JFD_IVAN', 	'FLAVOR_MOBILE', 					4),
		('LEADER_JFD_IVAN', 	'FLAVOR_NAVAL', 					3),
		('LEADER_JFD_IVAN', 	'FLAVOR_NAVAL_RECON', 				2),
		('LEADER_JFD_IVAN', 	'FLAVOR_NAVAL_GROWTH', 				4),
		('LEADER_JFD_IVAN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
		('LEADER_JFD_IVAN', 	'FLAVOR_AIR', 						3),
		('LEADER_JFD_IVAN', 	'FLAVOR_EXPANSION', 				8),
		('LEADER_JFD_IVAN', 	'FLAVOR_GROWTH', 					4),
		('LEADER_JFD_IVAN', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_JFD_IVAN', 	'FLAVOR_INFRASTRUCTURE', 			2),
		('LEADER_JFD_IVAN', 	'FLAVOR_PRODUCTION', 				3),
		('LEADER_JFD_IVAN', 	'FLAVOR_GOLD', 						4),
		('LEADER_JFD_IVAN', 	'FLAVOR_SCIENCE', 					6),
		('LEADER_JFD_IVAN', 	'FLAVOR_CULTURE', 					4),
		('LEADER_JFD_IVAN', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_IVAN', 	'FLAVOR_GREAT_PEOPLE', 				3),
		('LEADER_JFD_IVAN', 	'FLAVOR_WONDER', 					2),
		('LEADER_JFD_IVAN', 	'FLAVOR_RELIGION', 					7),
		('LEADER_JFD_IVAN', 	'FLAVOR_DIPLOMACY', 				3),
		('LEADER_JFD_IVAN', 	'FLAVOR_SPACESHIP', 				2),
		('LEADER_JFD_IVAN', 	'FLAVOR_WATER_CONNECTION', 			2),
		('LEADER_JFD_IVAN', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_IVAN', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_IVAN', 	'FLAVOR_ESPIONAGE', 				4),
		('LEADER_JFD_IVAN', 	'FLAVOR_AIRLIFT', 					3),
		('LEADER_JFD_IVAN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_IVAN', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_IVAN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_IVAN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_IVAN', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_IVAN', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------
-- Leader_Traits
--------------------------------
INSERT INTO Leader_Traits 
		(LeaderType, 			TraitType)
VALUES	('LEADER_JFD_IVAN',		'TRAIT_JFD_MUSCOVY');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 					Description, 					ShortDescription)
VALUES	('TRAIT_JFD_MUSCOVY', 	'TXT_KEY_TRAIT_JFD_MUSCOVY', 	'TXT_KEY_TRAIT_JFD_MUSCOVY_SHORT');
--==========================================================================================================================	
-- MINOR CIVILIZATIONS
--==========================================================================================================================
-- MinorCivilizations
--------------------------------		
INSERT INTO MinorCivilizations 
		(Type, 							Description, 						ShortDescription, 					Adjective, 								Civilopedia, 						DefaultPlayerColor, 				ArtDefineTag, 					ArtStyleType, 			ArtStyleSuffix, ArtStylePrefix, MinorCivTrait)
SELECT	'MINOR_CIV_JFD_PSKOV', 			'TXT_KEY_CITYSTATE_JFD_PSKOV',		'TXT_KEY_CITYSTATE_JFD_PSKOV',		'TXT_KEY_CITYSTATE_JFD_PSKOV_ADJ',		'TXT_KEY_CIV5_JFD_PSKOV_TEXT', 		'PLAYERCOLOR_MINOR_LIGHT_PURPLE', 	'ART_DEF_CIVILIZATION_MINOR', 	'ARTSTYLE_EUROPEAN', 	'_EURO', 		'EUROPEAN ', 	'MINOR_TRAIT_MERCANTILE'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilizations 
		(Type, 							Description, 						ShortDescription, 					Adjective, 								Civilopedia, 						DefaultPlayerColor, 				ArtDefineTag, 					ArtStyleType, 			ArtStyleSuffix, ArtStylePrefix, MinorCivTrait)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		'TXT_KEY_CITYSTATE_JFD_ROSTOV',		'TXT_KEY_CITYSTATE_JFD_ROSTOV',		'TXT_KEY_CITYSTATE_JFD_ROSTOV_ADJ',		'TXT_KEY_CIV5_JFD_ROSTOV_TEXT', 	'PLAYERCOLOR_MINOR_WHITE', 			'ART_DEF_CIVILIZATION_MINOR', 	'ARTSTYLE_EUROPEAN', 	'_EURO', 		'EUROPEAN ', 	'MINOR_TRAIT_RELIGIOUS'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilizations 
		(Type, 							Description, 						ShortDescription, 					Adjective, 								Civilopedia, 						DefaultPlayerColor, 				ArtDefineTag, 					ArtStyleType, 			ArtStyleSuffix, ArtStylePrefix, MinorCivTrait)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		'TXT_KEY_CITYSTATE_JFD_SMOLENSK',	'TXT_KEY_CITYSTATE_JFD_SMOLENSK',	'TXT_KEY_CITYSTATE_JFD_SMOLENSK_ADJ',	'TXT_KEY_CIV5_JFD_SMOLENSK_TEXT', 	'PLAYERCOLOR_MINOR_GOLDENROD', 		'ART_DEF_CIVILIZATION_MINOR', 	'ARTSTYLE_EUROPEAN', 	'_EURO', 		'EUROPEAN ', 	'MINOR_TRAIT_MILITARISTIC'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilizations 
		(Type, 							Description, 						ShortDescription, 					Adjective, 								Civilopedia, 						DefaultPlayerColor, 				ArtDefineTag, 					ArtStyleType, 			ArtStyleSuffix, ArtStylePrefix, MinorCivTrait)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	'TXT_KEY_CITYSTATE_JFD_TMUTARAKAN',	'TXT_KEY_CITYSTATE_JFD_TMUTARAKAN',	'TXT_KEY_CITYSTATE_JFD_TMUTARAKAN_ADJ',	'TXT_KEY_CIV5_JFD_TMUTARAKAN_TEXT', 'PLAYERCOLOR_MINOR_CYAN', 			'ART_DEF_CIVILIZATION_MINOR', 	'ARTSTYLE_EUROPEAN', 	'_EURO', 		'EUROPEAN ', 	'MINOR_TRAIT_MILITARISTIC'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilizations 
		(Type, 							Description, 						ShortDescription, 					Adjective, 								Civilopedia, 						DefaultPlayerColor, 				ArtDefineTag, 					ArtStyleType, 			ArtStyleSuffix, ArtStylePrefix, MinorCivTrait)
SELECT	'MINOR_CIV_JFD_VLADIMIR',		'TXT_KEY_CITYSTATE_JFD_VLADIMIR',	'TXT_KEY_CITYSTATE_JFD_VLADIMIR',	'TXT_KEY_CITYSTATE_JFD_VLADIMIR_ADJ',	'TXT_KEY_CIV5_JFD_VLADIMIR_TEXT', 	'PLAYERCOLOR_MINOR_WHITE', 			'ART_DEF_CIVILIZATION_MINOR', 	'ARTSTYLE_EUROPEAN', 	'_EURO', 		'EUROPEAN ', 	'MINOR_TRAIT_CULTURED'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
--------------------------------	
-- MinorCivilization_Flavors
--------------------------------		
INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_PSKOV', 			Type,					 0
FROM Flavors WHERE Type IN ('FLAVOR_NUKE', 'FLAVOR_EXPANSION', 'FLAVOR_WONDER')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_PSKOV', 			'FLAVOR_GOLD',			10
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		Type,					0
FROM Flavors WHERE Type IN ('FLAVOR_NUKE', 'FLAVOR_EXPANSION', 'FLAVOR_WONDER')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		'FLAVOR_RELIGION',		10
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		Type,					0
FROM Flavors WHERE Type IN ('FLAVOR_NUKE', 'FLAVOR_EXPANSION', 'FLAVOR_WONDER')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		Type,					7
FROM Flavors WHERE Type IN ('FLAVOR_CITY_DEFENSE', 'FLAVOR_OFFENSE', 'FLAVOR_MILITARY_TRAINING')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	Type,					0
FROM Flavors WHERE Type IN ('FLAVOR_NUKE', 'FLAVOR_EXPANSION', 'FLAVOR_WONDER')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	Type,					8
FROM Flavors WHERE Type IN ('FLAVOR_NAVAL', 'FLAVOR_GROWTH')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		Type,					0
FROM Flavors WHERE Type IN ('FLAVOR_NUKE', 'FLAVOR_EXPANSION', 'FLAVOR_WONDER')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_Flavors 
		(MinorCivType, 					FlavorType,				Flavor)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		'FLAVOR_CITY_DEFENSE',	5
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
--------------------------------	
-- MinorCivilization_CityNames
--------------------------------
INSERT INTO MinorCivilization_CityNames 
		(MinorCivType, 					CityName)
SELECT	'MINOR_CIV_JFD_PSKOV', 			'TXT_KEY_CITYSTATE_JFD_PSKOV'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_CityNames 
		(MinorCivType, 					CityName)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		'TXT_KEY_CITYSTATE_JFD_ROSTOV'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_CityNames 
		(MinorCivType, 					CityName)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		'TXT_KEY_CITYSTATE_JFD_SMOLENSK'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
	
INSERT INTO MinorCivilization_CityNames 
		(MinorCivType, 					CityName)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	'TXT_KEY_CITYSTATE_JFD_TMUTARAKAN'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_CityNames 
		(MinorCivType, 					CityName)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		'TXT_KEY_CITYSTATE_JFD_VLADIMIR'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 							DerivativeCiv,			Description, 					 ShortDescription, 						Adjective, 							  Civilopedia, 					 CivilopediaTag, 			DefaultPlayerColor, 		ArtDefineTag,			ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 			AlphaIconAtlas, 			PortraitIndex,	SoundtrackTag, 	MapImage, 						DawnOfManQuote, 					DawnOfManImage)
SELECT	'CIVILIZATION_JFD_MUSCOVY', 	'CIVILIZATION_RUSSIA',	'TXT_KEY_CIV_JFD_MUSCOVY_DESC',  'TXT_KEY_CIV_JFD_MUSCOVY_SHORT_DESC',	'TXT_KEY_CIV_JFD_MUSCOVY_ADJECTIVE',  'TXT_KEY_CIV5_MUSCOVY_TEXT_1', 'TXT_KEY_CIV5_MUSCOVY',	'PLAYERCOLOR_JFD_MUSCOVY',	'ART_DEF_JFD_MUSCOVY',	ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_MUSCOVY_ATLAS',	'JFD_MUSCOVY_ALPHA_ATLAS', 	0, 				'Russia', 		'Janboruta_MapMuscovy512.dds',	'TXT_KEY_CIV5_DOM_JFD_IVAN_TEXT',	'Janboruta_Muscovy_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_RUSSIA';
--------------------------------
-- Civilization_CityNames
--------------------------------		
INSERT INTO Civilization_CityNames 
		(CivilizationType, 				CityName)
VALUES	('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_01'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_02'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_03'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_04'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_05'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_06'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_07'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_08'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_09'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_10'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_11'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_12'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_13'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_14'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_15'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_16'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_17'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_18'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_19'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_20'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_21'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_22'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_23'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_24'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_25'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_26'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_27'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_28'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_29'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_CITY_NAME_JFD_MUSCOVY_30');
--------------------------------
-- Civilization_FreeBuildingClasses
--------------------------------		
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 				BuildingClassType)
SELECT	'CIVILIZATION_JFD_MUSCOVY', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------
-- Civilization_FreeTechs
--------------------------------	
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 				TechType)
SELECT	'CIVILIZATION_JFD_MUSCOVY', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------
-- Civilization_FreeUnits
--------------------------------	
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_MUSCOVY', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 				LeaderheadType)
VALUES	('CIVILIZATION_JFD_MUSCOVY', 	'LEADER_JFD_IVAN');
--------------------------------
-- Civilization_UnitClassOverrides 
--------------------------------	
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 				UnitClassType, 				UnitType)
VALUES	('CIVILIZATION_JFD_MUSCOVY', 	'UNITCLASS_MUSKETMAN',		'UNIT_JFD_STRELTSY');
--------------------------------
-- Civilization_BuildingClassOverrides 
--------------------------------	
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_JFD_MUSCOVY', 	'BUILDINGCLASS_TEMPLE',		'BUILDING_JFD_SOBOR');
--------------------------------
-- Civilization_Religions
--------------------------------	
INSERT INTO Civilization_Religions 
		(CivilizationType, 				ReligionType)
VALUES	('CIVILIZATION_JFD_MUSCOVY', 	'RELIGION_ORTHODOXY');		
--------------------------------
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 				SpyName)
VALUES	('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_0'),	
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_1'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_2'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_3'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_4'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_5'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_6'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_7'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_8'),
		('CIVILIZATION_JFD_MUSCOVY', 	'TXT_KEY_SPY_NAME_JFD_MUSCOVY_9');
--==========================================================================================================================
--==========================================================================================================================