--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- IconTextureAtlasesa
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES	('DMS_ETHIOPIA_ATLAS', 						256, 		'EthiopiaAtlas_256.dds',					5,				4),
		('DMS_ETHIOPIA_ATLAS', 						128, 		'EthiopiaAtlas_128.dds',					5, 				4),
		('DMS_ETHIOPIA_ATLAS', 						80, 		'EthiopiaAtlas_80.dds',						5, 				4),
		('DMS_ETHIOPIA_ATLAS', 						64, 		'EthiopiaAtlas_64.dds',						5, 				4),
		('DMS_ETHIOPIA_ATLAS', 						45, 		'EthiopiaAtlas_45.dds',						5, 				4),
		('DMS_ETHIOPIA_ATLAS', 						32, 		'EthiopiaAtlas_32.dds',						5, 				4),
		('DMS_SEMIEN_ATLAS', 						256, 		'SemienAtlas_256.dds',						2,				2),
		('DMS_SEMIEN_ATLAS', 						128, 		'SemienAtlas_128.dds',						2, 				2),
		('DMS_SEMIEN_ATLAS', 						80, 		'SemienAtlas_80.dds',						2, 				2),
		('DMS_SEMIEN_ATLAS', 						64, 		'SemienAtlas_64.dds',						2, 				2),
		('DMS_SEMIEN_ATLAS', 						45, 		'SemienAtlas_45.dds',						2, 				2),
		('DMS_SEMIEN_ATLAS', 						32, 		'SemienAtlas_32.dds',						2, 				2),
		('DMS_ETHIOPIA_ALPHA_ATLAS', 				128, 		'EthiopiaAlphaAtlas_128.dds',				4, 				1),
		('DMS_ETHIOPIA_ALPHA_ATLAS', 				80, 		'EthiopiaAlphaAtlas_80.dds',				4, 				1),
		('DMS_ETHIOPIA_ALPHA_ATLAS', 				64, 		'EthiopiaAlphaAtlas_64.dds',				4, 				1),
		('DMS_ETHIOPIA_ALPHA_ATLAS', 				48, 		'EthiopiaAlphaAtlas_48.dds',				4, 				1),
		('DMS_ETHIOPIA_ALPHA_ATLAS', 				45, 		'EthiopiaAlphaAtlas_45.dds',				4, 				1),
		('DMS_ETHIOPIA_ALPHA_ATLAS', 				32, 		'EthiopiaAlphaAtlas_32.dds',				4, 				1),
		('DMS_ETHIOPIA_ALPHA_ATLAS', 				24, 		'EthiopiaAlphaAtlas_24.dds',				4, 				1),
		('DMS_ETHIOPIA_ALPHA_ATLAS', 				16, 		'EthiopiaAlphaAtlas_16.dds',				4, 				1),
		('DMS_SEMIEN_ALPHA_ATLAS', 					128, 		'SemienAlphaAtlas_128.dds',					1, 				1),
		('DMS_SEMIEN_ALPHA_ATLAS', 					80, 		'SemienAlphaAtlas_80.dds',					1, 				1),
		('DMS_SEMIEN_ALPHA_ATLAS', 					64, 		'SemienAlphaAtlas_64.dds',					1, 				1),
		('DMS_SEMIEN_ALPHA_ATLAS', 					48, 		'SemienAlphaAtlas_48.dds',					1, 				1),
		('DMS_SEMIEN_ALPHA_ATLAS', 					45, 		'SemienAlphaAtlas_45.dds',					1, 				1),
		('DMS_SEMIEN_ALPHA_ATLAS', 					32, 		'SemienAlphaAtlas_32.dds',					1, 				1),
		('DMS_SEMIEN_ALPHA_ATLAS', 					24, 		'SemienAlphaAtlas_24.dds',					1, 				1),
		('DMS_SEMIEN_ALPHA_ATLAS', 					16, 		'SemienAlphaAtlas_16.dds',					1, 				1),
		('DMS_MONOLITHIC_CHURCH_ATLAS', 			256, 		'MonolithicChurchIcon256.dds',				1, 				2),
		('DMS_MONOLITHIC_CHURCH_ATLAS', 			64, 		'MonolithicChurchIcon64.dds',				1, 				2),
		('DMS_MONOLITHIC_CHURCH_ATLAS', 			45, 		'MonolithicChurchIcon45.dds',				1, 				2),
		('DMS_SARAWIT_FLAG_ART_ATLAS', 				32, 		'UnitFlag_Sarawit_32.dds',					1, 				1),
		('DMS_SHOTELAI_FLAG_ART_ATLAS', 			32, 		'UnitFlag_Shotelai_32.dds',					1, 				1),
		('DMS_KOREM_FLAG_ART_ATLAS', 				32, 		'UnitFlag_Korem_32.dds',					1, 				1),
		('DMS_DEBTERA_FLAG_ART_ATLAS', 				32, 		'UnitFlag_Debtera_32.dds',					1, 				1),
		('DMS_SEBASTOPOL_FLAG_ART_ATLAS',			32, 		'UnitFlag_Sebastopol_32.dds',				1, 				1),
		('DMS_KAGNEW_FLAG_ART_ATLAS', 				32, 		'UnitFlag_Kagnew_32.dds',					1, 				1),
		('DMS_MAKONNEN_FLAG_ART_ATLAS', 			32, 		'UnitFlag_Makonnen_32.dds',					1, 				1),
		('DMS_AGAW_BOUDA_FLAG_ART_ATLAS', 			32, 		'UnitFlag_AgawBouda_32.dds',				1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 													Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_AKSUM_ICON', 							0.667, 	0.416, 	0.067, 	1),
		('COLOR_PLAYER_AKSUM_BACKGROUND', 						0.059,	0.039,	0.259,	1),
		('COLOR_PLAYER_ETHIOPIA_AMDA_SEYON_ICON', 				0.765, 	0.596, 	0.412, 	1),
		('COLOR_PLAYER_ETHIOPIA_AMDA_SEYON_BACKGROUND', 		0.467,	0.106,	0.039,	1),
		('COLOR_PLAYER_ETHIOPIA_ZARA_YAQOB_ICON', 				0.239, 	0.569, 	0.525, 	1),
		('COLOR_PLAYER_ETHIOPIA_ZARA_YAQOB_BACKGROUND', 		0.067,	0.051,	0.294,	1),
		('COLOR_PLAYER_ETHIOPIA_MENELIK_ICON', 					0.851, 	0.733, 	0.2, 	1),
		('COLOR_PLAYER_ETHIOPIA_MENELIK_BACKGROUND', 			0.325,	0.431,	0.212,	1),
		('COLOR_PLAYER_SEMIEN_GUDIT_ICON', 						0.824, 	0.702, 	0.424, 	1),
		('COLOR_PLAYER_SEMIEN_GUDIT_BACKGROUND', 				0.333,	0.035,	0.184,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 									PrimaryColor, 								SecondaryColor, 									TextColor)
VALUES	('PLAYERCOLOR_DMS_AKSUM_KALEB', 		'COLOR_PLAYER_AKSUM_ICON', 					'COLOR_PLAYER_AKSUM_BACKGROUND', 					'COLOR_PLAYER_WHITE_TEXT'),
		('PLAYERCOLOR_DMS_ETHIOPIA_SEYON_I',	'COLOR_PLAYER_ETHIOPIA_AMDA_SEYON_ICON', 	'COLOR_PLAYER_ETHIOPIA_AMDA_SEYON_BACKGROUND', 		'COLOR_PLAYER_WHITE_TEXT'),
		('PLAYERCOLOR_DMS_ETHIOPIA_YAQOB',		'COLOR_PLAYER_ETHIOPIA_ZARA_YAQOB_ICON', 	'COLOR_PLAYER_ETHIOPIA_ZARA_YAQOB_BACKGROUND', 		'COLOR_PLAYER_WHITE_TEXT'),
		('PLAYERCOLOR_DMS_ETHIOPIA_MENELIK_II', 'COLOR_PLAYER_ETHIOPIA_MENELIK_ICON', 		'COLOR_PLAYER_ETHIOPIA_MENELIK_BACKGROUND', 		'COLOR_PLAYER_WHITE_TEXT'),
		('PLAYERCOLOR_DMS_SEMIEN_GUDIT',		'COLOR_PLAYER_SEMIEN_GUDIT_ICON', 			'COLOR_PLAYER_SEMIEN_GUDIT_BACKGROUND', 			'COLOR_PLAYER_WHITE_TEXT');
------------------------------
-- ArtDefine_LandmarkTypes
------------------------------	
INSERT INTO ArtDefine_LandmarkTypes
		(Type,									LandmarkType,	FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH', 'Improvement',	'ETHIOPIA_MONOLITHIC_CHURCH';
------------------------------
-- ArtDefine_Landmarks
------------------------------	
INSERT INTO ArtDefine_Landmarks
		(Era,	State,					Scale,	ImprovementType,							LayoutHandler,	ResourceType,			Model,					TerrainContour)
SELECT	'Any',	'UnderConstruction',	1.5,	'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'Lalibela_HB.fxsxml',	1 UNION ALL
SELECT	'Any',	'Constructed',			1.5,	'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'Lalibela_B.fxsxml',	1 UNION ALL
SELECT	'Any',	'Pillaged',				1.5,	'ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'Lalibela_PL.fxsxml',	1;
------------------------------
-- ArtDefine_StrategicView
------------------------------	
INSERT INTO ArtDefine_StrategicView
		(StrategicViewType,							TileType,		Asset)
VALUES	('ART_DEF_IMPROVEMENT_MONOLITHIC_CHURCH',	'Improvement', 'sv_monolithic_church.dds');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 									Filename, 			LoadType)
VALUES	('SND_LEADER_MUSIC_DMS_KALEB_PEACE',		'Kaleb_Peace',		'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_KALEB_WAR', 			'Kaleb_War', 		'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_SEYON_I_PEACE',		'AmdaSeyonI_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_SEYON_I_WAR', 		'AmdaSeyonI_War', 	'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_YAQOB_PEACE', 		'ZaraYaqob_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_YAQOB_WAR',			'ZaraYaqob_War', 	'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_MENELIK_II_PEACE', 	'MenelikII_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_MENELIK_II_WAR', 	'MenelikII_War', 	'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_GUDIT_PEACE',		'Gudit_Peace',		'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_GUDIT_WAR', 			'Gudit_War', 		'DynamicResident');			
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 									SoundType, 		MinVolume, 	MaxVolume,  IsMusic,	Looping)
VALUES	('AS2D_LEADER_MUSIC_DMS_KALEB_PEACE', 			'SND_LEADER_MUSIC_DMS_KALEB_PEACE', 		'GAME_MUSIC', 	60, 		60, 		1, 			0),
		('AS2D_LEADER_MUSIC_DMS_KALEB_WAR', 			'SND_LEADER_MUSIC_DMS_KALEB_WAR', 			'GAME_MUSIC', 	60, 		60, 		1,			0),
		('AS2D_LEADER_MUSIC_DMS_SEYON_I_PEACE', 		'SND_LEADER_MUSIC_DMS_SEYON_I_PEACE', 		'GAME_MUSIC', 	50, 		50, 		1, 			0),
		('AS2D_LEADER_MUSIC_DMS_SEYON_I_WAR', 			'SND_LEADER_MUSIC_DMS_SEYON_I_WAR', 		'GAME_MUSIC', 	80, 		80, 		1,			0),
		('AS2D_LEADER_MUSIC_DMS_YAQOB_PEACE', 			'SND_LEADER_MUSIC_DMS_YAQOB_PEACE', 		'GAME_MUSIC', 	60, 		60, 		1, 			0),
		('AS2D_LEADER_MUSIC_DMS_YAQOB_WAR', 			'SND_LEADER_MUSIC_DMS_YAQOB_WAR', 			'GAME_MUSIC', 	60, 		60, 		1,			0),
		('AS2D_LEADER_MUSIC_DMS_MENELIK_II_PEACE', 		'SND_LEADER_MUSIC_DMS_MENELIK_II_PEACE',	'GAME_MUSIC', 	60, 		60, 		1, 			0),
		('AS2D_LEADER_MUSIC_DMS_MENELIK_II_WAR', 		'SND_LEADER_MUSIC_DMS_MENELIK_II_WAR', 		'GAME_MUSIC', 	60, 		60, 		1,			0),
		('AS2D_LEADER_MUSIC_DMS_GUDIT_PEACE', 			'SND_LEADER_MUSIC_DMS_GUDIT_PEACE',			'GAME_MUSIC', 	40, 		40, 		1, 			0),
		('AS2D_LEADER_MUSIC_DMS_GUDIT_WAR', 			'SND_LEADER_MUSIC_DMS_GUDIT_WAR', 			'GAME_MUSIC', 	60, 		60, 		1,			0);
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 				TileType,	Asset)
VALUES	('ART_DEF_UNIT_DMS_SARAWIT', 		'Unit', 	'sv_u_sarawit.dds'),
		('ART_DEF_UNIT_DMS_SHOTELAI', 		'Unit', 	'sv_u_shotelai.dds'),
		('ART_DEF_UNIT_DMS_KOREM', 			'Unit', 	'sv_u_korem.dds'),
		('ART_DEF_UNIT_DMS_DEBTERA', 		'Unit', 	'sv_u_debtera.dds'),
		('ART_DEF_UNIT_DMS_SEBASTOPOL', 	'Unit', 	'sv_u_sebastopol.dds'),
		('ART_DEF_UNIT_DMS_KAGNEW', 		'Unit', 	'sv_u_kagnew.dds'),
		('ART_DEF_UNIT_DMS_MAKONNEN', 		'Unit', 	'sv_u_makonnen.dds'),
		('ART_DEF_UNIT_DMS_AGAW_BOUDA', 	'Unit', 	'sv_u_agawbouda.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_SARAWIT'),		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_SPEARMAN');

INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_KOREM'),			DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_KNIGHT');

INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_SHOTELAI'),		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_SWORDSMAN');

INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_DEBTERA'),		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_MISSIONARY');

INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_SEBASTOPOL'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_ARTILLERY');

INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_KAGNEW'),		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_INFANTRY');

INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_MAKONNEN'),		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_WW1_FIGHTER');

INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_AGAW_BOUDA'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_COMPOSITE_BOWMAN');
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	('ART_DEF_UNIT_DMS_SARAWIT'),		('ART_DEF_UNIT_MEMBER_DMS_SARAWIT'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_SPEARMAN');

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	('ART_DEF_UNIT_DMS_KOREM'),			('ART_DEF_UNIT_MEMBER_DMS_KOREM'),		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_KNIGHT');

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	('ART_DEF_UNIT_DMS_SHOTELAI'),		('ART_DEF_UNIT_MEMBER_DMS_SHOTELAI'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_SWORDSMAN');

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	('ART_DEF_UNIT_DMS_DEBTERA'),		('ART_DEF_UNIT_MEMBER_DMS_DEBTERA'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_MISSIONARY');

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	('ART_DEF_UNIT_DMS_SEBASTOPOL'),	('ART_DEF_UNIT_MEMBER_DMS_SEBASTOPOL'),	1
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_ARTILLERY');

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	('ART_DEF_UNIT_DMS_KAGNEW'),		('ART_DEF_UNIT_MEMBER_DMS_KAGNEW'),		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_INFANTRY');

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	('ART_DEF_UNIT_DMS_MAKONNEN'),		('ART_DEF_UNIT_MEMBER_DMS_MAKONNEN'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_WW1_FIGHTER');

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	('ART_DEF_UNIT_DMS_AGAW_BOUDA'),	('ART_DEF_UNIT_MEMBER_DMS_AGAW_BOUDA'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_COMPOSITE_BOWMAN');
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_SARAWIT'),		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SPEARMAN');

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_KOREM'),			EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT');

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_SHOTELAI'),		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SWORDSMAN');

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_DEBTERA'),		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_MISSIONARY');

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_SEBASTOPOL'),		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_ARTILLERY');

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_KAGNEW'),			EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_INFANTRY');

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_MAKONNEN'),		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_WW1_FIGHTER');

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_AGAW_BOUDA'),		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_COMPOSITE_BOWMAN');
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_SARAWIT'),		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SPEARMAN');

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_KOREM'),			"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_KNIGHT');

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_SHOTELAI'),		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SWORDSMAN');

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_DEBTERA'),		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_MISSIONARY');

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_SEBASTOPOL'),		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_ARTILLERY');

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_KAGNEW'),			"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_INFANTRY');

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_MAKONNEN'),		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_WW1_FIGHTER');

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_AGAW_BOUDA'),		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_COMPOSITE_BOWMAN');
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model,								MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_SARAWIT'),	Scale,	ZOffset, Domain, ('EthiopiaSpearman.fxsxml'),		MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_SPEARMAN');

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model,								MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_KOREM'),		Scale,	ZOffset, Domain, ('EthiopiaKnight.fxsxml'),			MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_KNIGHT');

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model,								MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_SHOTELAI'),	Scale,	ZOffset, Domain, ('EthiopiaMedSwordsman.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_SWORDSMAN');

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model,								MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_DEBTERA'),	Scale,	ZOffset, Domain, ('DMS_EthiopianMissionary.fxsxml'),MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_MISSIONARY');

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model,								MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_SEBASTOPOL'),	Scale,	ZOffset, Domain, ('Bombard.fxsxml'),				MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_ARTILLERY');

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model,								MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_KAGNEW'),		Scale,	ZOffset, Domain, ('AfricanInfantry.fxsxml'),		MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_INFANTRY');

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model,							MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_MAKONNEN'),	Scale,	ZOffset, Domain, ('Spowith_Camel.fxsxml'),		MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_WW1_FIGHTER');

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model,							MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_AGAW_BOUDA'),	Scale,	ZOffset, Domain, ('EthiopiaCompBow.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_COMPOSITE_BOWMAN');
--==========================================================================================================================	
--==========================================================================================================================	
