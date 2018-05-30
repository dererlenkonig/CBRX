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
        (LeaderType,			TraitOne,				TraitTwo)
SELECT	 'LEADER_JFD_IVAN',		'POLICY_AGGRESSIVE_X',	'POLICY_SPIRITUAL_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Leaders 
SET Description = 'Ivan IV [ICON_WAR][ICON_PEACE]'
WHERE Type = 'LEADER_JFD_IVAN'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--==========================================================================================================================
-- GAZEBO COMMUNITY BALANCE PATCH
--==========================================================================================================================
-- COMMUNITY
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS COMMUNITY (Type TEXT, Value INTEGER);
------------------------------
-- Buildings
------------------------------	
UPDATE Buildings 
SET Help = 'TXT_KEY_BUILDING_JFD_SOBOR_HELP_CBO'
WHERE Type = 'BUILDING_JFD_SOBOR'
AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value = 1);
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_RUSSIA'
WHERE Type = 'CIVILIZATION_JFD_MUSCOVY'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_RUSSIA');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	38,		72);

CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_YagemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			33,		74
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_YagemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		40,		74
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_YagemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		34,		73
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_YagemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	38,		64
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_YagemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		42,		74
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	75,		63);

CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_YahemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			70,		63
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_YahemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		75,		64
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_YahemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		72,		65
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_YahemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	73,		56
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_YahemStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		78,		65
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	45,		36);

CREATE TABLE IF NOT EXISTS MinorCiv_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_CordiformStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			44,		35
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_CordiformStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		46,		38
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_CordiformStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		44,		37
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_CordiformStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	47,		28
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_CordiformStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		47,		38
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	63,		56);

CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_GreatestEarthStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			61,		55
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_GreatestEarthStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		65,		59
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_GreatestEarthStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		62,		57
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_GreatestEarthStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	63,		49
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_GreatestEarthStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		66,		57
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_EuroGiantStartPosition (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	122,	84);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_EuroGiantStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			106,	82
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroGiantStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		126,	89
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroGiantStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		113,	80
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_GreatestEarthStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	127,	50
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroGiantStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		127,	86
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_EuroLargeStartPosition (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	60,		53);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_EuroGiantStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			52,		54
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroLargeStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		69,		58
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroLargeStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		58,		50
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroLargeStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	60,		37
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroLargeStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		66,		53
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_EuroLargeNewStartPosition (Europe Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeNewStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	70,		56);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroLargeNewStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_EuroLargeNewStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			62,		60
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroLargeNewStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		68,		37
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroLargeNewStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		66,		57
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroLargeNewStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	67,		32
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroLargeNewStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		72,		57
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	103,	46);

CREATE TABLE IF NOT EXISTS MinorCiv_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_NorthAtlanticStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			106,	82
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_NorthAtlanticStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		102,	57
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_NorthAtlanticStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		104,	54
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_NorthAtlanticStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		105,	43
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
		(Type,							X,		Y)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		X,		Y
FROM Civilizations_AmericasStartPosition WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeStartPosition (North-West Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthWestEuropeStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	53,		43);

CREATE TABLE IF NOT EXISTS MinorCiv_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_NorthWestEuropeStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			55,		43
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_EuroEasternStartPosition (Eastern Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroEasternStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroEasternStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	79,		53);

CREATE TABLE IF NOT EXISTS MinorCiv_EuroEasternStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO MinorCiv_EuroEasternStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_PSKOV', 			56,		57
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroEasternStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_ROSTOV', 		85,		16
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroEasternStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_SMOLENSK', 		61,		52
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroEasternStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 	83,		10
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCiv_EuroEasternStartPosition 
		(Type, 							X,		Y)
