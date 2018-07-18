INSERT INTO Building_Flavors
		(BuildingType, 					FlavorType, 			Flavor)
VALUES 	('BUILDING_CHEOMSEONGDAE', 		'FLAVOR_CULTURE', 		10),
		('BUILDING_CHEOMSEONGDAE', 		'FLAVOR_WONDER', 		20),
		('BUILDING_TEMPLO', 			'FLAVOR_PRODUCTION', 	15),
		('BUILDING_TEMPLO', 			'FLAVOR_CULTURE', 		15),
		('BUILDING_TEMPLO', 			'FLAVOR_WONDER', 		35),
		('BUILDING_DOME', 				'FLAVOR_CULTURE', 		30),
		('BUILDING_DOME', 				'FLAVOR_WONDER', 		30),
		('BUILDING_BANAUE', 			'FLAVOR_FOOD', 			15),
		('BUILDING_BANAUE', 			'FLAVOR_WONDER', 		20),
		();
		
INSERT INTO Building_YieldChanges
		(BuildingType, 				YieldType, 			Yield)
VALUES 	('BUILDING_CHEOMSEONGDAE', 	'YIELD_SCIENCE', 	3),
		('BUILDING_CHEOMSEONGDAE', 	'YIELD_CULTURE', 	1),
		('BUILDING_TEMPLO', 		'YIELD_CULTURE', 	2),
		('BUILDING_TEMPLO', 		'YIELD_FAITH', 		2),
		();

		
INSERT INTO Building_YieldChangesPerPop
		(BuildingType, 				YieldType, 			Yield)
VALUES 	('BUILDING_CHEOMSEONGDAE', 	'YIELD_SCIENCE', 	34),
		();

INSERT INTO Building_TechAndPrereqs
		(BuildingType, 				TechType)
VALUES 	('BUILDING_CHEOMSEONGDAE', 	'TECH_MASONRY'),
		();
		
INSERT INTO Building_FreeUnits
		(BuildingType, 			UnitType, 		NumUnits)
VALUES 	('BUILDING_DOME', 	'UNIT_PROPHET', 1),
		();
		
INSERT INTO Building_TerrainYieldChanges
		(BuildingType, 			TerrainType, 	YieldType, 		Yield)
VALUES 	('BUILDING_BANAUE', 	'TERRAIN_HILL', 'YIELD_FOOD' 	1),
		();
		