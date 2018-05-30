--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 							Description, 						Civilopedia, 									CivilopediaTag, 								ArtDefineTag, 					VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_SENSHI_SEONJO', 		'TXT_KEY_LEADER_SENSHI_SEONJO', 	'TXT_KEY_CIVILOPEDIA_LEADER_SENSHI_SEONJO', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SENSHI_SEONJO', 	'Seonjo_Scene.xml',				4, 						4, 						2, 							5, 			7, 				10, 			8, 						6, 				10, 		5, 			2, 				4, 			3, 			'SENSHI_KOREA_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_SEONJO', 		'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_SENSHI_SEONJO', 		'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_SENSHI_SEONJO', 		'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_SENSHI_SEONJO', 		'MAJOR_CIV_APPROACH_GUARDED', 		10),
			('LEADER_SENSHI_SEONJO', 		'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_SENSHI_SEONJO', 		'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_SENSHI_SEONJO', 		'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_SENSHI_SEONJO', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_SENSHI_SEONJO', 	'MINOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_SENSHI_SEONJO', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
			('LEADER_SENSHI_SEONJO', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_SENSHI_SEONJO', 	'MINOR_CIV_APPROACH_BULLY', 		2);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_SENSHI_SEONJO', 	'FLAVOR_OFFENSE', 					5),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_RECON', 					5),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_RANGED', 					5),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_MOBILE', 					6),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_NAVAL', 					10),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_NAVAL_RECON', 				9),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_NAVAL_GROWTH', 				9),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	7),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_AIR', 						5),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_GROWTH', 					7),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_GOLD', 						3),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_CULTURE', 					7),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_GREAT_PEOPLE', 				8),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_WONDER', 					3),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_RELIGION', 					6),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_DIPLOMACY', 				4),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_SPACESHIP', 				7),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_WATER_CONNECTION', 			8),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_NUKE', 						4),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_USE_NUKE', 					4),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_ESPIONAGE', 				4),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_AIRLIFT', 					3),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		6),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		4),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_SENSHI_SEONJO', 	'FLAVOR_AIR_CARRIER', 				4);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_SENSHI_SEONJO', 	'TRAIT_SENSHI_KOREA');
--==========================================================================================================================				
--==========================================================================================================================		