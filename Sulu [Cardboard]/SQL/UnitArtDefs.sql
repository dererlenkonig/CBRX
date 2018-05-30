--------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitInfos(Type, DamageStates)
  VALUES ('ART_DEF_UNIT_SULU_PROA', 3);

INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_SULU_PROA', 'ART_DEF_UNIT_MEMBER_SULU_PROA', 1);

INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_SULU_PROA', 0.0750000029802322, 'Sea', 'Trireme.fxsxml', 'WOOD', 'WOODLRG');

INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasRefaceAfterCombat, HasIndependentWeaponFacing)
  VALUES ('ART_DEF_UNIT_MEMBER_SULU_PROA', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady AttackSurfaceToAir', 1, 1, 1, 0, 1);

INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_SULU_PROA', 0, 0, 0.0, 0.0, 'ARROW', 'ARROW');

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_UNIT_SULU_PROA', 'Unit', 'ProaFlagSV.dds')
--------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitInfos(Type, DamageStates, Formation)
  VALUES ('ART_DEF_UNIT_SULU_LANTAKA', 1, 'ThreeBigGuns');


INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_SULU_LANTAKA', 'ART_DEF_UNIT_MEMBER_SULU_LANTAKA', 3);

INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_SULU_LANTAKA', 0.119999997317791, 'Cannon.fxsxml', 'WOOD', 'WOODSM');

INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, HasShortRangedAttack, HasLongRangedAttack, HasStationaryMelee, HasRefaceAfterCombat, ReformBeforeCombat)
  VALUES ('ART_DEF_UNIT_MEMBER_SULU_LANTAKA', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady', 1, 1, 1, 1, 1);

INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, HitEffect, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_SULU_LANTAKA', 0, 0, 25.0, 50.0, 5.0, 'ART_DEF_VEFFECT_SULU_LANTAKA_IMPACT_$(TERRAIN)', 'EXPLOSIVE', 'EXPLOSION6POUND');

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_UNIT_SULU_LANTAKA', 'Unit', 'LantakaFlagSV.dds');
--------------------------------------------------------------------------------------------------------------------