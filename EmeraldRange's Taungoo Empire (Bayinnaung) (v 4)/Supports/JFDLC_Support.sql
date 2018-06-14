--==========================================================================================================================
-- USER SETTINGS 
--==========================================================================================================================
-- JFD_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);
--==========================================================	
-- COLONIES 
--==========================================================	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 						text 	REFERENCES Civilizations(Type) 	default null,
	ColonyName 								text									default null,
	LinguisticType							text									default	null,
	CultureType								text									default	null);
	
INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 					ColonyName,								LinguisticType)
VALUES	('CIVILIZATION_TAUNGOO', 			null,									'JFD_Mandala');
--==========================================================================================================================
-- JFD's CULTURAL DIVERSITY (31a31d1c-b9d7-45e1-842c-23232d66cd47)
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 					text 			default null,
	CultureType 						text			default null,
	SubCultureType 						text			default null,
	ArtDefineTag						text			default	null,
	DecisionsTag						text			default null,
	DefeatScreenEarlyTag				text			default	null,
	DefeatScreenMidTag					text			default	null,
	DefeatScreenLateTag					text			default	null,
	IdealsTag							text			default	null,
	SplashScreenTag						text			default	null,
	SoundtrackTag						text			default	null,
	UnitDialogueTag						text			default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag,	CultureType,			IdealsTag,		SplashScreenTag,	SoundtrackTag, UnitDialogueTag)
VALUES	('CIVILIZATION_TAUNGOO',	'_JFD_MANDALA', 'CULTURE_JFD_MANDALA',  'JFD_Mandala',	'JFD_Mandala',		'JFD_Mandala', 'AS2D_SOUND_JFD_CHINESE');

------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Mandala'
WHERE Type = 'CIVILIZATION_TAUNGOO'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_NorthernCeltic');
--==========================================================================================================================
-- JFDLC
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION'),
		('FLAVOR_JFD_MERCENARY'),
		('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION'),
		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_SLAVERY'),
		('FLAVOR_JFD_STATE_RELIGION');
--------------------------------------------------------------------------------------------------------------------------
-- Leader_Flavors
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,								Flavor)
VALUES	('LEADER_BAYINNAUNG',	'FLAVOR_JFD_DECOLONIZATION',			1),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_MERCENARY',					7),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		5),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_REFORM_GOVERNMENT',			5),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_REFORM_LEGAL',				6),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_REFORM_CULTURE',			4),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_REFORM_ECONOMIC',			3),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_REFORM_FOREIGN',			4),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_REFORM_INDUSTRY',			5),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_REFORM_MILITARY',			8),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_REFORM_RELIGION',			7),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_SLAVERY',					5),
		('LEADER_BAYINNAUNG',	'FLAVOR_JFD_STATE_RELIGION',			6);
--==========================================================================================================================
--==========================================================================================================================
