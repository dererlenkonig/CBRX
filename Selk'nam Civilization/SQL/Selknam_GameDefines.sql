

--------------------------------
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT	'UNIT_KMAL', 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SPEARMAN');	

--------------------------------
-- Unit_AITypes
--------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 						UnitAIType)
SELECT	'UNIT_KMAL', 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SPEARMAN');

--------------------------------	
-- Unit_ResourceQuantityRequirements
--------------------------------	
INSERT INTO Unit_ResourceQuantityRequirements 	
		(UnitType, 						ResourceType,	Cost)
SELECT	'UNIT_KMAL', 		ResourceType,	1
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_SPEARMAN');

--------------------------------
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 						UnitClassType)
SELECT	'UNIT_KMAL', 		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_SPEARMAN');

--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 						FlavorType, Flavor)
SELECT	'UNIT_KMAL', 		FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SPEARMAN');

--------------------------------
-- Unit_FreePromotions
--------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 						PromotionType)
SELECT	'UNIT_KMAL', 		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_SPEARMAN');

INSERT INTO Unit_FreePromotions 	
		(UnitType, 						PromotionType)
VALUES	('UNIT_KMAL', 		'PROMOTION_CAN_MOVE_AFTER_ATTACKING');


--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 									Description, 							Civilopedia, 								 CivilopediaTag, 										ArtDefineTag, 							VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES	('LEADER_XOON', 			'TXT_KEY_LEADER_XOON',	'TXT_KEY_LEADER_XOON_PEDIA',	 'TXT_KEY_CIVILOPEDIA_LEADERS_XOON', 	'XoonScene.xml',	5, 						2, 						6, 							6, 			5, 				7, 				6, 						6, 				6, 			2, 			2, 				4, 			5, 			'SELKNAM_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 							MajorCivApproachType, 				Bias)
VALUES	('LEADER_XOON', 			'MAJOR_CIV_APPROACH_WAR', 			5),
		('LEADER_XOON', 			'MAJOR_CIV_APPROACH_HOSTILE', 		7),
		('LEADER_XOON', 			'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
		('LEADER_XOON', 			'MAJOR_CIV_APPROACH_GUARDED', 		6),
		('LEADER_XOON', 			'MAJOR_CIV_APPROACH_AFRAID', 		2),
		('LEADER_XOON', 			'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_XOON', 			'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------								
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 							MinorCivApproachType, 				Bias)
VALUES	('LEADER_XOON', 			'MINOR_CIV_APPROACH_IGNORE', 		2),
		('LEADER_XOON', 			'MINOR_CIV_APPROACH_FRIENDLY', 		6),
		('LEADER_XOON', 			'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
		('LEADER_XOON', 			'MINOR_CIV_APPROACH_CONQUEST', 		7),
		('LEADER_XOON', 			'MINOR_CIV_APPROACH_BULLY', 		4);
--------------------------------		
-- Leader_Flavors
--------------------------------									
INSERT INTO Leader_Flavors 
		(LeaderType, 							FlavorType, 						Flavor)
VALUES	('LEADER_XOON', 			'FLAVOR_OFFENSE', 					5),
		('LEADER_XOON', 			'FLAVOR_DEFENSE', 					8),
		('LEADER_XOON', 			'FLAVOR_CITY_DEFENSE', 				7),
		('LEADER_XOON', 			'FLAVOR_MILITARY_TRAINING', 		6),
		('LEADER_XOON', 			'FLAVOR_RECON', 					7),
		('LEADER_XOON', 			'FLAVOR_RANGED', 					3),
		('LEADER_XOON', 			'FLAVOR_MOBILE', 					7),
		('LEADER_XOON', 			'FLAVOR_NAVAL', 					5),
		('LEADER_XOON', 			'FLAVOR_NAVAL_RECON', 				3),
		('LEADER_XOON', 			'FLAVOR_NAVAL_GROWTH', 				3),
		('LEADER_XOON', 			'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
		('LEADER_XOON', 			'FLAVOR_AIR', 						6),
		('LEADER_XOON', 			'FLAVOR_EXPANSION', 				6),
		('LEADER_XOON', 			'FLAVOR_GROWTH', 					5),
		('LEADER_XOON', 			'FLAVOR_TILE_IMPROVEMENT', 			5),
		('LEADER_XOON', 			'FLAVOR_INFRASTRUCTURE', 			5),
		('LEADER_XOON', 			'FLAVOR_PRODUCTION', 				5),
		('LEADER_XOON', 			'FLAVOR_GOLD', 						3),
		('LEADER_XOON', 			'FLAVOR_SCIENCE', 					4),
		('LEADER_XOON', 			'FLAVOR_CULTURE', 					8),
		('LEADER_XOON', 			'FLAVOR_HAPPINESS', 				4),
		('LEADER_XOON', 			'FLAVOR_GREAT_PEOPLE', 				7),
		('LEADER_XOON', 			'FLAVOR_WONDER', 					3),
		('LEADER_XOON', 			'FLAVOR_RELIGION', 					7),
		('LEADER_XOON', 			'FLAVOR_DIPLOMACY', 				4),
		('LEADER_XOON', 			'FLAVOR_SPACESHIP', 				3),
		('LEADER_XOON', 			'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_XOON', 			'FLAVOR_NUKE', 						5),
		('LEADER_XOON', 			'FLAVOR_USE_NUKE', 					3),
		('LEADER_XOON', 			'FLAVOR_ESPIONAGE', 				3),
		('LEADER_XOON', 			'FLAVOR_AIRLIFT', 					6),
		('LEADER_XOON', 			'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_XOON', 			'FLAVOR_I_TRADE_ORIGIN', 			7),
		('LEADER_XOON', 			'FLAVOR_I_SEA_TRADE_ROUTE', 		3),
		('LEADER_XOON', 			'FLAVOR_I_LAND_TRADE_ROUTE', 		7),
		('LEADER_XOON', 			'FLAVOR_ARCHAEOLOGY', 				4),
		('LEADER_XOON', 			'FLAVOR_AIR_CARRIER', 				3);
--------------------------------		
-- Leader_Traits
--------------------------------		
INSERT INTO Leader_Traits 
		(LeaderType, 							TraitType)
VALUES	('LEADER_XOON', 			'TRAIT_HOOWIN');
--==========================================================================================================================	

--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 							CityName)
VALUES	('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_0'),
        ('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_1'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_2'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_3'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_4'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_5'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_6'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_7'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_8'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_9'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_10'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_11'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_12'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_13'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_14'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_15'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_16'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_17'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_18'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_19'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_20'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_21'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_22'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_23'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_24'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_25'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_26'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_27'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_28'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_29'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_30'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_31'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_32'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_33'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_34'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_CITY_NAME_SELKNAM_35');
	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 							BuildingClassType)
VALUES	('CIVILIZATION_SELKNAM',  'BUILDINGCLASS_PALACE'),
        ('CIVILIZATION_SELKNAM',  'BUILDINGCLASS_TUNDRA_BONUS');
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 							TechType)
SELECT	'CIVILIZATION_SELKNAM', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_INCA';
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_SELKNAM', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_INCA';
--------------------------------	
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 							LeaderheadType)
VALUES	('CIVILIZATION_SELKNAM',	'LEADER_XOON');
--------------------------------	
-- Civilization_ClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 							UnitClassType, 				UnitType)
VALUES	('CIVILIZATION_SELKNAM', 	'UNITCLASS_SPEARMAN',		'UNIT_KMAL'),
		('CIVILIZATION_SELKNAM', 'UNITCLASS_ARTIST', 'UNIT_HAALCHIN');
