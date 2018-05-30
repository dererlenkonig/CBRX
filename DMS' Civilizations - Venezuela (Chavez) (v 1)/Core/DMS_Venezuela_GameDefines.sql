--==========================================================================================================================
-- BUILDINGCLASSES
--==========================================================================================================================
-- BuildingClasses
------------------------------
INSERT OR REPLACE INTO BuildingClasses 
		(DefaultBuilding, 								Type, 												Description)
VALUES	('BUILDING_DMS_COMMUNAL_COUNCIL_PRODUCTION',	'BUILDINGCLASS_DMS_COMMUNAL_COUNCIL_PRODUCTION', 	'TXT_KEY_BUILDING_DMS_COMMUNAL_COUNCIL_PRODUCTION'),
		('BUILDING_DMS_COMMUNAL_COUNCIL_COUNTER',		'BUILDINGCLASS_DMS_COMMUNAL_COUNCIL_COUNTER', 		'TXT_KEY_BUILDING_DMS_COMMUNAL_COUNCIL_COUNTER');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 									BuildingClass,	FreeStartEra,	Cost,	GoldMaintenance,	PrereqTech,	Description,								Civilopedia,								Help,											Strategy,											ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	ConquestProb,	HurryCostModifier,	AllowsProductionTradeRoutes,	IconAtlas,				PortraitIndex)
SELECT	('BUILDING_DMS_COMMUNAL_COUNCIL'),		BuildingClass,	FreeStartEra,	Cost,	GoldMaintenance,	PrereqTech,	('TXT_KEY_BUILDING_DMS_COMMUNAL_COUNCIL'),	('TXT_KEY_CIV5_DMS_COMMUNAL_COUNCIL_TEXT'),	('TXT_KEY_BUILDING_DMS_COMMUNAL_COUNCIL_HELP'),	('TXT_KEY_BUILDING_DMS_COMMUNAL_COUNCIL_STRATEGY'),	ArtDefineTag,	SpecialistType,	SpecialistCount,	MinAreaSize,	0,				HurryCostModifier,	AllowsProductionTradeRoutes,	'DMS_VENEZUELA_ATLAS',	2
FROM Buildings WHERE (Type = 'BUILDING_WORKSHOP');

INSERT INTO Buildings
		(Type, 						 					BuildingClass, 										Cost,	FaithCost,	GreatWorkSlotType,	GreatWorkCount,	PrereqTech,	MinAreaSize,	Description, 										Help,														ConquestProb,	IconAtlas,	PortraitIndex)
VALUES	('BUILDING_DMS_COMMUNAL_COUNCIL_PRODUCTION', 	'BUILDINGCLASS_DMS_COMMUNAL_COUNCIL_PRODUCTION',	-1,		-1,			NULL,				-1,				NULL,		-1,				'TXT_KEY_BUILDING_DMS_COMMUNAL_COUNCIL_PRODUCTION',	'TXT_KEY_BUILDING_DMS_COMMUNAL_COUNCIL_PRODUCTION_HELP',	0,				NULL,		-1),
		('BUILDING_DMS_COMMUNAL_COUNCIL_COUNTER', 		'BUILDINGCLASS_DMS_COMMUNAL_COUNCIL_COUNTER',		-1,		-1,			NULL,				-1,				NULL,		-1,				'TXT_KEY_BUILDING_DMS_COMMUNAL_COUNCIL_COUNTER',	'TXT_KEY_BUILDING_DMS_COMMUNAL_COUNCIL_COUNTER_HELP',		0,				NULL,		-1);
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 						FlavorType,			Flavor)
SELECT	('BUILDING_DMS_COMMUNAL_COUNCIL'),	FlavorType,			Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_WORKSHOP');

INSERT OR REPLACE INTO Building_Flavors 
		(BuildingType, 						FlavorType,			Flavor)
VALUES	('BUILDING_DMS_COMMUNAL_COUNCIL',	'FLAVOR_PRODUCTION',25),
		('BUILDING_DMS_COMMUNAL_COUNCIL',	'FLAVOR_CULTURE',	10);
------------------------------	
-- Building_YieldChanges
------------------------------		
INSERT INTO Building_YieldChanges 	
		(BuildingType, 						YieldType,		Yield)
SELECT	('BUILDING_DMS_COMMUNAL_COUNCIL'),	YieldType,		Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_WORKSHOP');

INSERT OR REPLACE INTO Building_YieldChanges 
		(BuildingType, 									YieldType, 			Yield)
