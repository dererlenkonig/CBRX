--=======================================================================================================================
-- Bingle's Civ IV Traits
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------  
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
        (LeaderType,				TraitOne,					TraitTwo)
SELECT  'LEADER_MC_MINOS',			'POLICY_SEAFARING_X',		'POLICY_INVENTIVE_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Seleucus I Nicator [ICON_MOVES][ICON_SCIENCE]'
WHERE Type = 'LEADER_MC_MINOS'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');

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
-- Events & Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_Minoa_Decisions.lua');
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
	DefeatScreenEarlyTag						text											default	null,
	DefeatScreenMidTag							text											default	null,
	DefeatScreenLateTag							text											default	null,
	IdealsTag									text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_MC_MINOA',	ArtDefineTag, CultureType, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_GREECE';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Classical'
WHERE Type = 'CIVILIZATION_MC_MINOA'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Classical')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
-- Enlightenment Era
--==========================================================================================================================
UPDATE Unit_ClassUpgrades
Set UnitClassType = 'UNIT_EE_CARRACK'
Where UnitType = 'UNIT_MC_MINOAN_GALEA'
AND EXISTS (SELECT * FROM Units WHERE Type = 'UNIT_EE_CARRACK');
--==========================================================================================================================
-- JFD's Cities in Development
--==========================================================================================================================
--====================================
-- JFD's CiD: Colonies
--====================================
-- Civilization_JFD_ColonialCityNames
--------------------------------------
CREATE TABLE IF NOT EXISTS
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(TYPE)      DEFAULT NULL,
    ColonyName                                  text                                        DEFAULT NULL,
    LinguisticType                              text                                        DEFAULT NULL,
    CultureType                                 text                                        DEFAULT NULL);
 
INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
            (CivilizationType,                    ColonyName,                               LinguisticType)
VALUES      ('CIVILIZATION_MC_MINOA',             null,                                     'JFD_Hellenic'),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_01',        null),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_02',        null),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_03',        null),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_04',        null),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_05',        null),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_06',        null),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_07',        null),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_08',        null),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_09',        null),
            ('CIVILIZATION_MC_MINOA',             'TXT_KEY_COLONY_NAME_MC_MINOA_10',        null);
--====================================
-- JFD's CiD: Provinces 
--====================================
-- Civilization_JFD_ProvinceTitles
--------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle, UniqueTitle)
SELECT	'CIVILIZATION_MC_MINOA',	DefaultTitle, UniqueTitle
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_GREECE';
--====================================  
-- JFD's CiD: Slavery
--====================================    
-- Flavors
--------------------------------------
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_SLAVERY');
--------------------------------------
-- Leader_Flavors
--------------------------------------
--A value of 0-10 may be set. This value determines the proclivity a civ has toward enslaving a captured city and toward spending Slavery on Units.
INSERT INTO Leader_Flavors
        (LeaderType,            FlavorType,                 Flavor)
VALUES  ('LEADER_MC_MINOS',		'FLAVOR_JFD_SLAVERY',       7);
--==========================================================================================================================
-- Tomatekh's Historical Religions
--==========================================================================================================================
-- Civilization_Religions
------------------------------
UPDATE Civilization_Religions
SET ReligionType = 'RELIGION_HELLENISM'
WHERE CivilizationType = 'CIVILIZATION_MC_MINOA'
AND EXISTS (SELECT * FROM Religions WHERE Type = 'RELIGION_HELLENISM');
--==========================================================================================================================
-- R.E.D. / Ethnic Units
--==========================================================================================================================
UPDATE Civilizations
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_GREECE' )
    THEN '_GREECE'
    ELSE '_MED' END)
WHERE Type = 'CIVILIZATION_MC_MINOA';
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
            (CivType,                       CultureType,        CultureEra)
VALUES      ('CIVILIZATION_MC_MINOA',       'MEDITERRANEAN',    'ANY');
--==========================================================================================================================  
-- JFD's and Pouakai's Mercenaries
--==========================================================================================================================
-- Flavors
------------------------------------------------------------    
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------    
--A value of 1-10 may be set. This value determines the likelihood that a leader will take out Mercenary Contracts (provided they have the funds).
--A value of 10 means this civilization will always take a Contract if available. A value of 0 means this civilization will never take out a contract.
INSERT OR REPLACE INTO Leader_Flavors
        (LeaderType,            FlavorType,                 Flavor)
VALUES  ('LEADER_MC_MINOS',		'FLAVOR_JFD_MERCENARY',    6);
--==========================================================================================================================    
-- JFD's Rise to Power
--==========================================================================================================================
--==================================== 
-- JFD's RtP: Piety
--====================================
-- Flavors
--------------------------------------
INSERT OR REPLACE INTO Flavors
        (TYPE)
VALUES  ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
--------------------------------------
-- Leader_Flavors
--------------------------------------
INSERT OR REPLACE INTO Flavors
            (Type)
