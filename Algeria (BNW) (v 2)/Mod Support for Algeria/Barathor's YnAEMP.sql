--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_DJSH_ALGERIA',					54,		62,		null,	null);		
--==========================================================================================================================
-- Civilizations_YahemStartPosition (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_DJSH_ALGERIA',					83,		55,		null,	null);
--==========================================================================================================================
-- Civilizations_CordiformStartPosition (Earth Standard)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_DJSH_ALGERIA',					56,		33,		null,	null);
--==========================================================================================================================
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_DJSH_ALGERIA',					75,		48,		null,	null);
--==========================================================================================================================
-- Civilizations_YagemRequestedResource (Earth Giant)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_DJSH_ALGERIA'),					Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_MOROCCO';
--==========================================================================================================================
-- Civilizations_YahemRequestedResource (Earth Huge)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_DJSH_ALGERIA'),					Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE Type = 'CIVILIZATION_MOROCCO';
--==========================================================================================================================
-- Civilizations_CordiformRequestedResource (Earth Standard)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_CordiformRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_CordiformRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_DJSH_ALGERIA'),					Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_CordiformRequestedResource WHERE Type = 'CIVILIZATION_MOROCCO';
--==========================================================================================================================
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_DJSH_ALGERIA'),					Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE Type = 'CIVILIZATION_MOROCCO';
--==========================================================================================================================
--==========================================================================================================================
