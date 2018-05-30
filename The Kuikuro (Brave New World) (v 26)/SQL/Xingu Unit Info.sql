--Dummy
---------------------------

INSERT INTO Units 
		(Class,										       Type,	Cost,	Moves,              Capture,                CivilianAttackPriority,		       Domain,        DefaultUnitAI,                            Description,                                           Civilopedia,                                         Strategy,                                           Help,		AdvancedStartCost,		WorkRate,		CombatLimit,			                    UnitArtInfo,        UnitArtInfoEraVariation,                     UnitFlagIconOffset,                 IconAtlas,		   PortraitIndex,        ShowInPedia)
VALUES	('UNITCLASS_XINGU_WORKER',			'UNIT_XINGU_WORKER',	  -1,	    2,	 'UNITCLASS_WORKER',		'CIVILIAN_ATTACK_PRIORITY_LOW',     'DOMAIN_LAND',		'UNITAI_WORKER',	              'TXT_KEY_UNIT_WORKER',		          'TXT_KEY_CIV5_ANTIQUITY_WORKER_TEXT',		              'TXT_KEY_UNIT_WORKER_STRATEGY',		              'TXT_KEY_UNIT_HELP_WORKER',		               20,           100,                 0,		             'ART_DEF_UNIT__WORKER',		                      1,		                              1,			'UNIT_ATLAS_1',                    1,                  0),
		('UNITCLASS_XINGU_AI_WORKER',	 'UNIT_XINGU_AI_WORKER',	  -1,	    2,	 'UNITCLASS_WORKER',		'CIVILIAN_ATTACK_PRIORITY_LOW',     'DOMAIN_LAND',		'UNITAI_WORKER',	              'TXT_KEY_UNIT_WORKER',		          'TXT_KEY_CIV5_ANTIQUITY_WORKER_TEXT',		              'TXT_KEY_UNIT_WORKER_STRATEGY',		              'TXT_KEY_UNIT_HELP_WORKER',		               20,           100,                 0,		             'ART_DEF_UNIT__WORKER',		                      1,		                              1,			'UNIT_ATLAS_1',                    1,                  0);

INSERT INTO Unit_AITypes
		(UnitType,															 UnitAIType)
VALUES	('UNIT_XINGU_WORKER',								            'UNITAI_WORKER'),
		('UNIT_XINGU_AI_WORKER',								        'UNITAI_WORKER');

INSERT INTO Unit_Flavors
		(UnitType,															 FlavorType,						Flavor)
VALUES	('UNIT_XINGU_WORKER',					              'FLAVOR_TILE_IMPROVEMENT',							30),
		('UNIT_XINGU_AI_WORKER',					          'FLAVOR_TILE_IMPROVEMENT',							30);

INSERT INTO UnitClasses
		(Type,											  Description,						DefaultUnit)
VALUES	('UNITCLASS_XINGU_WORKER',				'TXT_KEY_UNIT_WORKER',				'UNIT_XINGU_WORKER'),
		('UNITCLASS_XINGU_AI_WORKER',		    'TXT_KEY_UNIT_WORKER',		     'UNIT_XINGU_AI_WORKER');

INSERT INTO Unit_Builds 
	    (UnitType,												   BuildType)
VALUES	('UNIT_XINGU_WORKER',									'BUILD_ROAD'),
		('UNIT_XINGU_WORKER',								'BUILD_RAILROAD'),
		('UNIT_XINGU_WORKER',							  'BUILD_FARM_XINGU'),
		('UNIT_XINGU_WORKER',							  'BUILD_MINE_XINGU'),
		('UNIT_XINGU_WORKER',					  'BUILD_TRADING_POST_XINGU'),
		('UNIT_XINGU_WORKER',						      'BUILD_LUMBERMILL'),
		('UNIT_XINGU_WORKER',						   'BUILD_PASTURE_XINGU'),
		('UNIT_XINGU_WORKER',					                'BUILD_CAMP'),
		('UNIT_XINGU_WORKER',					    'BUILD_PLANTATION_XINGU'),
		('UNIT_XINGU_WORKER',						    'BUILD_QUARRY_XINGU'),
		('UNIT_XINGU_WORKER',						      'BUILD_WELL_XINGU'),
		('UNIT_XINGU_WORKER',						      'BUILD_FORT_XINGU'),
		('UNIT_XINGU_WORKER',						   'BUILD_REMOVE_JUNGLE'),
		('UNIT_XINGU_WORKER',						    'BUILD_REMOVE_MARSH'),
		('UNIT_XINGU_WORKER',						   'BUILD_REMOVE_FOREST'),
		('UNIT_XINGU_WORKER',						   'BUILD_SCRUB_FALLOUT'),
		('UNIT_XINGU_WORKER',								  'BUILD_REPAIR'),
		('UNIT_XINGU_WORKER',							'BUILD_REMOVE_ROUTE'),
		('UNIT_XINGU_AI_WORKER',								'BUILD_ROAD'),
		('UNIT_XINGU_AI_WORKER',							'BUILD_RAILROAD'),
		('UNIT_XINGU_AI_WORKER',                          'BUILD_FARM_XINGU'),
		('UNIT_XINGU_AI_WORKER',                          'BUILD_MINE_XINGU'),
		('UNIT_XINGU_AI_WORKER',				  'BUILD_TRADING_POST_XINGU'),
		('UNIT_XINGU_AI_WORKER',						  'BUILD_LUMBERMILL'),
		('UNIT_XINGU_AI_WORKER',                       'BUILD_PASTURE_XINGU'),
		('UNIT_XINGU_AI_WORKER',                                'BUILD_CAMP'),
		('UNIT_XINGU_AI_WORKER',                    'BUILD_PLANTATION_XINGU'),
		('UNIT_XINGU_AI_WORKER',                        'BUILD_QUARRY_XINGU'),
		('UNIT_XINGU_AI_WORKER',                          'BUILD_WELL_XINGU'),
		('UNIT_XINGU_AI_WORKER',                          'BUILD_FORT_XINGU'),
		('UNIT_XINGU_AI_WORKER',                        'BUILD_REMOVE_MARSH'),
		('UNIT_XINGU_AI_WORKER',                       'BUILD_SCRUB_FALLOUT'),
		('UNIT_XINGU_AI_WORKER',                              'BUILD_REPAIR'),
		('UNIT_XINGU_AI_WORKER',				        'BUILD_REMOVE_ROUTE');

