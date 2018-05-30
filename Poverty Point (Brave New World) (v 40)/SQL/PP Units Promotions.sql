---------------------------
--Units
---------------------------

--Special,

INSERT INTO Units 	
		(Type, 							    Class,	Cost,	Moves, Capture, CivilianAttackPriority,					  Special, Domain, 	DefaultUnitAI,             Description,                  Civilopedia,                         Strategy, 			                 Help,         AdvancedStartCost, 				        WorkRate, 								CombatLimit, 	FoundReligion, SpreadReligion, ReligionSpreads, ReligiousStrength,                    UnitArtInfo,                      UnitFlagAtlas, UnitFlagIconOffset, MoveRate, PortraitIndex,              IconAtlas)
SELECT	('UNIT_POVERTY_POINT_MOD'), 		Class,	Cost,   Moves, Capture, CivilianAttackPriority, ('SPECIALUNIT_PEOPLE_EX'), Domain, 	DefaultUnitAI, ('TXT_KEY_PP_UNIT_MOD'), ('TXT_KEY_PP_UNIT_MOD_TEXT'), ('TXT_KEY_PP_UNIT_MOD_STRATEGY'),      ('TXT_KEY_PP_UNIT_MOD_HELP'),         AdvancedStartCost,	                    WorkRate, 	                            CombatLimit,	FoundReligion, SpreadReligion, ReligionSpreads, ReligiousStrength, ('ART_DEF_UNIT_GREAT_POVERTY'), ('POVERTY_POINT_UNIT_ALPHA_ATLAS'),                  0, MoveRate,             2, ('POVERTY_POINT_ATLAS')
FROM Units WHERE (Type = 'UNIT_PROPHET');

INSERT INTO Units 	
		(Type, 									Class,	          PrereqTech,	Cost,	Moves, Capture, CivilianAttackPriority,                   Special, Domain, 	DefaultUnitAI,             Description,                  Civilopedia,                         Strategy, 			                 Help,           AdvancedStartCost, 				    WorkRate, 								CombatLimit, 	ShowInPedia,	                   UnitArtInfo,                      UnitFlagAtlas, UnitFlagIconOffset, MoveRate, PortraitIndex,              IconAtlas)
SELECT	('UNIT_POVERTY_POINT_MOD_DUMMY'), 		Class,	('TECH_AGRICULTURE'),	Cost,   Moves, Capture, CivilianAttackPriority, ('SPECIALUNIT_PEOPLE_EX'), Domain, 	DefaultUnitAI, ('TXT_KEY_PP_UNIT_MOD'), ('TXT_KEY_PP_UNIT_MOD_TEXT'), ('TXT_KEY_PP_UNIT_MOD_STRATEGY'),      ('TXT_KEY_PP_UNIT_MOD_HELP'),           AdvancedStartCost,	                    WorkRate, 	                            CombatLimit,	          0,	('ART_DEF_UNIT_GREAT_POVERTY'), ('POVERTY_POINT_UNIT_ALPHA_ATLAS'),                  0, MoveRate,             2, ('POVERTY_POINT_ATLAS')
FROM Units WHERE (Type = 'UNIT_PROPHET');

INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType,											           UnitClassType,						                                   UnitType)
VALUES	('CIVILIZATION_BARBARIAN',				                         'UNITCLASS_PROPHET',							         'UNIT_POVERTY_POINT_MOD_DUMMY');

INSERT INTO SpecialUnits 
		(Type,											       Description,					 Valid,		CityLoad)
VALUES	('SPECIALUNIT_PEOPLE_EX',		      'TXT_KEY_SPECIALUNIT_PEOPLE',					     1,			   0);

INSERT INTO SpecialUnit_CarrierUnitAI 
		(SpecialUnitType,								   UnitAIType)
VALUES	('SPECIALUNIT_PEOPLE_EX',		      'UNITAI_MISSIONARY_SEA'),
		('SPECIALUNIT_PEOPLE_EX',		         'UNITAI_ASSAULT_SEA');

INSERT INTO Unit_AITypes
		(UnitType,																	  UnitAIType)
Values	('UNIT_POVERTY_POINT_MOD',												'UNITAI_PROPHET'),
		('UNIT_POVERTY_POINT_MOD_DUMMY',								        'UNITAI_PROPHET');

INSERT INTO Unit_Builds 
	    (UnitType,			                                              BuildType)
VALUES	('UNIT_POVERTY_POINT_MOD',								  'BUILD_HOLY_SITE');

