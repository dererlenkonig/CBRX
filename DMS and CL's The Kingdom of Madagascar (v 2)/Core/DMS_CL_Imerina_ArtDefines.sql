--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- IconTextureAtlasesa
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('DMS_CL_IMERINA_ATLAS', 					256, 		'DMS_CL_ImerinaAtlas_256.dds',			2, 				2),
		('DMS_CL_IMERINA_ATLAS', 					128, 		'DMS_CL_ImerinaAtlas_128.dds',			2, 				2),
		('DMS_CL_IMERINA_ATLAS', 					80, 		'DMS_CL_ImerinaAtlas_80.dds',			2, 				2),
		('DMS_CL_IMERINA_ATLAS', 					64, 		'DMS_CL_ImerinaAtlas_64.dds',			2, 				2),
		('DMS_CL_IMERINA_ATLAS', 					45, 		'DMS_CL_ImerinaAtlas_45.dds',			2, 				2),
		('DMS_CL_IMERINA_ATLAS', 					32, 		'DMS_CL_ImerinaAtlas_32.dds',			2, 				2),
		('DMS_CL_IMERINA_ALPHA_ATLAS', 				128, 		'DMS_CL_ImerinaAlphaAtlas_128.dds',		1,				1),
		('DMS_CL_IMERINA_ALPHA_ATLAS', 				80, 		'DMS_CL_ImerinaAlphaAtlas_80.dds',		1, 				1),
		('DMS_CL_IMERINA_ALPHA_ATLAS', 				64, 		'DMS_CL_ImerinaAlphaAtlas_64.dds',		1, 				1),
		('DMS_CL_IMERINA_ALPHA_ATLAS', 				48, 		'DMS_CL_ImerinaAlphaAtlas_48.dds',		1, 				1),
		('DMS_CL_IMERINA_ALPHA_ATLAS', 				45, 		'DMS_CL_ImerinaAlphaAtlas_45.dds',		1, 				1),
		('DMS_CL_IMERINA_ALPHA_ATLAS', 				32, 		'DMS_CL_ImerinaAlphaAtlas_32.dds',		1, 				1),
		('DMS_CL_IMERINA_ALPHA_ATLAS', 				24, 		'DMS_CL_ImerinaAlphaAtlas_24.dds',		1, 				1),
		('DMS_CL_IMERINA_ALPHA_ATLAS', 				16, 		'DMS_CL_ImerinaAlphaAtlas_16.dds',		1, 				1),
		('DMS_CL_IMERINA_ROVA_ATLAS', 				256, 		'DMS_CL_ImerinaRovaAtlas_256.dds',		1, 				2),
		('DMS_CL_IMERINA_ROVA_ATLAS', 				64, 		'DMS_CL_ImerinaRovaAtlas_64.dds',		1, 				2),
		('DMS_CL_IMERINA_ROVA_ATLAS', 				45, 		'DMS_CL_ImerinaRovaAtlas_45.dds',		1, 				2),
		('DMS_CL_TAFIKA_FLAG_ART_ATLAS', 			32, 		'UnitFlag_Tafika_32.dds',				1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_DMS_CL_IMERINA_ICON',			0.353,	0.741,	0.055,	1),
		('COLOR_PLAYER_DMS_CL_IMERINA_BACKGROUND',		0.682,	0.027,	0.208,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 								PrimaryColor, 								SecondaryColor, 								TextColor)
VALUES	('PLAYERCOLOR_DMS_CL_IMERINA',		'COLOR_PLAYER_DMS_CL_IMERINA_ICON', 	'COLOR_PLAYER_DMS_CL_IMERINA_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 										Filename, 				LoadType)
VALUES	('SND_LEADER_MUSIC_DMS_CL_RANAVALONA_I_PEACE', 	'RanavalonaI_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_CL_RANAVALONA_I_WAR', 	'RanavalonaI_War', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 										SoundType, 		MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_DMS_CL_RANAVALONA_I_PEACE', 'SND_LEADER_MUSIC_DMS_CL_RANAVALONA_I_PEACE',	'GAME_MUSIC', 	60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_DMS_CL_RANAVALONA_I_WAR', 	'SND_LEADER_MUSIC_DMS_CL_RANAVALONA_I_WAR', 	'GAME_MUSIC', 	60, 		60, 		1,		 0);
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 				TileType,		Asset)
VALUES	('ART_DEF_UNIT_DMS_CL_TAFIKA', 		'Unit', 		'sv_u_tafika.dds');

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType,					TileType,		Asset)
SELECT 'ART_DEF_IMPROVEMENT_DMS_CL_ROVA',	'Improvement',	'sv_i_rova.dds';
------------------------------
-- ArtDefine_LandmarkTypes
------------------------------	
INSERT INTO ArtDefine_LandmarkTypes
		(Type,								LandmarkType,	FriendlyName)
SELECT	'ART_DEF_IMPROVEMENT_DMS_CL_ROVA',	'Improvement',	'IMERINA_ROVA';
------------------------------
-- ArtDefine_Landmarks
------------------------------	
INSERT INTO ArtDefine_Landmarks
		(Era,	State,					Scale,	ImprovementType,					LayoutHandler,	ResourceType,			Model,							TerrainContour)
SELECT	'Any',	'UnderConstruction',	1,		'ART_DEF_IMPROVEMENT_DMS_CL_ROVA',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL',	'European Fort 1 HB.fxsxml',	1				UNION ALL
SELECT	'Any',	'Constructed',			1,		'ART_DEF_IMPROVEMENT_DMS_CL_ROVA',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'European Fort 1 B.fxsxml',		1				UNION ALL
SELECT	'Any',	'Pillaged',				1,		'ART_DEF_IMPROVEMENT_DMS_CL_ROVA',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'European Fort 1 PL.fxsxml',	1;
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_CL_TAFIKA'),		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_PIKEMAN');
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT	('ART_DEF_UNIT_DMS_CL_TAFIKA'),		('ART_DEF_UNIT_MEMBER_DMS_CL_TAFIKA'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_PIKEMAN');
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_CL_TAFIKA'),		EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_PIKEMAN');
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_CL_TAFIKA'),		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_PIKEMAN');
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model,						MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_CL_TAFIKA'),	Scale,	ZOffset, Domain, 'BA_EthiopiaSpear.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_PIKEMAN');
--==========================================================================================================================	
--==========================================================================================================================	
