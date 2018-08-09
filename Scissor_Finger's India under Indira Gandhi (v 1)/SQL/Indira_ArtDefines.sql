--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES	('INDIRA_ICON_ATLAS', 						256, 		'IndiaIndiraAtlas_256.dds',					2, 				2),
		('INDIRA_ICON_ATLAS', 						128, 		'IndiaIndiraAtlas_128.dds',					2, 				2),
		('INDIRA_ICON_ATLAS', 						80, 		'IndiaIndiraAtlas_80.dds',					2, 				2),
		('INDIRA_ICON_ATLAS', 						64, 		'IndiaIndiraAtlas_64.dds',					2, 				2),
		('INDIRA_ICON_ATLAS', 						45, 		'IndiaIndiraAtlas_45.dds',					2, 				2),
		('INDIRA_ICON_ATLAS', 						32, 		'IndiaIndiraAtlas_32.dds',					2, 				2),
		('INDIRA_ALPHA_ATLAS', 						128, 		'IndiaIndiraAlphaAtlas_128.dds',			1,				1),
		('INDIRA_ALPHA_ATLAS', 						80, 		'IndiaIndiraAlphaAtlas_80.dds',				1, 				1),
		('INDIRA_ALPHA_ATLAS', 						64, 		'IndiaIndiraAlphaAtlas_64.dds',				1, 				1),
		('INDIRA_ALPHA_ATLAS', 						48, 		'IndiaIndiraAlphaAtlas_48.dds',				1, 				1),
		('INDIRA_ALPHA_ATLAS', 						45, 		'IndiaIndiraAlphaAtlas_45.dds',				1, 				1),
		('INDIRA_ALPHA_ATLAS', 						32, 		'IndiaIndiraAlphaAtlas_32.dds',				1, 				1),
		('INDIRA_ALPHA_ATLAS', 						24, 		'IndiaIndiraAlphaAtlas_24.dds',				1, 				1),
		('INDIRA_ALPHA_ATLAS', 						16, 		'IndiaIndiraAlphaAtlas_16.dds',				1, 				1),
		('GARUDA_FLAG',								32, 		'Garuda_Flag.dds',							1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 											Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_INDIRA_GANDHI_ICON', 			0.545,	0.694,	0.843,	1),
		('COLOR_PLAYER_INDIRA_GANDHI_BACKGROUND',		0.267,	0.067,	0.318,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 							PrimaryColor, 						SecondaryColor, 							TextColor)
VALUES	('PLAYERCOLOR_INDIRA_GANDHI',	'COLOR_PLAYER_INDIRA_GANDHI_ICON', 	'COLOR_PLAYER_INDIRA_GANDHI_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 									Filename, 			LoadType)
VALUES	('SND_LEADER_MUSIC_INDIRA_GANDHI_PEACE', 	'IndiraPeace',		'DynamicResident'),
		('SND_LEADER_MUSIC_INDIRA_GANDHI_WAR', 		'IndiraWar', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 								SoundType, 		MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_INDIRA_GANDHI_PEACE', 	'SND_LEADER_MUSIC_INDIRA_GANDHI_PEACE',	'GAME_MUSIC', 	60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_INDIRA_GANDHI_WAR', 	'SND_LEADER_MUSIC_INDIRA_GANDHI_WAR', 	'GAME_MUSIC', 	60, 		60, 		1,		 0);
--==========================================================================================================================
-- UNIT GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,	Asset)
VALUES	('ART_DEF_UNIT_GARUDA_TROOPERS',		'Unit', 	'sv_Garuda.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_GARUDA_TROOPERS',			DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_PARATROOPER';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,						NumMembers)
SELECT	'ART_DEF_UNIT_GARUDA_TROOPERS',			'ART_DEF_UNIT_MEMBER_INDIRA_GARUDA',	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_PARATROOPER';
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_INDIRA_GARUDA',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_PARATROOPER';
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_INDIRA_GARUDA',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_PARATROOPER';
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale,  ZOffset, Domain, Model, 					MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_INDIRA_GARUDA',	Scale,	ZOffset, Domain, Model,			MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_PARATROOPER';
--==========================================================================================================================	
--==========================================================================================================================	
