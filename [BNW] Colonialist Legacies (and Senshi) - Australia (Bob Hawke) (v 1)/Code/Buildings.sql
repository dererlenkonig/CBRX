--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 						FreeStartEra, BuildingClass, PrereqTech,				 EnhancedYieldTech,	Cost, FaithCost, UnlockedByBelief, SpecialistType, SpecialistCount, GoldMaintenance, MinAreaSize, ConquestProb, Description, 							Civilopedia, 								Help, 										 Strategy,											ArtDefineTag, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_SENSHI_CSIRO'),	FreeStartEra, BuildingClass, ('TECH_REPLACEABLE_PARTS'), ('TECH_INTERNET'),	Cost, FaithCost, UnlockedByBelief, SpecialistType, 2,				 GoldMaintenance, MinAreaSize, ConquestProb, ('TXT_KEY_BUILDING_SENSHI_CSIRO'), 	('TXT_KEY_CIV5_SENSHI_CSIRO_TEXT'),	('TXT_KEY_BUILDING_SENSHI_CSIRO_HELP'), ('TXT_KEY_BUILDING_SENSHI_CSIRO_STRATEGY'),	ArtDefineTag, 3, 				('SENSHI_HAWKE_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_LABORATORY';	
--==========================================================================================================================	
-- Building_ClassesNeededInCity
--==========================================================================================================================	
INSERT INTO Building_ClassesNeededInCity
			(BuildingType,				BuildingClassType)
SELECT		('BUILDING_SENSHI_CSIRO'),	BuildingClassType 
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_LABORATORY';
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================	
INSERT INTO Building_YieldChanges
			(BuildingType,				YieldType,	Yield)
SELECT		('BUILDING_SENSHI_CSIRO'),	YieldType,	Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_LABORATORY';
--==========================================================================================================================	
-- Building_YieldModifiers
--==========================================================================================================================	
INSERT INTO Building_YieldModifiers
			(BuildingType,				YieldType,	Yield)
SELECT		('BUILDING_SENSHI_CSIRO'),	YieldType,	Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_LABORATORY';
--==========================================================================================================================
--Building_TechEnhancedYieldChanges
--==========================================================================================================================
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType,						YieldType,			Yield)
VALUES		('IMPROVEMENT_SENSHI_HAWKE_FARM',	'YIELD_GOLD',		3);
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================	
INSERT INTO Building_Flavors 	
			(BuildingType, 					FlavorType, Flavor)
SELECT		('BUILDING_SENSHI_CSIRO'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_LABORATORY';
--==========================================================================================================================	
--==========================================================================================================================	