SELECT	'MINOR_CIV_JFD_VLADIMIR', 		91,		54
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeStartPosition (Americas Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasGiantStartPosition
		(Type,							X,		Y)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	5,		141);
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Large)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_EuroLargeRequestedResource (Europe Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeNewRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeNewRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_AmericasRequestedResource (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_NorthAtlanticRequestedResource (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAtlanticRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_NorthWestEuropeRequestedResource (North-West Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthWestEuropeRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthWestEuropeRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_EuroEasternRequestedResource (Eastern Europe)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroEasternRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroEasternRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroEasternRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------	
-- Civilizations_AmericasGiantRequestedResource (Americas Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasGiantRequestedResource
		(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasGiantRequestedResource WHERE Type = 'CIVILIZATION_RUSSIA';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,						CultureType,	CultureEra)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		CultureType,	CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_RUSSIA';
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
-- JFD DYNAMIC TOP PANEL
--==========================================================================================================================			
-- JFD_TopPanelIncludes
------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_TopPanelIncludes (
	FileName				text		default null);
	
INSERT INTO JFD_TopPanelIncludes
		(FileName)
VALUES	('JFD_Muscovy_DTP.lua');
------------------------------		
-- JFD_TopPanelAdditions
------------------------------		
CREATE TABLE IF NOT EXISTS 
	JFD_TopPanelAdditions (
	CivilizationType		text		REFERENCES Civilizations(Type) 	default null,
	YieldType  				text 										default null,
	YieldSourceFunction 	text										default null,
	YieldSourceToolTip		text										default	null,
	MiscToolTipFunction		text										default	null);
	
INSERT INTO JFD_TopPanelAdditions
		(CivilizationType,				YieldType,			YieldSourcefunction,							YieldSourceToolTip)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	'YIELD_GOLDEN_AGE',	'JFD_Muscovy_GetGoldenAgePointsFromRazing',		'TXT_KEY_JFD_MUSCOVY_GOLDEN_AGE_POINTS_FROM_RAZING');	
--==========================================================================================================================
-- JFD CIVILOPEDIA
--==========================================================================================================================
-- JFD_Civilopedia_HideFromPedia
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
JFD_Civilopedia_HideFromPedia (Type text default null);

INSERT INTO JFD_Civilopedia_HideFromPedia
		(Type)
VALUES	('PROMOTION_JFD_STRELTSY_ACTIVE');
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
-- Building_ConstructionAudio
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
	Building_ConstructionAudio (
    BuildingType								text		REFERENCES Buildings(Type)      default null,
    ConstructionAudio							text										default null);
	
INSERT INTO Building_ConstructionAudio
		(BuildingType, 					ConstructionAudio)
SELECT	'BUILDING_JFD_SOBOR',			'AS2D_BUILDING_JFD_SOBOR'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_MISC_CIV_BUILDING_SOUNDS' AND Value = 1);
--====================================	
-- JFD COLONIES
--====================================	
-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 								text 	REFERENCES Civilizations(Type) 	default null,
	ColonyName 										text									default null,
	LinguisticType									text									default	null,
	CultureType										text									default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType, 				ColonyName,		LinguisticType)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		ColonyName,		LinguisticType
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_DECOLONIZATION');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------
INSERT INTO Leader_Flavors
		(LeaderType,				FlavorType,						Flavor)
VALUES	('LEADER_JFD_IVAN',			'FLAVOR_JFD_DECOLONIZATION',	2);
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
		(CivilizationType,			DefaultTitle, UniqueTitle)
SELECT	'CIVILIZATION_JFD_MUSCOVY',	DefaultTitle, UniqueTitle
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
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
VALUES	('LEADER_JFD_IVAN',			'FLAVOR_JFD_SLAVERY',	7);
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
SELECT	'CIVILIZATION_JFD_MUSCOVY',	ArtDefineTag, CultureType, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, 'JFD_Eastern', UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------	
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_Eastern'
WHERE Type = 'CIVILIZATION_JFD_MUSCOVY'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Eastern')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
------------------------------
-- MinorCivilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
MinorCivilization_JFD_CultureTypes(
	MinorCivilizationType 			text 	REFERENCES MinorCivilizations(Type) 	default null,
	CultureType 					text											default null);

INSERT INTO MinorCivilization_JFD_CultureTypes
		(MinorCivilizationType,		CultureType)
SELECT	'MINOR_CIV_JFD_PSKOV',		'JFD_Eastern'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_JFD_CultureTypes
		(MinorCivilizationType,		CultureType)
SELECT	'MINOR_CIV_JFD_ROSTOV',		'JFD_Eastern'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_JFD_CultureTypes
		(MinorCivilizationType,		CultureType)
SELECT	'MINOR_CIV_JFD_SMOLENSK',	'JFD_Eastern'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_JFD_CultureTypes
		(MinorCivilizationType,		CultureType)
SELECT	'MINOR_CIV_JFD_TMUTARAKAN', 'JFD_Eastern'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);

INSERT INTO MinorCivilization_JFD_CultureTypes
		(MinorCivilizationType,		CultureType)
SELECT	'MINOR_CIV_JFD_VLADIMIR',	'JFD_Eastern'
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_MINOR_CIVILIZATIONS_RUSSIAN' AND Value = 1);
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
		(LeaderType,				FlavorType,								Flavor)
VALUES	('LEADER_JFD_IVAN',			'FLAVOR_JFD_MERCENARY',					4);
--====================================	
-- JFD PIETY
--====================================	
-- Buildings
------------------------------	
INSERT OR REPLACE INTO Buildings 	
		(Type, 					BuildingClass, PrereqTech, Cost, GoldMaintenance, MinAreaSize, Description, 					Civilopedia, 					Help, 										Strategy,								ArtDefineTag, PortraitIndex, IconAtlas)
SELECT	'BUILDING_JFD_SOBOR',	BuildingClass, PrereqTech, Cost, GoldMaintenance, MinAreaSize, 'TXT_KEY_BUILDING_JFD_SOBOR', 	'TXT_KEY_CIV5_JFD_SOBOR_TEXT',	'TXT_KEY_BUILDING_JFD_SOBOR_HELP_PIETY', 	'TXT_KEY_BUILDING_JFD_SOBOR_STRATEGY',	ArtDefineTag, 3, 			 'JFD_MUSCOVY_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_MONASTERY'
AND EXISTS (SELECT * FROM Processes WHERE Type = 'PROCESS_JFD_PIETY');	

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_SOBOR_HELP_PIETY_EXCE'
WHERE Type = 'BUILDING_JFD_SOBOR'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_EXCE_EXPLORATION_BUILDING_CHANGES_MONASTERY' AND Value = 1);

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_SOBOR_HELP_PIETY_EXCE'
WHERE Type = 'BUILDING_JFD_SOBOR'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_EXCE_EXPLORATION_BUILDING_CHANGES_MONASTERY' AND Value = 1);

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_SOBOR_HELP_PIETY_HEALTH'
WHERE Type = 'BUILDING_JFD_SOBOR'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_HEALTH_CORE' AND Value = 1);

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_SOBOR_HELP_PIETY_EXCE_HEALTH'
WHERE Type = 'BUILDING_JFD_SOBOR'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_HEALTH_CORE' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_EXCE_EXPLORATION_BUILDING_CHANGES_MONASTERY' AND Value = 1);
--------------------------------	
-- Building_ResourceYieldChanges
--------------------------------	
DELETE FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_JFD_SOBOR'
AND EXISTS (SELECT * FROM Processes WHERE Type = 'PROCESS_JFD_PIETY');
INSERT INTO Building_ResourceYieldChanges 	
		(BuildingType, 			ResourceType, YieldType, Yield)
SELECT	'BUILDING_JFD_SOBOR',	ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_MONASTERY'
AND EXISTS (SELECT * FROM Processes WHERE Type = 'PROCESS_JFD_PIETY');
------------------------------	
-- Building_YieldChanges
------------------------------	
DELETE FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_JFD_SOBOR'
AND EXISTS (SELECT * FROM Processes WHERE Type = 'PROCESS_JFD_PIETY');
INSERT INTO Building_YieldChanges 	
		(BuildingType, 			YieldType, Yield)
SELECT	'BUILDING_JFD_SOBOR',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_MONASTERY'
AND EXISTS (SELECT * FROM Processes WHERE Type = 'PROCESS_JFD_PIETY');	
------------------------------
-- Civilization_BuildingClassOverrides
------------------------------	
UPDATE Civilization_BuildingClassOverrides
SET BuildingClassType = 'BUILDINGCLASS_MONASTERY'
WHERE CivilizationType = 'CIVILIZATION_JFD_MUSCOVY' AND BuildingType = 'BUILDING_JFD_SOBOR'
AND EXISTS (SELECT * FROM Processes WHERE Type = 'PROCESS_JFD_PIETY');
------------------------------
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
		(LeaderType,				FlavorType,								Flavor)
VALUES	('LEADER_JFD_IVAN',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		9),
		('LEADER_JFD_IVAN',			'FLAVOR_JFD_STATE_RELIGION',			9);
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
		(CivilizationType,			CurrencyType)
SELECT	'CIVILIZATION_JFD_MUSCOVY',	CurrencyType
FROM Civilization_JFD_Currencies WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
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
		(CivilizationType,				LegislatureName, 										OfficeTitle,													GovernmentType,				Weight)
VALUES	('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_LEGISLATURE_NAME_CIVILIZATION_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_MUSCOVY',	'GOVERNMENT_JFD_MONARCHY',	90);
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      		HeadOfGovernmentName)
VALUES  ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_1'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_2'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_3'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_4'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_5'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_6'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_7'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_8'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_9'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_10'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_11'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_12'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_13'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_14'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_15'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_16'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_17'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_18'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_19'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_20'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_21'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_22'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_23'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_24'),
        ('CIVILIZATION_JFD_MUSCOVY',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_CIVILIZATION_JFD_MUSCOVY_25');
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
		(CivilizationType,			DefaultTitle,	UniqueTitle)
SELECT	'CIVILIZATION_JFD_MUSCOVY',	DefaultTitle,	UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------
-- Civilization_JFD_Politics
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  					text 		REFERENCES Civilizations(Type) 					default null,
	PoliticsType  						text 														default null,
	UniqueName							text														default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,				PoliticsType, UniqueName)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
