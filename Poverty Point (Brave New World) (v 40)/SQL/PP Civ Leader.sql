---------------------------
--Civilizations
---------------------------

INSERT INTO Civilizations 
		(Type,										                     Description,							      ShortDescription,									     Adjective,								     CivilopediaTag,					        DefaultPlayerColor,						      ArtDefineTag,				          ArtStyleType,			  PortraitIndex,				        IconAtlas,				        AlphaIconAtlas,					     MapImage,			ArtStyleSuffix,			   ArtStylePrefix,									         DawnOfManQuote,			        DawnOfManImage,			     SoundtrackTag)			--DawnOfManAudio,
VALUES	('CIVILIZATION_POVERTY_POINT_MOD',		    'TXT_KEY_POVERTY_POINT_MOD_DESC',			'TXT_KEY_POVERTY_POINT_MOD_SHORT_DESC',			 'TXT_KEY_POVERTY_POINT_MOD_ADJECTIVE',			 'TXT_KEY_CIVLOPEDIA_POVERTY_POINT_MOD',			 'PLAYERCOLOR_POVERTY_POINT_MOD_1',		   'ART_DEF_CIVILIZATION_IROQUOIS',			  'ARTSTYLE_SOUTH_AMERICA',                       0,			'POVERTY_POINT_ATLAS',		   'POVERTY_POINT_ALPHA_ATLAS',			'PovertyPointMap.dds',			       '_AMER',			       'AMERICAN',			   'TXT_KEY_DAWN_OF_MAN_POVERTY_POINT_MOD_TEXT',			 'PovertyPointDoM.dds',                 'Iroquois');		--'AS2D_DOM_SPEECH_POVERTY_POINT_MOD',

INSERT INTO Civilization_Leaders 
		(CivilizationType,											                        LeaderheadType)
VALUES	('CIVILIZATION_POVERTY_POINT_MOD',				                        'LEADER_POVERTY_POINT_MOD');

INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType,											                        BuildingClassType)
VALUES	('CIVILIZATION_POVERTY_POINT_MOD',				                               'BUILDINGCLASS_PALACE');

INSERT INTO Civilization_FreeTechs 
		(CivilizationType,											                                 TechType)
VALUES	('CIVILIZATION_POVERTY_POINT_MOD',				                                   'TECH_AGRICULTURE');

INSERT INTO Civilization_FreeUnits 
		(CivilizationType,							          UnitClassType,			Count,				 UnitAIType)
VALUES	('CIVILIZATION_POVERTY_POINT_MOD',	            'UNITCLASS_SETTLER',				1,			'UNITAI_SETTLE');

INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType,											                   UnitClassType,						                             UnitType)
VALUES	('CIVILIZATION_POVERTY_POINT_MOD',				                         'UNITCLASS_PROPHET',							         'UNIT_POVERTY_POINT_MOD');

INSERT INTO Civilization_Religions 
		(CivilizationType,											                           ReligionType)
VALUES	('CIVILIZATION_POVERTY_POINT_MOD',				                           'RELIGION_PROTESTANTISM');

INSERT INTO Colors 
		(Type,											           Red,		   Green,		   Blue,			Alpha)
VALUES	('COLOR_PLAYER_POVERTY_POINT_MOD_ICON_1',				 0.474,        0.443,         0.188,                1),
		('COLOR_PLAYER_POVERTY_POINT_MOD_ICON_2',				 0.258,        0.341,         0.341,                1),
		('COLOR_PLAYER_POVERTY_POINT_MOD_BACKGROUND_1',	         0.862,        0.807,         0.619,                1),
		('COLOR_PLAYER_POVERTY_POINT_MOD_BACKGROUND_2',	         0.984,        0.784,         0.509,                1);

INSERT INTO PlayerColors 
		(Type,							                                                PrimaryColor,			                                        SecondaryColor,						                TextColor)
VALUES	('PLAYERCOLOR_POVERTY_POINT_MOD_1',			         'COLOR_PLAYER_POVERTY_POINT_MOD_ICON_1',				     'COLOR_PLAYER_POVERTY_POINT_MOD_BACKGROUND_1',						'COLOR_PLAYER_WHITE_TEXT'),
		('PLAYERCOLOR_POVERTY_POINT_MOD_2',			         'COLOR_PLAYER_POVERTY_POINT_MOD_ICON_2',				     'COLOR_PLAYER_POVERTY_POINT_MOD_BACKGROUND_2',						'COLOR_PLAYER_WHITE_TEXT');