VALUES      ('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
 
INSERT INTO Leader_Flavors
            (LeaderType,            FlavorType,                             Flavor)
VALUES      ('LEADER_MC_MINOS',     'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',     3);
--====================================
-- JFD's RtP: Prosperity
--====================================
-- Civilization_JFD_Currencies
--------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Currencies (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 	default null,
	CurrencyType	  				text 		  								default null);

INSERT INTO Civilization_JFD_Currencies
		(CivilizationType,				CurrencyType)
SELECT	'CIVILIZATION_MC_MINOA',		CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_GREECE';
--====================================
-- JFD's RtP: Sovereignty
--====================================
--------------------------------------
-- Civilization_JFD_Governments
--------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType	  					text 		 												default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,				LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT	'CIVILIZATION_MC_MINOA0',		LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_GREECE';
--------------------------------------
-- Civilization_JFD_HeadsOfGovernment	
--------------------------------------
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
		(CivilizationType,				HeadOfGovernmentName)
SELECT	'CIVILIZATION_MC_MINOA',		HeadOfGovernmentName
FROM Civilization_JFD_HeadsOfGovernment WHERE CivilizationType = 'CIVILIZATION_GREECE';
--------------------------------------
-- Civilization_JFD_Politics
--------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,				PoliticsType, UniqueName)
SELECT	'CIVILIZATION_MC_MINOA',		PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_GREECE';
--------------------------------------
-- Civilization_JFD_Titles
--------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	ReligionType					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	
	
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,			DefaultTitle, UniqueTitle, UseAdjective)
SELECT	'CIVILIZATION_MC_MINOA',	DefaultTitle, UniqueTitle, UseAdjective
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_GREECE';
--------------------------------------
-- Flavors
--------------------------------------
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_REFORM_GOVERNMENT'),
		('FLAVOR_JFD_REFORM_CULTURE'),
		('FLAVOR_JFD_REFORM_ECONOMIC'),
		('FLAVOR_JFD_REFORM_FOREIGN'),
		('FLAVOR_JFD_REFORM_LEGAL'),
		('FLAVOR_JFD_REFORM_INDUSTRY'),
		('FLAVOR_JFD_REFORM_MILITARY'),
		('FLAVOR_JFD_REFORM_RELIGION');
--------------------------------------
-- Leader_Flavors
--------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,			FlavorType,							 Flavor)
VALUES	('LEADER_MC_MINOS',		'FLAVOR_JFD_REFORM_GOVERNMENT',		 6),
		('LEADER_MC_MINOS',		'FLAVOR_JFD_REFORM_CULTURE',		 7),
		('LEADER_MC_MINOS',		'FLAVOR_JFD_REFORM_ECONOMIC',		 5),
		('LEADER_MC_MINOS',		'FLAVOR_JFD_REFORM_FOREIGN',		 5),
		('LEADER_MC_MINOS',		'FLAVOR_JFD_REFORM_INDUSTRY',		 5),
		('LEADER_MC_MINOS',		'FLAVOR_JFD_REFORM_LEGAL',			 5),
		('LEADER_MC_MINOS',		'FLAVOR_JFD_REFORM_MILITARY',		 5),
		('LEADER_MC_MINOS',		'FLAVOR_JFD_REFORM_RELIGION',		 7);
--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================
--PROMOTION_JFD_SNOW_IMMUNITY, PROMOTION_JFD_DESERT_IMMUNITY, PROMOTION_JFD_DISEASE_IMMUNITY, PROMOTION_JFD_JUNGLE_IMMUNITY, PROMOTION_JFD_SCUVRY_IMMUNITY, PROMOTION_JFD_IMMUNITY (immunity to all attrition)
INSERT INTO Unit_FreePromotions
            (UnitType,                 PromotionType)
SELECT      ('UNIT_MC_MINOAN_GALEA'),  ('PROMOTION_JFD_SCURVY_IMMUNITY')
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_SCURVY_IMMUNITY');
--==========================================================================================================================
-- YnAEMP v24
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	30,		52,		null,	null);

------------------------------------------------------------
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	67,		51,		null,	null);

------------------------------------------------------------
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	44,		22,		null,	null);

------------------------------------------------------------
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	59,		38,		null,	null);

------------------------------------------------------------
-- Civilizations_AegeanStartPosition (Aegean)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AegeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AegeanStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	22,		4,		null,	null);

------------------------------------------------------------
-- Civilizations_AfriAsiaAustStartPosition (Africa, Asia, Oceania Huge)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	37,		68,		null,	null);

------------------------------------------------------------
-- Civilizations_AfriGiantStartPosition (Africa Giant)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriGiantStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	77,		135,	null,	null);

------------------------------------------------------------
-- Civilizations_AfriSouthEuroStartPosition (Africa & Southern Europe Large)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriSouthEuroStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	47,		62,		null,	null);

------------------------------------------------------------
-- Civilizations_CaucasusStartPosition (Caucasus Giant)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_CaucasusStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaucasusStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	27,		4,		null,	null);

------------------------------------------------------------
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	100,	12,		null,	null);

------------------------------------------------------------
-- Civilizations_EuroLargeStartPosition (Large Europe)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	50,		21,		null,	null);

------------------------------------------------------------
-- Civilizations_EuroLargeNewStartPosition (Europe Greatest Large)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	55,		10,		null,	null);

------------------------------------------------------------
-- Civilizations_MediterraneanStartPosition (Mediterranean)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	67,		23,		null,	null);

------------------------------------------------------------
-- Civilizations_MesopotamiaGiantStartPosition (Mesopotamia Giant)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaGiantStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	1,		56,		null,	null);


------------------------------------------------------------
-- Civilizations_MesopotamiaStartPosition (Mesopotamia)
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaStartPosition
			(Type,						X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MC_MINOA',	13,		17,		null,	null);


--==========================================================================================================================
--==========================================================================================================================