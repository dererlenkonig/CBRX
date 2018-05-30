--==========================================================================================================================	
-- Audio_Sounds
--==========================================================================================================================		
INSERT INTO Audio_Sounds 
			(SoundID, 														Filename, 								LoadType)
VALUES		('SND_LEADER_MUSIC_MC_LITE_ABD_AR_RAHMAN_III_PEACE',		 	'AbdArRahmanIII_Peace',					'DynamicResident'),
			('SND_LEADER_MUSIC_MC_LITE_ABD_AR_RAHMAN_III_WAR', 				'AbdArRahmanIII_War', 					'DynamicResident'),
			('SND_DOM_SPEECH_MC_LITE_MOORS', 								'MoorsDoM',								'DynamicResident');			
--==========================================================================================================================	
-- Audio_2DSounds
--==========================================================================================================================		
INSERT INTO Audio_2DSounds 
			(ScriptID, 														SoundID, 												SoundType, 			MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_MC_LITE_ABD_AR_RAHMAN_III_PEACE', 			'SND_LEADER_MUSIC_MC_LITE_ABD_AR_RAHMAN_III_PEACE', 	'GAME_MUSIC', 		80, 		80, 		1, 		 0),
			('AS2D_LEADER_MUSIC_MC_LITE_ABD_AR_RAHMAN_III_WAR', 			'SND_LEADER_MUSIC_MC_LITE_ABD_AR_RAHMAN_III_WAR', 		'GAME_MUSIC', 		80, 		80, 		1,		 0),
			('AS2D_DOM_SPEECH_MC_LITE_MOORS', 								'SND_DOM_SPEECH_MC_LITE_MOORS',							'GAME_SPEECH', 		100, 		100, 		0, 		 0);
--==========================================================================================================================		
--==========================================================================================================================		
