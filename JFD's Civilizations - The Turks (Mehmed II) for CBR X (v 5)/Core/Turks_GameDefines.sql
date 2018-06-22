--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses 		
		(Type, 						 	DefaultBuilding, 			Description)
VALUES	('BUILDINGCLASS_JFD_TURKS', 	'BUILDING_JFD_TURKS', 		'TXT_KEY_BUILDING_JFD_TURKS');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Buildings																										 				 
		(Type, 						BuildingClass,					ConquestProb,	Cost, FaithCost, GreatWorkCount,	PrereqTech,		Description,					Help)
VALUES	('BUILDING_JFD_TURKS',		'BUILDINGCLASS_JFD_TURKS',		100,			-1,	  -1,		 -1,				null,			'TXT_KEY_BUILDING_JFD_TURKS',	'TXT_KEY_BUILDING_JFD_TURKS_HELP');
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions 
		(Type, 						Description, 						 Help, 									Sound, 				CityAttack,	LostWithUpgrade,	CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_BOMBARD',	'TXT_KEY_PROMOTION_JFD_BOMBARD',	 'TXT_KEY_PROMOTION_JFD_BOMBARD_HELP',	'AS2D_IF_LEVELUP',	350,		1,					1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_BOMBARD');
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Units 	
		(Type, 					Class, PrereqTech,		 Combat,   RangedCombat, Range, Cost,	  ExtraMaintenanceCost,	FaithCost,		RequiresFaithPurchaseEnabled, Moves, HurryCostModifier, CombatClass, Domain, DefaultUnitAI, Description, 				Civilopedia, 				Strategy, 						Help, 						MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 				UnitFlagAtlas, 						UnitFlagIconOffset, PortraitIndex, 	IconAtlas, 						MoveRate)
SELECT	'UNIT_JFD_BOMBARD',		Class, 'TECH_GUNPOWDER', Combat-2, 16,			 Range, Cost+50,  0,					FaithCost+100,  RequiresFaithPurchaseEnabled, Moves, HurryCostModifier, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_JFD_BOMBARD_DESC', 'TXT_KEY_JFD_BOMBARD_TEXT', 'TXT_KEY_JFD_BOMBARD_STRATEGY', 'TXT_KEY_JFD_BOMBARD_HELP',	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_JFD_BOMBARD',	'JFD_TURKS_FLAG_ATLAS', 	0,					2, 				'JFD_TURKS_ATLAS',	MoveRate
FROM Units WHERE Type = 'UNIT_CANNON';

--Janissary
UPDATE Units
SET Help = 'TXT_KEY_UNIT_HELP_JFD_JANISSARY', Strategy = 'TXT_KEY_UNIT_OTTOMAN_JFD_JANISSARY_STRATEGY'
WHERE Type = 'UNIT_OTTOMAN_JANISSARY';
--------------------------------------------------------------------------------------------------------------------------	
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_BOMBARD',		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_CANNON');
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Unit_AITypes 	
		(UnitType, 				UnitAIType)
SELECT	'UNIT_JFD_BOMBARD',		UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_CANNON';
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Unit_Flavors 	
		(UnitType, 				FlavorType,	Flavor)
SELECT	'UNIT_JFD_BOMBARD',		FlavorType,	Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_CANNON';
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 				ResourceType)
SELECT	'UNIT_JFD_BOMBARD',		ResourceType
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_CANNON';
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_JFD_BOMBARD',		PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_CANNON' AND NOT PromotionType = 'PROMOTION_CITY_SIEGE';

INSERT INTO Unit_FreePromotions 
		(UnitType, 				PromotionType)
VALUES	('UNIT_JFD_BOMBARD', 	'PROMOTION_RANGE'),
		('UNIT_JFD_BOMBARD', 	'PROMOTION_JFD_BOMBARD');
