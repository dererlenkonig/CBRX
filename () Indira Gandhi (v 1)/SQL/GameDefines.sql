INSERT INTO Traits 
		(Type, 							Description, 					ShortDescription)
VALUES	('TRAIT_THE_EMERGENCY', 		'TXT_KEY_TRAIT_THE_EMERGENCY', 	'TXT_KEY_TRAIT_THE_EMERGENCY_SHORT');

INSERT INTO Unit_ProductionModifierBuildings
       (UnitType,				BuildingType,			ProductionModifier)
VALUES ('UNIT_ATOMIC_BOMB',		'BUILDING_POKHRAN_LAB', 75),
       ('UNIT_NUCLEAR_MISSILE', 'BUILDING_POKHRAN_LAB', 75);