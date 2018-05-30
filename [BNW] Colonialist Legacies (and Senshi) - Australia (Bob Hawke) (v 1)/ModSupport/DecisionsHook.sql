--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 			DefaultBuilding, 							Description, 									MaxGlobalInstances, MaxPlayerInstances)
VALUES		('BUILDINGCLASS_DECISIONS_SENSHI_NEWPARLIAMENT', 		'BUILDING_DECISIONS_SENSHI_NEWPARLIAMENT', 		'TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT',  			-1,					1);
--==========================================================================================================================	
-- Buildings: Regular
--==========================================================================================================================
INSERT INTO Buildings 	
			(Type, 						 					BuildingClass, 									Description,										Civilopedia,													Help,													Strategy,			Cost,	PrereqTech, 	ConquestProb,	IconAtlas, 				PortraitIndex)
VALUES		('BUILDING_DECISIONS_SENSHI_NEWPARLIAMENT', 	'BUILDINGCLASS_DECISIONS_SENSHI_NEWPARLIAMENT',		'TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT',		'TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT',		'TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT',		'TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT',				-1,  	null,			100,			'EXPANSION_BW_ATLAS_1',	0),
			('BUILDING_DECISIONS_SENSHI_KIRRIBILLI', 		'BUILDINGCLASS_DECISIONS_SENSHI_NEWPARLIAMENT',		'TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT',		'TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT',		'TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT',		'TXT_KEY_DECISIONS_SENSHI_NEWPARLIAMENT',				-1,  	null,			100,			'EXPANSION_BW_ATLAS_1',	0);
--==========================================================================================================================	
-- Building_BuildingClassYieldChanges
--==========================================================================================================================		
INSERT INTO Building_BuildingClassYieldChanges 	
			(BuildingType, 									BuildingClassType,				YieldType, 				YieldChange)
VALUES		('BUILDING_DECISIONS_SENSHI_NEWPARLIAMENT', 			'BUILDINGCLASS_CONSTABLE',		'YIELD_CULTURE', 		2),
			('BUILDING_DECISIONS_SENSHI_NEWPARLIAMENT', 			'BUILDINGCLASS_PALACE',			'YIELD_CULTURE', 		2);
--==========================================================================================================================	
-- Building_SpecialistYieldChanges
--==========================================================================================================================		
INSERT INTO Building_SpecialistYieldChanges 	
			(BuildingType, 								SpecialistType,				YieldType, 			YieldChange)
VALUES		('BUILDING_DECISIONS_SENSHI_KIRRIBILLI', 	'SPECIALIST_MERCHANT',		'YIELD_GOLD', 		1);
--==========================================================================================================================
-- DecisionsAddin_Support
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('HawkeDecisions.lua');
--==========================================================================================================================