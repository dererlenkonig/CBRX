--
INSERT INTO IconTextureAtlases 
		(Atlas, 						  IconSize, 	                  Filename, 	IconsPerRow, 	IconsPerColumn)
VALUES	('SHANG_STANDALONE_ATLAS', 			   256, 	  'ShangStandalone256.dds',				  1, 				 1),
		('SHANG_STANDALONE_ATLAS', 			   214, 	  'ShangStandalone214.dds',				  1, 				 1),
		('SHANG_STANDALONE_ATLAS', 			   128, 	  'ShangStandalone128.dds',				  1, 				 1),
		('SHANG_STANDALONE_ATLAS', 			    80, 	   'ShangStandalone80.dds',				  1, 				 1),
		('SHANG_STANDALONE_ATLAS', 				64, 	   'ShangStandalone64.dds',				  1, 				 1),
		('SHANG_STANDALONE_ATLAS', 				45, 	   'ShangStandalone45.dds',				  1, 				 1),
		('SHANG_STANDALONE_ATLAS', 				32, 	   'ShangStandalone32.dds',				  1, 				 1),
		('SHANG_STANDALONE_ALPHA', 			   128,  'ShangStandaloneAlpha128.dds',				  1, 				 1),
		('SHANG_STANDALONE_ALPHA', 				64,   'ShangStandaloneAlpha64.dds',				  1, 				 1),
		('SHANG_STANDALONE_ALPHA', 				48,   'ShangStandaloneAlpha48.dds',				  1, 				 1),
		('SHANG_STANDALONE_ALPHA', 				32,   'ShangStandaloneAlpha32.dds',				  1, 				 1),
		('SHANG_STANDALONE_ALPHA', 				24,   'ShangStandaloneAlpha24.dds',				  1, 				 1),
		('SHANG_STANDALONE_ALPHA', 				16,   'ShangStandaloneAlpha16.dds',				  1, 				 1);

INSERT INTO Colors 
		(Type,												Red,		Green,			Blue,			Alpha)
VALUES	('COLOR_PLAYER_SHANG_STANDALONE_ICON',	          0.698,        0.690,         0.674,               1),
		('COLOR_PLAYER_SHANG_STANDALONE_BACKGROUND',	  0.333,        0.286,         0.184,               1);

INSERT INTO PlayerColors 
		(Type,							                            PrimaryColor,			                            SecondaryColor,						                TextColor)
VALUES	('PLAYERCOLOR_SHANG_STANDALONE',	'COLOR_PLAYER_SHANG_STANDALONE_ICON',		    'COLOR_PLAYER_SHANG_STANDALONE_BACKGROUND',						'COLOR_PLAYER_WHITE_TEXT');