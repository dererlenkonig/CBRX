--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 										Description, 									Help, 													Sound, 				CannotBeChosen, 	IgnoreZOC,  LostWithUpgrade, 	GoldenAgeValueFromKills,	NearbyEnemyCombatMod,	NearbyEnemyCombatRange,	AdjacentMod,	PortraitIndex, 	IconAtlas, 						PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_DEATHS_HEAD', 				'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD', 			'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_HELP', 				'AS2D_IF_LEVELUP', 	1, 					1, 			1, 					0,							-10,					2,						0,				59, 			'ABILITY_ATLAS', 				'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD'),
		('PROMOTION_JFD_DEATHS_HEAD_BLACK_DUKE',	'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_BLACK_DUKE', 'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_BLACK_DUKE_HELP', 	'AS2D_IF_LEVELUP', 	1, 					0, 			1, 					0,							0,						0,						0,				59, 			'ABILITY_ATLAS', 				'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_BLACK_DUKE'),
		('PROMOTION_JFD_LANDWEHR', 					'TXT_KEY_PROMOTION_JFD_LANDWEHR', 				'TXT_KEY_PROMOTION_JFD_LANDWEHR_HELP',					'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					0, 							0,						0,						15,				59, 			'ABILITY_ATLAS', 				'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_LANDWEHR'),
		('PROMOTION_JFD_LANDWEHR_DOUBLE', 			'TXT_KEY_PROMOTION_JFD_LANDWEHR', 				'TXT_KEY_PROMOTION_JFD_LANDWEHR_DOUBLE_HELP',			'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					0, 							0,						0,						30,				0, 				'JFD_PRUSSIA_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_LANDWEHR'),
		('PROMOTION_JFD_PRUSSIAN_VETERAN_5', 		'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_5', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_HELP', 			'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					20,							0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_5'),
		('PROMOTION_JFD_PRUSSIAN_VETERAN_4', 		'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_4', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_HELP', 			'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					20,							0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_4'),
		('PROMOTION_JFD_PRUSSIAN_VETERAN_3', 		'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_3', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_HELP', 			'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					20,							0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_3'),
		('PROMOTION_JFD_PRUSSIAN_VETERAN_2', 		'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_2', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_HELP', 			'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					20,							0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_2'),
		('PROMOTION_JFD_PRUSSIAN_VETERAN_1', 		'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_1', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_HELP', 			'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					20,							0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_1');
--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 						Class, PrereqTech, Combat, Cost, FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,						PortraitIndex, 	IconAtlas,				MoveRate)
SELECT	'UNIT_JFD_DEATHS_HEAD',		Class, PrereqTech, Combat, Cost, FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_DEATHS_HEAD', 	'TXT_KEY_CIV5_JFD_DEATHS_HEAD_TEXT', 	'TXT_KEY_UNIT_JFD_DEATHS_HEAD_STRATEGY', 	'TXT_KEY_UNIT_HELP_JFD_DEATHS_HEAD', 	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, 'ART_DEF_UNIT_JFD_DEATHS_HEAD',	0,					'JFD_UNIT_FLAG_DEATHS_HEAD_ATLAS',	3, 				'JFD_PRUSSIA_ATLAS',	MoveRate
FROM Units WHERE Type = 'UNIT_CAVALRY';
	
INSERT INTO Units 	
		(Type, 						Class, PrereqTech, Combat, Cost, FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT	'UNIT_JFD_LANDWEHR', 		Class, PrereqTech, Combat, Cost, FaithCost,	RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, 'TXT_KEY_UNIT_JFD_LANDWEHR', 		'TXT_KEY_CIV5_JFD_LANDWEHR_TEXT', 		'TXT_KEY_UNIT_JFD_LANDWEHR_STRATEGY', 		'TXT_KEY_UNIT_HELP_JFD_LANDWEHR',		MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, 'ART_DEF_UNIT_JFD_LANDWEHR',		0,					'JFD_UNIT_FLAG_LANDWEHR_ATLAS',		2, 				'JFD_PRUSSIA_ATLAS'
FROM Units WHERE Type = 'UNIT_RIFLEMAN';
--------------------------------	
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_DEATHS_HEAD', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_CAVALRY';	
	
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_LANDWEHR', 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_RIFLEMAN';
--------------------------------		
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_JFD_DEATHS_HEAD', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_CAVALRY';	
	
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_JFD_LANDWEHR',		UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_RIFLEMAN';	
--------------------------------	
-- Unit_ClassUpgrades
--------------------------------		
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_JFD_DEATHS_HEAD', 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_CAVALRY';

INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 					UnitClassType)
SELECT	'UNIT_JFD_LANDWEHR',		UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_RIFLEMAN';
--------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------		
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 					ResourceType)
SELECT	'UNIT_JFD_DEATHS_HEAD', 	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE UnitType = 'UNIT_CAVALRY';
--------------------------------	
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_JFD_DEATHS_HEAD',		FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_CAVALRY';

INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_JFD_LANDWEHR', 		FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_RIFLEMAN';	
--------------------------------
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	'UNIT_JFD_DEATHS_HEAD',		PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_CAVALRY';

INSERT INTO Unit_FreePromotions 
		(UnitType, 					PromotionType)
VALUES	('UNIT_JFD_DEATHS_HEAD', 	'PROMOTION_JFD_DEATHS_HEAD'),
		('UNIT_JFD_DEATHS_HEAD', 	'PROMOTION_JFD_DEATHS_HEAD_BLACK_DUKE'),
		('UNIT_JFD_LANDWEHR', 		'PROMOTION_JFD_LANDWEHR');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 						Description, 							Civilopedia, 							CivilopediaTag, 								ArtDefineTag, 						VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_JFD_FREDERICK', 	'TXT_KEY_LEADER_JFD_FREDERICK_DESC', 	'TXT_KEY_LEADER_JFD_FREDERICK_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_FREDERICK', 	'Janboruta_Frederick_Scene.xml',	9, 						8, 						6, 							7, 			8, 				6, 				4, 						7, 				8, 			5, 			5, 				4, 			3, 			'JFD_PRUSSIA_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_FREDERICK', 	'MAJOR_CIV_APPROACH_WAR', 			4),
		('LEADER_JFD_FREDERICK', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_JFD_FREDERICK', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
		('LEADER_JFD_FREDERICK', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
		('LEADER_JFD_FREDERICK', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
		('LEADER_JFD_FREDERICK', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
		('LEADER_JFD_FREDERICK', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		8);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_FREDERICK', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
		('LEADER_JFD_FREDERICK', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_JFD_FREDERICK', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
		('LEADER_JFD_FREDERICK', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
		('LEADER_JFD_FREDERICK', 	'MINOR_CIV_APPROACH_BULLY', 		4);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 				FlavorType, 						Flavor)
VALUES	('LEADER_JFD_FREDERICK', 	'FLAVOR_OFFENSE', 					9),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_DEFENSE', 					5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_MILITARY_TRAINING', 		9),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_RECON', 					6),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_RANGED', 					4),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_MOBILE', 					7),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_NAVAL', 					4),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_NAVAL_RECON', 				4),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_NAVAL_GROWTH', 				4),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_AIR', 						5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_EXPANSION', 				7),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_GROWTH', 					6),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_INFRASTRUCTURE', 			4),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_PRODUCTION', 				6),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_GOLD', 						6),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_SCIENCE', 					5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_CULTURE', 					5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_GREAT_PEOPLE', 				6),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_WONDER', 					6),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_RELIGION', 					4),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_DIPLOMACY', 				8),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_SPACESHIP', 				4),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_ESPIONAGE', 				5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_AIRLIFT', 					2),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_FREDERICK', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 				TraitType)
VALUES	('LEADER_JFD_FREDERICK', 	'TRAIT_JFD_PRUSSIA');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 						Description, 						ShortDescription)
VALUES	('TRAIT_JFD_PRUSSIA', 		'TXT_KEY_TRAIT_JFD_PRUSSIA', 		'TXT_KEY_TRAIT_JFD_PRUSSIA_SHORT');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 						DerivativeCiv,			Description, 					ShortDescription, 						Adjective, 								Civilopedia, 						CivilopediaTag, 			DefaultPlayerColor, 		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 						DawnOfManQuote, 						DawnOfManImage)
SELECT	'CIVILIZATION_JFD_PRUSSIA',	'CIVILIZATION_GERMANY',	'TXT_KEY_CIV_JFD_PRUSSIA_DESC', 'TXT_KEY_CIV_JFD_PRUSSIA_SHORT_DESC', 	'TXT_KEY_CIV_JFD_PRUSSIA_ADJECTIVE', 	'TXT_KEY_CIV5_JFD_PRUSSIA_TEXT_1', 	'TXT_KEY_CIV5_JFD_PRUSSIA', 'PLAYERCOLOR_JFD_PRUSSIA', 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_PRUSSIA_ATLAS', 	0, 				'JFD_PRUSSIA_ALPHA_ATLAS', 	'Germany', 		'Janboruta_MapPrussia512.dds', 	'TXT_KEY_CIV5_DOM_JFD_FREDERICK_TEXT', 	'Janboruta_Frederick_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_GERMANY';
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 				CityName)
VALUES	('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_01'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_02'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_03'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_04'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_05'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_06'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_07'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_08'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_09'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_10'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_11'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_12'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_13'),	
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_14'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_15'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_16'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_17'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_18'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_19'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_20'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_21'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_22'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_23'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_24'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_25'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_26'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_27'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_28'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_29'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_30'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_31'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_32'),
		('CIVILIZATION_JFD_PRUSSIA',	'TXT_KEY_CITY_NAME_JFD_PRUSSIA_33');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 				BuildingClassType)
