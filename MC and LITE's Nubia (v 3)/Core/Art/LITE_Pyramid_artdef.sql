--==========================================================================================================================
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO ArtDefine_LandmarkTypes(Type, 					LandmarkType, 	FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_MC_LITE_NUBIAN_ROYAL_PYRAMID', 	'Improvement', 	'LITE_PYRAMID';
--==========================================================================================================================
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO ArtDefine_Landmarks
		(Era, 	State, 					Scale,	ImprovementType,									LayoutHandler, 	ResourceType, 			Model, 						TerrainContour)
VALUES 	('Any', 'UnderConstruction', 	1.3,  	'ART_DEF_IMPROVEMENT_MC_LITE_NUBIAN_ROYAL_PYRAMID', 'RANDOM', 		'ART_DEF_RESOURCE_ALL', 'LITE_Pyramid_HB.fxsxml', 	1),
		('Any', 'Constructed',		 	1.3, 	'ART_DEF_IMPROVEMENT_MC_LITE_NUBIAN_ROYAL_PYRAMID', 'RANDOM', 		'ART_DEF_RESOURCE_ALL', 'LITE_Pyramid_B.fxsxml', 	1),
		('Any', 'Constructed',		 	1.3, 	'ART_DEF_IMPROVEMENT_MC_LITE_NUBIAN_ROYAL_PYRAMID', 'RANDOM', 		'ART_DEF_RESOURCE_ALL', 'LITE_Pyramid_B2.fxsxml', 	1),
		('Any', 'Pillaged',				1.3,  	'ART_DEF_IMPROVEMENT_MC_LITE_NUBIAN_ROYAL_PYRAMID', 'RANDOM', 		'ART_DEF_RESOURCE_ALL', 'LITE_Pyramid_PL.fxsxml', 	1);
--==========================================================================================================================
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO ArtDefine_StrategicView(StrategicViewType,	   TileType,	  Asset)
SELECT 'ART_DEF_IMPROVEMENT_MC_LITE_NUBIAN_ROYAL_PYRAMID', 'Improvement', 'sv_LITE_Pyramid.dds';
--==========================================================================================================================
--==========================================================================================================================