VALUES	('BUILDING_DMS_COMMUNAL_COUNCIL_PRODUCTION',	'YIELD_PRODUCTION', 1);
------------------------------	
-- Building_YieldModifiers
------------------------------		
INSERT INTO Building_YieldModifiers 	
		(BuildingType, 						YieldType,		Yield)
SELECT	('BUILDING_DMS_COMMUNAL_COUNCIL'),	YieldType,		Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_WORKSHOP');
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 						Class, 	PrereqTech,	Combat,	Cost,	Moves,	CombatClass,	Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage,	IgnoreBuildingDefense, Mechanized,	AdvancedStartCost, GoodyHutUpgradeUnitClass,	XPValueAttack,	XPValueDefense, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,						PortraitIndex, 	IconAtlas,					MoveRate)
SELECT	('UNIT_DMS_VE_NILANGAL'),	Class,	PrereqTech,	45,		Cost,	Moves,	CombatClass,	Domain, DefaultUnitAI, ('TXT_KEY_UNIT_DMS_VE_NILANGAL'),	('TXT_KEY_CIV5_DMS_VE_NILANGAL_TEXT'),	('TXT_KEY_UNIT_DMS_VE_NILANGAL_STRATEGY'),	('TXT_KEY_UNIT_DMS_VE_NILANGAL_HELP'),	MilitarySupport, MilitaryProduction, Pillage,	IgnoreBuildingDefense, Mechanized,	AdvancedStartCost, GoodyHutUpgradeUnitClass,	XPValueAttack,	XPValueDefense, ('ART_DEF_UNIT_DMS_VE_NILANGAL'),	0,					('DMS_VE_NILANGAL_FLAG_ART_ATLAS'),	3, 				('DMS_VENEZUELA_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_TANK');
--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	('UNIT_DMS_VE_NILANGAL'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_TANK');
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	('UNIT_DMS_VE_NILANGAL'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_TANK');
--------------------------------
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType,			Flavor)
SELECT	('UNIT_DMS_VE_NILANGAL'), 	FlavorType,			Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_TANK');
--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	('UNIT_DMS_VE_NILANGAL'),	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_TANK');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	('UNIT_DMS_VE_NILANGAL'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_TANK');
--------------------------------
-- Unit_ResourceQuantityRequirements
--------------------------------	
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 					ResourceType)
SELECT	('UNIT_DMS_VE_NILANGAL'),	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_TANK');
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 							Description, 							Civilopedia, 									CivilopediaTag, 									ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_DMS_HUGO_CHAVEZ', 		'TXT_KEY_LEADER_DMS_HUGO_CHAVEZ', 		'TXT_KEY_LEADER_DMS_HUGO_CHAVEZ_PEDIA', 		'TXT_KEY_CIVILOPEDIA_LEADERS_DMS_HUGO_CHAVEZ',		'HugoChavez_Diplo.xml',		7, 						4, 						7, 							6, 			5, 				3, 				12, 					7, 				4, 			7, 			6, 				5, 			8, 			'DMS_VENEZUELA_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_HUGO_CHAVEZ', 		'MAJOR_CIV_APPROACH_WAR', 			6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MAJOR_CIV_APPROACH_HOSTILE', 		7),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MAJOR_CIV_APPROACH_GUARDED', 		5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MAJOR_CIV_APPROACH_AFRAID', 		6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 					MinorCivApproachType, 				Bias)
VALUES	('LEADER_DMS_HUGO_CHAVEZ', 		'MINOR_CIV_APPROACH_IGNORE', 		2),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MINOR_CIV_APPROACH_FRIENDLY', 		8),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MINOR_CIV_APPROACH_PROTECTIVE', 	8),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MINOR_CIV_APPROACH_CONQUEST', 		8),
		('LEADER_DMS_HUGO_CHAVEZ', 		'MINOR_CIV_APPROACH_BULLY', 		8);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 					FlavorType, 						Flavor)
