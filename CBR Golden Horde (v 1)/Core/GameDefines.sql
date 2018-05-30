--==========================================================================================================================	
-- Buildings
--==========================================================================================================================
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 							BuildingClass, 		FreeStartEra,	Cost,		GoldMaintenance, 	PrereqTech,			Help,								Description,	 				Civilopedia,						Strategy, 								ArtDefineTag, MinAreaSize, HurryCostModifier, ConquestProb, IconAtlas, 				PortraitIndex)
SELECT	'BUILDING_CBR_KHUARAN', 		BuildingClass,		FreeStartEra,	Cost-10,	0, 					'TECH_AGRICULTURE',	'TXT_KEY_CIV5_CBR_KHUARAN_HELP',	'TXT_KEY_CIV5_CBR_KHUARAN',	 	'TXT_KEY_CIV5_CBR_KHUARAN_PEDIA',	'TXT_KEY_CIV5_CBR_KHUARAN_STRATEGY', 	ArtDefineTag, MinAreaSize, HurryCostModifier, ConquestProb, 'CBR_GOLDEN_HORDE_ATLAS', 2
FROM Buildings WHERE Type = 'BUILDING_BARRACKS';
------------------------------
-- Building_ResourceYieldModifiers
------------------------------
INSERT INTO Building_ResourceYieldChanges
		(BuildingType,				ResourceType, 		YieldType,			Yield)
VALUES	('BUILDING_CBR_KHUARAN',	'RESOURCE_HORSE', 	'YIELD_FAITH',		1);
--------------------------------------------------------------------------------------------------------------------------	
-- Building_DomainFreeExperiences
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Building_DomainFreeExperiences 
		(BuildingType, 					DomainType,			Experience)
SELECT	'BUILDING_CBR_KHUARAN',			DomainType,			Experience
FROM Building_DomainFreeExperiences WHERE BuildingType = 'BUILDING_BARRACKS';	
--------------------------------------------------------------------------------------------------------------------------	
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_YieldChanges 
		(BuildingType, 							YieldType,	Yield)
SELECT	'BUILDING_CBR_KHUARAN',					YieldType,	Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_BARRACKS';	
--------------------------------------------------------------------------------------------------------------------------	
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Building_Flavors 
		(BuildingType, 				FlavorType,			Flavor)
SELECT	'BUILDING_CBR_KHUARAN', 	FlavorType,			Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_BARRACKS';	

--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 								CannotBeChosen,	IgnoreZOC, FreePillageMoves, 	CityAttack, 	Description, 							Help, 										Sound, 				IconAtlas, 			PortraitIndex, 	PediaType, 			PediaEntry)
VALUES	('PROMOTION_CBR_GH_TATARYOKE',		1, 				1, 			1, 					0,				'TXT_KEY_PROMOTION_CBR_GH_TATARYOKE', 	'TXT_KEY_PROMOTION_CBR_GH_TATARYOKE_HELP', 	'AS2D_IF_LEVELUP', 	'PROMOTION_ATLAS', 	22, 			'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_CBR_GH_TATARYOKE'),
		('PROMOTION_CBR_GH_ZOC',			1, 				1, 			0, 					0,				'TXT_KEY_PROMOTION_CBR_GH_ZOC', 		'TXT_KEY_PROMOTION_CBR_GH_ZOC_HELP', 		'AS2D_IF_LEVELUP', 	'PROMOTION_ATLAS', 	22, 			'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_CBR_GH_ZOC'),
		('PROMOTION_CBR_GH_CITY_COMBAT',	1, 				0, 			0, 					50,				'TXT_KEY_PROMOTION_CBR_GH_CITY_COMBAT', 'TXT_KEY_PROMOTION_CBR_GH_CITY_COMBAT_HELP', 'AS2D_IF_LEVELUP', 'PROMOTION_ATLAS', 	22, 			'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_CBR_GH_CITY_COMBAT');

