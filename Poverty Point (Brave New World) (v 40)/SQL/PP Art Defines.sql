--
INSERT INTO ArtDefine_LandmarkTypes(Type, 			         LandmarkType, 	            FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_POVERTY_MOUND_MOD', 	        'Improvement', 	      'TOMATEKH_POVERTY';
	
INSERT INTO ArtDefine_Landmarks
		(Era, 	State, 					Scale,	ImprovementType, 						LayoutHandler, 	ResourceType, 			Model, 							TerrainContour)
VALUES 	('Any', 'UnderConstruction', 	1.38,  	'ART_DEF_IMPROVEMENT_POVERTY_MOUND_MOD', 'RANDOM', 		'ART_DEF_RESOURCE_ALL', 'Serpent Mound_HB.fxsxml', 	1),
		--
		('Any', 'Constructed',		 	1.38, 	'ART_DEF_IMPROVEMENT_POVERTY_MOUND_MOD', 'RANDOM', 		'ART_DEF_RESOURCE_ALL', 'Serpent Mound_B_Ex.fxsxml', 	1),
		('Any', 'Constructed',		 	1.38, 	'ART_DEF_IMPROVEMENT_POVERTY_MOUND_MOD', 'RANDOM', 		'ART_DEF_RESOURCE_ALL', 'Serpent Mound_B.fxsxml', 	1),
		--
		('Any', 'Pillaged',				1.38,  	'ART_DEF_IMPROVEMENT_POVERTY_MOUND_MOD', 'RANDOM', 		'ART_DEF_RESOURCE_ALL', 'Serpent Mound_PL.fxsxml', 	1);

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_IMPROVEMENT_POVERTY_MOUND_MOD', 'Improvement', 'sv_CeremonialMound.dds');

----
----

INSERT INTO ArtDefine_UnitInfos(Type, DamageStates, Formation)
  VALUES ('ART_DEF_UNIT_GREAT_POVERTY', 1, 'LooseCivilian');

INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_GREAT_POVERTY', 'ART_DEF_UNIT_GREAT_POVERTY_MEMBER', 1);

INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_GREAT_POVERTY_MEMBER', 0.135, 'NativeGreatProphet.fxsxml', 'CLOTH', 'FLESH');

INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, HasRefaceAfterCombat)
  VALUES ('ART_DEF_UNIT_GREAT_POVERTY_MEMBER', 'Idle Death BombardDefend Run', 1);

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
  VALUES ('ART_DEF_UNIT_GREAT_POVERTY', 'Unit', 'sv_PovertyPoint.dds');