VALUES	('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_OFFENSE', 					6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_DEFENSE', 					7),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_CITY_DEFENSE', 				7),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_MILITARY_TRAINING', 		6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_RECON', 					7),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_RANGED', 					6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_MOBILE', 					5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_NAVAL', 					5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_NAVAL_RECON', 				5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_NAVAL_GROWTH', 				5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_AIR', 						6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_EXPANSION', 				8),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_GROWTH', 					5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_PRODUCTION', 				9),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_GOLD', 						6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_SCIENCE', 					6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_CULTURE', 					7),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_HAPPINESS', 				5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_GREAT_PEOPLE', 				4),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_WONDER', 					4),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_RELIGION', 					5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_DIPLOMACY', 				7),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_SPACESHIP', 				6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_NUKE', 						7),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_USE_NUKE', 					7),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_ESPIONAGE', 				7),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_AIRLIFT', 					6),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_DMS_HUGO_CHAVEZ', 		'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 						TraitType)
VALUES	('LEADER_DMS_HUGO_CHAVEZ', 			'TRAIT_DMS_BOLIVARIAN_SOCIALISM');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 								Description, 									ShortDescription)
VALUES	('TRAIT_DMS_BOLIVARIAN_SOCIALISM', 	'TXT_KEY_TRAIT_DMS_BOLIVARIAN_SOCIALISM',		'TXT_KEY_TRAIT_DMS_BOLIVARIAN_SOCIALISM_SHORT');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 
		(Type, 								Description, 								ShortDescription,								Adjective,											CivilopediaTag,											DefaultPlayerColor,				ArtDefineTag,	ArtStyleType,	ArtStyleSuffix,	ArtStylePrefix,	PortraitIndex,	IconAtlas,					AlphaIconAtlas,					SoundtrackTag,		MapImage,					DawnOfManQuote,								DawnOfManImage)
SELECT	('CIVILIZATION_DMS_VENEZUELA'), 	('TXT_KEY_CIVILIZATION_DMS_VENEZUELA'), 	('TXT_KEY_CIVILIZATION_DMS_VENEZUELA_SHORT'),	('TXT_KEY_CIVILIZATION_DMS_VENEZUELA_ADJECTIVE'),	('TXT_KEY_CIVILOPEDIA_CIVILIZATIONS_DMS_VENEZUELA'),	('PLAYERCOLOR_DMS_VENEZUELA'),	ArtDefineTag,	ArtStyleType,	ArtStyleSuffix,	ArtStylePrefix,	0,				('DMS_VENEZUELA_ATLAS'),	('DMS_VENEZUELA_ALPHA_ATLAS'),	('Brazil'), 		('Venezuela_Map512.dds'),	('TXT_KEY_CIV5_DAWN_DMS_VENEZUELA_TEXT'),	('HugoChavez_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_BRAZIL');
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
        (CivilizationType,				CityName)
VALUES	('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_1'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_2'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_3'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_4'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_5'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_6'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_7'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_8'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_9'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_10'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_11'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_12'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_13'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_14'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_15'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_16'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_17'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_18'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_19'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_20'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_21'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_22'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_23'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_24'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_25'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_26'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_27'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_28'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_29'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_30'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_31'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_32'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_33'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_34'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_35'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_36'),
        ('CIVILIZATION_DMS_VENEZUELA',   'TXT_KEY_CITY_NAME_CIVILIZATION_DMS_VENEZUELA_37');			
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 				BuildingClassType)
SELECT	('CIVILIZATION_DMS_VENEZUELA'),	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');
--------------------------------	
-- Civilization_FreeTechs
--------------------------------		
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 				TechType)
SELECT	('CIVILIZATION_DMS_VENEZUELA'),	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT	('CIVILIZATION_DMS_VENEZUELA'),	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_BRAZIL');
--------------------------------	
-- Civilization_Leaders
--------------------------------
INSERT INTO Civilization_Leaders 
		(CivilizationType, 				LeaderheadType)
VALUES	('CIVILIZATION_DMS_VENEZUELA',	'LEADER_DMS_HUGO_CHAVEZ');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 				UnitClassType, 				UnitType)
VALUES	('CIVILIZATION_DMS_VENEZUELA', 	'UNITCLASS_TANK',		'UNIT_DMS_VE_NILANGAL');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_DMS_VENEZUELA', 	'BUILDINGCLASS_WORKSHOP', 	'BUILDING_DMS_COMMUNAL_COUNCIL');
--------------------------------	
-- Civilization_Religions
--------------------------------		
INSERT INTO Civilization_Religions 
		(CivilizationType, 				ReligionType)
VALUES	('CIVILIZATION_DMS_VENEZUELA', 	'RELIGION_CHRISTIANITY');
--------------------------------	
-- Civilization_SpyNames
--------------------------------
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 				SpyName)
VALUES	('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_0'),	
		('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_1'),
		('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_2'),
		('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_3'),
		('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_4'),
		('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_5'),
		('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_6'),
		('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_7'),
		('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_8'),
		('CIVILIZATION_DMS_VENEZUELA', 	'TXT_KEY_SPY_NAME_DMS_VENEZUELA_9');
--==========================================================================================================================
-- Civilization_Start_Region_Priority
--==========================================================================================================================
INSERT INTO Civilization_Start_Along_Ocean 
		(CivilizationType, 				StartAlongOcean)
VALUES	('CIVILIZATION_DMS_VENEZUELA', 	1);	
--==========================================================================================================================
--==========================================================================================================================