------------------------------------------------------------
-- MinorCivilization_JFD_Titles
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	MinorCivilization_JFD_Titles (
	MinorCivilizationType  				text 		REFERENCES MinorCivilizations(Type)			default null,
	ReligionType						text 		REFERENCES Religions(Type) 					default null,
	UniqueGovernmentTitle				text 		 											default null,
	UniqueLeaderTitle					text 		 											default null);	

INSERT INTO MinorCivilization_JFD_Titles
		(MinorCivilizationType,			UniqueGovernmentTitle,										UniqueLeaderTitle)
VALUES	('MINOR_CIV_JFD_PSKOV',			'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_PSKOV',		'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_PSKOV'),	
		('MINOR_CIV_JFD_ROSTOV',		'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_ROSTOV',		'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_ROSTOV'),	
		('MINOR_CIV_JFD_SMOLENSK',		'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_SMOLENSK',		'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_SMOLENSK'),	
		('MINOR_CIV_JFD_TMUTARAKAN',	'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_TMUTARAKAN',	'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_TMUTARAKAN'),
		('MINOR_CIV_JFD_VLADIMIR',		'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_VLADIMIR',		'TXT_KEY_GOVERNMENT_JFD_TITLE_GOVERNMENT_JFD_VLADIMIR');	
--------------------------------------------------------------------------------------------------------------------------
-- JFD_PrivyCouncillor_UniqueNames
--------------------------------------------------------------------------------------------------------------------------
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
		(CivilizationType,				PrivyCouncillorType, UniqueName)
