--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,			TraitOne,               TraitTwo)
SELECT	'LEADER_JFD_SEDDON',	'POLICY_CHARISMATIC_X',	'POLICY_INDUSTRIOUS_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Seddon [ICON_HAPPINESS_1][ICON_PRODUCTION]'
WHERE Type = 'LEADER_JFD_SEDDON'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_ENGLAND'
WHERE Type = 'CIVILIZATION_JFD_NEW_ZEALAND'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_ENGLAND');
--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	113,	8);

CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_YagemStartPosition WHERE Type IN ('MINOR_CIV_WELLINGTON');
INSERT INTO MinorCiv_YagemStartPosition
		(Type,								X,		Y)
VALUES	('MINOR_CIV_WELLINGTON',			112,	24); --Port Villa
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	1,		9);

CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_YahemStartPosition WHERE Type IN ('MINOR_CIV_WELLINGTON');
INSERT INTO MinorCiv_YahemStartPosition
		(Type,								X,		Y)
VALUES	('MINOR_CIV_WELLINGTON',			1,		22); --Port Villa
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	2,		9);

CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_GreatestEarthStartPosition WHERE Type IN ('MINOR_CIV_WELLINGTON');
INSERT INTO MinorCiv_GreatestEarthStartPosition
		(Type,								X,		Y)
VALUES	('MINOR_CIV_WELLINGTON',			1,		15); --Port Villa
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (Pacific)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	61,		5);

CREATE TABLE IF NOT EXISTS MinorCiv_PacificStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_PacificStartPosition WHERE Type IN ('MINOR_CIV_WELLINGTON');
INSERT INTO MinorCiv_PacificStartPosition
		(Type,								X,		Y)
VALUES	('MINOR_CIV_WELLINGTON',			61,		19); --Port Villa
------------------------------------------------------------	
-- Civilizations_SouthPacificGiantStartPosition (South Pacific Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificGiantStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	69,		9);

CREATE TABLE IF NOT EXISTS MinorCiv_SouthPacificGiantStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_SouthPacificGiantStartPosition WHERE Type IN ('MINOR_CIV_WELLINGTON');
INSERT INTO MinorCiv_SouthPacificGiantStartPosition
		(Type,								X,		Y)
VALUES	('MINOR_CIV_WELLINGTON',			46,		46); --Port Villa
------------------------------------------------------------	
-- Civilizations_SouthPacificStartPosition (South Pacific)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	20,		11);

CREATE TABLE IF NOT EXISTS MinorCiv_SouthPacificStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_SouthPacificStartPosition WHERE Type IN ('MINOR_CIV_WELLINGTON');
INSERT INTO MinorCiv_SouthPacificStartPosition
		(Type,								X,		Y)
VALUES	('MINOR_CIV_WELLINGTON',			27,		52); --Port Villa
------------------------------------------------------------	
-- Civilizations_SouthPacificStartPosition (Australia & South East Asia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AustralasiaGiantStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	133,	19);

CREATE TABLE IF NOT EXISTS MinorCiv_AustralasiaGiantStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_AustralasiaGiantStartPosition WHERE Type IN ('MINOR_CIV_WELLINGTON');
INSERT INTO MinorCiv_AustralasiaGiantStartPosition
		(Type,								X,		Y)
