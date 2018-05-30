--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_RussiaCatherine_Decisions.lua');
------------------------------
-- BuildingClasses
------------------------------
INSERT INTO BuildingClasses 	
		(Type, 						 		 	DefaultBuilding, 						Description, 									MaxGlobalInstances)
VALUES	('BUILDINGCLASS_DECISIONS_JFD_SMOLNY', 	'BUILDING_DECISIONS_JFD_SMOLNY', 		'TXT_KEY_BUILDING_DECISIONS_JFD_SMOLNY',		1);
------------------------------
-- Buildings
------------------------------
INSERT INTO Buildings			
		(Type, 									BuildingClass, 			  				Cost, 	FaithCost,	SpecialistType,				SpecialistCount,	Description,								 Civilopedia,									IconAtlas,		HurryCostModifier, 	MinAreaSize, 	ConquestProb, 	NukeImmune, DisplayPosition, 	PortraitIndex,	NeverCapture)
VALUES	('BUILDING_DECISIONS_JFD_SMOLNY', 		'BUILDINGCLASS_DECISIONS_JFD_SMOLNY', 	-1, 	-1,			'SPECIALIST_SCIENTIST',		2,					'TXT_KEY_BUILDING_DECISIONS_JFD_SMOLNY',	 'TXT_KEY_BUILDING_DECISIONS_JFD_SMOLNY_TEXT',	'BW_ATLAS_1',	-1,					-1,				0,				1,			1,					14,				1);
--==========================================================================================================================
--==========================================================================================================================