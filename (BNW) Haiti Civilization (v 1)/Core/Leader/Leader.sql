--==========================================================================================================================
-- Leaders
--==========================================================================================================================		
INSERT INTO Leaders 
			(Type, 						Description, 							Civilopedia, 							CivilopediaTag, 												ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_LEUGI_LOUVERTURE', 	'TXT_KEY_LEADER_LEUGI_LOUVERTURE_DESC', 	'TXT_KEY_LEADER_LEUGI_LOUVERTURE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_LEUGI_LOUVERTURE', 	'Louverture_Scene.xml',		10, 					1, 						7, 							10,			5, 				10, 			8, 						6, 				10, 		1, 			1, 				10, 		8, 			'LEUGI_HAITI_ATLAS', 	0);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES		('LEADER_LEUGI_LOUVERTURE', 	'MAJOR_CIV_APPROACH_WAR', 			8),
			('LEADER_LEUGI_LOUVERTURE', 	'MAJOR_CIV_APPROACH_HOSTILE', 		8),
			('LEADER_LEUGI_LOUVERTURE', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_LEUGI_LOUVERTURE', 	'MAJOR_CIV_APPROACH_GUARDED', 		3),
			('LEADER_LEUGI_LOUVERTURE', 	'MAJOR_CIV_APPROACH_AFRAID', 		1),
			('LEADER_LEUGI_LOUVERTURE', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_LEUGI_LOUVERTURE', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 					Bias)
VALUES		('LEADER_LEUGI_LOUVERTURE', 	'MINOR_CIV_APPROACH_IGNORE', 		1),
			('LEADER_LEUGI_LOUVERTURE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_LEUGI_LOUVERTURE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	9),
			('LEADER_LEUGI_LOUVERTURE', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_LEUGI_LOUVERTURE', 	'MINOR_CIV_APPROACH_BULLY', 		1);
--==========================================================================================================================
-- Leader_Flavors
--==========================================================================================================================					
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_MILITARY_TRAINING', 		9),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_RECON', 					5),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_RANGED', 					5),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_MOBILE', 					5),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_NAVAL', 					9),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_NAVAL_RECON', 				8),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_NAVAL_GROWTH', 				8),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	7),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_AIR', 						10),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_EXPANSION', 				1),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_GROWTH', 					10),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_GOLD', 						1),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_CULTURE', 					8),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_HAPPINESS', 				1),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_WONDER', 					1),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_RELIGION', 					10),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_SPACESHIP', 				1),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_NUKE', 						1),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_USE_NUKE', 					1),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_ESPIONAGE', 				9),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_AIRLIFT', 					1),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_I_TRADE_DESTINATION', 		6),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_I_TRADE_ORIGIN', 			6),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		8),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		1),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_LEUGI_LOUVERTURE', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================
-- Leader_Traits
--==========================================================================================================================					
INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_LEUGI_LOUVERTURE', 	'TRAIT_LEUGI_HAITI');
--==========================================================================================================================			
--==========================================================================================================================	