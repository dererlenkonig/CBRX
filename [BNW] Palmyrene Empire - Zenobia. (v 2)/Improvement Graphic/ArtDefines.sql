
--==========================================================================================================================
-- ArtDefine_LandmarkTypes
--==========================================================================================================================
INSERT INTO ArtDefine_LandmarkTypes 
			(Type, 								LandmarkType,	FriendlyName)
VALUES		('ART_DEF_IMPROVEMENT_FUNERARY_TOWER',	'Improvement', 	'FUNERARY_TOWER');

--==========================================================================================================================
-- ArtDefine_Landmarks
--==========================================================================================================================
INSERT INTO ArtDefine_Landmarks 
			(ImprovementType, 						Era,	State,				 Scale, LayoutHandler,	ResourceType,			Model,			TerrainContour)
VALUES		('ART_DEF_IMPROVEMENT_FUNERARY_TOWER',		'Any', 	'UnderConstruction', 1.0,	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'Palmyra Funerary Towers_HB.fxsxml', 1),
			('ART_DEF_IMPROVEMENT_FUNERARY_TOWER',		'Any', 	'Constructed',		 1.0,	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'Palmyra Funerary Towers_B.fxsxml', 1),
			('ART_DEF_IMPROVEMENT_FUNERARY_TOWER',		'Any', 	'Pillaged',			 1.0,	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'Palmyra Funerary Towers_PL.fxsxml', 1);