SELECT	'CIVILIZATION_JFD_MUSCOVY',		PrivyCouncillorType, UniqueName
FROM JFD_PrivyCouncillor_UniqueNames WHERE CivilizationType = 'CIVILIZATION_RUSSIA';
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
		(LeaderType,				FlavorType,							 Flavor)
VALUES	('LEADER_JFD_IVAN',			'FLAVOR_JFD_REFORM_GOVERNMENT',		 7),
		('LEADER_JFD_IVAN',			'FLAVOR_JFD_REFORM_LEGAL',			 6),
		('LEADER_JFD_IVAN',			'FLAVOR_JFD_REFORM_CULTURE',		 4),
		('LEADER_JFD_IVAN',			'FLAVOR_JFD_REFORM_ECONOMIC',		 6),
		('LEADER_JFD_IVAN',			'FLAVOR_JFD_REFORM_FOREIGN',		 8),
		('LEADER_JFD_IVAN',			'FLAVOR_JFD_REFORM_INDUSTRY',		 6),
		('LEADER_JFD_IVAN',			'FLAVOR_JFD_REFORM_MILITARY',		 7),
		('LEADER_JFD_IVAN',			'FLAVOR_JFD_REFORM_RELIGION',		 8);
--------------------------------------------------------------------------------------------------------------------------
-- Leader_JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  					text 	REFERENCES Leaders(Type) 	default	null,
	ReformType						text								default	null);
	
INSERT INTO Leader_JFD_Reforms
		(LeaderType,				ReformType)
VALUES	('LEADER_JFD_IVAN',			'REFORM_JFD_LEGITIMACY_MIGHT');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_Muscovy_Decisions.lua');
------------------------------	
-- Policies
------------------------------	
INSERT INTO Policies 
		(Type, 										Description)
VALUES	('POLICY_DECISIONS_JFD_MUSCOVY_RUSSIA', 	'TXT_KEY_DECISIONS_JFD_MUSCOVY_RUSSIA');
------------------------------------------------------------
-- Policy_JFD_CivilizationNames
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS
	Policy_JFD_CivilizationNames (
	PolicyType								text 	REFERENCES Policies(Type) 				default null,
	CivilizationType						text 	REFERENCES Civilizations(Type) 			default null,
	Description								text 											default null,
	ShortDescription						text 											default null,
	Adjective								text 											default null);
	
