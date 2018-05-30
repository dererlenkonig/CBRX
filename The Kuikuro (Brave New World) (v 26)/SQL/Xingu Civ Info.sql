---------------------------
--Civilizations
---------------------------

INSERT INTO Civilizations 
		(Type,												Description,							 ShortDescription,									Adjective,								CivilopediaTag,					 DefaultPlayerColor,							 ArtDefineTag,						  ArtStyleType,			  PortraitIndex,					IconAtlas,					AlphaIconAtlas,					   MapImage,			ArtStyleSuffix,			 ArtStylePrefix,								     DawnOfManQuote,				  DawnOfManImage,							DawnOfManAudio,				SoundtrackTag)
VALUES	('CIVILIZATION_XINGU_MOD',			   'TXT_KEY_XINGU_MOD_DESC',			   'TXT_KEY_XINGU_MOD_SHORT_DESC',			    'TXT_KEY_XINGU_MOD_ADJECTIVE',			    'TXT_KEY_CIVLOPEDIA_XINGU_MOD',			    'PLAYERCOLOR_XINGU_MOD',		    'ART_DEF_CIVILIZATION_BRAZIL',			  'ARTSTYLE_SOUTH_AMERICA',                       0,			'XINGU_ATLAS_MOD',		   'XINGU_ALPHA_ATLAS_MOD',			'Xingu_Map_Mod.dds',			       '_AMER',			     'AMERICAN',			   'TXT_KEY_DAWN_OF_MAN_XINGU_MOD_TEXT',			 'Xingu_DoM_Mod.dds',                                     NULL,                   'Aztec');

INSERT INTO Civilization_Leaders 
		(CivilizationType,											                   LeaderheadType)
VALUES	('CIVILIZATION_XINGU_MOD',				                                   'LEADER_XINGU_MOD');

INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType,											                BuildingClassType)
VALUES	('CIVILIZATION_XINGU_MOD',				                               'BUILDINGCLASS_PALACE');

INSERT INTO Civilization_FreeTechs 
		(CivilizationType,											                         TechType)
VALUES	('CIVILIZATION_XINGU_MOD',				                                   'TECH_AGRICULTURE');

INSERT INTO Civilization_FreeUnits 
		(CivilizationType,							  UnitClassType,			Count,						     UnitAIType)
VALUES	('CIVILIZATION_XINGU_MOD',			    'UNITCLASS_SETTLER',				1,						'UNITAI_SETTLE');

INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType,											         BuildingClassType,						                        BuildingType)
VALUES	('CIVILIZATION_XINGU_MOD',				                       'BUILDINGCLASS_GRANARY',							                'BUILDING_XINGU');

INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType,											             UnitClassType,						                            UnitType)
VALUES	('CIVILIZATION_XINGU_MOD',				                           'UNITCLASS_WARRIOR',							                'UNIT_XINGU_MOD');

INSERT INTO Civilization_Start_Region_Priority 
		(CivilizationType,											     RegionType)
VALUES	('CIVILIZATION_XINGU_MOD',				                    'REGION_JUNGLE');

INSERT INTO Civilization_Religions 
		(CivilizationType,											   ReligionType)
VALUES	('CIVILIZATION_XINGU_MOD',				            'RELIGION_CHRISTIANITY');

INSERT INTO Colors 
		(Type,										   Red,		  Green,		 Blue,			 Alpha)
VALUES	('COLOR_PLAYER_XINGU_MOD_ICON',				 0.086,       0.329,        0.286,               1),
		('COLOR_PLAYER_XINGU_MOD_BACKGROUND',	     0.490,       0.701,        0.478,               1);

INSERT INTO PlayerColors 
		(Type,							                            PrimaryColor,			                            SecondaryColor,						                TextColor)
VALUES	('PLAYERCOLOR_XINGU_MOD',			       'COLOR_PLAYER_XINGU_MOD_ICON',				   'COLOR_PLAYER_XINGU_MOD_BACKGROUND',						'COLOR_PLAYER_WHITE_TEXT');

INSERT INTO Civilization_CityNames 
			(CivilizationType, 				                                       CityName)
