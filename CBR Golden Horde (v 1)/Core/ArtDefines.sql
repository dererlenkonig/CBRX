--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('CBR_GOLDEN_HORDE_ATLAS', 				256, 		'CBR_GoldenHordeAtlas_256.dds',			2, 				2),
		('CBR_GOLDEN_HORDE_ATLAS', 				128, 		'CBR_GoldenHordeAtlas_128.dds',			2, 				2),
		('CBR_GOLDEN_HORDE_ATLAS', 				80, 		'CBR_GoldenHordeAtlas_80.dds',			2, 				2),
		('CBR_GOLDEN_HORDE_ATLAS', 				64, 		'CBR_GoldenHordeAtlas_64.dds',			2, 				2),
		('CBR_GOLDEN_HORDE_ATLAS', 				45, 		'CBR_GoldenHordeAtlas_45.dds',			2, 				2),
		('CBR_GOLDEN_HORDE_ATLAS', 				32, 		'CBR_GoldenHordeAtlas_32.dds',			2, 				2),
		('CBR_GOLDEN_HORDE_ALPHA_ATLAS', 		64, 		'CBR_GoldenHordeAlpha_64.dds',			1, 				1),
		('CBR_GOLDEN_HORDE_ALPHA_ATLAS', 		48, 		'CBR_GoldenHordeAlpha_48.dds',			1, 				1),
		('CBR_GOLDEN_HORDE_ALPHA_ATLAS', 		32, 		'CBR_GoldenHordeAlpha_32.dds',			1, 				1),
		('CBR_GOLDEN_HORDE_ALPHA_ATLAS', 		24, 		'CBR_GoldenHordeAlpha_24.dds',			1, 				1),
		('CBR_KHAMGAALAGCH_FLAG_ART_ATLAS', 	32, 		'CBR_KhamgaalagchUnitFlag_32.dds',		1, 				1);

------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_CBR_GOLDEN_HORDE_ICON', 			0.3216,	0.1843,	0.0235,	1),
		('COLOR_PLAYER_CBR_GOLDEN_HORDE_BACKGROUND',	0.7804,	0.6509,	0.1568,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 									PrimaryColor, 							SecondaryColor, 								TextColor)
VALUES	('PLAYERCOLOR_CBR_GOLDEN_HORDE',		'COLOR_PLAYER_CBR_GOLDEN_HORDE_ICON', 	'COLOR_PLAYER_CBR_GOLDEN_HORDE_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,		Asset)
VALUES	('ART_DEF_UNIT_CBR_KHAMGAALAGCH', 		'Unit', 		'SV_Khamgaalagch.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 							DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_CBR_KHAMGAALAGCH',DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_U_MONGOLIAN_KESHIK';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,						NumMembers)
SELECT	'ART_DEF_UNIT_CBR_KHAMGAALAGCH',		'ART_DEF_UNIT_MEMBER_CBR_KHAMGAALAGCH',	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_MONGOLIAN_KESHIK';
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_CBR_KHAMGAALAGCH',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_MONGOLIAN_KESHIK';
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_CBR_KHAMGAALAGCH',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_MONGOLIAN_KESHIK';
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_CBR_KHAMGAALAGCH',	Scale,	ZOffset, Domain, Model,	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_U_MONGOLIAN_KESHIK';
--==========================================================================================================================	
--==========================================================================================================================	
