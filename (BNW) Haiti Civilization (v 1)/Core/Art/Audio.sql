--==========================================================================================================================
-- Audio_Sounds
--==========================================================================================================================	
INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 				LoadType)
VALUES		('SND_LEADER_MUSIC_LEUGI_LOUVERTURE_PEACE', 	'HaitiPeace', 		'DynamicResident'),
			('SND_LEADER_MUSIC_LEUGI_LOUVERTURE_WAR', 		'HaitiWar', 		'DynamicResident'),
			('SND_UNIT_HOUNGAN_CHANT',					'houngan_activate',		'DynamicResident');
--==========================================================================================================================
-- Audio_2DSounds
--==========================================================================================================================	
INSERT INTO Audio_2DSounds 
			(ScriptID, 											SoundID, 									SoundType, 		MinVolume, 	MaxVolume,	IsMusic, Looping)
VALUES		('AS2D_AMBIENCE_LEADER_LEUGI_LOUVERTURE_AMBIENCE', 	'SND_AMBIENCE_NAPOLEON_AMBIENCE', 			'GAME_SFX', 	50, 		50, 		0, 		1),
			('AS2D_LEADER_MUSIC_LEUGI_LOUVERTURE_PEACE', 		'SND_LEADER_MUSIC_LEUGI_LOUVERTURE_PEACE', 	'GAME_MUSIC', 	50, 		50, 		1, 		0),
			('AS2D_LEADER_MUSIC_LEUGI_LOUVERTURE_WAR', 			'SND_LEADER_MUSIC_LEUGI_LOUVERTURE_WAR', 	'GAME_MUSIC', 	50, 		50, 		1,		0);
--==========================================================================================================================
-- Audio_3DSounds
--==========================================================================================================================	
INSERT INTO Audio_3DSounds 
			(ScriptID, 						SoundID, 							SoundType, 		MinVolume, 	MaxVolume,	DontPlayMoreThan, DontTriggerDuplicates)
VALUES		('AS3D_UNIT_HOUNGAN_CHANT', 	'SND_UNIT_HOUNGAN_CHANT', 			'GAME_SFX', 	70, 		70, 		1, 					1);
--==========================================================================================================================	
--==========================================================================================================================	
