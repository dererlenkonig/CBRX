--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================
-- BuildingClasses
--------------------------------
INSERT INTO BuildingClasses 	
			(Type, 										DefaultBuilding, 							Description)
VALUES		('BUILDINGCLASS_KOREAN_SEA',				'BUILDING_KOREAN_SEA',						'TXT_KEY_CIV_SENSHI_KOREA_DESC'),
			('BUILDINGCLASS_SENSHI_KOREAN_EXAMINATION',	'BUILDING_SENSHI_KOREAN_EXAMINATION',		'TXT_KEY_CIV_SENSHI_KOREA_DESC');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
			(Type, 						 			BuildingClass, 								GreatWorkCount, Cost,	FaithCost, PolicyCostModifier,	NeverCapture,	 Description, 									PrereqTech,		NukeImmune)
VALUES		('BUILDING_KOREAN_SEA', 				'BUILDINGCLASS_KOREAN_SEA',					-1, 			-1,		-1, 		0,					1,				'TXT_KEY_CIV_SENSHI_KOREA_DESC', 				NULL,			1),
			('BUILDING_SENSHI_KOREAN_EXAMINATION', 	'BUILDINGCLASS_SENSHI_KOREAN_EXAMINATION',	-1, 			-1,		-1, 		-15,				1,				'TXT_KEY_CIV_SENSHI_KOREA_DESC', 				NULL,			1);
			
------------------------------
-- Policies
------------------------------
INSERT INTO Policies 
		(Type,							Description) 
VALUES	('POLICY_GPUZ_KOREA',			'TXT_KEY_TRAIT_SCHOLARS_JADE_HALL_SHORT'),
		('POLICY_KOREAN_FORTRESS',		'TXT_KEY_DECISIONS_KOREA_FORT_CONSTRUCTION'),
		('POLICY_C15_DUMMY',			'TXT_KEY_POLICY_C15_DUMMY');

INSERT INTO Policy_SpecialistExtraYields
			(PolicyType, 			YieldType, 			Yield)
VALUES		('POLICY_GPUZ_KOREA', 	'YIELD_SCIENCE',	1);

INSERT INTO Policy_ImprovementYieldChanges
			(PolicyType, 			ImprovementType,				 YieldType, 		Yield)
/*VALUES		('POLICY_GPUZ_KOREA', 	'IMPROVEMENT_ACADEMY', 			'YIELD_SCIENCE', 1),
			('POLICY_GPUZ_KOREA', 	'IMPROVEMENT_CITADEL', 			'YIELD_SCIENCE', 1),
			('POLICY_GPUZ_KOREA', 	'IMPROVEMENT_CUSTOMS_HOUSE', 	'YIELD_SCIENCE', 1),
			('POLICY_GPUZ_KOREA', 	'IMPROVEMENT_MANUFACTORY', 		'YIELD_SCIENCE', 1),
			('POLICY_GPUZ_KOREA', 	'IMPROVEMENT_HOLY_SITE',		'YIELD_SCIENCE', 1);*/
SELECT		'POLICY_GPUZ_KOREA',	Type,							'YIELD_SCIENCE',	1
FROM Improvements WHERE CreatedByGreatPerson = 1;

UPDATE Units
SET Combat = 32, Moves = 3, Help = 'TXT_KEY_SENSHI_TURTLESHIP_HELP', Strategy = 'TXT_KEY_SENSHI_TURTLESHIP_STRATEGY'
WHERE Type = 'UNIT_KOREAN_TURTLE_SHIP';