
--==========================================================================================================================
-- ArtDefine_LandmarkTypes
--==========================================================================================================================
INSERT INTO ArtDefine_LandmarkTypes 
			(Type, 									LandmarkType,	FriendlyName)
VALUES		('ART_DEF_IMPROVEMENT_SHEVENCHEDEK',	'Improvement', 	'SHEVENCHEDEK'),
			('ART_DEF_IMPROVEMENT_BUGADYL',			'Improvement', 	'BUGADYL');

--==========================================================================================================================
-- ArtDefine_Landmarks
--==========================================================================================================================
INSERT INTO ArtDefine_Landmarks 
			(ImprovementType, 						Era,	State,				 Scale, LayoutHandler,	ResourceType,			Model,			TerrainContour)
VALUES		('ART_DEF_IMPROVEMENT_SHEVENCHEDEK',		'Any', 	'UnderConstruction', 1.0,	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'WoodenTent_HB.fxsxml', 1),
			('ART_DEF_IMPROVEMENT_SHEVENCHEDEK',		'Any', 	'Constructed',		 1.0,	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'WoodenTent_B.fxsxml', 1),
			('ART_DEF_IMPROVEMENT_SHEVENCHEDEK',		'Any', 	'Pillaged',			 1.0,	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'WoodenTent_PL.fxsxml', 1),
			('ART_DEF_IMPROVEMENT_BUGADYL',				'Any', 	'UnderConstruction', 0.5,	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'WoodenTent_PL.fxsxml', 1),
			('ART_DEF_IMPROVEMENT_BUGADYL',				'Any', 	'Constructed',		 0.5,	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'WoodenTent_PL.fxsxml', 1),
			('ART_DEF_IMPROVEMENT_BUGADYL',				'Any', 	'Pillaged',			 0.5,	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'WoodenTent_PL.fxsxml', 1);