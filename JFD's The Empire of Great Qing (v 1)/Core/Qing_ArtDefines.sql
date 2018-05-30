--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_QING_ATLAS', 						256, 		'JFD_QingAtlas_256.dds',				2, 				2),
		('JFD_QING_ATLAS', 						128, 		'JFD_QingAtlas_128.dds',				2, 				2),
		('JFD_QING_ATLAS', 						80, 		'JFD_QingAtlas_80.dds',					2, 				2),
		('JFD_QING_ATLAS', 						64, 		'JFD_QingAtlas_64.dds',					2, 				2),
		('JFD_QING_ATLAS', 						45, 		'JFD_QingAtlas_45.dds',					2, 				2),
		('JFD_QING_ATLAS', 						32, 		'JFD_QingAtlas_32.dds',					2, 				2),
		('JFD_QING_ALPHA_ATLAS', 				128, 		'JFD_QingAlphaAtlas_128.dds',			1,				1),
		('JFD_QING_ALPHA_ATLAS', 				80, 		'JFD_QingAlphaAtlas_80.dds',			1, 				1),
		('JFD_QING_ALPHA_ATLAS', 				64, 		'JFD_QingAlphaAtlas_64.dds',			1, 				1),
		('JFD_QING_ALPHA_ATLAS', 				48, 		'JFD_QingAlphaAtlas_48.dds',			1, 				1),
		('JFD_QING_ALPHA_ATLAS', 				45, 		'JFD_QingAlphaAtlas_45.dds',			1, 				1),
		('JFD_QING_ALPHA_ATLAS', 				32, 		'JFD_QingAlphaAtlas_32.dds',			1, 				1),
		('JFD_QING_ALPHA_ATLAS', 				24, 		'JFD_QingAlphaAtlas_24.dds',			1, 				1),
		('JFD_QING_ALPHA_ATLAS', 				16, 		'JFD_QingAlphaAtlas_16.dds',			1, 				1),
		('JFD_UNIT_FLAG_PEKING_FORCE_ATLAS',	32, 		'Unit_PekingForce_Flag_32.dds',			1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 									Red, 	Green, 	Blue,	Alpha)
VALUES	('COLOR_PLAYER_JFD_QING_ICON', 			0.090,	0.215,	0.388,	1),
		('COLOR_PLAYER_JFD_QING_BACKGROUND', 	0.917,	0.725,	0.129,	1);
------------------------------	
-- PlayerColors
------------------------------				
INSERT INTO PlayerColors 
		(Type, 									PrimaryColor, 						SecondaryColor, 						TextColor)
VALUES	('PLAYERCOLOR_JFD_QING',				'COLOR_PLAYER_JFD_QING_ICON', 		'COLOR_PLAYER_JFD_QING_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 								Filename, 							LoadType)
VALUES	('SND_BUILDING_JFD_NAVAL_COLLEGE', 		'NavalCollege',						'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_CIXI_PEACE', 	'Cixi_Peace', 						'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_CIXI_WAR', 		'Cixi_War', 						'DynamicResident');			
------------------------------	
-- Audio_2DSounds
------------------------------		
INSERT INTO Audio_2DSounds 
		(ScriptID, 								SoundID, 							SoundType, 		MinVolume, 	MaxVolume,  IsMusic,	Looping)
VALUES	('AS2D_BUILDING_JFD_NAVAL_COLLEGE',		'SND_BUILDING_JFD_NAVAL_COLLEGE',	'GAME_SFX', 	100, 		100, 		0, 			0),
		('AS2D_LEADER_MUSIC_JFD_CIXI_PEACE', 	'SND_LEADER_MUSIC_JFD_CIXI_PEACE', 	'GAME_MUSIC', 	45, 		45, 		1, 			0),
		('AS2D_LEADER_MUSIC_JFD_CIXI_WAR', 		'SND_LEADER_MUSIC_JFD_CIXI_WAR', 	'GAME_MUSIC', 	45, 		45, 		1,			0);
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,		Asset)
VALUES	('ART_DEF_UNIT_JFD_PEKING_FORCE', 		'Unit', 		'sv_PekingForce.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JFD_PEKING_FORCE',		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_RIFLEMAN';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT	'ART_DEF_UNIT_JFD_PEKING_FORCE', 		'ART_DEF_UNIT_MEMBER_JFD_PEKING_FORCE',		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_RIFLEMAN';
------------------------
-- ArtDefine_UnitMemberCombats
------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_PEKING_FORCE',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN';
------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_PEKING_FORCE',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN';
------------------------
-- ArtDefine_UnitMemberInfos
------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,	ZOffset, Domain, Model, 					MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_PEKING_FORCE',	Scale,	ZOffset, Domain, 'pekingfieldforce.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_RIFLEMAN';
--==========================================================================================================================	
--==========================================================================================================================	
