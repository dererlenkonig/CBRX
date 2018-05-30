--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 					Description, 					 Help, 									Sound, 				LostWithUpgrade,	CannotBeChosen, PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
SELECT	'PROMOTION_JFD_SIPAHI',	'TXT_KEY_PROMOTION_JFD_SIPAHI',	 'TXT_KEY_PROMOTION_JFD_SIPAHI_HELP',	'AS2D_IF_LEVELUP',	1,					1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_SIPAHI'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UU' AND Value = 1);	
------------------------------
-- Units
------------------------------	
INSERT INTO UnitPromotions_UnitCombatMods 	
		(PromotionType, 		UnitCombatType,		Modifier)
SELECT	'PROMOTION_JFD_SIPAHI',	'UNITCOMBAT_GUN',	25
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UU' AND Value = 1);	
--==========================================================================================================================	
-- UNITS
--==========================================================================================================================	
-- Units
------------------------------	
--Sipahi
UPDATE Units
SET Help = 'TXT_KEY_UNIT_HELP_JFD_SIPAHI', Strategy = 'TXT_KEY_UNIT_OTTOMAN_JFD_SIPAHI_STRATEGY', Cost = 200, FaithCost = 400
WHERE Type = 'UNIT_OTTOMAN_SIPAHI'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UU' AND Value = 1);	
------------------------------	
-- Unit_FreePromotions
------------------------------	
UPDATE Unit_FreePromotions
SET PromotionType = 'PROMOTION_SMALL_CITY_PENALTY'
WHERE UnitType = 'UNIT_OTTOMAN_SIPAHI' AND PromotionType = 'PROMOTION_CITY_PENALTY'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UU' AND Value = 1);	

INSERT INTO Unit_FreePromotions 	
		(UnitType, 				PromotionType)
SELECT	'UNIT_OTTOMAN_SIPAHI',	'PROMOTION_JFD_SIPAHI'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UU' AND Value = 1);	
------------------------------	
-- Unit_ClassUpgrades
------------------------------	
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_CAVALRY'
WHERE UnitType = 'UNIT_OTTOMAN_SIPAHI'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UU' AND Value = 1);	
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 					BuildingClass, Cost, Happiness,	FreshWater,	GreatPeopleRateModifier, FoodKept,	GoldMaintenance, PrereqTech,	Description, 					Civilopedia, 				Help, 								Strategy,								ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex,  IconAtlas)
SELECT	'BUILDING_JFD_HAMMAM',	BuildingClass, Cost, 1,			FreshWater,	GreatPeopleRateModifier, 10,		GoldMaintenance, PrereqTech,	'TXT_KEY_BUILDING_JFD_HAMMAM',	'TXT_KEY_JFD_HAMMAM_TEXT',	'TXT_KEY_BUILDING_JFD_HAMMAM_HELP', 'TXT_KEY_BUILDING_JFD_HAMMAM_STRATEGY',	ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 3, 			  'JFD_TURKS_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_GARDEN';	
------------------------------	
-- Building_Flavors
------------------------------	
INSERT INTO Building_Flavors 
		(BuildingType, 				FlavorType,			Flavor)
VALUES	('BUILDING_JFD_HAMMAM',		'FLAVOR_GROWTH',	15),
		('BUILDING_JFD_HAMMAM',		'FLAVOR_GOLD',		10),
		('BUILDING_JFD_HAMMAM',		'FLAVOR_RELIGION',	10);

INSERT INTO Building_Flavors 	
		(BuildingType, 			FlavorType, Flavor)
SELECT	'BUILDING_JFD_HAMMAM',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_GARDEN';
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leader_Flavors
--------------------------------			
UPDATE Leader_Flavors
SET Flavor = 7
WHERE LeaderType = 'LEADER_SULEIMAN' AND FlavorType IN ('FLAVOR_GOLD', 'FLAVOR_MILITARY_TRAINING')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UA' AND Value = 1);	

UPDATE Leader_Flavors
SET Flavor = 5
WHERE LeaderType = 'LEADER_SULEIMAN' AND FlavorType IN ('FLAVOR_NAVAL', 'FLAVOR_NAVAL_RECON')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UA' AND Value = 1);	
--------------------------------	
-- Leader_Traits
--------------------------------	
UPDATE Leader_Traits 
SET TraitType = 'TRAIT_JFD_OTTOMAN'
WHERE LeaderType = 'LEADER_SULEIMAN'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UA' AND Value = 1);	
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 						Description, 					ShortDescription)
SELECT	'TRAIT_JFD_OTTOMAN', 		'TXT_KEY_TRAIT_JFD_OTTOMAN', 	'TXT_KEY_TRAIT_JFD_OTTOMAN_SHORT'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UA' AND Value = 1);	
--------------------------------
--Civilization_FreePolicies
--------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_FreePolicies (
	CivilizationType  				text 	REFERENCES Civilizations(Type) 	default null,
	PolicyType						text 	REFERENCES Policies(Type) 		default null);	

INSERT INTO Civilization_FreePolicies
		(CivilizationType,			PolicyType)
SELECT	'CIVILIZATION_OTTOMAN',		'POLICY_JFD_OTTOMAN'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UA' AND Value = 1);	
------------------------------
-- Policies
------------------------------
INSERT INTO Policies
		(Type,						Description,					InternalTradeRouteYieldModifier)
SELECT	'POLICY_JFD_OTTOMAN',		'TXT_KEY_TRAIT_JFD_OTTOMAN',	33
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UA' AND Value = 1);	
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--------------------------------	
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 			BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_OTTOMAN', 	'BUILDINGCLASS_GARDEN',		'BUILDING_JFD_HAMMAM');
--==========================================================================================================================
--==========================================================================================================================