VALUES		('CIVILIZATION_XINGU_MOD', 						'TXT_KEY_CITY_NAME_XINGU_MOD_1'),
			('CIVILIZATION_XINGU_MOD', 						'TXT_KEY_CITY_NAME_XINGU_MOD_2'),
			('CIVILIZATION_XINGU_MOD', 						'TXT_KEY_CITY_NAME_XINGU_MOD_3'),
			('CIVILIZATION_XINGU_MOD', 						'TXT_KEY_CITY_NAME_XINGU_MOD_4'),
			('CIVILIZATION_XINGU_MOD', 						'TXT_KEY_CITY_NAME_XINGU_MOD_5'),
			('CIVILIZATION_XINGU_MOD', 						'TXT_KEY_CITY_NAME_XINGU_MOD_6'),
			('CIVILIZATION_XINGU_MOD', 						'TXT_KEY_CITY_NAME_XINGU_MOD_7'),
			('CIVILIZATION_XINGU_MOD', 						'TXT_KEY_CITY_NAME_XINGU_MOD_8'),
			('CIVILIZATION_XINGU_MOD', 						'TXT_KEY_CITY_NAME_XINGU_MOD_9'),
			('CIVILIZATION_XINGU_MOD', 					   'TXT_KEY_CITY_NAME_XINGU_MOD_10'),
			('CIVILIZATION_XINGU_MOD', 					   'TXT_KEY_CITY_NAME_XINGU_MOD_11'),
			('CIVILIZATION_XINGU_MOD', 					   'TXT_KEY_CITY_NAME_XINGU_MOD_12'),
			('CIVILIZATION_XINGU_MOD', 					   'TXT_KEY_CITY_NAME_XINGU_MOD_13'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_14'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_15'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_16'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_17'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_18'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_19'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_20'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_21'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_22'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_23'),
			('CIVILIZATION_XINGU_MOD', 		               'TXT_KEY_CITY_NAME_XINGU_MOD_24'),
			('CIVILIZATION_XINGU_MOD', 				       'TXT_KEY_CITY_NAME_XINGU_MOD_25'),
			('CIVILIZATION_XINGU_MOD', 		               'TXT_KEY_CITY_NAME_XINGU_MOD_26');

INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				                                        SpyName)
VALUES		('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_0'),	
			('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_1'),	
			('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_2'),	
			('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_3'),	
			('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_4'),	
			('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_5'),	
			('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_6'),	
			('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_7'),	
			('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_8'),	
			('CIVILIZATION_XINGU_MOD', 						 'TXT_KEY_SPY_NAME_XINGU_MOD_9');

---------------------------
--Traits
---------------------------

INSERT INTO Traits 
		(Type,											                                   Description,						                                ShortDescription)
VALUES	('TRAIT_GARDEN_CITIES',				                             'TXT_KEY_TRAIT_GARDEN_CITIES',							         'TXT_KEY_TRAIT_GARDEN_CITIES_SHORT');

---------------------------
--Leaders
---------------------------

INSERT INTO Leaders 
		(Type,														          Description,									       Civilopedia,						              CivilopediaTag,									ArtDefineTag,		VictoryCompetitiveness,		WonderCompetitiveness,		MinorCivCompetitiveness,	 Boldness,		DiploBalance,		WarmongerHate,		DenounceWillingness,		DoFWillingness,			Loyalty,		Neediness,		Forgiveness,	Chattiness,		Meanness,	PortraitIndex,	                IconAtlas)
VALUES	('LEADER_XINGU_MOD',			                  'TXT_KEY_LEADER_XINGU_MOD_DESC',				       'TXT_KEY_LEADER_XINGU_MOD_PEDIA',			    'TXT_KEY_LEADER_XINGU_MOD_PEDIA',					'Xingu_Leader_Scene_Mod.xml',						     5,							4,							  4,            6,                 5,                   6,                        5,                     6,               6,                4,                4,             6,            5,               1,			'XINGU_ATLAS_MOD');

INSERT INTO Leader_Traits 
		(LeaderType,											                            TraitType)
VALUES	('LEADER_XINGU_MOD',				                                    'TRAIT_GARDEN_CITIES');

INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 						MajorCivApproachType, 				 Bias)
VALUES		('LEADER_XINGU_MOD', 			'MAJOR_CIV_APPROACH_WAR', 					4),
			('LEADER_XINGU_MOD', 		'MAJOR_CIV_APPROACH_HOSTILE', 					4),
			('LEADER_XINGU_MOD', 	  'MAJOR_CIV_APPROACH_DECEPTIVE', 					3),
			('LEADER_XINGU_MOD', 		'MAJOR_CIV_APPROACH_GUARDED', 					3),
			('LEADER_XINGU_MOD', 		 'MAJOR_CIV_APPROACH_AFRAID', 					3),
			('LEADER_XINGU_MOD', 	   'MAJOR_CIV_APPROACH_FRIENDLY', 					5),
			('LEADER_XINGU_MOD', 		'MAJOR_CIV_APPROACH_NEUTRAL', 					5);

INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 						MinorCivApproachType, 				 Bias)
VALUES		('LEADER_XINGU_MOD', 		 'MINOR_CIV_APPROACH_IGNORE', 					4),
			('LEADER_XINGU_MOD', 	   'MINOR_CIV_APPROACH_FRIENDLY', 					5),
			('LEADER_XINGU_MOD', 	 'MINOR_CIV_APPROACH_PROTECTIVE', 					4),
			('LEADER_XINGU_MOD', 	   'MINOR_CIV_APPROACH_CONQUEST', 					4),
			('LEADER_XINGU_MOD', 	      'MINOR_CIV_APPROACH_BULLY', 					4);