--------------------------------------------------------------------------------------------------------------------------	
-- Unit_ClassUpgrades
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 				UnitClassType)
SELECT	'UNIT_JFD_BOMBARD',		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_CANNON';	
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Leaders 
		(Type, 						Description, 					CivilopediaTag, 								ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 			PortraitIndex)
VALUES	('LEADER_JFD_MEHMED_II', 	'TXT_KEY_LEADER_JFD_MEHMED_II', 'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_MEHMED_II', 	'JFD_MehmedII_Scene.xml',		8, 						2, 						3, 							8, 			4, 				2, 				4, 						3, 				3, 			3, 			4, 				2, 			7, 			'JFD_TURKS_ATLAS', 	1);
--------------------------------------------------------------------------------------------------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_MEHMED_II', 	'MAJOR_CIV_APPROACH_WAR', 			7),
		('LEADER_JFD_MEHMED_II', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_JFD_MEHMED_II', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
		('LEADER_JFD_MEHMED_II', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
		('LEADER_JFD_MEHMED_II', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
		('LEADER_JFD_MEHMED_II', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
		('LEADER_JFD_MEHMED_II', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_MinorCivApproachBiases
--------------------------------------------------------------------------------------------------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_MEHMED_II', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
		('LEADER_JFD_MEHMED_II', 	'MINOR_CIV_APPROACH_FRIENDLY', 		2),
		('LEADER_JFD_MEHMED_II', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
		('LEADER_JFD_MEHMED_II', 	'MINOR_CIV_APPROACH_CONQUEST', 		6),
		('LEADER_JFD_MEHMED_II', 	'MINOR_CIV_APPROACH_BULLY', 		6);
--------------------------------------------------------------------------------------------------------------------------		
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------								
INSERT INTO Leader_Flavors 
		(LeaderType, 				FlavorType, 						Flavor)
VALUES	('LEADER_JFD_MEHMED_II', 	'FLAVOR_OFFENSE', 					7),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_DEFENSE', 					4),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_MILITARY_TRAINING', 		6),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_RECON', 					4),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_RANGED', 					7),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_MOBILE', 					5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_NAVAL', 					3),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_NAVAL_RECON', 				2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_NAVAL_GROWTH', 				2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_AIR', 						2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_EXPANSION', 				5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_GROWTH', 					5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_INFRASTRUCTURE', 			4),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_PRODUCTION', 				5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_GOLD', 						4),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_CULTURE', 					6),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_GREAT_PEOPLE', 				3),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_WONDER', 					2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_RELIGION', 					5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_DIPLOMACY', 				2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_SPACESHIP', 				2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_ESPIONAGE', 				4),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_AIRLIFT', 					2),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_MEHMED_II', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------------------------------------------------------------------------------------------------	
-- Leader_Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 				TraitType)
VALUES	('LEADER_JFD_MEHMED_II', 	'TRAIT_JFD_TURKS');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Traits 
		(Type, 						Description, 					ShortDescription)
VALUES	('TRAIT_JFD_TURKS', 		'TXT_KEY_TRAIT_JFD_TURKS',		'TXT_KEY_TRAIT_JFD_TURKS_SHORT');
--------------------------------------------------------------------------------------------------------------------------
--Civilization_FreePolicies
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_FreePolicies (
	CivilizationType  				text 	REFERENCES Civilizations(Type) 	default null,
	PolicyType						text 	REFERENCES Policies(Type) 		default null);	

INSERT INTO Civilization_FreePolicies
		(CivilizationType,			PolicyType)
VALUES	('CIVILIZATION_JFD_TURKS',	'POLICY_JFD_TURKS');
--------------------------------------------------------------------------------------------------------------------------
-- Policies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policies
		(Type,						Description,					HappinessPerGarrisonedUnit)
VALUES	('POLICY_JFD_TURKS',		'TXT_KEY_TRAIT_JFD_TURKS',		1);	
--==========================================================================================================================	
-- DIPLOMACY
--==========================================================================================================================	
-- Diplomacy_Responses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses
		(LeaderType, 				ResponseType, 									Response, 																Bias)
