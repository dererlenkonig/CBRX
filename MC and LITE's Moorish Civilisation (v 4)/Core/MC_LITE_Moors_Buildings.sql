--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================			
INSERT OR REPLACE INTO BuildingClasses 
			(DefaultBuilding, 					Type, 									Description)
VALUES		('BUILDING_MC_LITE_AL_ANDALUS', 	'BUILDINGCLASS_MC_LITE_AL_ANDALUS', 	'TXT_KEY_BUILDING_MC_LITE_AL_ANDALUS'),
			('BUILDING_MC_LITE_ALCAZAR_DUMMY', 	'BUILDINGCLASS_MC_LITE_ALCAZAR_DUMMY', 	'TXT_KEY_BUILDING_MC_LITE_ALCAZAR_DUMMY');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT OR REPLACE INTO Buildings 
			(Type, 								BuildingClass, 							GreatWorkCount, Cost, 	FaithCost,	GoldMaintenance,	PrereqTech, NeverCapture,	Description, 								Help,												PortraitIndex, 	IconAtlas)							
VALUES		('BUILDING_MC_LITE_AL_ANDALUS', 	'BUILDINGCLASS_MC_LITE_AL_ANDALUS',		-1,				-1, 	-1,			0,					NULL, 		1,				'TXT_KEY_BUILDING_MC_LITE_AL_ANDALUS',		'TXT_KEY_BUILDING_MC_LITE_AL_ANDALUS_HELP',			5,				'MC_LITE_MOORS_ATLAS'),
			('BUILDING_MC_LITE_ALCAZAR_DUMMY', 	'BUILDINGCLASS_MC_LITE_ALCAZAR_DUMMY',	-1,				-1, 	-1,			0,					NULL, 		1,				'TXT_KEY_BUILDING_MC_LITE_ALCAZAR_DUMMY',	'TXT_KEY_BUILDING_MC_LITE_ALCAZAR_DUMMY_HELP',		3,				'MC_LITE_MOORS_ATLAS');

INSERT INTO Buildings 	
			(Type, 							BuildingClass, Cost, SpecialistType, SpecialistCount, TradeRouteRecipientBonus, TradeRouteTargetBonus, GoldMaintenance, PrereqTech,	Description, 						Civilopedia, 						Help, 									Strategy,								 					ArtDefineTag, 	MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_MC_LITE_ALCAZAR'),	BuildingClass, Cost, SpecialistType, SpecialistCount, TradeRouteRecipientBonus, TradeRouteTargetBonus, GoldMaintenance, PrereqTech,	('TXT_KEY_BUILDING_MC_LITE_ALCAZAR'),	('TXT_KEY_CIV5_MC_LITE_ALCAZAR_TEXT'), 	('TXT_KEY_BUILDING_MC_LITE_ALCAZAR_HELP'), 	('TXT_KEY_BUILDING_MC_LITE_ALCAZAR_STRATEGY'),	ArtDefineTag,	MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 3, 				('MC_LITE_MOORS_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_UNIVERSITY');

UPDATE Buildings
	SET BuildingProductionModifier = 5 --, WonderProductionModifier = 5
	WHERE Type = 'BUILDING_MC_LITE_AL_ANDALUS';
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================	
INSERT INTO Building_Flavors 	
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_MC_LITE_ALCAZAR'),	FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_UNIVERSITY');
--==========================================================================================================================	
-- Building_ClassesNeededInCity
--==========================================================================================================================	
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 				BuildingClassType)
SELECT		('BUILDING_MC_LITE_ALCAZAR'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_UNIVERSITY');	
--==========================================================================================================================	
-- Building_YieldModifiers
--==========================================================================================================================	
INSERT INTO Building_YieldModifiers 	
			(BuildingType, 				YieldType, Yield)
SELECT		('BUILDING_MC_LITE_ALCAZAR'),	YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_UNIVERSITY');
--==========================================================================================================================
-- Building_FeatureYieldChanges
--==========================================================================================================================
INSERT INTO Building_FeatureYieldChanges 	
			(BuildingType, 								FeatureType,				YieldType, 		Yield)
SELECT		('BUILDING_MC_LITE_ALCAZAR'),				FeatureType,				YieldType,		Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================	
INSERT INTO Building_YieldChanges 	
			(BuildingType, 					YieldType, Yield)
SELECT		('BUILDING_MC_LITE_ALCAZAR'),	YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

INSERT INTO Building_YieldChanges 
			(BuildingType, 						YieldType, 		Yield)
VALUES		('BUILDING_MC_LITE_ALCAZAR_DUMMY',	'YIELD_FAITH',	1);
--==========================================================================================================================	
--==========================================================================================================================	