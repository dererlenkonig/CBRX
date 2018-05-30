 INSERT INTO Resources 
		(Type,						Description,						Civilopedia, 								ResourceClassType, 		Happiness,  AITradeModifier, 	ResourceUsage,	AIObjective,	'Unique', 	IconString, 				PortraitIndex, 	IconAtlas)
VALUES	('RESOURCE_JEPR',	'TXT_KEY_RESOURCE_JEPR',		'TXT_KEY_CIV5_RESOURCE_JEPR_TEXT',	'RESOURCECLASS_LUXURY',	1,			10,					2, 				0, 				2, 			'[ICON_RES_JEPR]',	4, 				'SELKNAM_ATLAS');

INSERT INTO Building_ResourceQuantity 	
		(BuildingType, 						ResourceType, 			Quantity)
VALUES	('BUILDING_SELKNAM_MARKET',	'RESOURCE_JEPR', 2);	
 

INSERT INTO Resource_YieldChanges
        (ResourceType,    YieldType,     Yield)
VALUES  ('RESOURCE_JEPR', 'YIELD_FOOD', 2);