VALUES	('MINOR_CIV_WELLINGTON',			112,	65); --Port Villa
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 								Req1,				Yield1,		Req2,				Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',		'RESOURCE_SHEEP',	1,			'RESOURCE_FISH',	1,		Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_ENGLAND';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1,				Yield1,		Req2,				Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',		'RESOURCE_SHEEP',	1,			'RESOURCE_FISH',	1,		Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_ENGLAND';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1,				Yield1,		Req2,				Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',		'RESOURCE_SHEEP',	1,			'RESOURCE_FISH',	1,		Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_ENGLAND';
------------------------------------------------------------	
-- Civilizations_PacificRequestedResource (Pacific)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_PacificRequestedResource
		(Type, 								Req1,				Yield1,		Req2,				Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',		'RESOURCE_SHEEP',	1,			'RESOURCE_FISH',	1,		Req3, Yield3, Req4, Yield4
FROM Civilizations_PacificRequestedResource WHERE Type = 'CIVILIZATION_ENGLAND';
------------------------------------------------------------	
-- Civilizations_SouthPacificRequestedResource (South Pacific)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthPacificRequestedResource
		(Type, 								Req1,				Yield1,		Req2,				Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',		'RESOURCE_SHEEP',	1,			'RESOURCE_FISH',	1,		Req3, Yield3, Req4, Yield4
FROM Civilizations_SouthPacificRequestedResource WHERE Type = 'CIVILIZATION_ENGLAND';
------------------------------------------------------------	
-- Civilizations_SouthPacificGiantRequestedResource (South Pacific Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthPacificGiantRequestedResource
		(Type, 								Req1,				Yield1,		Req2,				Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',		'RESOURCE_SHEEP',	1,			'RESOURCE_FISH',	1,		Req3, Yield3, Req4, Yield4
FROM Civilizations_SouthPacificGiantRequestedResource WHERE Type = 'CIVILIZATION_ENGLAND';
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Australia & South East Asia)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AustralasiaGiantRequestedResource
		(Type, 								Req1,				Yield1,		Req2,				Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',		'RESOURCE_SHEEP',	1,			'RESOURCE_FISH',	1,		Req3, Yield3, Req4, Yield4
FROM Civilizations_AustralasiaGiantRequestedResource WHERE Type = 'CIVILIZATION_ENGLAND';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,							CultureType,	CultureEra)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',		CultureType,	CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_ENGLAND';
--==========================================================================================================================
-- JFD USER SETTINGS
--==========================================================================================================================
-- JFD_GlobalUserSettings
-------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);
--==========================================================================================================================
-- JFD CIVILOPEDIA
--==========================================================================================================================
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);

INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('PROMOTION_JFD_DEFENDER_ACTIVE');
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
--====================================	
-- JFD COLONIES
--====================================	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 					ColonyName,									LinguisticType)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	null,										'JFD_Germanic'),
		('CIVILIZATION_JFD_NEW_ZEALAND', 	'TXT_KEY_COLONY_NAME_JFD_NEW_ZEALAND_01',	null),
		('CIVILIZATION_JFD_NEW_ZEALAND', 	'TXT_KEY_COLONY_NAME_JFD_NEW_ZEALAND_02',	null),
		('CIVILIZATION_JFD_NEW_ZEALAND', 	'TXT_KEY_COLONY_NAME_JFD_NEW_ZEALAND_03',	null),
		('CIVILIZATION_JFD_NEW_ZEALAND', 	'TXT_KEY_COLONY_NAME_JFD_NEW_ZEALAND_04',	null),
		('CIVILIZATION_JFD_NEW_ZEALAND', 	'TXT_KEY_COLONY_NAME_JFD_NEW_ZEALAND_05',	null),
		('CIVILIZATION_JFD_NEW_ZEALAND', 	'TXT_KEY_COLONY_NAME_JFD_NEW_ZEALAND_06',	null);
--====================================
-- JFD PROVINCES 
--====================================
-- Civilization_JFD_ProvinceTitles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,				DefaultTitle, UniqueTitle)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',	DefaultTitle, UniqueTitle
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_AMERICA';
--====================================	
-- JFD SLAVERY
--====================================	
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_SLAVERY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,				Flavor)
VALUES	('LEADER_JFD_SEDDON',		'FLAVOR_JFD_SLAVERY',	0);
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,				ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',	ArtDefineTag, CultureType, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_AMERICA';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Colonial'
WHERE Type = 'CIVILIZATION_JFD_NEW_ZEALAND'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Colonial')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
------------------------------
-- MinorCivilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
MinorCivilization_JFD_CultureTypes(
	MinorCivilizationType 						text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null);

UPDATE MinorCivilization_JFD_CultureTypes 
SET CultureType = 'CULTURE_JFD_OCEANIC'
WHERE MinorCivilizationType = 'MINOR_CIV_WELLINGTON';
--==========================================================================================================================
-- JFD RISE TO POWER
--==========================================================================================================================
--====================================	
-- JFD AND POUAKAI MERCENARIES
--====================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,				 Flavor)
VALUES	('LEADER_JFD_SEDDON',	'FLAVOR_JFD_MERCENARY',	 5);
--====================================	
-- JFD PIETY
--====================================	
-- Flavors
------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_RELIGIOUS_INTOLERANCE'),
		('FLAVOR_JFD_STATE_RELIGION');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,								Flavor)
