--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SENSHI_BOMBOGOR', 		'TXT_KEY_LEADER_SENSHI_BOMBOGOR', 	'TXT_KEY_CIVILOPEDIA_LEADER_SENSHI_BOMBOGOR', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SENSHI_BOMBOGOR', 	'Bombogor_Scene.xml',			4, 						5, 						3, 							8, 			5, 				10, 			7, 						4, 				7, 			5, 			3, 				2, 			3, 			'SENSHI_EVENKS_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_BOMBOGOR', 		'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_SENSHI_BOMBOGOR', 		'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_SENSHI_BOMBOGOR', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_SENSHI_BOMBOGOR', 		'MAJOR_CIV_APPROACH_GUARDED', 		9),
			('LEADER_SENSHI_BOMBOGOR', 		'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_SENSHI_BOMBOGOR', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_SENSHI_BOMBOGOR', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_BOMBOGOR', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_SENSHI_BOMBOGOR', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_SENSHI_BOMBOGOR', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_SENSHI_BOMBOGOR', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_SENSHI_BOMBOGOR', 	'MINOR_CIV_APPROACH_BULLY', 		2);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_DEFENSE', 					8),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_RECON', 					4),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_RANGED', 					7),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_MOBILE', 					7),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_NAVAL', 					3),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_NAVAL_GROWTH', 				3),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_AIR', 						5),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_EXPANSION', 				9),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_GROWTH', 					8),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_GOLD', 						4),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_CULTURE', 					6),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_WONDER', 					5),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_RELIGION', 					9),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_DIPLOMACY', 				4),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_NUKE', 						6),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_USE_NUKE', 					6),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_ESPIONAGE', 				8),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		3),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		7),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_ARCHAEOLOGY', 				6),
			('LEADER_SENSHI_BOMBOGOR', 	'FLAVOR_AIR_CARRIER', 				3);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_SENSHI_BOMBOGOR', 	'TRAIT_SENSHI_EVENKS');
--==========================================================================================================================				
--==========================================================================================================================		