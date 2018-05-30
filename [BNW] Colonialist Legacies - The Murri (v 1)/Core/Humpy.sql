--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 						TradeRouteLandDistanceModifier, TradeRouteLandGoldBonus, BuildingClass, PrereqTech,			Cost, GoldMaintenance, MinAreaSize, Description, 					Civilopedia, 					Help, 								Strategy,							ArtDefineTag, PortraitIndex, IconAtlas)
SELECT	'BUILDING_CL_HUMPY',		TradeRouteLandDistanceModifier, TradeRouteLandGoldBonus, BuildingClass, 'TECH_THE_WHEEL',	Cost, GoldMaintenance, MinAreaSize, ('TXT_KEY_BUILDING_CL_HUMPY'), 	('TXT_KEY_CIV5_CL_HUMPY_TEXT'),	('TXT_KEY_BUILDING_CL_HUMPY_HELP'), ('TXT_KEY_BUILDING_CL_HUMPY_STRATEGY'),	ArtDefineTag, 3, 			 ('CL_MURRI_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_CARAVANSARY';	
------------------------------	
-- Building_YieldChanges
------------------------------	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType,		Yield)
SELECT	'BUILDING_CL_HUMPY',		YieldType,		Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_CARAVANSARY';
------------------------------	
-- Building_Flavors
------------------------------	
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType,		Flavor)
SELECT	'BUILDING_CL_HUMPY',		FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CARAVANSARY';

INSERT INTO Building_Flavors
		(BuildingType,				FlavorType,				Flavor)
VALUES	('BUILDING_CL_HUMPY',		'FLAVOR_EXPANSION',		20),
		('BUILDING_CL_HUMPY',		'FLAVOR_RELIGION',		10);