VALUES	('LEADER_JFD_SEDDON',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		0),
		('LEADER_JFD_SEDDON',	'FLAVOR_JFD_STATE_RELIGION',			2);
--====================================
-- JFD PROSPERITY
--====================================
-- Civilization_JFD_Currencies
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies	
		(CivilizationType,				CurrencyType)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_ENGLAND';
--====================================	
-- JFD SOVEREIGNTY
--====================================	
-- Civilization_JFD_Governments
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType	  					text 		 												default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,					GovernmentType,				Weight)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	'GOVERNMENT_JFD_MONARCHY',	70);
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      			HeadOfGovernmentName)
VALUES  ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_1'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_2'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_3'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_4'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_5'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_6'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_7'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_8'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_9'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_10'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_11'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_12'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_13'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_14'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_15'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_16'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_17'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_18'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_19'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_20'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_21'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_22'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_23'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_24'),
        ('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_NEW_ZEALAND_25');
------------------------------------------------------------
-- Civilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	ReligionType					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_Titles
		(CivilizationType,					DefaultTitle,	UniqueTitle)
SELECT	'CIVILIZATION_JFD_NEW_ZEALAND',		DefaultTitle,	UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_AMERICA';
------------------------------------------------------------
-- MinorCivilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	MinorCivilization_JFD_Titles (
	MinorCivilizationType  				text 		REFERENCES MinorCivilizations(Type)			default null,
	ReligionType						text 		REFERENCES Religions(Type) 					default null,
	UniqueGovernmentTitle				text 		 											default null,
	UniqueLeaderTitle					text 		 											default null);	

UPDATE MinorCivilization_JFD_Titles
SET UniqueGovernmentTitle = 'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_PORT_VILLA', UniqueLeaderTitle = 'TXT_KEY_GOVERNMENT_JFD_TITLE_LEADER_JFD_PORT_VILLA'
WHERE MinorCivilizationType = 'MINOR_CIV_WELLINGTON';

INSERT INTO MinorCivilization_JFD_Titles	
		(MinorCivilizationType,				UniqueGovernmentTitle,										UniqueLeaderTitle)
VALUES	('MINOR_CIV_WELLINGTON',			'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_PORT_VILLA',	'TXT_KEY_GOVERNMENT_JFD_TITLE_LEADER_JFD_PORT_VILLA');
------------------------------------------------------------
-- JFD_PrivyCouncillor_UniqueNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_PrivyCouncillor_UniqueNames (
	PrivyCouncillorType  				text 										 	default null,
	PolicyType  						text 	REFERENCES Policies(Type) 				default null,
	CivilizationType					text	REFERENCES Civilizations(Type) 			default	null,
	CultureType							text											default	null,
	GovernmentType  					text 	 										default null,
	ReligionType						text	REFERENCES Religions(Type) 				default	null,
	UniqueName							text											default	null);

INSERT INTO JFD_PrivyCouncillor_UniqueNames	
		(PrivyCouncillorType,				CivilizationType,									UniqueName)
