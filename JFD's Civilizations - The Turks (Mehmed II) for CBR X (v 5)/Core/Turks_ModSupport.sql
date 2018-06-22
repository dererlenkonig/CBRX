--=======================================================================================================================
-- BINGLES CIV IV TRAITS
--=======================================================================================================================
-- Leader_SharedTraits
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT INTO Leader_SharedTraits
		(LeaderType,			TraitOne,				TraitTwo)
SELECT	'LEADER_JFD_MEHMED',	'POLICY_AGGRESSIVE_X',	'POLICY_SPIRITUAL_X'
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X');
--------------------------------------------------------------------------------------------------------------------------	
-- Leaders
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Leaders 
SET Description = 'Mehmed II [ICON_WAR][ICON_PEACE]'
WHERE Type = 'TXT_KEY_LEADER_JFD_MEHMED'
AND EXISTS (SELECT * FROM Policies WHERE Type = 'LEADER_JFD_MEHMED');
--==========================================================================================================================
-- GEDEMON R.E.D.
--==========================================================================================================================
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = '_OTTOMAN'
WHERE Type = 'CIVILIZATION_JFD_TURKS'
AND EXISTS (SELECT * FROM Civilizations WHERE ArtStyleSuffix = '_OTTOMAN');
--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Civilizations_YnAEMP
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMP(CivilizationType, MapPrefix, X, Y, CapitalName, AltX, AltY, AltCapitalName);
INSERT INTO Civilizations_YnAEMP
		(CivilizationType,			MapPrefix, 			 X,   Y,	AltX,	AltY,	AltCapitalName)
VALUES	('CIVILIZATION_JFD_TURKS',	'Cordiform', 		 45,  23,	43,		24,		null),
		('CIVILIZATION_JFD_TURKS',	'GreatestEarth', 	 59,  44,	57,		44,		null),
		('CIVILIZATION_JFD_TURKS',	'EuroLarge', 		 54,  30,	52,		32,		null),
		('CIVILIZATION_JFD_TURKS',	'Yagem', 			 56,  57,	30,		60,		null),
		('CIVILIZATION_JFD_TURKS',	'Yahem', 			 69,  53,	68,		54,		null),
		('CIVILIZATION_JFD_TURKS',	'Aegean', 		 	 37,  38,	23,		45,		null),
		('CIVILIZATION_JFD_TURKS',	'EuroGiant', 		 110, 30,	104,	34,		null),
		('CIVILIZATION_JFD_TURKS',	'Mediterranean', 	 74,  39,	70,		41,		null),
		('CIVILIZATION_JFD_TURKS',	'Mesopotamia', 	 	 15,  37,	8,		40,		null),
		('CIVILIZATION_JFD_TURKS',	'AfriAsiaAust', 	 40,  73,	38,		74,		null),
		('CIVILIZATION_JFD_TURKS',	'AfriSouthEuro', 	 51,  70,	49,		72,		null),
		('CIVILIZATION_JFD_TURKS',	'EuroLargeNew', 	 59,  21,	56,		23,		null),
		('CIVILIZATION_JFD_TURKS',	'Caucasus', 	 	 44,  34,	31,		44,		null),
		('CIVILIZATION_JFD_TURKS',	'MesopotamiaGiant',	 21,  86,	7,		93,		null),
		('CIVILIZATION_JFD_TURKS',	'AtlanticGiant',	 171, 32,	169,	36,		null),
		('CIVILIZATION_JFD_TURKS',	'EarthMk3', 		 34,  56,	31,	    58,		null),
		('CIVILIZATION_JFD_TURKS',	'MediterraneanHuge', 68,  45,	63,		46,		null);
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CordiformStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Cordiform';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_GreatestEarthStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'GreatestEarth';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroLargeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EuroLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YagemStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Yagem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YahemStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Yahem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AegeanStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AegeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AegeanStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Aegean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfricaLargeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfricaLargeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AfricaLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AmericasStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Americas';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_ApennineStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ApennineStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_ApennineStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Apennine';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Asia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CaribbeanStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaribbeanStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Caribbean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_BritishIslesStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_BritishIslesStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_BritishIslesStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'BritishIsles';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EastAsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EastAsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EastAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EuroGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MediterraneanStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MediterraneanStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Mediterranean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MesopotamiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Mesopotamia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NileValleyStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NileValleyStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NileValleyStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NileValley';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAtlanticStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthAtlantic';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthEastAsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthEastAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthEastAsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthEastAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthWestEuropeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthWestEuropeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthWestEurope';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_PacificStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_PacificStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Pacific';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthPacificStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthPacific';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AdriaticStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AdriaticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AdriaticStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Adriatic';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriAsiaAustStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriAsiaAustStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AfriAsiaAust';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AfriGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriSouthEuroStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AfriSouthEuroStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AfriSouthEuro';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AmericasGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AmericasGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSmallStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSmallStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaSmallStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AsiaSmall';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSteppeGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSteppeGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AsiaSteppeGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AsiaSteppeGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AustralasiaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AustralasiaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AustralasiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CaucasusStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaucasusStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaucasusStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Caucasus';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CentralAsiaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CentralAsiaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CentralAsiaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'CentralAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroEasternStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroEasternStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroEasternStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EuroEastern';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroLargeNewStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeNewStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EuroLargeNew';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_IndiaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndiaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'IndiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MesopotamiaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_MesopotamiaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'MesopotamiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAmericaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAmericaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthAmericaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAmericaHugeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAmericaHugeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthAmericaHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthSeaEuropeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthSeaEuropeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthSeaEuropeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthSeaEurope';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_ScotlandIrelandHugeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ScotlandIrelandHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_ScotlandIrelandHugeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'ScotlandIrelandHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAmericaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaLargeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaLargeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAmericaLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralHugeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaCentralHugeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAmericaCentralHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAmericaCentralGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAmericaCentralGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAsiaHugeStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAsiaHugeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthAsiaHugeStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAsiaHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthPacificGiantStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_SouthPacificGiantStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthPacificGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_WestAfricaStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_WestAfricaStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_WestAfricaStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'WestAfrica';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_IndianOceanStartPosition
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_IndianOceanStartPosition (Type, X,	Y) SELECT 'CIVILIZATION_JFD_TURKS',	X, Y 
FROM Civilizations_YnAEMP WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'IndianOcean';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations_YnAEMPRequestedResources
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YnAEMPRequestedResources(CivilizationType, MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6);
INSERT INTO Civilizations_YnAEMPRequestedResources
		(CivilizationType,			MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6)
