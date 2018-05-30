--==========================================================================================================================
-- GEDEMON YNAEMP
--==========================================================================================================================
-- Earth Giant
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_MC_LITE_MOOR',		8,		55);

CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
		(Type, 								Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_PORTUGAL');
------------------------------------------------------------	
-- Earth Huge
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_MC_LITE_MOOR',		54,		53);

CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
		(Type, 								Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_PORTUGAL');
------------------------------------------------------------	
-- Earth Greatest
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_MC_LITE_MOOR',		37,		35);

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
		(Type, 								Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_PORTUGAL');
------------------------------------------------------------	
-- Earth Cordiform
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_MC_LITE_MOOR',		30,		23);

CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource
		(Type, 								Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_CordiformRequestedResource WHERE (Type = 'CIVILIZATION_PORTUGAL');
------------------------------------------------------------	
-- Europe Giant
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroGiantStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_MC_LITE_MOOR',		10,		27);

CREATE TABLE IF NOT EXISTS Civilizations_EuroGiantRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroGiantRequestedResource
		(Type, 								Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroGiantRequestedResource WHERE (Type = 'CIVILIZATION_PORTUGAL');
------------------------------------------------------------	
-- Europe Large
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_EuroLargeStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_MC_LITE_MOOR',		18,		26);

CREATE TABLE IF NOT EXISTS Civilizations_EuroLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_EuroLargeRequestedResource
		(Type, 								Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_EuroLargeRequestedResource WHERE (Type = 'CIVILIZATION_PORTUGAL');
------------------------------------------------------------	
-- Mediterranean Standard
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmcWestMedStandardStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmcWestMedStandardStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_MC_LITE_MOOR',		11,		14);

CREATE TABLE IF NOT EXISTS Civilizations_AmcWestMedStandardRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmcWestMedStandardRequestedResource
		(Type, 								Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_AmcWestMedStandardRequestedResource WHERE (Type = 'CIVILIZATION_PORTUGAL');
------------------------------------------------------------	
-- Mediterranean Large
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmcMedLargeStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmcMedLargeStartPosition
		(Type,								X,		Y)
VALUES	('CIVILIZATION_MC_LITE_MOOR',		11,		18);

CREATE TABLE IF NOT EXISTS Civilizations_AmcMedLargeRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmcMedLargeRequestedResource
		(Type, 								Req1, Yield1, Req2,	Yield2, Req3, Yield3, Req4, Yield4)
SELECT	('CIVILIZATION_MC_LITE_MOOR'),		Req1, Yield1, Req2,	Yield2,	Req3, Yield3, Req4, Yield4
FROM Civilizations_AmcWestMedStandardRequestedResource WHERE (Type = 'CIVILIZATION_PORTUGAL');
--==========================================================================================================================
--==========================================================================================================================