--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 						Class,	PrereqTech,	Combat, 	RangedCombat, 	Range, 	Cost,		Moves, 	CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, UnitArtInfo, 						UnitFlagAtlas, 						UnitFlagIconOffset, PortraitIndex,	IconAtlas)
SELECT	'UNIT_CBR_KHAMGAALAGCH', 	Class,	PrereqTech, Combat, 	RangedCombat+5,	2, 		Cost, 		Moves, 	CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_CBR_KHAMGAALAGCH', 	'TXT_KEY_CIV5_CBR_KHAMGAALAGCH_TEXT',	'TXT_KEY_UNIT_CBR_KHAMGAALAGCH_STRATEGY', 	'TXT_KEY_UNIT_CBR_KHAMGAALAGCH_HELP',	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, 'ART_DEF_UNIT_CBR_KHAMGAALAGCH', 	'CBR_KHAMGAALAGCH_FLAG_ART_ATLAS',	0,					3,				'CBR_GOLDEN_HORDE_ATLAS'
FROM Units WHERE Type = 'UNIT_MONGOLIAN_KESHIK';
--------------------------------
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_CBR_KHAMGAALAGCH', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_MONGOLIAN_KESHIK';	
--------------------------------
-- Unit_AITypes
--------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_CBR_KHAMGAALAGCH', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_MONGOLIAN_KESHIK';
--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_CBR_KHAMGAALAGCH', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_MONGOLIAN_KESHIK';
--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	'UNIT_CBR_KHAMGAALAGCH', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_LANCER';

INSERT INTO Unit_FreePromotions
		(UnitType,					PromotionType)
VALUES	('UNIT_CBR_KHAMGAALAGCH',	'PROMOTION_CBR_GH_TATARYOKE');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 						UnitClassType)
SELECT	'UNIT_CBR_KHAMGAALAGCH',		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_MONGOLIAN_KESHIK';

INSERT INTO Unit_ResourceQuantityRequirements
		(UnitType, 					ResourceType)
SELECT 	'UNIT_CBR_KHAMGAALAGCH', 	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_MONGOLIAN_KESHIK';
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 						Description, 						Civilopedia, 								CivilopediaTag, 								ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex)
VALUES	('LEADER_CBR_TOKHTAMYSH', 	'TXT_KEY_LEADER_CBR_TOKHTAMYSH', 	'TXT_KEY_LEADER_CBR_TOKHTAMYSH_PEDIA', 		'TXT_KEY_CIVILOPEDIA_LEADERS_CBR_TOKHTAMYSH', 	'Tokhtamysh_Scene.xml',	5, 						5, 						9, 							6, 			6, 				3, 				4, 						6, 				5, 			5, 			5, 				4, 			7, 			'CBR_GOLDEN_HORDE_ATLAS', 		1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES	('LEADER_CBR_TOKHTAMYSH', 	'MAJOR_CIV_APPROACH_WAR', 			8),
		('LEADER_CBR_TOKHTAMYSH', 	'MAJOR_CIV_APPROACH_HOSTILE', 		8),
		('LEADER_CBR_TOKHTAMYSH', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
		('LEADER_CBR_TOKHTAMYSH', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
		('LEADER_CBR_TOKHTAMYSH', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
		('LEADER_CBR_TOKHTAMYSH', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
		('LEADER_CBR_TOKHTAMYSH', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES	('LEADER_CBR_TOKHTAMYSH', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
		('LEADER_CBR_TOKHTAMYSH', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_CBR_TOKHTAMYSH', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
		('LEADER_CBR_TOKHTAMYSH', 	'MINOR_CIV_APPROACH_CONQUEST', 		4),
		('LEADER_CBR_TOKHTAMYSH', 	'MINOR_CIV_APPROACH_BULLY', 		9);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 				FlavorType, 						Flavor)
VALUES	('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_OFFENSE', 					9),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_DEFENSE', 					4),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_CITY_DEFENSE', 				3),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_MILITARY_TRAINING', 		8),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_RECON', 					6),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_RANGED', 					8),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_MOBILE', 					9),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_NAVAL', 					2),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_NAVAL_RECON', 				3),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_NAVAL_GROWTH', 				6),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_AIR', 						6),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_EXPANSION', 				8),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_GROWTH', 					5),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_INFRASTRUCTURE', 			4),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_PRODUCTION', 				7),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_GOLD', 						6),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_CULTURE', 					4),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_HAPPINESS', 				5),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_GREAT_PEOPLE', 				5),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_WONDER', 					4),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_RELIGION', 					6),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_DIPLOMACY', 				7),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_SPACESHIP', 				5),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_NUKE', 						6),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_USE_NUKE', 					7),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_ESPIONAGE', 				6),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_AIRLIFT', 					4),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		3),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		7),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_ARCHAEOLOGY', 				4),
		('LEADER_CBR_TOKHTAMYSH', 	'FLAVOR_AIR_CARRIER', 				4);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 				TraitType)
