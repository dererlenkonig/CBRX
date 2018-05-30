--------------------------------
-- Improvements
--------------------------------	
INSERT INTO Improvements
		(Type,								GraphicalOnly,	Description, Civilopedia, ArtDefineTag,	PillageGold, PortraitIndex,	IconAtlas)
SELECT	'IMPROVEMENT_SENSHI_HAWKE_FARM',	GraphicalOnly,	Description, Civilopedia, ArtDefineTag, PillageGold, PortraitIndex,	IconAtlas
FROM Improvements WHERE Type = 'IMPROVEMENT_FARM';
--------------------------------
--Improvement_Yields
--------------------------------
INSERT INTO Improvement_Yields
			(ImprovementType,					YieldType,			Yield)
VALUES		('IMPROVEMENT_SENSHI_HAWKE_FARM',	'YIELD_FOOD',		2);
--------------------------------
-- Improvement_ResourceTypes
--------------------------------
INSERT INTO Improvement_ResourceTypes
		(ImprovementType,						ResourceType)
SELECT	'IMPROVEMENT_SENSHI_HAWKE_FARM', 	ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_FARM';
--------------------------------
-- Improvement_ResourceType_Yields
--------------------------------
INSERT INTO Improvement_ResourceType_Yields
		(ImprovementType,						ResourceType, YieldType, Yield)
SELECT	'IMPROVEMENT_SENSHI_HAWKE_FARM', 	ResourceType, YieldType, Yield
FROM Improvement_ResourceType_Yields WHERE ImprovementType = 'IMPROVEMENT_FARM';
--------------------------------
-- Improvement_TechYieldChanges
--------------------------------
INSERT INTO Improvement_TechYieldChanges
		(ImprovementType,						TechType, YieldType, Yield)
SELECT	'IMPROVEMENT_SENSHI_HAWKE_FARM', 	TechType, YieldType, Yield
FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_FARM';
--------------------------------
-- Belief_ImprovementYieldChanges
--------------------------------
INSERT INTO Belief_ImprovementYieldChanges
		(BeliefType,	ImprovementType,						YieldType, Yield)
SELECT	BeliefType,		'IMPROVEMENT_SENSHI_HAWKE_FARM',	YieldType, Yield
FROM Belief_ImprovementYieldChanges WHERE ImprovementType = 'IMPROVEMENT_FARM';