INSERT INTO Unit_FreePromotions 
		(UnitType,											                   PromotionType)
VALUES	('UNIT_POVERTY_POINT_MOD',			                     'PROMOTION_RIVAL_TERRITORY'),
		('UNIT_POVERTY_POINT_MOD',			                       'PROMOTION_SIGHT_PENALTY'),
		('UNIT_POVERTY_POINT_MOD',			                         'PROMOTION_PP_BLESSING'),
		--('UNIT_POVERTY_POINT_MOD_DUMMY',			             'PROMOTION_RIVAL_TERRITORY'),
		('UNIT_POVERTY_POINT_MOD_DUMMY',			               'PROMOTION_SIGHT_PENALTY'),
		('UNIT_POVERTY_POINT_MOD_DUMMY',			                 'PROMOTION_PP_BLESSING');

INSERT INTO Unit_Flavors
		(UnitType,										FlavorType,						Flavor)
Values	('UNIT_POVERTY_POINT_MOD',									'FLAVOR_RELIGION',					1),
	    ('UNIT_POVERTY_POINT_MOD_DUMMY',								'FLAVOR_RELIGION',				1);

---------------------------
--Promotions
---------------------------

INSERT INTO UnitPromotions 
		(Type, 												          Description, 	                                         Help, 	                 Sound, 	CannotBeChosen,		VisibilityChange,	IgnoreTerrainCost,	PortraitIndex,		                          IconAtlas,				 PediaType,										 PediaEntry)
VALUES	('PROMOTION_PP_BLESSING', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		     'TXT_KEY_PROMOTION_PP_BLESSING_HELP',		 'AS2D_IF_LEVELUP', 				 1,                    0,                   0,			    1,		    'POVERTY_POINT_PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',					'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_HUNTER_BONUS', 	   'TXT_KEY_POVERTY_BONUS_PROMOTION_4_B1', 		   'TXT_KEY_POVERTY_BONUS_PROMOTION_4_B2',		 'AS2D_IF_LEVELUP', 				 1,                    1,                   0,             56,		                  'PROMOTION_ATLAS',		'PEDIA_ATTRIBUTES',		     'TXT_KEY_POVERTY_BONUS_PROMOTION_4_B1'),
		('PROMOTION_PP_DUCK_MOVE', 	       'TXT_KEY_POVERTY_BONUS_PROMOTION_6_A1', 		   'TXT_KEY_POVERTY_BONUS_PROMOTION_6_A2',		 'AS2D_IF_LEVELUP', 				 1,                    0,                   1,             59,		                    'ABILITY_ATLAS',		'PEDIA_ATTRIBUTES',		     'TXT_KEY_POVERTY_BONUS_PROMOTION_6_A1');

--Dummy
---------------------------

INSERT INTO UnitPromotions 
		(Type, 												              Description, 	                                              Help, 	             Sound, 	CannotBeChosen,		PortraitIndex,		                          IconAtlas,				 PediaType,		                          PediaEntry)
VALUES	('PROMOTION_PP_DUCK_STOP', 			   'TXT_KEY_POVERTY_BONUS_PROMOTION_6_A1', 		        'TXT_KEY_POVERTY_BONUS_PROMOTION_6_A2',		 'AS2D_IF_LEVELUP', 				 1,                59,		                    'ABILITY_ATLAS',		              NULL,	  'TXT_KEY_POVERTY_BONUS_PROMOTION_6_A1'),
		('PROMOTION_PP_BLESSING_NULL', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		     'TXT_KEY_PROMOTION_PP_BLESSING_HELP_NULL',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_1', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_1',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_2', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_2',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_5', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_5',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_7_E', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_7',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_7_M', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_7',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_7_S', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_7',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_7_G', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_7',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_8', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_8',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_9', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_9',		 'AS2D_IF_LEVELUP', 				 1,                 1,		    'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING');

INSERT INTO UnitPromotions 
		(Type, 												              Description, 	                                              Help, 	             Sound, 	CannotBeChosen,		PortraitIndex,		         GreatGeneral,    GreatAdmiral,		AllowsEmbarkation,	EmbarkedAllWater,	ExtraNavalMovement,                           IconAtlas,				 PediaType,		                          PediaEntry)