VALUES	('COUNCILLOR_JFD_CHANCELLOR',		'CIVILIZATION_JFD_NEW_ZEALAND',						'TXT_KEY_COUNCILLOR_JFD_CHANCELLOR_DESC_JFD_NEW_ZEALAND'),
		('COUNCILLOR_JFD_MARSHAL',			'CIVILIZATION_JFD_NEW_ZEALAND',						'TXT_KEY_COUNCILLOR_JFD_MARSHAL_DESC_JFD_NEW_ZEALAND'),
		('COUNCILLOR_JFD_HERALD',			'CIVILIZATION_JFD_NEW_ZEALAND',						'TXT_KEY_COUNCILLOR_JFD_HERALD_DESC_JFD_NEW_ZEALAND'),
		('COUNCILLOR_JFD_STEWARD',			'CIVILIZATION_JFD_NEW_ZEALAND',						'TXT_KEY_COUNCILLOR_JFD_STEWARD_DESC_JFD_NEW_ZEALAND');
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,					UniqueName,													PoliticsType)
VALUES	('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_ASSEMBLY_JFD_MILITARY_JFD_NEW_ZEALAND',		'ASSEMBLY_JFD_MILITARY'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_FACTION_JFD_NATIONALIST_JFD_NEW_ZEALAND',		'FACTION_JFD_NATIONALIST'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_FACTION_JFD_POPULARIST_JFD_NEW_ZEALAND',		'FACTION_JFD_POPULARIST'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_REVOLUTIONARY_JFD_NEW_ZEALAND',		'FACTION_JFD_REVOLUTIONARY'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_BURGHERS_JFD_NEW_ZEALAND',			'PARTY_JFD_BURGHERS'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_CLERGY_JFD_NEW_ZEALAND',				'PARTY_JFD_CLERGY'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_COMMUNIST_JFD_NEW_ZEALAND',			'PARTY_JFD_COMMUNIST'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_CONSERVATIVE_JFD_NEW_ZEALAND',		'PARTY_JFD_CONSERVATIVE'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_FASCIST_JFD_NEW_ZEALAND',			'PARTY_JFD_FASCIST'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_LIBERAL_JFD_NEW_ZEALAND',			'PARTY_JFD_LIBERAL'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_LIBERTARIAN_JFD_NEW_ZEALAND',		'PARTY_JFD_LIBERTARIAN'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_NOBILITY_JFD_NEW_ZEALAND',			'PARTY_JFD_NOBILITY'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_REACTIONARY_JFD_NEW_ZEALAND',		'PARTY_JFD_REACTIONARY'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_REVOLUTIONARY_JFD_NEW_ZEALAND',		'PARTY_JFD_REVOLUTIONARY'),
		('CIVILIZATION_JFD_NEW_ZEALAND',	'TXT_KEY_JFD_PARTY_JFD_SOCIALIST_JFD_NEW_ZEALAND',			'PARTY_JFD_SOCIALIST');
------------------------------------------------------------			
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,							Flavor)
VALUES	('LEADER_JFD_SEDDON',	'FLAVOR_JFD_REFORM_GOVERNMENT',		8),
		('LEADER_JFD_SEDDON',	'FLAVOR_JFD_REFORM_LEGAL',			6),
		('LEADER_JFD_SEDDON',	'FLAVOR_JFD_REFORM_CULTURE',		6),
		('LEADER_JFD_SEDDON',	'FLAVOR_JFD_REFORM_ECONOMIC',		3),
		('LEADER_JFD_SEDDON',	'FLAVOR_JFD_REFORM_FOREIGN',		9),
		('LEADER_JFD_SEDDON',	'FLAVOR_JFD_REFORM_INDUSTRY',		2),
		('LEADER_JFD_SEDDON',	'FLAVOR_JFD_REFORM_MILITARY',		5),
		('LEADER_JFD_SEDDON',	'FLAVOR_JFD_REFORM_RELIGION',		2);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  					text 	REFERENCES Leaders(Type) 	default	null,
	ReformType						text								default	null);
	
INSERT INTO Leader_JFD_Reforms
		(LeaderType,				ReformType)
VALUES	('LEADER_JFD_SEDDON',		'REFORM_JFD_TRADE_FREE');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_NewZealand_Decisions.lua');
------------------------------	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 												Description, 											Help, 														Sound, 				 CityAttack,	CannotBeChosen,	PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_DECISIONS_JFD_NEW_ZEALAND_EMPIRE',		'TXT_KEY_PROMOTION_DECISIONS_JFD_NEW_ZEALAND_EMPIRE',	'TXT_KEY_PROMOTION_DECISIONS_JFD_NEW_ZEALAND_EMPIRE_HELP',	'AS2D_IF_LEVELUP', 	 33,			1,				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_DECISIONS_JFD_NEW_ZEALAND_EMPIRE');
------------------------------
-- UnitPromotions_UnitCombats
------------------------------
INSERT INTO UnitPromotions_UnitCombats
		(PromotionType, 									UnitCombatType)