INSERT INTO Civilization_BuildingClassOverrides
        (CivilizationType,                  BuildingClassType,             BuildingType)
VALUES  ('CIVILIZATION_SELKNAM', 'BUILDINGCLASS_SHRINE', 'BUILDING_HAIN_HUT'),
        ('CIVILIZATION_SELKNAM', 'BUILDINGCLASS_MARKET', 'BUILDING_SELKNAM_MARKET');

         
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 							ReligionType)
VALUES	('CIVILIZATION_SELKNAM', 	'RELIGION_CHRISTIANITY');
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 							SpyName)
VALUES	('CIVILIZATION_SELKNAM', 	'TXT_KEY_SPY_NAME_SELKNAM_1'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_SPY_NAME_SELKNAM_2'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_SPY_NAME_SELKNAM_3'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_SPY_NAME_SELKNAM_4'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_SPY_NAME_SELKNAM_5'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_SPY_NAME_SELKNAM_6'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_SPY_NAME_SELKNAM_7'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_SPY_NAME_SELKNAM_8'),
		('CIVILIZATION_SELKNAM', 	'TXT_KEY_SPY_NAME_SELKNAM_9');
--==========================================================================================================================
--==========================================================================================================================
INSERT INTO Units
(Type, 								Class, Cost,  Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI, WorkRate, CombatLimit, GoldenAgeTurns, MoveRate, Description, 						Civilopedia, 						Strategy,									Help,								AdvancedStartCost,	UnitArtInfo, UnitFlagIconOffset, UnitFlagAtlas,	PortraitIndex, 	IconAtlas)
SELECT		'UNIT_HAALCHIN',	Class, Cost,  Moves, CivilianAttackPriority, Special, Domain, DefaultUnitAI, WorkRate, CombatLimit, GoldenAgeTurns+3, MoveRate, ('TXT_KEY_UNIT_HAALCHIN'), 	('TXT_KEY_CIV5_UNIT_HAALCHIN'), ('TXT_KEY_UNIT_HAALCHIN_STRATEGY'), 	('TXT_KEY_UNIT_HAALCHIN_HELP'),AdvancedStartCost, 	'ART_DEF_UNIT_HAALCHIN', 0, 'Haalchinalpha',	5, 	'SELKNAM_ATLAS'
FROM Units WHERE (Type = 'UNIT_ARTIST');

--Unit Defines
INSERT INTO UnitGameplay2DScripts
		(UnitType, 				SelectionSound,	FirstSelectionSound)
SELECT	'UNIT_HAALCHIN',	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_ARTIST');
INSERT INTO Unit_AITypes
		(UnitType,				UnitAIType)
SELECT	'UNIT_HAALCHIN', 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_ARTIST');
INSERT INTO Unit_Flavors
		(UnitType, 				FlavorType,	Flavor)
VALUES	('UNIT_HAALCHIN',	'FLAVOR_CULTURE', 	5);

--Unit Unique Names

INSERT INTO GreatWorks
		(Type,						Description,						GreatWorkClassType,	Image,						Audio,						 ArchaeologyOnly)
VALUES	('GREAT_WORK_HAWITPIN',	'TXT_KEY_GREAT_WORK_HAWITPIN',		'GREAT_WORK_ART',	'Hawitpin.dds',	'AS2D_GREAT_ARTIST_ARTWORK', 0),
		('GREAT_WORK_HOORN',	'TXT_KEY_GREAT_WORK_HOORN',	'GREAT_WORK_ART',	'hoorn.dds',		'AS2D_GREAT_ARTIST_ARTWORK', 0),
		('GREAT_WORK_PAAUTIN', 'TXT_KEY_GREAT_WORK_PAAUTIN', 	'GREAT_WORK_ART',	'Paautin.dds',	'AS2D_GREAT_ARTIST_ARTWORK', 0),
		('GREAT_WORK_SOLJEN',	'TXT_KEY_GREAT_WORK_SOLJEN',	'GREAT_WORK_ART',	'soljen.dds','AS2D_GREAT_ARTIST_ARTWORK', 0),
		('GREAT_WORK_SORREN','TXT_KEY_GREAT_WORK_SORREN', 'GREAT_WORK_ART',	'sorren.dds',		'AS2D_GREAT_ARTIST_ARTWORK', 0),
		('GREAT_WORK_ULICHEN','TXT_KEY_GREAT_WORK_ULICHEN', 'GREAT_WORK_ART',	'ulichen.dds', 'AS2D_GREAT_ARTIST_ARTWORK', 0),
		('GREAT_WORK_KINA','TXT_KEY_GREAT_WORK_KINA', 'GREAT_WORK_ART',	'Bark Mask.dds', 'AS2D_GREAT_ARTIST_ARTWORK', 0);
INSERT INTO Unit_UniqueNames
		(UnitType,				UniqueName,								GreatWorkType)
VALUES	('UNIT_HAALCHIN',	'TXT_KEY_HAWITPIN',		'GREAT_WORK_HAWITPIN'),
		('UNIT_HAALCHIN',	'TXT_KEY_HOORN',		'GREAT_WORK_HOORN'),
		('UNIT_HAALCHIN',	'TXT_KEY_PAAUTIN',		'GREAT_WORK_PAAUTIN'),
		('UNIT_HAALCHIN',	'TXT_KEY_SOLJEN',		'GREAT_WORK_SOLJEN'),
		('UNIT_HAALCHIN',	'TXT_KEY_SORREN',	'GREAT_WORK_SORREN'),
		('UNIT_HAALCHIN',	'TXT_KEY_ULICHEN', 	'GREAT_WORK_ULICHEN'),
		('UNIT_HAALCHIN',	'TXT_KEY_KINA', 	'GREAT_WORK_KINA');
		