SELECT	'CIVILIZATION_JFD_TURKS',	MapPrefix, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4, Req5, Yield5, Req6, Yield6
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CordiformRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Cordiform';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_GreatestEarthRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'GreatestEarth';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroLargeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EuroLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YagemRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Yagem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_YahemRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Yahem';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AegeanRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AegeanRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AegeanRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Aegean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfricaLargeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfricaLargeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfricaLargeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AfricaLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AmericasRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Americas';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_ApennineRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ApennineRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_ApennineRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Apennine';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AsiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Asia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CaribbeanRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CaribbeanRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Caribbean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_BritishIslesRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_BritishIslesRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_BritishIslesRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'BritishIsles';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EastAsiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EastAsiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EastAsiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EastAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EuroGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MediterraneanRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MediterraneanRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MediterraneanRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Mediterranean';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MesopotamiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MesopotamiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Mesopotamia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NileValleyRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NileValleyRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NileValleyRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NileValley';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAtlanticRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAtlanticRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthAtlantic';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthEastAsiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthEastAsiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthEastAsiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthEastAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthWestEuropeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthWestEuropeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthWestEuropeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthWestEurope';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_PacificRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_PacificRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_PacificRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Pacific';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthPacificRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthPacificRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthPacific';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AdriaticRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AdriaticRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AdriaticRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Adriatic';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriAsiaAustRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriAsiaAustRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriAsiaAustRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AfriAsiaAust';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AfriGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AfriSouthEuroRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AfriSouthEuroRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AfriSouthEuroRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AfriSouthEuro';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AmericasGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AmericasGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSmallRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSmallRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AsiaSmallRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AsiaSmall';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AsiaSteppeGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AsiaSteppeGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AsiaSteppeGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AsiaSteppeGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_AustralasiaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AustralasiaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AustralasiaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'AustralasiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CaucasusRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CaucasusRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CaucasusRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'Caucasus';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_CentralAsiaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CentralAsiaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CentralAsiaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'CentralAsia';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroEasternRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroEasternRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroEasternRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EuroEastern';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_EuroLargeNewRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeNewRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeNewRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'EuroLargeNew';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_IndiaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndiaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_IndiaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'IndiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_MesopotamiaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_MesopotamiaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_MesopotamiaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'MesopotamiaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAmericaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAmericaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthAmericaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthAmericaHugeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAmericaHugeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAmericaHugeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthAmericaHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_NorthSeaEuropeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthSeaEuropeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthSeaEuropeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'NorthSeaEurope';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_ScotlandIrelandHugeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_ScotlandIrelandHugeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_ScotlandIrelandHugeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'ScotlandIrelandHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAmericaGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAmericaGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaLargeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaLargeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAmericaLargeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAmericaLarge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralHugeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralHugeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAmericaCentralHugeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAmericaCentralHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAmericaCentralGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAmericaCentralGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAmericaCentralGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAmericaCentralGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthAsiaHugeRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthAsiaHugeRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthAsiaHugeRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthAsiaHuge';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_SouthPacificGiantRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_SouthPacificGiantRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_SouthPacificGiantRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'SouthPacificGiant';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_WestAfricaRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_WestAfricaRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_WestAfricaRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'WestAfrica';
--------------------------------------------------------------------------------------------------------------------------
-- Civilizations_IndianOceanRequestedResource
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_IndianOceanRequestedResource(Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_IndianOceanRequestedResource (Type, Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4) SELECT 'CIVILIZATION_JFD_TURKS',	Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YnAEMPRequestedResources WHERE CivilizationType = 'CIVILIZATION_JFD_TURKS' AND MapPrefix = 'IndianOcean';
--==========================================================================================================================
-- HAZEL MAP LABELS
--==========================================================================================================================
-- ML_CivCultures
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
		(CivType,					CultureType, CultureEra)
SELECT	'CIVILIZATION_JFD_TURKS',	CultureType, CultureEra
FROM ML_CivCultures WHERE CivType = 'CIVILIZATION_OTTOMAN';
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
VALUES	('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_DECOLONIZATION',			4),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_MERCENARY',					6),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',		5),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_GOVERNMENT',			6),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_LEGAL',				7),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_CULTURE',			4),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_ECONOMIC',			5),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_FOREIGN',			7),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_INDUSTRY',			5),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_MILITARY',			7),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_REFORM_RELIGION',			6),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_SLAVERY',					8),
		('LEADER_JFD_MEHMED_II',	'FLAVOR_JFD_STATE_RELIGION',			8);
