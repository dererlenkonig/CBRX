INSERT INTO ArtDefine_UnitInfos(Type, DamageStates)
  VALUES ('ART_DEF_UNIT_RED_FLEET_JUNK', 3);
INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_RED_FLEET_JUNK', 'ART_DEF_UNIT_MEMBER_RED_FLEET_JUNK', 1);
INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_RED_FLEET_JUNK', 0.140000000596046, 'Sea', 'WarJunk.fxsxml', 'WOOD', 'WOODLRG');
INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, HasShortRangedAttack, HasLeftRightAttack, HasRefaceAfterCombat, HasIndependentWeaponFacing)
  VALUES ('ART_DEF_UNIT_MEMBER_RED_FLEET_JUNK', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady AttackSurfaceToAir', 1, 1, 0, 1);
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, HitEffect, WeaponTypeTag, WeaponTypeSoundOverrideTag)
  VALUES ('RT_DEF_UNIT_MEMBER_RED_FLEET_JUNK', 0, 0, 10.0, 20.0, 'ART_DEF_VEFFECT_CANNON_IMPACT_$(TERRAIN)', 'EXPLOSIVE', 'EXPLOSION6POUND');
INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_UNIT_RED_FLEET_JUNK', 'Unit', 'WarJunk_diff.dds');
  UPDATE ArtDefine_UnitMemberInfos SET Scale = (SELECT Scale FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_RED_FLEET_JUNK') WHERE Type = 'ART_DEF_UNIT_RED_FLEET_JUNK';
