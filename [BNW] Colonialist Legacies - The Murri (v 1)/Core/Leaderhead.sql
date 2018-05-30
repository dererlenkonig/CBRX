--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 						VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_CL_GANUURRU', 		'TXT_KEY_LEADER_CL_GANUURRU', 	'TXT_KEY_CIVILOPEDIA_LEADER_CL_GANUURRU', 	'TXT_KEY_CIVILOPEDIA_LEADERS_CL_GANUURRU', 	'Ganuurru_Scene.xml',								7, 						4, 						5, 							8, 			4, 				6, 				7, 						5, 				8, 			3, 			2, 				7, 			6, 			'CL_MURRI_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_CL_GANUURRU', 		'MAJOR_CIV_APPROACH_WAR', 			8),
			('LEADER_CL_GANUURRU', 		'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_CL_GANUURRU', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
			('LEADER_CL_GANUURRU', 		'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_CL_GANUURRU', 		'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_CL_GANUURRU', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_CL_GANUURRU', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_CL_GANUURRU', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_CL_GANUURRU', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_CL_GANUURRU', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_CL_GANUURRU', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_CL_GANUURRU', 	'MINOR_CIV_APPROACH_BULLY', 		2);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_CL_GANUURRU', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_CL_GANUURRU', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_CL_GANUURRU', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_CL_GANUURRU', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_RECON', 					6),
			('LEADER_CL_GANUURRU', 	'FLAVOR_RANGED', 					6),
			('LEADER_CL_GANUURRU', 	'FLAVOR_MOBILE', 					4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_NAVAL', 					4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_AIR', 						5),
			('LEADER_CL_GANUURRU', 	'FLAVOR_EXPANSION', 				11),
			('LEADER_CL_GANUURRU', 	'FLAVOR_GROWTH', 					7),
			('LEADER_CL_GANUURRU', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
			('LEADER_CL_GANUURRU', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_CL_GANUURRU', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_CL_GANUURRU', 	'FLAVOR_GOLD', 						4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_CULTURE', 					6),
			('LEADER_CL_GANUURRU', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_CL_GANUURRU', 	'FLAVOR_GREAT_PEOPLE', 				5),
			('LEADER_CL_GANUURRU', 	'FLAVOR_WONDER', 					4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_RELIGION', 					8),
			('LEADER_CL_GANUURRU', 	'FLAVOR_DIPLOMACY', 				4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_WATER_CONNECTION', 			4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_NUKE', 						2),
			('LEADER_CL_GANUURRU', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_CL_GANUURRU', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_CL_GANUURRU', 	'FLAVOR_AIRLIFT', 					4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_CL_GANUURRU', 	'FLAVOR_I_TRADE_ORIGIN', 			7),
			('LEADER_CL_GANUURRU', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		4),
			('LEADER_CL_GANUURRU', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		7),
			('LEADER_CL_GANUURRU', 	'FLAVOR_ARCHAEOLOGY', 				3),
			('LEADER_CL_GANUURRU', 	'FLAVOR_AIR_CARRIER', 				4);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_CL_GANUURRU', 	'TRAIT_CL_MURRI');
--==========================================================================================================================				
--==========================================================================================================================		