VALUES	('PROMOTION_PP_BLESSING_3', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_3',		 'AS2D_IF_LEVELUP', 				 1,                 1,		                    0,				 0,	                    0,			       0,					 0,		'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_6_A', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_6',		 'AS2D_IF_LEVELUP', 				 1,                 1,		                    0,				 0,	                    1,	               1,                    2,		'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_6_B', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_6',		 'AS2D_IF_LEVELUP', 				 1,                 1,		                    0,				 0,	                    1,	               1,                    1,		'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING'),
		('PROMOTION_PP_BLESSING_6_C', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_6',		 'AS2D_IF_LEVELUP', 				 1,                 1,		                    0,				 0,	                    1,	               1,                    0,		'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		     'TXT_KEY_PROMOTION_PP_BLESSING');

INSERT INTO UnitPromotions 
		(Type, 												              Description, 	                                              Help, 	             Sound, 	CannotBeChosen,		ExperiencePercent,	    AllowsEmbarkation,   ExtraNavalMovement,	IgnoreTerrainCost,		PortraitIndex,		                                 IconAtlas,				 PediaType,		                                   PediaEntry)
VALUES	('PROMOTION_PP_BLESSING_4', 	              'TXT_KEY_PROMOTION_PP_BLESSING', 		           'TXT_KEY_POVERTY_BONUS_PROMOTION_4',		 'AS2D_IF_LEVELUP', 				 1,                    25,                      0,                    0,                    0,                  1,		           'POVERTY_POINT_PROMOTION_ATLAS',		              NULL,		              'TXT_KEY_PROMOTION_PP_BLESSING');

INSERT INTO UnitPromotions 
		(Type, 												              Description, 	                                              Help, 	             Sound, 	CannotBeChosen,     ExperiencePercent,		CombatPercent,	IgnoreTerrainCost,		PortraitIndex,			                 IconAtlas,		PediaType,		                                    PediaEntry)
VALUES	('PROMOTION_PP_BLESSING_4_A', 	       'TXT_KEY_POVERTY_BONUS_PROMOTION_4_A1', 		        'TXT_KEY_POVERTY_BONUS_PROMOTION_4_A2',		 'AS2D_IF_LEVELUP', 				 1,                    25,                  0,					0,                  1,     'POVERTY_POINT_PROMOTION_ATLAS',		     NULL,		        'TXT_KEY_POVERTY_BONUS_PROMOTION_4_A1'),
		('PROMOTION_PP_BLESSING_3_D', 	       'TXT_KEY_POVERTY_BONUS_PROMOTION_3_D1', 		        'TXT_KEY_POVERTY_BONUS_PROMOTION_3_D2',		 'AS2D_IF_LEVELUP', 				 1,                     0,                 10,					0,                  1,     'POVERTY_POINT_PROMOTION_ATLAS',		     NULL,		        'TXT_KEY_POVERTY_BONUS_PROMOTION_3_D1'),
		('PROMOTION_PP_BLESSING_6_D', 	       'TXT_KEY_POVERTY_BONUS_PROMOTION_6_D1', 		        'TXT_KEY_POVERTY_BONUS_PROMOTION_6_D2',		 'AS2D_IF_LEVELUP', 				 1,                     0,                 10,					0,                  1,     'POVERTY_POINT_PROMOTION_ATLAS',		     NULL,		        'TXT_KEY_POVERTY_BONUS_PROMOTION_6_D1');

---------------------------
--Buildings
---------------------------

--Dummy
---------------------------

INSERT INTO Buildings 
		(Type,																				        BuildingClass,	  Cost,		FaithCost,		PrereqTech,		GreatWorkCount,											   Description,	                                             Civilopedia,													      Strategy,				          ArtDefineTag,		 TradeRouteLandDistanceModifier,	BuildingProductionModifier,		WonderProductionModifier,	MinAreaSize,	HurryCostModifier,		   IconAtlas,		 PortraitIndex,		    NeverCapture,		 NukeImmune)
VALUES	('BUILDING_POVERTY_DECISION_FAITH',			                       'BUILDINGCLASS_POVERTY_DECISION_FAITH',		-1,			   -1,		     NULL,			        -1,			'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_DESC',			  'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_TEXT',				'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_STRATEGY',		    'ART_DEF_BUILDING_GRANARY',									  0,                             0,			                   0,	         -1,			       25,		'BW_ATLAS_1',                    0,                    1,                 1),
		('BUILDING_POVERTY_TURTLE_BONUS_1',			                       'BUILDINGCLASS_POVERTY_TURTLE_BONUS_1',		-1,			   -1,		     NULL,			        -1,			'TXT_KEY_BUILDING_POVERTY_TURTLE_BONUS_1_DESC',			  'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_TEXT',				'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_STRATEGY',		'ART_DEF_BUILDING_CARAVANSARY',									 33,                             0,			                   0,	         -1,			       25,		'BW_ATLAS_1',                    0,                    1,                 1),
		('BUILDING_POVERTY_TURTLE_BONUS_2',			                       'BUILDINGCLASS_POVERTY_TURTLE_BONUS_2',		-1,			   -1,		     NULL,			        -1,			'TXT_KEY_BUILDING_POVERTY_TURTLE_BONUS_2_DESC',			  'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_TEXT',				'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_STRATEGY',		'ART_DEF_BUILDING_CARAVANSARY',									  0,                            10,			                   0,	         -1,			       25,		'BW_ATLAS_1',                    0,                    1,                 1);

INSERT INTO Buildings 
		(Type,																				        BuildingClass,	  Cost,		FaithCost,		PrereqTech,		GreatWorkCount,											   Description,	                                             Civilopedia,													      Strategy,				          ArtDefineTag,		 TradeRouteLandDistanceModifier,	BuildingProductionModifier,		WonderProductionModifier,	MinAreaSize,	HurryCostModifier,		   IconAtlas,		 PortraitIndex,		    NeverCapture,		 NukeImmune)
VALUES	('BUILDING_PROPHET_BONUS_0',			                                  'BUILDINGCLASS_PROPHET_BONUS_0',		-1,			   -1,		     NULL,			        -1,			       'TXT_KEY_BUILDING_PROPHET_BONUS_0_DESC',			  'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_TEXT',				'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_STRATEGY',		    'ART_DEF_BUILDING_GRANARY',									  0,                             0,			                   0,	         -1,			       25,		'BW_ATLAS_1',                    0,                    1,                 1);


INSERT INTO BuildingClasses
		(Type,																					  DefaultBuilding,											 Description)
Values	('BUILDINGCLASS_POVERTY_DECISION_FAITH',		                        'BUILDING_POVERTY_DECISION_FAITH',		  'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_DESC'),
		('BUILDINGCLASS_POVERTY_TURTLE_BONUS_1',		                        'BUILDING_POVERTY_TURTLE_BONUS_1',		  'TXT_KEY_BUILDING_POVERTY_TURTLE_BONUS_1_DESC'),
		('BUILDINGCLASS_POVERTY_TURTLE_BONUS_2',		                        'BUILDING_POVERTY_TURTLE_BONUS_2',		  'TXT_KEY_BUILDING_POVERTY_TURTLE_BONUS_2_DESC'),
		('BUILDINGCLASS_PROPHET_BONUS_0',		                                       'BUILDING_PROPHET_BONUS_0',		  '       TXT_KEY_BUILDING_PROPHET_BONUS_0_DESC');

INSERT INTO Building_YieldChanges 
		(BuildingType,											             YieldType,				   Yield)
VALUES	('BUILDING_POVERTY_DECISION_FAITH',								 'YIELD_FAITH',					   2);


INSERT INTO Building_FreeUnits 
		(BuildingType,											              UnitType,				NumUnits)
VALUES	('BUILDING_PROPHET_BONUS_0',								    'UNIT_PROPHET',					   1);

--
--
--

INSERT INTO Buildings 
		(Type,																				      BuildingClass,	  Cost,		FaithCost,		PrereqTech,		GreatWorkCount,												   Description,	                                                        Civilopedia,													        Strategy,				                ArtDefineTag,			MinAreaSize,	HurryCostModifier,						IconAtlas,		     PortraitIndex,		     NeverCapture,		ConquestProb,	NukeImmune)
VALUES	('BUILDING_TOMATEKH_PROPHET_PP_DUMMY_MAX',				  'BUILDINGCLASS_TOMATEKH_PROPHET_PP_DUMMY_MAX',		-1,			   -1,		     NULL,			        -1,				     'TXT_KEY_BUILDING_POVERTY_MAX_FAITH_DESC',					     'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_TEXT',			      'TXT_KEY_BUILDING_POVERTY_DECISION_FAITH_STRATEGY',	              'ART_DEF_BUILDING_GRANARY',					 -1,			       25,					 'BW_ATLAS_1',                       0,                     0,               100,            1);

INSERT INTO BuildingClasses
		(Type,																			    DefaultBuilding,										          Description)
Values	('BUILDINGCLASS_TOMATEKH_PROPHET_PP_DUMMY_MAX',		       'BUILDING_TOMATEKH_PROPHET_PP_DUMMY_MAX',		            'TXT_KEY_BUILDING_POVERTY_MAX_FAITH_DESC');

--
--
--

---------------------------
--Policies
---------------------------

--Dummy
---------------------------

INSERT INTO Policies 
		(Type,														                 Description,								                      Civilopedia,                                                   Help,	    GridX,	GridY,	PortraitIndex,		GarrisonedCityRangeStrikeModifier,	FaithCostModifier,	GreatMusicianRateModifier,		 IconAtlas,		   IconAtlasAchieved)
VALUES	('POLICY_POVERTY_MOUND_FOOD_1',			    'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FOOD_1',			    'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FOOD_TEXT_1',		'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FOOD_HELP_1',	     1000,	 1000,		       47,					                    0,					0,							0,	'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_MOUND_FOOD_2',	            'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FOOD_2',			    'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FOOD_TEXT_2',	    'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FOOD_HELP_2',	     1000,	 1000,		       47,					                    0,					0,							0,	'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_MOUND_FAITH_1',	       'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_1',			   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_TEXT_1',	   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_HELP_1',	     1000,	 1000,		       47,					                    0,				  -10,							0,	'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_MOUND_FAITH_2',	       'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_2',			   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_TEXT_2',	   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_HELP_2',       1000,	 1000,		       47,					                    0,					0,							0,	'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_MOUND_FAITH_3',	       'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_3',			   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_TEXT_3',	   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_HELP_3',       1000,	 1000,		       47,					                    0,					0,							0,	'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_CAMP_SCIENCE_1',	      'TXT_KEY_POLICY_POLICY_POVERTY_CAMP_SCIENCE_1',			  'TXT_KEY_POLICY_POLICY_POVERTY_CAMP_SCIENCE_TEXT_1',	  'TXT_KEY_POLICY_POLICY_POVERTY_CAMP_SCIENCE_HELP_1',       1000,	 1000,		       47,					                    0,					0,							0,	'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_BONUS_8',						 'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_8',			         'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_8_TEXT',	         'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_8_HELP',       1000,	 1000,		       47,					                    0,					0,							0,	'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_BONUS_9',						 'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_9',			         'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_9_TEXT',	         'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_9_HELP',       1000,	 1000,		       47,									    0,					0,							0,	'POLICY_ATLAS',			'POLICY_A_ATLAS');

INSERT INTO Policy_ImprovementYieldChanges
		(PolicyType,														                     ImprovementType,		                          YieldType,                       Yield)
Values	('POLICY_POVERTY_MOUND_FOOD_1',                                       'IMPROVEMENT_CEREMONIAL_MOUND_MOD',                              'YIELD_FOOD',                           1),
	    ('POLICY_POVERTY_MOUND_FOOD_2',                                       'IMPROVEMENT_CEREMONIAL_MOUND_MOD',                              'YIELD_FOOD',                           1),
		('POLICY_POVERTY_MOUND_FAITH_1',                                      'IMPROVEMENT_CEREMONIAL_MOUND_MOD',                             'YIELD_FAITH',                           1),
	    ('POLICY_POVERTY_MOUND_FAITH_2',                                      'IMPROVEMENT_CEREMONIAL_MOUND_MOD',                             'YIELD_FAITH',                           1),
		('POLICY_POVERTY_MOUND_FAITH_3',                                      'IMPROVEMENT_CEREMONIAL_MOUND_MOD',                             'YIELD_FAITH',                           4),
        ('POLICY_POVERTY_CAMP_SCIENCE_1',                                                     'IMPROVEMENT_CAMP',                           'YIELD_SCIENCE',                           2);

INSERT INTO Policy_GreatWorkYieldChanges
		(PolicyType,													 YieldType,                       Yield)
Values	('POLICY_POVERTY_BONUS_8',                                 'YIELD_CULTURE',                           1);

INSERT INTO Policies 
		(Type,														                 Description,								                      Civilopedia,                                                   Help,	    GridX,	GridY,	PortraitIndex,		     IconAtlas,		   IconAtlasAchieved)
VALUES	('POLICY_POVERTY_COUNT_1',			                    'TXT_KEY_POLICY_POVERTY_COUNT_1',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_1',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_1',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_2',			                    'TXT_KEY_POLICY_POVERTY_COUNT_2',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_2',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_2',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_3',			                    'TXT_KEY_POLICY_POVERTY_COUNT_3',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_3',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_3',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_4',			                    'TXT_KEY_POLICY_POVERTY_COUNT_4',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_4',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_4',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_5',			                    'TXT_KEY_POLICY_POVERTY_COUNT_5',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_5',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_5',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_6',			                    'TXT_KEY_POLICY_POVERTY_COUNT_6',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_6',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_6',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_7',			                    'TXT_KEY_POLICY_POVERTY_COUNT_7',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_7',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_7',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_8',			                    'TXT_KEY_POLICY_POVERTY_COUNT_8',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_8',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_8',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_9',			                    'TXT_KEY_POLICY_POVERTY_COUNT_9',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_9',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_9',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS');

--
--

INSERT INTO Policies 
		(Type,																			 Description,								                      Civilopedia,                                                   Help,	    GridX,	GridY,	PortraitIndex,		     IconAtlas,		   IconAtlasAchieved)
VALUES	('POLICY_POVERTY_COUNT_1_A',								'TXT_KEY_POLICY_POVERTY_COUNT_1',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_1',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_1',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_2_A',			                    'TXT_KEY_POLICY_POVERTY_COUNT_2',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_2',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_2',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_3_A',			                    'TXT_KEY_POLICY_POVERTY_COUNT_3',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_3',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_3',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_4_A',			                    'TXT_KEY_POLICY_POVERTY_COUNT_4',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_4',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_4',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_5_A',			                    'TXT_KEY_POLICY_POVERTY_COUNT_5',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_5',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_5',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_6_A',			                    'TXT_KEY_POLICY_POVERTY_COUNT_6',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_6',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_6',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_7_A',			                    'TXT_KEY_POLICY_POVERTY_COUNT_7',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_7',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_7',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_8_A',			                    'TXT_KEY_POLICY_POVERTY_COUNT_8',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_8',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_8',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_COUNT_9_A',			                    'TXT_KEY_POLICY_POVERTY_COUNT_9',			                'TXT_KEY_POLICY_POVERTY_COUNT_TEXT_9',		            'TXT_KEY_POLICY_POVERTY_COUNT_HELP_9',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS');

INSERT INTO Policies 
		(Type,														                     Description,								                      Civilopedia,                                                   Help,	    GridX,	GridY,	PortraitIndex,			IconAtlas,		   IconAtlasAchieved)
VALUES	('POLICY_POVERTY_MOUND_FAITH_1_A',			   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_1',			   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_TEXT_1',	   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_HELP_1',	     1000,	 1000,		       47,	   'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_MOUND_FAITH_2_A',			   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_2',			   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_TEXT_2',	   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_HELP_2',       1000,	 1000,		       47,	   'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_MOUND_FAITH_3_A',			   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_3',			   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_TEXT_3',	   'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_HELP_3',       1000,	 1000,		       47,     'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_CAMP_SCIENCE_1_A',			  'TXT_KEY_POLICY_POLICY_POVERTY_CAMP_SCIENCE_1',			  'TXT_KEY_POLICY_POLICY_POVERTY_CAMP_SCIENCE_TEXT_1',	  'TXT_KEY_POLICY_POLICY_POVERTY_CAMP_SCIENCE_HELP_1',       1000,	 1000,		       47,	   'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_BONUS_8_A',						 'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_8',			         'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_8_TEXT',	         'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_8_HELP',       1000,	 1000,		       47,	   'POLICY_ATLAS',			'POLICY_A_ATLAS'),
		('POLICY_POVERTY_BONUS_9_A',						 'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_9',			         'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_9_TEXT',	         'TXT_KEY_POLICY_POLICY_POVERTY_BONUS_9_HELP',       1000,	 1000,		       47,	   'POLICY_ATLAS',			'POLICY_A_ATLAS');

--
--

INSERT INTO Policies 
		(Type,														                          Description,								                      Civilopedia,                                                   Help,	    GridX,	GridY,	PortraitIndex,			 IconAtlas,		   IconAtlasAchieved)
VALUES	('POLICY_POVERTY_FIX_UI_BASE_YIELD',			    'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_4',			    'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_TEXT_4',		'TXT_KEY_POLICY_POLICY_POVERTY_MOUND_FAITH_HELP_4',	     1000,	 1000,		       47,		'POLICY_ATLAS',			'POLICY_A_ATLAS');

INSERT INTO Policy_ImprovementYieldChanges
		(PolicyType,														                     ImprovementType,		                          YieldType,                       Yield)
Values	('POLICY_POVERTY_FIX_UI_BASE_YIELD',                                  'IMPROVEMENT_CEREMONIAL_MOUND_MOD',                             'YIELD_FAITH',                           1);

--
--