VALUES	('LEADER_CBR_TOKHTAMYSH', 	'TRAIT_CBR_GOLDEN_HORDE');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 						Description, 						ShortDescription)
VALUES	('TRAIT_CBR_GOLDEN_HORDE', 	'TXT_KEY_TRAIT_CBR_GOLDEN_HORDE', 	'TXT_KEY_TRAIT_CBR_GOLDEN_HORDE_SHORT');

INSERT INTO Trait_FreePromotionUnitCombats
		(TraitType, 				UnitCombatType, 		PromotionType)
VALUES 	('TRAIT_CBR_GOLDEN_HORDE', 'UNITCOMBAT_MOUNTED', 	'PROMOTION_CBR_GH_ZOC');

--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 								Description, 									ShortDescription, 									Adjective,											CivilopediaTag, 	DefaultPlayerColor,				ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,					PortraitIndex,	AlphaIconAtlas,					SoundtrackTag,  	MapImage, 				DawnOfManQuote, 							DawnOfManImage)
SELECT	'CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_CIVILIZATION_CBR_GOLDEN_HORDE_DESC', 	'TXT_KEY_CIVILIZATION_CBR_GOLDEN_HORDE_SHORT_DESC', 'TXT_KEY_CIVILIZATION_CBR_GOLDEN_HORDE_ADJECTIVE', 	CivilopediaTag, 	'PLAYERCOLOR_CBR_GOLDEN_HORDE', ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'CBR_GOLDEN_HORDE_ATLAS',	0,				'CBR_GOLDEN_HORDE_ALPHA_ATLAS',	SoundtrackTag, 		'MapGoldenHorde.dds',	'TXT_KEY_CIV5_DAWN_CBR_TOKHTAMYSH_TEXT',	'DoMTokhtamysh.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_MONGOL';
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 					CityName)
VALUES	('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_1'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_2'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_3'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_4'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_5'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_6'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_7'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_8'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_9'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_10'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_11'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_12'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_13'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_14'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_15'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_16'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_17'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_18'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_19'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_20'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_21'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_22'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_23'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_24'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_25'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_26'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_27'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_28'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_29'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_30'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_31'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_32'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_33'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_34'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_35'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_36'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_37'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_38'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_39'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_40'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_41'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_42'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_43'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_44'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_45'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_46'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_47'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_48'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_49'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_50'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_51'),
		('CIVILIZATION_CBR_GOLDEN_HORDE',    'TXT_KEY_CITY_NAME_CBR_GOLDEN_HORDE_52');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 					BuildingClassType)
SELECT	'CIVILIZATION_CBR_GOLDEN_HORDE', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_MONGOL';

INSERT INTO Civilization_BuildingClassOverrides
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES 		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'BUILDINGCLASS_BARRACKS', 	'BUILDING_CBR_KHUARAN');
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 					TechType)
SELECT	'CIVILIZATION_CBR_GOLDEN_HORDE', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_MONGOL';
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_CBR_GOLDEN_HORDE', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_MONGOL';
--------------------------------	
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 					LeaderheadType)
VALUES	('CIVILIZATION_CBR_GOLDEN_HORDE',	'LEADER_CBR_TOKHTAMYSH');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 					UnitClassType, 		UnitType)
VALUES	('CIVILIZATION_CBR_GOLDEN_HORDE', 	'UNITCLASS_KNIGHT',	'UNIT_CBR_KHAMGAALAGCH');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 					ReligionType)
SELECT	'CIVILIZATION_CBR_GOLDEN_HORDE', 	'ReligionType'
FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_MONGOL';
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 					SpyName)
VALUES	('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_1'),
		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_2'),
		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_3'),
		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_4'),
		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_5'),
		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_6'),
		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_7'),
		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_8'),
		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_9'),
		('CIVILIZATION_CBR_GOLDEN_HORDE', 	'TXT_KEY_SPY_NAME_CIVILIZATION_CBR_GOLDEN_HORDE_10');
--------------------------------	
-- Civilization_Start_Region_Priority
--------------------------------			
INSERT INTO Civilization_Start_Region_Priority 
		(CivilizationType, 					RegionType)
SELECT	'CIVILIZATION_CBR_GOLDEN_HORDE', 	RegionType
FROM Civilization_Start_Region_Priority WHERE CivilizationType = 'CIVILIZATION_MONGOL';
--==========================================================================================================================
--==========================================================================================================================