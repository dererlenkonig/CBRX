INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_NIZAMIYYAH', 'Improvement', 'European';

INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.60,  'ART_DEF_IMPROVEMENT_NIZAMIYYAH', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'NizamiyyahWTI_HB.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed',       0.60,  'ART_DEF_IMPROVEMENT_NIZAMIYYAH', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'NizamiyyahWTI_B.fxsxml',    1 UNION ALL
SELECT 'Any', 'Pillaged',          0.60,  'ART_DEF_IMPROVEMENT_NIZAMIYYAH', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'WTI_PL.fxsxml', 1;