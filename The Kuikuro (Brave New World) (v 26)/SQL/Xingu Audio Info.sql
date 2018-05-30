INSERT INTO Audio_Sounds 
			(SoundID, 												    Filename, 						LoadType)
VALUES	  --('SND_DOM_SPEECH_XINGU_MOD', 							  'XinguDoM', 			   'DynamicResident'),
			('SND_LEADER_MUSIC_XINGU_MOD_PEACE',				    'XinguPeace', 			   'DynamicResident'),
			('SND_LEADER_MUSIC_XINGU_MOD_WAR', 				          'XinguWar', 			   'DynamicResident');


INSERT INTO Audio_2DSounds 
			(ScriptID, 																		   SoundID, 				SoundType, 			MinVolume, 			MaxVolume,			IsMusic)
VALUES		('AS2D_LEADER_MUSIC_XINGU_MOD_PEACE', 				    'SND_LEADER_MUSIC_XINGU_MOD_PEACE', 	         'GAME_MUSIC', 	               60, 		           60, 		          1),
			('AS2D_LEADER_MUSIC_XINGU_MOD_WAR', 	                  'SND_LEADER_MUSIC_XINGU_MOD_WAR', 		     'GAME_MUSIC', 	               60, 		           60, 		          1);

INSERT INTO Audio_2DSounds 
			(ScriptID, 																					    SoundID, 				SoundType, 			 Looping,		MinVolume, 			MaxVolume)
VALUES	  --('AS2D_DOM_SPEECH_XINGU_MOD', 		                                         'SND_DOM_SPEECH_XINGU_MOD', 		    'GAME_SPEECH',           	   0,	           90, 		           90),
			('AS2D_AMBIENCE_LEADER_XINGU_MOD_AMBIENCE', 		                          'SND_AMBIENCE_JUNGLE_BED', 		       'GAME_SFX', 	               1,	           25, 		           25);
			