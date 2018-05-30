--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
------------------------------	
INSERT INTO BuildingClasses
		(Type, 								DefaultBuilding, 			Description)
VALUES	('BUILDINGCLASS_JFD_QING', 			'BUILDING_JFD_QING', 		'TXT_KEY_BUILDING_JFD_QING');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 								FreeBuildingThisCity,		TrainedFreePromotion,		BuildingClass, Water, Cost, FaithCost, PrereqTech, GoldMaintenance, MinAreaSize, SpecialistCount, SpecialistType, MutuallyExclusiveGroup, NeverCapture, Description, 							Help, 										Strategy,										Civilopedia, 							ArtDefineTag,	PortraitIndex,	IconAtlas)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',		'BUILDINGCLASS_ARSENAL',	'PROMOTION_NAVAL_COLLEGE',	BuildingClass, Water, Cost, FaithCost, PrereqTech, GoldMaintenance, MinAreaSize, SpecialistCount, SpecialistType, MutuallyExclusiveGroup, 1, 			'TXT_KEY_BUILDING_JFD_NAVAL_COLLEGE', 	'TXT_KEY_BUILDING_JFD_NAVAL_COLLEGE_HELP',	'TXT_KEY_BUILDING_JFD_NAVAL_COLLEGE_STRATEGY',	'TXT_KEY_CIV5_JFD_NAVAL_COLLEGE_TEXT',	ArtDefineTag,	3, 				'JFD_QING_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_SEAPORT';		

INSERT INTO Buildings		
		(Type, 								BuildingClass, 			  	Cost,  FaithCost, GreatWorkCount,  Description, 				 Help,								NeverCapture)
VALUES	('BUILDING_JFD_QING', 				'BUILDINGCLASS_JFD_QING', 	-1,    -1,		  -1,			   'TXT_KEY_BUILDING_JFD_QING',  'TXT_KEY_BUILDING_JFD_QING_HELP',	1);
--------------------------------	
-- Building_SeaResourceYieldChanges
--------------------------------	
INSERT INTO Building_SeaResourceYieldChanges 	
		(BuildingType, 						YieldType, Yield)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',		YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE BuildingType = 'BUILDING_SEAPORT';	
--------------------------------	
-- Building_DomainProductionModifiers
--------------------------------	
INSERT INTO Building_DomainProductionModifiers 	
		(BuildingType, 						DomainType, Modifier)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',		DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE BuildingType = 'BUILDING_SEAPORT';	
--------------------------------	
-- Building_ClassesNeededInCity
--------------------------------	
INSERT INTO Building_ClassesNeededInCity 	
		(BuildingType, 						BuildingClassType)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',		BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_SEAPORT';	
------------------------------	
-- Building_YieldChanges
------------------------------	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 						YieldType,			Yield)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',		YieldType,			Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_SEAPORT';	
------------------------------	
-- Building_Flavors
------------------------------	
INSERT INTO Building_Flavors 	
		(BuildingType, 						FlavorType,			Flavor)
SELECT	'BUILDING_JFD_NAVAL_COLLEGE',		FlavorType,			Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_SEAPORT';
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
--------------------------------
INSERT INTO UnitPromotions 
		(Type, 								Description, 							Help, 										Sound, 				ExperiencePercent,	CannotBeChosen, LostWithUpgrade, PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_PEKING_FORCE', 		'TXT_KEY_PROMOTION_JFD_PEKING_FORCE',	'TXT_KEY_PROMOTION_JFD_PEKING_FORCE_HELP',	'AS2D_IF_LEVELUP', 	15,					1, 				0, 				 59, 				'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PEKING_FORCE');
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 						Class, Cost, Moves, FaithCost,	RequiresFaithPurchaseEnabled, GoodyHutUpgradeUnitClass, PrereqTech,			Combat,	  CombatClass, Domain, DefaultUnitAI, ObsoleteTech,	Description, 						Civilopedia, 							Help, 									Strategy,									Pillage, HurryCostModifier, AdvancedStartCost, CombatLimit, UnitArtInfo,						XPValueAttack, XPValueDefense, UnitFlagIconOffset,  UnitFlagAtlas,							MoveRate,	PortraitIndex, 	IconAtlas)
SELECT	'UNIT_JFD_PEKING_FORCE',	Class, Cost, Moves, FaithCost,	RequiresFaithPurchaseEnabled, GoodyHutUpgradeUnitClass, 'TECH_STEAM_POWER', Combat-5, CombatClass, Domain, DefaultUnitAI, ObsoleteTech,	'TXT_KEY_UNIT_JFD_PEKING_FORCE', 	'TXT_KEY_CIV5_JFD_PEKING_FORCE_TEXT', 	'TXT_KEY_UNIT_JFD_PEKING_FORCE_HELP', 	'TXT_KEY_UNIT_JFD_PEKING_FORCE_STRATEGY',	Pillage, HurryCostModifier, AdvancedStartCost, CombatLimit, 'ART_DEF_UNIT_JFD_PEKING_FORCE',	XPValueAttack, XPValueAttack,  0,					'JFD_UNIT_FLAG_PEKING_FORCE_ATLAS',		MoveRate,	2, 				'JFD_QING_ATLAS'
FROM Units WHERE Type = 'UNIT_GREAT_WAR_INFANTRY';	
--------------------------------
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_PEKING_FORCE', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_GREAT_WAR_INFANTRY';	
--------------------------------
-- Unit_AITypes
--------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_JFD_PEKING_FORCE', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_GREAT_WAR_INFANTRY';
--------------------------------
-- Unit_ClassUpgrades
--------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_JFD_PEKING_FORCE', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_GREAT_WAR_INFANTRY';
--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType,	 Flavor)
SELECT	'UNIT_JFD_PEKING_FORCE', 	FlavorType,	 Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_GREAT_WAR_INFANTRY';
--------------------------------	
-- Unit_ProductionModifierBuildings
--------------------------------	
INSERT INTO Unit_ProductionModifierBuildings 	
		(UnitType,					BuildingType, 					ProductionModifier)