INSERT INTO Policy_JFD_CivilizationNames 	
		(PolicyType, 								CivilizationType,							Adjective,													Description,				ShortDescription)
VALUES	('POLICY_DECISIONS_JFD_MUSCOVY_RUSSIA',		'CIVILIZATION_JFD_MUSCOVY',					'TXT_KEY_CIV_RUSSIA_ADJECTIVE',								'TXT_KEY_CIV_RUSSIA_DESC',	'TXT_KEY_CIV_RUSSIA_SHORT_DESC');
------------------------------
-- Policy_GoldenAgeYieldMod
------------------------------
CREATE TABLE IF NOT EXISTS
	Policy_GoldenAgeYieldMod (
	PolicyType								text 	REFERENCES Policies(Type) 				default null,
	YieldType								text 	REFERENCES Yields(Type) 				default null,
	Yield									integer 										default 0);
	
INSERT INTO Policy_GoldenAgeYieldMod
		(PolicyType, 								YieldType, 					Yield)
SELECT	'POLICY_DECISIONS_JFD_MUSCOVY_RUSSIA', 		'YIELD_JFD_SOVEREIGNTY',	10
WHERE EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_RTP_SOVEREIGNTY_CORE' AND Value = 1);
------------------------------
-- BuildingClasses
------------------------------
INSERT INTO BuildingClasses 	
		(Type, 						 		 		DefaultBuilding, 							Description, 												MaxGlobalInstances)
VALUES	('BUILDINGCLASS_DECISIONS_JFD_ST_BASILS', 	'BUILDING_DECISIONS_JFD_ST_BASILS',			'TXT_KEY_DECISIONS_BUILDING_JFD_ST_BASILS',					1);
------------------------------
-- Buildings
------------------------------
INSERT INTO Buildings			
		(Type, 										BuildingClass, 			  					UnmoddedHappiness, 	Cost, 	FaithCost,	ReligiousPressureModifier,	FreeBuildingThisCity,		Description, 								Help,												Civilopedia,											Quote, 												IconAtlas,		HurryCostModifier, 	MinAreaSize, 	ConquestProb, 	NukeImmune, DisplayPosition, 	PortraitIndex,	WonderSplashImage, 				NeverCapture)
VALUES	('BUILDING_DECISIONS_JFD_ST_BASILS', 		'BUILDINGCLASS_DECISIONS_JFD_ST_BASILS', 	2,					-1, 	-1,			100,						'BUILDINGCLASS_CATHEDRAL',	'TXT_KEY_DECISIONS_BUILDING_JFD_ST_BASILS', 'TXT_KEY_DECISIONS_BUILDING_JFD_ST_BASILS_HELP',	'TXT_KEY_DECISIONS_BUILDING_JFD_ST_BASILS_CIVILOPEDIA', 'TXT_KEY_DECISIONS_BUILDING_JFD_ST_BASILS_QUOTE',	'BW_ATLAS_2',	-1,					-1,				100,			1,			1,					13,				'WonderConceptKremlin.dds',		0);

UPDATE Buildings
SET Help = 'TXT_KEY_DECISIONS_BUILDING_JFD_ST_BASILS_HELP_SOVEREIGNTY'
WHERE Type = 'BUILDING_DECISIONS_JFD_ST_BASILS'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_RTP_SOVEREIGNTY_CORE' AND Value = 1);
------------------------------
-- Building_YieldChanges
------------------------------
INSERT INTO Building_YieldChanges
		(BuildingType, 								YieldType, 					Yield)
VALUES	('BUILDING_DECISIONS_JFD_ST_BASILS', 		'YIELD_FAITH',				3),
		('BUILDING_DECISIONS_JFD_ST_BASILS', 		'YIELD_CULTURE', 			1);
--==========================================================================================================================
-- SUKRITACT EVENTS
--==========================================================================================================================
-- EventsAddin_Support
------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('JFD_Muscovy_Events.lua');
------------------------------
-- Events_CulturalDevelopments
------------------------------
CREATE TABLE IF NOT EXISTS 
Events_CulturalDevelopments(
	CivilizationType		text  REFERENCES Civilizations(Type)	default null,
	CultureType				text									default null,
	Description				text									default null);

INSERT INTO Events_CulturalDevelopments 
		(Description,								CivilizationType,				CultureType)
VALUES	('TXT_KEY_EVENT_CULDEV_JFD_MUSCOVY_01',		'CIVILIZATION_JFD_MUSCOVY',		'JFD_Eastern');
--==========================================================================================================================
--==========================================================================================================================