--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SENSHI_HAWKE', 		'TXT_KEY_LEADER_SENSHI_HAWKE', 	'TXT_KEY_CIVILOPEDIA_LEADER_SENSHI_HAWKE', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SENSHI_HAWKE', 	'BobHawke_Scene.xml',				4, 						4, 						5, 							8, 			5, 				4, 				4, 						6, 				8, 			4, 			4, 				6, 			2, 			'SENSHI_HAWKE_ATLAS',		1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_HAWKE', 		'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_SENSHI_HAWKE', 		'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_SENSHI_HAWKE', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_SENSHI_HAWKE', 		'MAJOR_CIV_APPROACH_GUARDED', 		4),
			('LEADER_SENSHI_HAWKE', 		'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_SENSHI_HAWKE', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_SENSHI_HAWKE', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_HAWKE', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_SENSHI_HAWKE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_SENSHI_HAWKE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_SENSHI_HAWKE', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
			('LEADER_SENSHI_HAWKE', 	'MINOR_CIV_APPROACH_BULLY', 		2);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_SENSHI_HAWKE', 	'FLAVOR_OFFENSE', 					5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_RECON', 					6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_RANGED', 					5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_MOBILE', 					4),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_NAVAL', 					5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_AIR', 						7),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_GROWTH', 					7),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_INFRASTRUCTURE', 			7),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_GOLD', 						5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_CULTURE', 					8),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_GREAT_PEOPLE', 				9),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_WONDER', 					6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_RELIGION', 					2),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_SPACESHIP', 				3),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_NUKE', 						3),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_USE_NUKE', 					3),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_ESPIONAGE', 				4),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_AIRLIFT', 					6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		6),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_SENSHI_HAWKE', 	'FLAVOR_AIR_CARRIER', 				3);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_SENSHI_HAWKE', 	'TRAIT_SENSHI_HAWKE');
--==========================================================================================================================				
--==========================================================================================================================		