INSERT INTO ArtDefine_LandmarkTypes(Type, LandmarkType, FriendlyName)
SELECT 'ART_DEF_IMPROVEMENT_LS_HUN_VEGVAR', 'Improvement', 'VEGVAR';

INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 1.0,  'ART_DEF_IMPROVEMENT_LS_HUN_VEGVAR', 'SNAPSHOT', 'ART_DEF_RESOURCE_NONE', 'Feitoria_HB.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 1.0,  'ART_DEF_IMPROVEMENT_LS_HUN_VEGVAR', 'SNAPSHOT', 'ART_DEF_RESOURCE_NONE', 'Feitoria.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 1.0,  'ART_DEF_IMPROVEMENT_LS_HUN_VEGVAR', 'SNAPSHOT', 'ART_DEF_RESOURCE_NONE', 'Feitoria_PIL.fxsxml', 1;