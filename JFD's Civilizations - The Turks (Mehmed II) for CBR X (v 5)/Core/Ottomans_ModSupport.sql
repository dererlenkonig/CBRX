--==========================================================================================================================	
-- GAZEBO COMMUNITY BALANCE PATCH
--==========================================================================================================================			
-- COMMUNITY
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_BuildingClassOverrides 
--------------------------------------------------------------------------------------------------------------------------	
DELETE FROM Civilization_BuildingClassOverrides 
WHERE CivilizationType = 'CIVILIZATION_OTTOMAN' AND BuildingType = 'BUILDING_JFD_HAMMAM'
AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value = 1);
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_UnitClassOverrides 
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 			UnitClassType, 			UnitType)
SELECT	'CIVILIZATION_OTTOMAN', 	'UNITCLASS_LANCER',		'UNIT_OTTOMAN_SIPAHI'
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value = 1);
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_BuildingClassOverrides 
--------------------------------------------------------------------------------------------------------------------------
UPDATE Units
SET Class = 'UNITCLASS_LANCER'
WHERE Type = 'UNIT_OTTOMAN_SIPAHI'
AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value = 1);
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 	text 	  default null,
	Value 	integer   default 1);
--==========================================================================================================================	
-- JFD DYNAMIC TOP PANEL
--==========================================================================================================================			
-- JFD_TopPanelIncludes
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_TopPanelIncludes (
	FileName				text		default null);
	
INSERT INTO JFD_TopPanelIncludes
		(FileName)
VALUES	('JFD_Ottomans_DTP.lua');
--------------------------------------------------------------------------------------------------------------------------		
-- JFD_TopPanelAdditions
--------------------------------------------------------------------------------------------------------------------------		
CREATE TABLE IF NOT EXISTS 
	JFD_TopPanelAdditions (
	CivilizationType		text		REFERENCES Civilizations(Type) 	default null,
	YieldType  				text 										default null,
	YieldSourceFunction 	text										default null,
	YieldSourceToolTip		text										default	null,
	MiscToolTipFunction		text										default	null);
	
INSERT INTO JFD_TopPanelAdditions
		(CivilizationType,			YieldType,		YieldSourcefunction,				YieldSourceToolTip)
SELECT	'CIVILIZATION_OTTOMAN',		'YIELD_GOLD',	'JFD_Ottomans_GetGoldFromPuppets',	'TXT_KEY_JFD_OTTOMAN_GOLD_FROM_PUPPETS'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UA' AND Value = 1);	

INSERT INTO JFD_TopPanelAdditions
		(CivilizationType,			YieldType,		YieldSourcefunction,				YieldSourceToolTip)
SELECT	'CIVILIZATION_OTTOMAN',		'YIELD_FAITH',	'JFD_Ottomans_GetFaithFromPuppets',	'TXT_KEY_JFD_OTTOMAN_FAITH_FROM_PUPPETS'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UA' AND Value = 1);	
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
-- Building_ConstructionAudio
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
	Building_ConstructionAudio (
    BuildingType								text		REFERENCES Buildings(Type)      default null,
    ConstructionAudio							text										default null);
	
INSERT INTO Building_ConstructionAudio
		(BuildingType, 				ConstructionAudio)
SELECT	'BUILDING_JFD_HAMMAM',		'AS2D_BUILDING_JFD_HAMMAM'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1);
--==========================================================================================================================
-- JFD RISE TO POWER
--==========================================================================================================================		
--====================================	
-- JFD PIETY
--====================================	
-- Traits
--------------------------------------------------------------------------------------------------------------------------
UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_JFD_OTTOMAN_PIETY'
WHERE Type = 'TRAIT_JFD_OTTOMAN'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_RTP_PIETY_CORE' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CIVILIZATIONS_OTTOMAN_UA' AND Value = 1);	
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_Ottomans_Decisions.lua');
--------------------------------------------------------------------------------------------------------------------------
-- Units
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO Units 	
		(Type, 											Class, 				GoldenAgeTurns, Cost,	Moves,	Domain,			DefaultUnitAI,		Description, 										ShowInPedia, 	AdvancedStartCost,	UnitArtInfo, 					UnitFlagIconOffset,		UnitFlagAtlas,					PortraitIndex,	IconAtlas, 					MoveRate)
VALUES	('UNIT_DECISIONS_JFD_OTTOMAN_CALLIGRAPHER', 	'UNITCLASS_ARTIST',	8,				-1,		2,		'DOMAIN_LAND',	'UNITAI_ARTIST',	'TXT_KEY_UNIT_DECISIONS_JFD_OTTOMAN_CALLIGRAPHER',	0,				-1,					'ART_DEF_UNIT_GREAT_WRITER',	6,						'EXPANSION2_UNIT_FLAG_ATLAS',	6, 				'EXPANSION2_UNIT_ATLAS',	'GREAT_PERSON');
--------------------------------------------------------------------------------------------------------------------------
-- UnitGameplay2DScripts
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO UnitGameplay2DScripts 	
		(UnitType, 									SelectionSound, FirstSelectionSound)
SELECT	'UNIT_DECISIONS_JFD_OTTOMAN_CALLIGRAPHER', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_ARTIST';	
--------------------------------------------------------------------------------------------------------------------------
-- Unit_UniqueNames
--------------------------------------------------------------------------------------------------------------------------
INSERT OR REPLACE INTO Unit_UniqueNames 
		(UnitType, 									UniqueName,													GreatWorkType)
VALUES	('UNIT_DECISIONS_JFD_OTTOMAN_CALLIGRAPHER', 'TXT_KEY_GREAT_PERSON_JFD_OTTOMAN_CALLIGRAPHER_DESC',		'GREAT_WORK_JFD_SULEIMAN_TUGHRA');
--------------------------------------------------------------------------------------------------------------------------	
-- GreatWorks
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO GreatWorks 
		(Type, 								 GreatWorkClassType,	Description,								Audio,							Image)
VALUES	('GREAT_WORK_JFD_SULEIMAN_TUGHRA',	 'GREAT_WORK_ART',		'TXT_KEY_GREAT_WORK_JFD_SULEIMAN_TUGHRA',	'AS2D_GREAT_ARTIST_ARTWORK',	'gw_suleiman_signature.dds');
--==========================================================================================================================
--==========================================================================================================================