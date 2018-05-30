--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ARABIA' )
	THEN '_ARABIA'
	ELSE '_AFRI' END) 
WHERE Type = 'CIVILIZATION_MC_LITE_MOOR';
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,						CultureType,	CultureEra)
VALUES		('CIVILIZATION_MC_LITE_MOOR',	'ARABIAN',		'ANY');
--==========================================================================================================================
-- JFD's Cultural Diversity
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	ArtDefineTag								text											default	null);

INSERT OR REPLACE INTO Civilization_JFD_CultureTypes
			(CivilizationType,				CultureType,		SplashScreenTag,	SoundtrackTag,		ArtDefineTag)
VALUES		('CIVILIZATION_MC_LITE_MOOR',	'JFD_Islamic',		'JFD_Islamic',		'JFD_Islamic',		'JFD_Islamic');

UPDATE Civilizations 
SET SoundtrackTag = (CASE WHEN EXISTS(SELECT SoundtrackTag FROM Civilizations WHERE SoundtrackTag = 'JFD_Islamic' )
	THEN 'JFD_Islamic'
	ELSE 'Arabia' END) 
WHERE Type = 'CIVILIZATION_MC_LITE_MOOR';
--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 					LinguisticType)
VALUES		('CIVILIZATION_MC_LITE_MOOR',		'JFD_Arabic');
------------------------------	
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_MC_LITE_MOOR'),		('CIVILIZATION_SPAIN')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_SPAIN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_MC_LITE_MOOR'),		('CIVILIZATION_PORTUGAL')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_PORTUGAL');
--==========================================================================================================================	
-- JFD's Piety & Prestige
--==========================================================================================================================			
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');

INSERT INTO Leader_Flavors
			(LeaderType,							FlavorType,								Flavor)
VALUES		('LEADER_MC_LITE_ABD_AR_RAHMAN_III',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		3);
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
	 
INSERT OR REPLACE INTO Leader_SharedTraits
			(LeaderType,							TraitOne,					TraitTwo)
VALUES      ('LEADER_MC_LITE_ABD_AR_RAHMAN_III',	'POLICY_PHILOSOPHICAL_X',	'POLICY_INVENTIVE_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X')
	THEN 'Abd-ar-Rahman III [ICON_GREAT_PEOPLE][ICON_RESEARCH]'
	ELSE 'TXT_KEY_LEADER_MC_LITE_ABD_AR_RAHMAN_III' END) 
WHERE Type = 'LEADER_MC_LITE_ABD_AR_RAHMAN_III';
--==========================================================================================================================	
-- JFD's SOVEREIGNTY (d99bf7aa-51ac-4bef-bd88-d765b28e260e)
--==========================================================================================================================
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

--This table determines a variety of things relating to your Government.
--The LegislatureName refers to the name of your Legislature (e.g. the Imperial Diet). 
--The OfficeTitle refers to the title of your Head of Government (if a Const. Monarchy) (e.g. Vizier. Default is Prime Minister)
--GovernmentType and Weight prefer to a Government preference (GOVERNMENT_JFD_MONARCHY or GOVERNMENT_JFD_REPUBLIC) and how strong that preference is.
INSERT INTO Civilization_JFD_Governments
		(CivilizationType,				GovernmentType, 			Weight)
VALUES	('CIVILIZATION_MC_LITE_MOOR',	'GOVERNMENT_JFD_MONARCHY', 	80);
------------------------------------------------------------
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
--Each flavour corresponds to one of the seven Reform Categories, and how likely a civ is to take a reform in either the Right, Centre, or Left column.
--A value of 1-3 will favour Left Reforms. A value of 4-6 will value Centre Reforms. A value of 7-10 will value Right Reforms. The strength of the value will determine how soon a Leader will implement that Reform.
INSERT INTO Leader_Flavors
		(LeaderType,							FlavorType,							Flavor)
VALUES	('LEADER_MC_LITE_ABD_AR_RAHMAN_III',	'FLAVOR_JFD_REFORM_GOVERNMENT',		7),
		('LEADER_MC_LITE_ABD_AR_RAHMAN_III',	'FLAVOR_JFD_REFORM_CULTURE',		3),
		('LEADER_MC_LITE_ABD_AR_RAHMAN_III',	'FLAVOR_JFD_REFORM_ECONOMIC',		4),
		('LEADER_MC_LITE_ABD_AR_RAHMAN_III',	'FLAVOR_JFD_REFORM_FOREIGN',		8),
		('LEADER_MC_LITE_ABD_AR_RAHMAN_III',	'FLAVOR_JFD_REFORM_INDUSTRY',		5),
		('LEADER_MC_LITE_ABD_AR_RAHMAN_III',	'FLAVOR_JFD_REFORM_MILITARY',		5),
		('LEADER_MC_LITE_ABD_AR_RAHMAN_III',	'FLAVOR_JFD_REFORM_RELIGION',		6);
--==========================================================================================================================
-- POUAKAI ENLIGHTENMENT ERA
--==========================================================================================================================
-- Unit_ClassUpgrades
------------------------------	
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_EE_SKIRMISHER'
WHERE UnitType = 'UNIT_MC_LITE_GRANADINE_CAVALRY'
AND EXISTS (SELECT * FROM Technologies WHERE Type = 'TECH_EE_FLINTLOCK');
--==========================================================================================================================		
--==========================================================================================================================