INSERT INTO Leader_Flavors 
			(LeaderType, 									FlavorType, 					   Flavor)
VALUES		('LEADER_XINGU_MOD', 					  'FLAVOR_OFFENSE', 							5),
			('LEADER_XINGU_MOD', 					  'FLAVOR_DEFENSE', 							6),
			('LEADER_XINGU_MOD', 				 'FLAVOR_CITY_DEFENSE', 							7),
			('LEADER_XINGU_MOD', 			'FLAVOR_MILITARY_TRAINING', 							5),
			('LEADER_XINGU_MOD', 						'FLAVOR_RECON', 							7),
			('LEADER_XINGU_MOD', 					   'FLAVOR_RANGED', 							8),
			('LEADER_XINGU_MOD', 					   'FLAVOR_MOBILE', 							4),
			('LEADER_XINGU_MOD', 						'FLAVOR_NAVAL', 							4),
			('LEADER_XINGU_MOD', 			      'FLAVOR_NAVAL_RECON', 							3),
			('LEADER_XINGU_MOD', 			     'FLAVOR_NAVAL_GROWTH', 							3),
			('LEADER_XINGU_MOD', 	   'FLAVOR_NAVAL_TILE_IMPROVEMENT', 							5),
			('LEADER_XINGU_MOD', 						  'FLAVOR_AIR', 							4),
			('LEADER_XINGU_MOD', 				    'FLAVOR_EXPANSION', 							4),
			('LEADER_XINGU_MOD', 					   'FLAVOR_GROWTH', 						    7),
			('LEADER_XINGU_MOD', 			 'FLAVOR_TILE_IMPROVEMENT', 							8),
			('LEADER_XINGU_MOD', 			   'FLAVOR_INFRASTRUCTURE', 							8),
			('LEADER_XINGU_MOD', 				   'FLAVOR_PRODUCTION', 							5),
			('LEADER_XINGU_MOD', 						 'FLAVOR_GOLD', 							5),
			('LEADER_XINGU_MOD', 					  'FLAVOR_SCIENCE', 							5),
			('LEADER_XINGU_MOD', 					  'FLAVOR_CULTURE', 							6),
			('LEADER_XINGU_MOD', 					'FLAVOR_HAPPINESS', 							6),
			('LEADER_XINGU_MOD', 				 'FLAVOR_GREAT_PEOPLE', 							4),
			('LEADER_XINGU_MOD', 					   'FLAVOR_WONDER', 							4),
			('LEADER_XINGU_MOD', 					 'FLAVOR_RELIGION', 							5),
			('LEADER_XINGU_MOD', 					'FLAVOR_DIPLOMACY', 							6),
			('LEADER_XINGU_MOD', 					'FLAVOR_SPACESHIP', 							4),
			('LEADER_XINGU_MOD', 			 'FLAVOR_WATER_CONNECTION', 							4),
			('LEADER_XINGU_MOD', 						 'FLAVOR_NUKE', 							5),
			('LEADER_XINGU_MOD', 					 'FLAVOR_USE_NUKE', 							5),
			('LEADER_XINGU_MOD', 					'FLAVOR_ESPIONAGE', 							6),
			('LEADER_XINGU_MOD', 				      'FLAVOR_ANTIAIR', 							5),
			('LEADER_XINGU_MOD', 				  'FLAVOR_AIR_CARRIER', 							4),
			('LEADER_XINGU_MOD', 		          'FLAVOR_ARCHAEOLOGY', 							8),
			('LEADER_XINGU_MOD', 		   'FLAVOR_I_LAND_TRADE_ROUTE', 							7),
			('LEADER_XINGU_MOD', 		    'FLAVOR_I_SEA_TRADE_ROUTE', 							5),
			('LEADER_XINGU_MOD', 		       'FLAVOR_I_TRADE_ORIGIN', 							5),
			('LEADER_XINGU_MOD', 		  'FLAVOR_I_TRADE_DESTINATION', 							5),
			('LEADER_XINGU_MOD', 					  'FLAVOR_AIRLIFT', 							3);

---------------------------
--Diplomacy
---------------------------

INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_XINGU_MOD',			'RESPONSE_FIRST_GREETING',			'TXT_KEY_LEADER_XINGU_MOD_FIRST_GREETING_%',				'1');
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_XINGU_MOD',			'RESPONSE_DEFEATED',				'TXT_KEY_LEADER_XINGU_MOD_DEFEATED_%',						'1');