VALUES 	('LEADER_JFD_MEHMED_II', 	'RESPONSE_ATTACKED_HOSTILE', 					'TXT_KEY_LEADER_JFD_MEHMED_II_ATTACKED_GENERIC%', 						500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_DEFEATED', 							'TXT_KEY_LEADER_JFD_MEHMED_II_DEFEATED%', 								500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_DOW_GENERIC', 						'TXT_KEY_LEADER_JFD_MEHMED_II_DOW_GENERIC%', 							500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_EXPANSION_SERIOUS_WARNING', 			'TXT_KEY_LEADER_JFD_MEHMED_II_EXPANSION_SERIOUS_WARNING%', 				500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_FIRST_GREETING', 						'TXT_KEY_LEADER_JFD_MEHMED_II_FIRSTGREETING%', 							500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_GREETING_AT_WAR_HOSTILE', 			'TXT_KEY_LEADER_JFD_MEHMED_II_GREETING_AT_WAR_HOSTILE%', 				500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_GREETING_POLITE_HELLO', 				'TXT_KEY_LEADER_JFD_MEHMED_II_GREETING_POLITE_HELLO%', 					500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_GREETING_NEUTRAL_HELLO', 				'TXT_KEY_LEADER_JFD_MEHMED_II_GREETING_NEUTRAL_HELLO%', 				500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_GREETING_HOSTILE_HELLO', 				'TXT_KEY_LEADER_JFD_MEHMED_II_GREETING_HOSTILE_HELLO%', 				500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_HOSTILE_AGGRESSIVE_MILITARY_WARNING', 'TXT_KEY_LEADER_JFD_MEHMED_II_HOSTILE_AGGRESSIVE_MILITARY_WARNING%', 	500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_INFLUENTIAL_ON_AI', 					'TXT_KEY_LEADER_JFD_MEHMED_II_INFLUENTIAL_ON_AI%', 						500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_INFLUENTIAL_ON_HUMAN', 				'TXT_KEY_LEADER_JFD_MEHMED_II_INFLUENTIAL_ON_HUMAN%', 					500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_INSULT_GENERIC', 						'TXT_KEY_LEADER_JFD_MEHMED_II_INSULT_GENERIC%', 						500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_LETS_HEAR_IT', 						'TXT_KEY_LEADER_JFD_MEHMED_II_LETS_HEAR_IT%', 							500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_LUXURY_TRADE', 						'TXT_KEY_LEADER_JFD_MEHMED_II_LUXURY_TRADE%', 							500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_NO_PEACE', 							'TXT_KEY_LEADER_JFD_MEHMED_II_NO_PEACE%', 								500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_OPEN_BORDERS_EXCHANGE', 				'TXT_KEY_LEADER_JFD_MEHMED_II_OPEN_BORDERS_EXCHANGE%', 					500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_PEACE_MADE_BY_HUMAN_GRACIOUS', 		'TXT_KEY_LEADER_JFD_MEHMED_II_LOSEWAR%', 								500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_REPEAT_NO', 							'TXT_KEY_LEADER_JFD_MEHMED_II_REPEAT_NO%', 								500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_RESPONSE_REQUEST', 					'TXT_KEY_LEADER_JFD_MEHMED_II_RESPONSE_REQUEST%', 						500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_RESPONSE_TO_BEING_DENOUNCED', 		'TXT_KEY_LEADER_JFD_MEHMED_II_RESPONSE_TO_BEING_DENOUNCED%', 			500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_TOO_SOON_NO_PEACE', 					'TXT_KEY_LEADER_JFD_MEHMED_II_TOO_SOON_NO_PEACE_1%', 					500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_WINNER_PEACE_OFFER', 					'TXT_KEY_LEADER_JFD_MEHMED_II_WINWAR%', 								500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_WORK_AGAINST_SOMEONE', 				'TXT_KEY_LEADER_JFD_MEHMED_II_DENOUNCE%', 								500),
		('LEADER_JFD_MEHMED_II', 	'RESPONSE_WORK_WITH_US', 						'TXT_KEY_LEADER_JFD_MEHMED_II_DEC_FRIENDSHIP%', 						500);
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilizations 	
		(Type, 							DerivativeCiv,			 Description, ShortDescription, Adjective, Civilopedia, CivilopediaTag,	DefaultPlayerColor,		 ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 		PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 			DawnOfManQuote,						 DawnOfManImage)
SELECT	'CIVILIZATION_JFD_TURKS',		'CIVILIZATION_OTTOMAN',	 Description, ShortDescription, Adjective, Civilopedia, CivilopediaTag,	'PLAYERCOLOR_JFD_TURKS', ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_TURKS_ATLAS', 0, 				'JFD_TURKS_ALPHA_ATLAS', 	'Ottoman', 		'MapTurks512.dds',	'TXT_KEY_CIV5_DAWN_JFD_TURKS_TEXT',	 'DOM_Turks.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_OTTOMAN';

UPDATE Civilizations 
SET AIPlayable = 0, Playable = 0
WHERE Type = 'CIVILIZATION_OTTOMAN'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_DISABLE' AND Value = 1);	

UPDATE Civilizations
SET DefaultPlayerColor = 'PLAYERCOLOR_JFD_TURKS_CBR', PortraitIndex = 4
WHERE Type = 'CIVILIZATION_JFD_TURKS'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_TURKS_COLOURS' AND Value = 1);	
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_CityNames
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 				CityName)
VALUES	('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_1'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_2'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_3'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_4'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_5'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_6'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_7'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_8'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_9'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_10'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_11'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_12'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_13'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_14'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_15'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_16'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_17'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_18'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_19'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_20'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_21'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_22'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_23'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_24'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_25'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_26'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_27'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_28'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_29'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_30'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_31'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_32'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_33'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_34'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_35'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_36'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_37'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_38'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_39'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_40'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_41'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_42'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_43'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_44'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_45'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_46'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_47'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_48'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_49'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_50'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_51'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_52'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_53'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_54'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_55'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_56'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_57'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_58'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_59'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_60'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_61'),	
        ('CIVILIZATION_JFD_TURKS',		'TXT_KEY_CITY_NAME_JFD_TURKS_62');	
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 				BuildingClassType)
SELECT	'CIVILIZATION_JFD_TURKS',		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--------------------------------------------------------------------------------------------------------------------------		
-- Civilization_FreeTechs
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO Civilization_FreeTechs 	
		(CivilizationType, 				TechType)
