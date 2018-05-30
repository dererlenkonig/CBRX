--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 							IconSize, 	Filename, 							IconsPerRow, 	IconsPerColumn)
VALUES	('JMANGELO_LIBYA_ATLAS', 				256, 		'JMANGELO_LibyaAtlas_256.dds',			2, 				3),
		('JMANGELO_LIBYA_ATLAS', 				128, 		'JMANGELO_LibyaAtlas_128.dds',			2, 				3),
		('JMANGELO_LIBYA_ATLAS', 				80, 		'JMANGELO_LibyaAtlas_80.dds',			2, 				3),
		('JMANGELO_LIBYA_ATLAS', 				64, 		'JMANGELO_LibyaAtlas_64.dds',			2, 				3),
		('JMANGELO_LIBYA_ATLAS', 				45, 		'JMANGELO_LibyaAtlas_45.dds',			2, 				3),
		('JMANGELO_LIBYA_ATLAS', 				32, 		'JMANGELO_LibyaAtlas_32.dds',			2, 				3),
		('JMANGELO_LIBYA_ALPHA_ATLAS', 			64, 		'JMANGELO_LibyaAlpha_64.dds',			1, 				1),
		('JMANGELO_LIBYA_ALPHA_ATLAS', 			48, 		'JMANGELO_LibyaAlpha_48.dds',			1, 				1),
		('JMANGELO_LIBYA_ALPHA_ATLAS', 			32, 		'JMANGELO_LibyaAlpha_32.dds',			1, 				1),
		('JMANGELO_LIBYA_ALPHA_ATLAS', 			24, 		'JMANGELO_LibyaAlpha_24.dds',			1, 				1),
		('JMANGELO_MARKAS_ATLAS', 				256, 		'JMANGELO_MarkasQiadaAtlas_256.dds',	1, 				2),
		('JMANGELO_MARKAS_ATLAS', 				64, 		'JMANGELO_MarkasQiadaAtlas_64.dds',		1, 				2),
		('JMANGELO_MARKAS_ATLAS', 				45, 		'JMANGELO_MarkasQiadaAtlas_45.dds',		1, 				2),
		('JMANGELO_LIBYA_FLAG_ART_ATLAS', 		32, 		'JMANGELO_LibyaUnitFlag_32.dds',		1, 				2);

------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 										Red, 								Green, 								Blue, 								Alpha)
VALUES	('COLOR_PLAYER_JMANGELO_LIBYA_ICON', 		0.68627450980392156862745098039216,	0.34509803921568627450980392156863,	0.34901960784313725490196078431373,	1),
		('COLOR_PLAYER_JMANGELO_LIBYA_BACKGROUND',	0,									0.18431372549019607843137254901961,	0.13725490196078431372549019607843,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 							PrimaryColor, 							SecondaryColor, 							TextColor)
VALUES	('PLAYERCOLOR_JMANGELO_LIBYA',	'COLOR_PLAYER_JMANGELO_LIBYA_ICON', 	'COLOR_PLAYER_JMANGELO_LIBYA_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');

--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,		Asset)
VALUES	('ART_DEF_UNIT_JMANGELO_AL_QAYID', 		'Unit', 		'SV_AlQayid.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 								DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JMANGELO_AL_QAYID',	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_U_OTTOMAN_JANISSARY';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT	'ART_DEF_UNIT_JMANGELO_AL_QAYID',		'ART_DEF_UNIT_MEMBER_JMANGELO_AL_QAYID',	1
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_OTTOMAN_JANISSARY';
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JMANGELO_AL_QAYID',EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_OTTOMAN_JANISSARY';
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JMANGELO_AL_QAYID',"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_OTTOMAN_JANISSARY';
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JMANGELO_AL_QAYID',Scale,	ZOffset, Domain, Model,	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_U_OTTOMAN_JANISSARY';
--==========================================================================================================================	
--==========================================================================================================================

--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 							TileType,		Asset)
VALUES	('ART_DEF_UNIT_JMANGELO_AKHDARI_CAVALRY', 		'Unit', 		'SV_Akhdari.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 										DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JMANGELO_AKHDARI_CAVALRY',	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_U_MORROCAN_BERBER_CAVALRY';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,									UnitMemberInfoType,								NumMembers)
SELECT	'ART_DEF_UNIT_JMANGELO_AKHDARI_CAVALRY',		'ART_DEF_UNIT_MEMBER_JMANGELO_AKHDARI_CAVALRY',	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_MORROCAN_BERBER_CAVALRY';
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,								EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JMANGELO_AKHDARI_CAVALRY',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_MORROCAN_BERBER_CAVALRY';
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,									"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JMANGELO_AKHDARI_CAVALRY',		"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_MORROCAN_BERBER_CAVALRY';
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 											Scale,  ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JMANGELO_AKHDARI_CAVALRY',	Scale,	ZOffset, Domain, Model,	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_U_MORROCAN_BERBER_CAVALRY';
--==========================================================================================================================	
--==========================================================================================================================	