SELECT	'CIVILIZATION_JFD_PRUSSIA', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_GERMANY';
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 				TechType)
SELECT	'CIVILIZATION_JFD_PRUSSIA', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_GERMANY';
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_PRUSSIA', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_GERMANY';
--------------------------------	
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 				LeaderheadType)
VALUES	('CIVILIZATION_JFD_PRUSSIA', 	'LEADER_JFD_FREDERICK');	
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 				UnitClassType, 			UnitType)
VALUES	('CIVILIZATION_JFD_PRUSSIA', 	'UNITCLASS_CAVALRY', 	'UNIT_JFD_DEATHS_HEAD'),
		('CIVILIZATION_JFD_PRUSSIA', 	'UNITCLASS_RIFLEMAN', 	'UNIT_JFD_LANDWEHR');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 				ReligionType)
SELECT	'CIVILIZATION_JFD_PRUSSIA', 	ReligionType			
FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_GERMANY';	
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 				SpyName)
VALUES	('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_0'),	
		('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_1'),
		('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_2'),
		('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_3'),
		('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_4'),
		('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_5'),
		('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_6'),
		('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_7'),
		('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_8'),
		('CIVILIZATION_JFD_PRUSSIA', 	'TXT_KEY_SPY_NAME_JFD_PRUSSIA_9');
--==========================================================================================================================
--==========================================================================================================================