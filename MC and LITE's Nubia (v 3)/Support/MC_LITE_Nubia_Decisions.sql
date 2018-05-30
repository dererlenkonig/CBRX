--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 				DefaultBuilding, 							Description, 								MaxGlobalInstances, MaxPlayerInstances)
VALUES		('BUILDINGCLASS_DECISIONS_NUBIAFURNACEFREE', 		'BUILDING_DECISIONS_NUBIAFURNACEFREE', 		'TXT_KEY_DECISIONS_NUBIAFURNACE',  			-1,					-1),
			('BUILDINGCLASS_DECISIONS_NUBIAFURNACE', 			'BUILDING_DECISIONS_NUBIAFURNACE', 			'TXT_KEY_DECISIONS_NUBIAFURNACE',  			-1,					-1);
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================
INSERT INTO Buildings 	
			(Type, 						 					BuildingClass, 									Description,						GreatWorkCount, Cost, FaithCost, PrereqTech, 	NeverCapture)
VALUES		('BUILDING_DECISIONS_NUBIAFURNACEFREE', 		'BUILDINGCLASS_DECISIONS_NUBIAFURNACEFREE',		'TXT_KEY_DECISIONS_NUBIAFURNACE',	-1, 			-1,   -1, 		 null,			1),
			('BUILDING_DECISIONS_NUBIAFURNACE', 			'BUILDINGCLASS_DECISIONS_NUBIAFURNACE',			'TXT_KEY_DECISIONS_NUBIAFURNACE',	-1, 			-1,   -1, 		 null,			1);

UPDATE Buildings
SET FreeBuildingThisCity = 'BUILDINGCLASS_FORGE'
WHERE Type = 'BUILDING_DECISIONS_NUBIAFURNACEFREE';

UPDATE Buildings
SET TradeRouteLandDistanceModifier = 25, TradeRouteSeaDistanceModifier = 25
WHERE Type = 'BUILDING_DECISIONS_NUBIAFURNACE';
--==========================================================================================================================
-- Policies
--==========================================================================================================================
INSERT INTO Policies 
			(Type, 											Description) 
VALUES		('POLICY_DECISIONS_NUBIAAMUNTEMPLE',	 	    'TXT_KEY_DECISIONS_NUBIAAMUNTEMPLE');
--==========================================================================================================================
-- Policy_BuildingClassYieldChanges
--==========================================================================================================================
INSERT INTO Policy_BuildingClassYieldChanges 
			(PolicyType, 									BuildingClassType,						YieldType, 					YieldChange)
VALUES 		('POLICY_DECISIONS_NUBIAAMUNTEMPLE', 			'BUILDINGCLASS_TEMPLE',	 				'YIELD_CULTURE',			1);
--==========================================================================================================================
-- Policy_ImprovementYieldChanges
--==========================================================================================================================
INSERT INTO Policy_ImprovementYieldChanges 
			(PolicyType, 									ImprovementType,								YieldType, 				Yield)
VALUES 		('POLICY_DECISIONS_NUBIAAMUNTEMPLE', 			'IMPROVEMENT_MC_LITE_NUBIAN_ROYAL_PYRAMID',		'YIELD_FAITH', 			1),
			('POLICY_DECISIONS_NUBIAAMUNTEMPLE', 			'IMPROVEMENT_MC_ROYAL_PYRAMID2',				'YIELD_FAITH', 			1),
			('POLICY_DECISIONS_NUBIAAMUNTEMPLE', 			'IMPROVEMENT_MC_ROYAL_PYRAMID3',				'YIELD_FAITH', 			1),
			('POLICY_DECISIONS_NUBIAAMUNTEMPLE', 			'IMPROVEMENT_MC_ROYAL_PYRAMID4',				'YIELD_FAITH', 			1),
			('POLICY_DECISIONS_NUBIAAMUNTEMPLE', 			'IMPROVEMENT_MC_ROYAL_PYRAMID5',				'YIELD_FAITH', 			1),
			('POLICY_DECISIONS_NUBIAAMUNTEMPLE', 			'IMPROVEMENT_MC_ROYAL_PYRAMID6',				'YIELD_FAITH', 			1),
			('POLICY_DECISIONS_NUBIAAMUNTEMPLE', 			'IMPROVEMENT_MC_ROYAL_PYRAMID7',				'YIELD_FAITH', 			1),
			('POLICY_DECISIONS_NUBIAAMUNTEMPLE', 			'IMPROVEMENT_MC_ROYAL_PYRAMID8',	