SELECT	'CIVILIZATION_JFD_TURKS',		TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_FreeUnits
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_TURKS',		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Leaders
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Civilization_Leaders 
		(CivilizationType, 				LeaderheadType)
VALUES	('CIVILIZATION_JFD_TURKS',		'LEADER_JFD_MEHMED_II');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Civilization_UnitClassOverrides WHERE UnitType = 'UNIT_OTTOMAN_JANISSARY';	
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 				UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_JFD_TURKS', 		'UNITCLASS_CANNON',		'UNIT_JFD_BOMBARD'),
		('CIVILIZATION_JFD_TURKS', 		'UNITCLASS_MUSKETMAN',	'UNIT_OTTOMAN_JANISSARY');
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_Religions
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_Religions 
		(CivilizationType, 				ReligionType)
VALUES	('CIVILIZATION_JFD_TURKS',		'RELIGION_ISLAM');	
--------------------------------------------------------------------------------------------------------------------------	
-- Civilization_SpyNames
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 				SpyName)
VALUES	('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_1'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_2'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_3'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_4'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_5'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_6'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_7'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_8'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_9'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_10'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_11'),
		('CIVILIZATION_JFD_TURKS', 		'TXT_KEY_SPY_NAME_JFD_TURKS_12');
--==========================================================================================================================
--==========================================================================================================================