VALUES	('PROMOTION_DECISIONS_JFD_NEW_ZEALAND_EMPIRE',		'UNITCOMBAT_SUBMARINE'),
		('PROMOTION_DECISIONS_JFD_NEW_ZEALAND_EMPIRE',		'UNITCOMBAT_CARRIER'),
		('PROMOTION_DECISIONS_JFD_NEW_ZEALAND_EMPIRE',		'UNITCOMBAT_NAVALMELEE'),
		('PROMOTION_DECISIONS_JFD_NEW_ZEALAND_EMPIRE',		'UNITCOMBAT_NAVALRANGED');
------------------------------
-- Policies
------------------------------
INSERT INTO Policies
		(Type, 												Description,									HappinessPerGarrisonedUnit)
VALUES	('POLICY_DECISIONS_JFD_NEW_ZEALAND_ANZACS', 		'TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_ANZACS',		1),
		('POLICY_DECISIONS_JFD_NEW_ZEALAND_IMPERIUM', 		'TXT_KEY_DECISIONS_JFD_NEW_ZEALAND_IMPERIUM',	0);
------------------------------
-- Policies
------------------------------
INSERT INTO Policy_FreePromotions
		(PolicyType, 										PromotionType)
VALUES	('POLICY_DECISIONS_JFD_NEW_ZEALAND_IMPERIUM', 		'PROMOTION_DECISIONS_JFD_NEW_ZEALAND_EMPIRE');
--==========================================================================================================================
-- SUKRITACT EVENTS
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('JFD_NewZealand_Events.lua');
------------------------------
-- BuildingClasses
------------------------------	
INSERT INTO BuildingClasses
		(Type, 													DefaultBuilding, 										Description,												MaxPlayerInstances)
VALUES	('BUILDINGCLASS_EVENTS_JFD_WORLD_HERITAGE_CULTURE',		'BUILDING_EVENTS_JFD_WORLD_HERITAGE_CULTURE', 			'TXT_KEY_BUILDING_EVENTS_JFD_WORLD_HERITAGE_CULTURE',	1),
		('BUILDINGCLASS_EVENTS_JFD_WORLD_HERITAGE_GOLD',		'BUILDING_EVENTS_JFD_WORLD_HERITAGE_GOLD', 				'TXT_KEY_BUILDING_EVENTS_JFD_WORLD_HERITAGE_GOLD',		1);
------------------------------	
-- Buildings
------------------------------	
INSERT INTO Buildings		
		(Type, 													BuildingClass, 			  								Cost, 	FaithCost,	EnhancedYieldTech,	TechEnhancedTourism, Description, 												Help,														IconAtlas,				PortraitIndex, ConquestProb,	NeverCapture)
VALUES	('BUILDING_EVENTS_JFD_WORLD_HERITAGE_CULTURE', 			'BUILDINGCLASS_EVENTS_JFD_WORLD_HERITAGE_CULTURE',		-1, 	-1,			'TECH_AGRICULTURE',	2,					 'TXT_KEY_BUILDING_EVENTS_JFD_WORLD_HERITAGE_CULTURE', 		'TXT_KEY_BUILDING_EVENTS_JFD_WORLD_HERITAGE_CULTURE_HELP',	'EXPANSION_BW_ATLAS_2', 8,				100,			0),
		('BUILDING_EVENTS_JFD_WORLD_HERITAGE_GOLD', 			'BUILDINGCLASS_EVENTS_JFD_WORLD_HERITAGE_GOLD',			-1, 	-1,			'TECH_AGRICULTURE',	2,					 'TXT_KEY_BUILDING_EVENTS_JFD_WORLD_HERITAGE_GOLD', 		'TXT_KEY_BUILDING_EVENTS_JFD_WORLD_HERITAGE_GOLD_HELP',		'EXPANSION_BW_ATLAS_2', 8,				100,			0);
------------------------------
-- Building_YieldChanges
------------------------------
INSERT INTO Building_YieldChanges
		(BuildingType,											YieldType,			Yield)
VALUES	('BUILDING_EVENTS_JFD_WORLD_HERITAGE_CULTURE',			'YIELD_CULTURE',	2),
		('BUILDING_EVENTS_JFD_WORLD_HERITAGE_GOLD',				'YIELD_GOLD',		3);
--==========================================================================================================================
--==========================================================================================================================