INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_KSAR', 'Improvement', 'European';

INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.90,  'ART_DEF_IMPROVEMENT_KSAR', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'redfortTI_HB.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed',       0.90,  'ART_DEF_IMPROVEMENT_KSAR', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'redfortTI_B.fxsxml',    1 UNION ALL
SELECT 'Any', 'Pillaged',          0.90,  'ART_DEF_IMPROVEMENT_KSAR', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'WTI_PL.fxsxml', 1;