--==========================================================	
-- INVENTIONS 
--==========================================================	
-- Civilization_JFD_Inventions
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Inventions (
	CivilizationType  				text 	REFERENCES Civilizations(Type) 						default null,
	InventionType  					text 		 												default null,
	InventionPreference				text 		 												default null);
	
INSERT INTO Civilization_JFD_Inventions
		(CivilizationType,			InventionType, InventionPreference)
SELECT	'CIVILIZATION_JFD_TURKS',	InventionType, InventionPreference
FROM Civilization_JFD_Inventions WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--==========================================================================================================================
-- JFD CITIES IN DEVELOPMENT
--==========================================================================================================================
--====================================	
-- JFD COLONIES
--====================================	
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_ColonialCityNames
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 				text 	REFERENCES Civilizations(Type) 						default null,
	ColonyName 						text														default null,
	LinguisticType					text														default	null);

INSERT INTO Civilization_JFD_ColonialCityNames
		(CivilizationType,			LinguisticType, ColonyName)
SELECT	'CIVILIZATION_JFD_TURKS',	LinguisticType, ColonyName
FROM Civilization_JFD_ColonialCityNames WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--====================================	
-- JFD DEVELOPMENT
--====================================	
--====================================
-- JFD PROVINCES 
--====================================
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_ProvinceTitles
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_ProvinceTitles (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	ReligionType  					text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle					text 		 												default null,
	UniqueTitle						text 		 												default null,
	UseAdjective					boolean														default 0);	

INSERT INTO Civilization_JFD_ProvinceTitles
		(CivilizationType,			DefaultTitle,	UniqueTitle)