VALUES	('UNIT_JFD_PEKING_FORCE',	'BUILDING_JFD_QING',			100);	
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 					Description, 						Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_JFD_CIXI', 	'TXT_KEY_LEADER_JFD_CIXI', 			'TXT_KEY_LEADER_JFD_CIXI_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_CIXI', 	'Janboruta_Cixi_Scene.xml',		7, 						2, 						2, 							7, 			6, 				9, 				8, 						4, 				4, 			4, 			2, 				3, 			5, 			'JFD_QING_ATLAS', 	1);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_CIXI', 	'MAJOR_CIV_APPROACH_WAR', 			5),
		('LEADER_JFD_CIXI', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
		('LEADER_JFD_CIXI', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
		('LEADER_JFD_CIXI', 	'MAJOR_CIV_APPROACH_GUARDED', 		9),
		('LEADER_JFD_CIXI', 	'MAJOR_CIV_APPROACH_AFRAID', 		6),
		('LEADER_JFD_CIXI', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
		('LEADER_JFD_CIXI', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_CIXI', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
		('LEADER_JFD_CIXI', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_CIXI', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
		('LEADER_JFD_CIXI', 	'MINOR_CIV_APPROACH_CONQUEST', 		4),
		('LEADER_JFD_CIXI', 	'MINOR_CIV_APPROACH_BULLY', 		5);
--------------------------------	
-- Leader_Flavors
--------------------------------						
INSERT INTO Leader_Flavors 
		(LeaderType, 			FlavorType, 						Flavor)
VALUES	('LEADER_JFD_CIXI', 	'FLAVOR_OFFENSE', 					6),
		('LEADER_JFD_CIXI', 	'FLAVOR_DEFENSE', 					5),
		('LEADER_JFD_CIXI', 	'FLAVOR_CITY_DEFENSE', 				7),
		('LEADER_JFD_CIXI', 	'FLAVOR_MILITARY_TRAINING', 		7),
		('LEADER_JFD_CIXI', 	'FLAVOR_RECON', 					4),
		('LEADER_JFD_CIXI', 	'FLAVOR_RANGED', 					5),
		('LEADER_JFD_CIXI', 	'FLAVOR_MOBILE', 					5),
		('LEADER_JFD_CIXI', 	'FLAVOR_NAVAL', 					7),
		('LEADER_JFD_CIXI', 	'FLAVOR_NAVAL_RECON', 				5),
		('LEADER_JFD_CIXI', 	'FLAVOR_NAVAL_GROWTH', 				5),
		('LEADER_JFD_CIXI', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_JFD_CIXI', 	'FLAVOR_AIR', 						4),
		('LEADER_JFD_CIXI', 	'FLAVOR_EXPANSION', 				7),
		('LEADER_JFD_CIXI', 	'FLAVOR_GROWTH', 					5),
		('LEADER_JFD_CIXI', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
		('LEADER_JFD_CIXI', 	'FLAVOR_INFRASTRUCTURE', 			6),
		('LEADER_JFD_CIXI', 	'FLAVOR_PRODUCTION', 				6),
		('LEADER_JFD_CIXI', 	'FLAVOR_GOLD', 						6),
		('LEADER_JFD_CIXI', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_JFD_CIXI', 	'FLAVOR_CULTURE', 					8),
		('LEADER_JFD_CIXI', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_CIXI', 	'FLAVOR_GREAT_PEOPLE', 				5),
		('LEADER_JFD_CIXI', 	'FLAVOR_WONDER', 					5),
		('LEADER_JFD_CIXI', 	'FLAVOR_RELIGION', 					6),
		('LEADER_JFD_CIXI', 	'FLAVOR_DIPLOMACY', 				5),
		('LEADER_JFD_CIXI', 	'FLAVOR_SPACESHIP', 				4),
		('LEADER_JFD_CIXI', 	'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_JFD_CIXI', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_CIXI', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_CIXI', 	'FLAVOR_ESPIONAGE', 				8),
		('LEADER_JFD_CIXI', 	'FLAVOR_AIRLIFT', 					3),
		('LEADER_JFD_CIXI', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_CIXI', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_CIXI', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_CIXI', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_CIXI', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_CIXI', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 			TraitType)
VALUES	('LEADER_JFD_CIXI',		'TRAIT_JFD_QING');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 					Description, 					ShortDescription)
VALUES	('TRAIT_JFD_QING',		'TXT_KEY_TRAIT_JFD_QING', 	'TXT_KEY_TRAIT_JFD_QING_SHORT');	
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------			
INSERT INTO Civilizations 	
		(Type, 						DerivativeCiv,			Description, 					ShortDescription, 					Adjective, 							Civilopedia, 						CivilopediaTag, 			DefaultPlayerColor, 		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 			PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 					DawnOfManQuote, 					DawnOfManImage)
SELECT	'CIVILIZATION_JFD_QING',	'CIVILIZATION_CHINA',	'TXT_KEY_CIV_JFD_QING_DESC',	'TXT_KEY_CIV_JFD_QING_SHORT_DESC', 	'TXT_KEY_CIV_JFD_QING_ADJECTIVE',	'TXT_KEY_CIV5_JFD_QING_TEXT_1', 	'TXT_KEY_CIV5_JFD_QING',	'PLAYERCOLOR_JFD_QING', 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_QING_ATLAS', 	0, 				'JFD_QING_ALPHA_ATLAS', 	'China', 		'Regalman_MapQing512.dds', 	'TXT_KEY_CIV5_DOM_JFD_CIXI_TEXT', 	'Janboruta_Qing_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_CHINA';
--------------------------------	
-- Civilization_CityNames
--------------------------------			
INSERT INTO Civilization_CityNames 
		(CivilizationType, 			CityName)
VALUES	('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_01'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_02'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_03'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_04'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_05'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_06'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_07'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_08'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_09'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_10'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_11'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_12'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_13'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_14'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_15'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_16'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_17'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_18'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_19'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_20'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_21'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_22'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_23'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_24'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_25'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_26'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_CITY_NAME_JFD_QING_27');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 			BuildingClassType)
SELECT	'CIVILIZATION_JFD_QING',	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_CHINA';
--------------------------------	
-- Civilization_FreeTechs
--------------------------------		
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 			TechType)
SELECT	'CIVILIZATION_JFD_QING',	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_CHINA';
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_QING',	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
--------------------------------	
-- Civilization_Leaders
--------------------------------			
INSERT INTO Civilization_Leaders 
		(CivilizationType, 			LeaderheadType)
VALUES	('CIVILIZATION_JFD_QING', 	'LEADER_JFD_CIXI');	
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 			UnitClassType, 						UnitType)
VALUES	('CIVILIZATION_JFD_QING', 	'UNITCLASS_GREAT_WAR_INFANTRY', 	'UNIT_JFD_PEKING_FORCE');
--------------------------------	
-- Civilization_BuildingClassOverrides
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 			BuildingClassType, 					BuildingType)
VALUES	('CIVILIZATION_JFD_QING', 	'BUILDINGCLASS_SEAPORT',			'BUILDING_JFD_NAVAL_COLLEGE');
--------------------------------	
-- Civilization_Religions
--------------------------------		
INSERT INTO Civilization_Religions 
		(CivilizationType, 			ReligionType)
VALUES	('CIVILIZATION_JFD_QING',	'RELIGION_CONFUCIANISM');	
--------------------------------	
-- Civilization_SpyNames
--------------------------------		
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 			SpyName)
VALUES	('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_0'),	
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_1'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_2'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_3'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_4'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_5'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_6'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_7'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_8'),
		('CIVILIZATION_JFD_QING', 	'TXT_KEY_SPY_NAME_JFD_QING_9');
--==========================================================================================================================
--==========================================================================================================================