INSERT INTO Civilization_CityNames 
			(CivilizationType, 				                                                                         CityName)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_0'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_1'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_2'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_3'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_4'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_5'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_6'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_7'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_8'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                      'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_9'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_10'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_11'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_12'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_13'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_14'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_15'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_16'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_17'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_18'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_19'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_20'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_21'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_22'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_23'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_24'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_25'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_26'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_27'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_28'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_29'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_30'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_31'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_32'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_33'),
			('CIVILIZATION_POVERTY_POINT_MOD', 					                     'TXT_KEY_CITY_NAME_POVERTY_POINT_MOD_34');

INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				                                           SpyName)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_0'),	
			('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_1'),	
			('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_2'),	
			('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_3'),	
			('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_4'),	
			('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_5'),	
			('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_6'),	
			('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_7'),	
			('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_8'),	
			('CIVILIZATION_POVERTY_POINT_MOD', 			'TXT_KEY_SPY_NAME_POVERTY_POINT_MOD_9');

---------------------------
--Traits
---------------------------

INSERT INTO Traits 
		(Type,											                                           Description,						                                    ShortDescription)
VALUES	('TRAIT_OLD_MAN_ABOVE_PP_MOD',				                      'TXT_KEY_TRAIT_OLD_MAN_ABOVE_PP_MOD',							      'TXT_KEY_TRAIT_OLD_MAN_ABOVE_PP_MOD_SHORT');

---------------------------
--Leaders
---------------------------

INSERT INTO Leaders 
		(Type,														                  Description,									         Civilopedia,						                      CivilopediaTag,						   ArtDefineTag,		VictoryCompetitiveness,		WonderCompetitiveness,		MinorCivCompetitiveness,	 Boldness,		DiploBalance,		WarmongerHate,		DenounceWillingness,		DoFWillingness,			Loyalty,		Neediness,		Forgiveness,	Chattiness,		Meanness,	PortraitIndex,	                    IconAtlas)
VALUES	('LEADER_POVERTY_POINT_MOD',			          'TXT_KEY_LEADER_POVERTY_POINT_MOD_DESC',				'TXT_KEY_LEADER_POVERTY_POINT_MOD_PEDIA',					      'TXT_KEY_LEADER_POVERTY_POINT_MOD',				'Poverty_Scene_Mod.xml',						     4,							6,							  5,            5,                 5,                   5,                        5,                     5,               5,                5,                6,             5,            4,               1,			'POVERTY_POINT_ATLAS');

INSERT INTO Leader_Traits 
		(LeaderType,											                           TraitType)
VALUES	('LEADER_POVERTY_POINT_MOD',				                    'TRAIT_OLD_MAN_ABOVE_PP_MOD');

INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 									MajorCivApproachType, 				 Bias)
VALUES		('LEADER_POVERTY_POINT_MOD', 			    'MAJOR_CIV_APPROACH_WAR', 					4),
			('LEADER_POVERTY_POINT_MOD', 		    'MAJOR_CIV_APPROACH_HOSTILE', 					4),
			('LEADER_POVERTY_POINT_MOD', 	      'MAJOR_CIV_APPROACH_DECEPTIVE', 					4),
			('LEADER_POVERTY_POINT_MOD', 		    'MAJOR_CIV_APPROACH_GUARDED', 					5),
			('LEADER_POVERTY_POINT_MOD', 		     'MAJOR_CIV_APPROACH_AFRAID', 					5),
			('LEADER_POVERTY_POINT_MOD', 	       'MAJOR_CIV_APPROACH_FRIENDLY', 					5),
			('LEADER_POVERTY_POINT_MOD', 		    'MAJOR_CIV_APPROACH_NEUTRAL', 					6);

INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 									MinorCivApproachType, 				 Bias)
VALUES		('LEADER_POVERTY_POINT_MOD', 		     'MINOR_CIV_APPROACH_IGNORE', 					5),
			('LEADER_POVERTY_POINT_MOD', 	       'MINOR_CIV_APPROACH_FRIENDLY', 					5),
			('LEADER_POVERTY_POINT_MOD', 	     'MINOR_CIV_APPROACH_PROTECTIVE', 					4),
			('LEADER_POVERTY_POINT_MOD', 	       'MINOR_CIV_APPROACH_CONQUEST', 					4),
			('LEADER_POVERTY_POINT_MOD', 	          'MINOR_CIV_APPROACH_BULLY', 					4);

INSERT INTO Leader_Flavors 
			(LeaderType, 											FlavorType, 					   Flavor)