SELECT	'CIVILIZATION_JFD_TURKS',	DefaultTitle,	UniqueTitle
FROM Civilization_JFD_ProvinceTitles WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';	
--==========================================================================================================================
-- JFD CULTURAL DIVERSITY
--==========================================================================================================================
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_CultureTypes
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType 					text														default null,
	SubCultureType 					text														default null,
	ArtDefineTag					text														default	null,
	DecisionsTag					text														default	null,
	DefeatScreenEarlyTag			text														default	null,
	DefeatScreenMidTag				text														default	null,
	DefeatScreenLateTag				text														default	null,
	IdealsTag						text														default	null,
	SplashScreenTag					text														default	null,
	SoundtrackTag					text														default	null,
	UnitDialogueTag					text														default null);

INSERT INTO Civilization_JFD_CultureTypes
		(CivilizationType,			ArtDefineTag, CultureType, SubCultureType, DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag)
SELECT	'CIVILIZATION_JFD_TURKS',	ArtDefineTag, CultureType, SubCultureType, DecisionsTag, DefeatScreenEarlyTag, DefeatScreenMidTag, DefeatScreenLateTag, IdealsTag, SplashScreenTag, SoundtrackTag, UnitDialogueTag
FROM Civilization_JFD_CultureTypes WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--------------------------------------------------------------------------------------------------------------------------	
-- Civilizations
--------------------------------------------------------------------------------------------------------------------------	
UPDATE Civilizations 
SET SoundtrackTag = 'JFD_IslamicTurkic'
WHERE Type = 'CIVILIZATION_JFD_TURKS'
AND EXISTS (SELECT * FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_IslamicTurkic')
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_SOUNDTRACK_ADDON' AND Value = 1);
--==========================================================================================================================
-- JFD RISE TO POWER
--==========================================================================================================================
--====================================	
-- JFD SOVEREIGNTY
--====================================	
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_Governments
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Governments (
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	LegislatureName					text														default	null,
	OfficeTitle						text														default	null,
	GovernmentType					text														default	null,
	Weight							integer														default	0);

INSERT INTO Civilization_JFD_Governments
		(CivilizationType,			LegislatureName, OfficeTitle, GovernmentType, Weight)
SELECT	'CIVILIZATION_JFD_TURKS',	LegislatureName, OfficeTitle, GovernmentType, Weight
FROM Civilization_JFD_Governments WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
------------------------------------------------------------	
-- Civilization_JFD_HeadsOfGovernment	
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 	
	Civilization_JFD_HeadsOfGovernment (	
	CivilizationType  				text 		REFERENCES Civilizations(Type) 					default null,
	CultureType						text 		 												default null,
	HeadOfGovernmentName			text 		 												default null);

INSERT INTO Civilization_JFD_HeadsOfGovernment
        (CivilizationType,      	HeadOfGovernmentName)
VALUES  ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_1'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_2'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_3'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_4'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_5'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_6'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_7'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_8'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_9'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_10'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_11'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_12'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_13'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_14'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_15'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_16'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_17'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_18'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_19'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_20'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_21'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_22'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_23'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_24'),
        ('CIVILIZATION_JFD_TURKS',	'TXT_KEY_JFD_HEAD_OF_GOVERNMENT_TITLE_JFD_TURKS_25');
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_Titles
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Titles (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 					default null,
	CultureType				text 		 												default null,
	ReligionType			text 		REFERENCES Religions(Type) 						default null,
	DefaultTitle			text 		 												default null,
	UniqueTitle				text 		 												default null,
	UseAdjective			boolean														default 0);	

INSERT INTO Civilization_JFD_Titles
		(CivilizationType,			DefaultTitle,	UniqueTitle)
SELECT	'CIVILIZATION_JFD_TURKS',	DefaultTitle,	UniqueTitle
FROM Civilization_JFD_Titles WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';

DELETE FROM Civilization_JFD_Titles WHERE DefaultTitle = 'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER' AND CivilizationType = 'CIVILIZATION_JFD_TURKS';
INSERT INTO Civilization_JFD_Titles
		(CivilizationType,			DefaultTitle,									UniqueTitle)
