--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- IconTextureAtlasesa
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES	('DMS_VENEZUELA_ATLAS', 						256, 	'DMS_VenezuelaAtlas_256.dds',			2, 				2),
		('DMS_VENEZUELA_ATLAS', 						128, 	'DMS_VenezuelaAtlas_128.dds',			2, 				2),
		('DMS_VENEZUELA_ATLAS', 						80, 	'DMS_VenezuelaAtlas_80.dds',			2, 				2),
		('DMS_VENEZUELA_ATLAS', 						64, 	'DMS_VenezuelaAtlas_64.dds',			2, 				2),
		('DMS_VENEZUELA_ATLAS', 						45, 	'DMS_VenezuelaAtlas_45.dds',			2, 				2),
		('DMS_VENEZUELA_ATLAS', 						32, 	'DMS_VenezuelaAtlas_32.dds',			2, 				2),
		('DMS_VENEZUELA_ALPHA_ATLAS', 					128, 	'DMS_VenezuelaAlphaAtlas_128.dds',		1,				1),
		('DMS_VENEZUELA_ALPHA_ATLAS', 					80, 	'DMS_VenezuelaAlphaAtlas_80.dds',		1, 				1),
		('DMS_VENEZUELA_ALPHA_ATLAS', 					64, 	'DMS_VenezuelaAlphaAtlas_64.dds',		1, 				1),
		('DMS_VENEZUELA_ALPHA_ATLAS', 					48, 	'DMS_VenezuelaAlphaAtlas_48.dds',		1, 				1),
		('DMS_VENEZUELA_ALPHA_ATLAS', 					45, 	'DMS_VenezuelaAlphaAtlas_45.dds',		1, 				1),
		('DMS_VENEZUELA_ALPHA_ATLAS', 					32, 	'DMS_VenezuelaAlphaAtlas_32.dds',		1, 				1),
		('DMS_VENEZUELA_ALPHA_ATLAS', 					24, 	'DMS_VenezuelaAlphaAtlas_24.dds',		1, 				1),
		('DMS_VENEZUELA_ALPHA_ATLAS', 					16, 	'DMS_VenezuelaAlphaAtlas_16.dds',		1, 				1),
		('DMS_VE_NILANGAL_FLAG_ART_ATLAS', 				32, 	'UnitFlag_VeNilangal_32.dds',			1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 												Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_DMS_VENEZUELA_ICON',					0.059,	0.086,	0.18,	1),
		('COLOR_PLAYER_DMS_VENEZUELA_BACKGROUND',			0.957,	0.769,	0.188,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 							PrimaryColor, 						SecondaryColor, 							TextColor)
VALUES	('PLAYERCOLOR_DMS_VENEZUELA',	'COLOR_PLAYER_DMS_VENEZUELA_ICON', 	'COLOR_PLAYER_DMS_VENEZUELA_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 										Filename, 				LoadType)
VALUES	('SND_LEADER_MUSIC_DMS_HUGO_CHAVEZ_PEACE', 		'HugoChavez_Peace',		'DynamicResident'),
		('SND_LEADER_MUSIC_DMS_HUGO_CHAVEZ_WAR', 		'HugoChavez_War', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 										SoundType, 		MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_DMS_HUGO_CHAVEZ_PEACE',		'SND_LEADER_MUSIC_DMS_HUGO_CHAVEZ_PEACE',		'GAME_MUSIC', 	60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_DMS_HUGO_CHAVEZ_WAR', 		'SND_LEADER_MUSIC_DMS_HUGO_CHAVEZ_WAR', 		'GAME_MUSIC', 	60, 		60, 		1,		 0);
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,	Asset)
VALUES	('ART_DEF_UNIT_DMS_VE_NILANGAL', 		'Unit', 	'sv_u_venzuela_venilangal.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_DMS_VE_NILANGAL'),		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_TANK');
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT	('ART_DEF_UNIT_DMS_VE_NILANGAL'),		('ART_DEF_UNIT_MEMBER_DMS_VE_NILANGAL'),	3
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_SMOKEY_LANDSHIP_LEVEL_1');
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_VE_NILANGAL'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SMOKEY_LANDSHIP_LEVEL_1');
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_VE_NILANGAL'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SMOKEY_LANDSHIP_LEVEL_1');
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale,				ZOffset, Domain, Model,	MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_DMS_VE_NILANGAL'),	0.129999996423721,	ZOffset, Domain, Model,	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_SMOKEY_LANDSHIP_LEVEL_1');
--==========================================================================================================================	
--==========================================================================================================================	