VALUES		('LEADER_POVERTY_POINT_MOD', 					  'FLAVOR_OFFENSE', 							5),
			('LEADER_POVERTY_POINT_MOD', 					  'FLAVOR_DEFENSE', 							5),
			('LEADER_POVERTY_POINT_MOD', 				 'FLAVOR_CITY_DEFENSE', 							5),
			('LEADER_POVERTY_POINT_MOD', 			'FLAVOR_MILITARY_TRAINING', 							5),
			('LEADER_POVERTY_POINT_MOD', 						'FLAVOR_RECON', 							6),
			('LEADER_POVERTY_POINT_MOD', 					   'FLAVOR_RANGED', 							6),
			('LEADER_POVERTY_POINT_MOD', 					   'FLAVOR_MOBILE', 							5),
			('LEADER_POVERTY_POINT_MOD', 						'FLAVOR_NAVAL', 							4),
			('LEADER_POVERTY_POINT_MOD', 			      'FLAVOR_NAVAL_RECON', 							4),
			('LEADER_POVERTY_POINT_MOD', 			     'FLAVOR_NAVAL_GROWTH', 							4),
			('LEADER_POVERTY_POINT_MOD', 	   'FLAVOR_NAVAL_TILE_IMPROVEMENT', 							5),
			('LEADER_POVERTY_POINT_MOD', 						  'FLAVOR_AIR', 							5),
			('LEADER_POVERTY_POINT_MOD', 				    'FLAVOR_EXPANSION', 							5),
			('LEADER_POVERTY_POINT_MOD', 					   'FLAVOR_GROWTH', 						    5),
			('LEADER_POVERTY_POINT_MOD', 			 'FLAVOR_TILE_IMPROVEMENT', 							7),
			('LEADER_POVERTY_POINT_MOD', 			   'FLAVOR_INFRASTRUCTURE', 							5),
			('LEADER_POVERTY_POINT_MOD', 				   'FLAVOR_PRODUCTION', 							5),
			('LEADER_POVERTY_POINT_MOD', 						 'FLAVOR_GOLD', 							6),
			('LEADER_POVERTY_POINT_MOD', 					  'FLAVOR_SCIENCE', 							5),
			('LEADER_POVERTY_POINT_MOD', 					  'FLAVOR_CULTURE', 							5),
			('LEADER_POVERTY_POINT_MOD', 					'FLAVOR_HAPPINESS', 							7),
			('LEADER_POVERTY_POINT_MOD', 				 'FLAVOR_GREAT_PEOPLE', 						    5),
			('LEADER_POVERTY_POINT_MOD', 					   'FLAVOR_WONDER', 							5),
			('LEADER_POVERTY_POINT_MOD', 					 'FLAVOR_RELIGION', 						    5),
			('LEADER_POVERTY_POINT_MOD', 					'FLAVOR_DIPLOMACY', 							5),
			('LEADER_POVERTY_POINT_MOD', 					'FLAVOR_SPACESHIP', 							5),
			('LEADER_POVERTY_POINT_MOD', 			 'FLAVOR_WATER_CONNECTION', 							4),
			('LEADER_POVERTY_POINT_MOD', 						 'FLAVOR_NUKE', 							5),
			('LEADER_POVERTY_POINT_MOD', 					 'FLAVOR_USE_NUKE', 							5),
			('LEADER_POVERTY_POINT_MOD', 					'FLAVOR_ESPIONAGE', 							5),
			('LEADER_POVERTY_POINT_MOD', 				      'FLAVOR_ANTIAIR', 							5),
			('LEADER_POVERTY_POINT_MOD', 				  'FLAVOR_AIR_CARRIER', 							5),
			('LEADER_POVERTY_POINT_MOD', 		          'FLAVOR_ARCHAEOLOGY', 							6),
			('LEADER_POVERTY_POINT_MOD', 		   'FLAVOR_I_LAND_TRADE_ROUTE', 							6),
			('LEADER_POVERTY_POINT_MOD', 		    'FLAVOR_I_SEA_TRADE_ROUTE', 							4),
			('LEADER_POVERTY_POINT_MOD', 		       'FLAVOR_I_TRADE_ORIGIN', 							6),
			('LEADER_POVERTY_POINT_MOD', 		  'FLAVOR_I_TRADE_DESTINATION', 							6),
			('LEADER_POVERTY_POINT_MOD', 					  'FLAVOR_AIRLIFT', 							5);

---------------------------
--Diplomacy
---------------------------

INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_POVERTY_POINT_MOD',			'RESPONSE_FIRST_GREETING',			'TXT_KEY_LEADER_POVERTY_POINT_MOD_FIRST_GREETING_%',				'1');
INSERT INTO Diplomacy_Responses (LeaderType, ResponseType, Response, Bias) VALUES ('LEADER_POVERTY_POINT_MOD',			'RESPONSE_DEFEATED',				'TXT_KEY_LEADER_POVERTY_POINT_MOD_DEFEATED_%',						'1');