VALUES	('CIVILIZATION_JFD_TURKS',	'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER',	'TXT_KEY_GOVERNMENT_JFD_EMPIRE_TITLE_LEADER_JFD_TURKS');	
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_JFD_Politics
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Civilization_JFD_Politics (
	CivilizationType  		text 		REFERENCES Civilizations(Type) 			default null,
	PoliticsType  			text 												default null,
	UniqueName				text												default	null);

INSERT INTO Civilization_JFD_Politics
		(CivilizationType,			PoliticsType, UniqueName)
SELECT	'CIVILIZATION_JFD_TURKS',	PoliticsType, UniqueName
FROM Civilization_JFD_Politics WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--------------------------------------------------------------------------------------------------------------------------
-- JFD_PrivyCouncillor_UniqueNames
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	JFD_PrivyCouncillor_UniqueNames (
	PrivyCouncillorType  	text 												default null,
	PolicyType  			text 												default null,
	CivilizationType		text												default	null,
	CultureType				text												default	null,
	GovernmentType  		text 												default null,
	ReligionType			text												default	null,
	UniqueName				text												default	null);

INSERT INTO JFD_PrivyCouncillor_UniqueNames
		(CivilizationType,			PrivyCouncillorType, UniqueName)
SELECT	'CIVILIZATION_JFD_TURKS',	PrivyCouncillorType, UniqueName
FROM JFD_PrivyCouncillor_UniqueNames WHERE CivilizationType = 'CIVILIZATION_OTTOMAN';
--------------------------------------------------------------------------------------------------------------------------
-- Leader_JFD_Reforms
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
	Leader_JFD_Reforms (
	LeaderType  			text 		REFERENCES Leaders(Type) 				default	null,
	ReformType				text												default	null);
	
INSERT INTO Leader_JFD_Reforms
		(LeaderType,				ReformType)
VALUES	('LEADER_JFD_MEHMED_II',	'REFORM_JFD_LEGITIMACY_MIGHT');
--==========================================================================================================================
-- SUKRITACT DECISIONS
--==========================================================================================================================
-- DecisionsAddin_Support
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('JFD_Turks_Decisions.lua');
--------------------------------------------------------------------------------------------------------------------------	
-- BuildingClasses
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO BuildingClasses 	
		(Type, 						 					DefaultBuilding, 								Description, 									MaxPlayerInstances)
VALUES	('BUILDINGCLASS_DECISIONS_JFD_ENDERUN_ACADEMY', 'BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY',		'TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY',		1);
--------------------------------------------------------------------------------------------------------------------------
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings			
		(Type, 											BuildingClass, 			  						GreatGeneralRateModifier,	Cost, 	FaithCost,	Help,											Description, 								Civilopedia,									IconAtlas,		PortraitIndex,	NukeImmune, ConquestProb)
VALUES	('BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY',		'BUILDINGCLASS_DECISIONS_JFD_ENDERUN_ACADEMY',  20,							-1, 	-1,			'TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY_HELP',	'TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY', 	'TXT_KEY_DECISIONS_JFD_ENDERUN_ACADEMY_PEDIA',	'TECH_ATLAS_1',	28,				1,			100);
--------------------------------------------------------------------------------------------------------------------------
-- Building_UnitCombatFreeExperiences
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_UnitCombatFreeExperiences
		(BuildingType,									UnitCombatType,			Experience)
VALUES	('BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY',		'UNITCOMBAT_GUN',		10),
		('BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY',		'UNITCOMBAT_MOUNTED',	10);
--------------------------------------------------------------------------------------------------------------------------
-- BuildingClass_JFD_District
--------------------------------------------------------------------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS 
	Building_JFD_District (
	BuildingType  		text 		REFERENCES Buildings(Type)					default null,
	DistrictType		text										 			default null);	
	
INSERT INTO Building_JFD_District
		(BuildingType,								DistrictType)
VALUES	('BUILDING_DECISIONS_JFD_ENDERUN_ACADEMY',	'DISTRICT_JFD_MILITARY');
--==========================================================================================================================
-- SUKRITACT EVENTS
--==========================================================================================================================
-- EventsAddin_Support
--------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('JFD_Turks_Events.lua');
--==========================================================================================================================
--==========================================================================================================================