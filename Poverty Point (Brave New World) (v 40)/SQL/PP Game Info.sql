---------------------------
--Atlas
---------------------------

INSERT INTO IconTextureAtlases 
			(Atlas, 					          IconSize, 	                       Filename, 	    IconsPerRow, 	IconsPerColumn)
VALUES		('POVERTY_POINT_ATLAS', 				   256, 		 'PovertyPointAtlas256.dds',				  8, 				 1),
			('POVERTY_POINT_ATLAS', 				   214, 		 'PovertyPointAtlas214.dds',				  8, 				 1),
			('POVERTY_POINT_ATLAS', 				   128, 		 'PovertyPointAtlas128.dds',				  8, 				 1),
			('POVERTY_POINT_ATLAS', 					80, 		  'PovertyPointAtlas80.dds',				  8, 				 1),
			('POVERTY_POINT_ATLAS', 					64, 		  'PovertyPointAtlas64.dds',				  8, 				 1),
			('POVERTY_POINT_ATLAS', 					45, 		  'PovertyPointAtlas45.dds',				  8, 				 1),
			('POVERTY_POINT_ATLAS', 					32, 		  'PovertyPointAtlas32.dds',				  8, 				 1),			
			('POVERTY_POINT_ALPHA_ATLAS', 			   128, 	'PovertyPointAlphaAtlas128.dds',				  1, 				 1),
			('POVERTY_POINT_ALPHA_ATLAS', 			    64, 	 'PovertyPointAlphaAtlas64.dds',				  1, 				 1),
			('POVERTY_POINT_ALPHA_ATLAS', 			    48, 	 'PovertyPointAlphaAtlas48.dds',				  1, 				 1),
			('POVERTY_POINT_ALPHA_ATLAS', 			    32, 	 'PovertyPointAlphaAtlas32.dds',				  1, 				 1),
			('POVERTY_POINT_ALPHA_ATLAS', 			    24, 	 'PovertyPointAlphaAtlas24.dds',				  1, 				 1),
			('POVERTY_POINT_ALPHA_ATLAS', 			    16, 	 'PovertyPointAlphaAtlas16.dds',				  1, 				 1),			
			('POVERTY_POINT_PROMOTION_ATLAS',	       256,      'PovertyPointPromotion256.dds',				  2, 				 1),
			('POVERTY_POINT_PROMOTION_ATLAS',	        64,       'PovertyPointPromotion64.dds',				  2, 				 1),
			('POVERTY_POINT_PROMOTION_ATLAS',	        45,       'PovertyPointPromotion45.dds',				  2, 				 1),
			('POVERTY_POINT_PROMOTION_ATLAS',	        32,       'PovertyPointPromotion32.dds',				  2, 				 1),			
			('POVERTY_POINT_UNIT_ALPHA_ATLAS', 	        32,         'PovertyPointUnitAlpha.dds',				  1, 				 1),
			('POVERTY_POINT_ACTION_ATLAS', 			    64, 	      'PovertyPointBuild64.dds',				  1, 				 1),
			('POVERTY_POINT_ACTION_ATLAS', 			    45, 	      'PovertyPointBuild45.dds',				  1, 				 1),
			('POVERTY_POINT_ACTION_GOLD_ATLAS', 		64,       'PovertyPointBuildGold64.dds',				  1, 				 1),
			('POVERTY_POINT_ACTION_GOLD_ATLAS', 		45,       'PovertyPointBuildGold45.dds',				  1, 				 1),
			('POVERTY_POINT_ACTION_ATLAS_2', 			64, 	     'PovertyPoint2Build64.dds',				  1, 				 1),
			('POVERTY_POINT_ACTION_ATLAS_2', 			45, 	     'PovertyPoint2Build45.dds',				  1, 				 1),
			('POVERTY_POINT_ACTION_GOLD_ATLAS_2', 		64,      'PovertyPoint2BuildGold64.dds',				  1, 				 1),
			('POVERTY_POINT_ACTION_GOLD_ATLAS_2', 		45,      'PovertyPoint2BuildGold45.dds',				  1, 				 1),
			('POVERTY_POINT_SPIRIT_GUARDIAN_ATLAS',	   256, 		'PovertySpiritAtlas256.dds',				  8, 				 2),
			('POVERTY_POINT_SPIRIT_GUARDIAN_ATLAS',    214, 		'PovertySpiritAtlas214.dds',				  8, 				 2),
			('POVERTY_POINT_SPIRIT_GUARDIAN_ATLAS',    128, 		'PovertySpiritAtlas128.dds',				  8, 				 2),
			('POVERTY_POINT_SPIRIT_GUARDIAN_ATLAS', 	80, 		 'PovertySpiritAtlas80.dds',				  8, 				 2),
			('POVERTY_POINT_SPIRIT_GUARDIAN_ATLAS', 	64, 		 'PovertySpiritAtlas64.dds',				  8, 				 2),
			('POVERTY_POINT_SPIRIT_GUARDIAN_ATLAS', 	45, 		 'PovertySpiritAtlas45.dds',				  8, 				 2),
			('POVERTY_POINT_SPIRIT_GUARDIAN_ATLAS', 	32, 		 'PovertySpiritAtlas32.dds',				  8, 				 2);	

---------------------------
--Audio
---------------------------

INSERT INTO Audio_Sounds 
			(SoundID, 															    Filename, 						LoadType)
VALUES		('SND_LEADER_MUSIC_POVERTY_POINT_MOD_PEACE',				      'PovertyPeace', 			   'DynamicResident'),
			('SND_LEADER_MUSIC_POVERTY_POINT_MOD_WAR', 				            'PovertyWar', 		       'DynamicResident'),
			--('SND_DOM_SPEECH_POVERTY_POINT_MOD', 							    'PovertyDoM', 			   'DynamicResident'),
			('SND_SOUND_POVERTY_MOD_BUILD', 		                          'PovertyBuild',		       'DynamicResident');

INSERT INTO Audio_2DSounds 
			(ScriptID, 																									SoundID, 				SoundType, 			MinVolume, 			MaxVolume,			IsMusic)
VALUES		('AS2D_LEADER_MUSIC_POVERTY_POINT_MOD_PEACE', 				             'SND_LEADER_MUSIC_POVERTY_POINT_MOD_PEACE', 	         'GAME_MUSIC', 	               60, 		           60, 		          1),
			('AS2D_LEADER_MUSIC_POVERTY_POINT_MOD_WAR', 	                           'SND_LEADER_MUSIC_POVERTY_POINT_MOD_WAR', 		     'GAME_MUSIC', 	               75, 		           75, 		          1);

INSERT INTO Audio_2DSounds 
			(ScriptID, 																									SoundID, 				SoundType, 			 Looping,		MinVolume, 			MaxVolume)
VALUES		('AS2D_AMBIENCE_LEADER_POVERTY_POINT_MOD_AMBIENCE', 		                            'SND_AMBIENCE_ODA_AMBIENCE', 		       'GAME_SFX', 	               1,	           15, 		           15),
			--('AS2D_DOM_SPEECH_POVERTY_POINT_MOD', 		                                 'SND_DOM_SPEECH_POVERTY_POINT_MOD', 		    'GAME_SPEECH',           	   0,	           90, 		           90),
			('AS2D_SOUND_POVERTY_MOD_BUILD', 		                                              'SND_SOUND_POVERTY_MOD_BUILD', 		       'GAME_SFX',           	   0,              45, 		           45);