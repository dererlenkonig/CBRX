--==========================================================================================================================
-- Leaders
--==========================================================================================================================		
INSERT INTO Leaders 
			(Type, 									Description, 									Civilopedia, 										CivilopediaTag, 											ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'TXT_KEY_LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'TXT_KEY_LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'TXT_KEY_CIVILOPEDIA_LEADERS_MC_LITE_ABD_AR_RAHMAN_III', 	'AbdArRahmanIII_Diplo.xml',	6, 						6, 						4, 							7, 			5, 				2, 				3, 						6, 				5, 			3, 			5, 				2, 			4, 			'MC_LITE_MOORS_ATLAS',		1);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 							MajorCivApproachType, 				Bias)
VALUES		('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MAJOR_CIV_APPROACH_WAR', 			5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MAJOR_CIV_APPROACH_HOSTILE', 		2),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 							MinorCivApproachType, 				Bias)
VALUES		('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MINOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MINOR_CIV_APPROACH_CONQUEST', 		4),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'MINOR_CIV_APPROACH_BULLY', 		2);
--==========================================================================================================================
-- Leader_Flavors
--==========================================================================================================================					
INSERT INTO Leader_Flavors 
			(LeaderType, 							FlavorType, 						Flavor)
VALUES		('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_OFFENSE', 					4),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_RECON', 					4),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_RANGED', 					6),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_MOBILE', 					6),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_NAVAL', 					3),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_AIR', 						6),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_EXPANSION', 				3),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_GROWTH', 					8),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_GOLD', 						6),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_CULTURE', 					8),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_GREAT_PEOPLE', 				9),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_WONDER', 					6),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_RELIGION', 					4),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_SPACESHIP', 				7),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_NUKE', 						5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================
-- Leader_Traits
--==========================================================================================================================					
INSERT INTO Leader_Traits 
			(LeaderType, 							TraitType)
VALUES		('LEADER_MC_LITE_ABD_AR_RAHMAN_III', 	'TRAIT_MC_LITE_MOOR');
--==========================================================================================================================			
--==========================================================================================================================	