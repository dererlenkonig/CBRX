-- Civilizations_YagemStartPosition (Earth Giant)
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD',		   145,	   58,	    null,	null);	

CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_POVERTY_POINT_MOD'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

-- Civilizations_YahemStartPosition (Earth Huge)
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD',		   24,	   51,		null,	null);

CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_POVERTY_POINT_MOD'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

-- Civilizations_CordiformStartPosition (Earth Standard)
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD',		    9,	   32,	    null,	null);	

CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_POVERTY_POINT_MOD'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_CordiformRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD',		   13,	   41,		null,	null);

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_POVERTY_POINT_MOD'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

-- Civilizations_AmericasStartPosition (Americas)
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(TYPE,										X,      Y,		AltX,	AltY)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD',		   40,	   50,		null,	null);

CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_POVERTY_POINT_MOD'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE Type = 'CIVILIZATION_IROQUOIS';

-- Civilizations_AmericasStartPosition (Americas)
CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CaribbeanStartPosition
			(TYPE,										X,      Y,		AltX,	AltY)
VALUES		('CIVILIZATION_POVERTY_POINT_MOD',		   23,	   68,		null,	null);

--CREATE TABLE IF NOT EXISTS Civilizations_CaribbeanStartPosition(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
--INSERT INTO Civilizations_CaribbeanStartPosition
--			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
--SELECT		('CIVILIZATION_POVERTY_POINT_MOD'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
--FROM Civilizations_CaribbeanStartPosition WHERE Type = 'CIVILIZATION_IROQUOIS';

