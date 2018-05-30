----
CREATE TABLE IF NOT EXISTS 
MinorCivilization_JFD_CultureTypes(
	MinorCivilizationType 						text 	REFERENCES MinorCivilizations(Type) 	default null,
	CultureType 								text											default null);

CREATE TABLE IF NOT EXISTS 
JFD_CultureTypes(
	ID  									integer 							   primary key autoincrement,
	Type 									text												default null,
	ShortDescription						text												default null,
	DefaultArtDefineTag						text												default null,
	DefaultSoundtrackTag					text												default null,
	DefaultSplashScreenTag					text												default null,
	DefaultUnitDialogueTag					text												default null,
	StartDistance							integer												default	0,
	FontIcon								text												default	null,
	IconAtlas								text		REFERENCES IconTextureAtlases(Atlas)	default	null,
	IconAlphaAtlas							text		REFERENCES IconTextureAtlases(Atlas)	default	null,
	PortraitIndex							integer												default	0,
	AlphaIndex								integer												default	0,
	EmbarkationArtDefineEarly				text												default	null,
	EmbarkationArtDefineMid					text												default	null);

----
UPDATE MinorCivilizations
SET Description = 'TXT_KEY_CITYSTATE_MOD_GGANTIJA',
	ShortDescription = 'TXT_KEY_CITYSTATE_MOD_GGANTIJA',
	Adjective = 'TXT_KEY_CITYSTATE_MOD_GGANTIJA_ADJ',
	Civilopedia = 'TXT_KEY_CITYSTATE_MOD_GGANTIJA_PEDIA',
	ArtStyleType = 'ARTSTYLE_MIDDLE_EAST',
	ArtStyleSuffix = '_AFRI',
	ArtStylePrefix = 'AFRICAN'
WHERE Type = 'MINOR_CIV_OUGADOUGOU' AND EXISTS (SELECT Type FROM MinorCivilizations WHERE Type = 'MINOR_CIV_OUGADOUGOU');

DELETE FROM MinorCivilization_CityNames WHERE MinorCivType IN ('MINOR_CIV_OUGADOUGOU');
INSERT INTO MinorCivilization_CityNames
			(MinorCivType,						                             CityName)
SELECT		('MINOR_CIV_OUGADOUGOU'),		        ('TXT_KEY_CITYSTATE_MOD_GGANTIJA')
WHERE EXISTS (SELECT Type FROM MinorCivilizations WHERE Type = 'MINOR_CIV_OUGADOUGOU');

DELETE FROM MinorCivilization_JFD_CultureTypes WHERE MinorCivilizationType IN ('MINOR_CIV_OUGADOUGOU');
INSERT INTO MinorCivilization_JFD_CultureTypes
			(MinorCivilizationType,						                  CultureType)
SELECT		('MINOR_CIV_OUGADOUGOU'),		                       ('JFD_Mesopotamic')
WHERE EXISTS (SELECT Type FROM MinorCivilizations WHERE Type = 'MINOR_CIV_OUGADOUGOU');

-- Civilizations_YagemStartPosition (Earth Giant)
CREATE TABLE IF NOT EXISTS MinorCiv_YagemStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_YagemStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

INSERT INTO MinorCiv_YagemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_OUGADOUGOU',				   21,	   51,		  20,	 53);

-- Civilizations_YahemStartPosition (Earth Huge)
CREATE TABLE IF NOT EXISTS MinorCiv_YahemStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_YahemStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');	
	
INSERT INTO MinorCiv_YahemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_OUGADOUGOU',				   61,	   49,		  60,	  51);

-- Civilizations_CordiformStartPosition (Earth Standard)
CREATE TABLE IF NOT EXISTS MinorCiv_CordiformStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_CordiformStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');	
	
INSERT INTO MinorCiv_CordiformStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_OUGADOUGOU',				   36,	   21,		null,	null);

-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
CREATE TABLE IF NOT EXISTS MinorCiv_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_GreatestEarthStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');	
	
INSERT INTO MinorCiv_GreatestEarthStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_OUGADOUGOU',				   50,	   36,		  49,	  38);

-- Civilizations_EuroLargeStartPosition (Europe Large)
CREATE TABLE IF NOT EXISTS MinorCiv_EuroLargeStartPosition(Type, X, Y, AltX, AltY);		
DELETE FROM MinorCiv_EuroLargeStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');	

INSERT INTO MinorCiv_EuroLargeStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_OUGADOUGOU',				   37,	   21,		  38,	  24);

-- Civilizations_EuroLargeStartPosition (Europe Giant)
CREATE TABLE IF NOT EXISTS MinorCiv_EuroGiantStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_EuroGiantStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');	

INSERT INTO MinorCiv_EuroGiantStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_OUGADOUGOU',				   67,	   13,		  68,	  17);

-- Civilizations_MesopotamiaStartPosition (Mesopotamia)
CREATE TABLE IF NOT EXISTS MinorCiv_MesopotamiaStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_MesopotamiaStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_NorthWestEuropeStartPosition (NW Europe)
CREATE TABLE IF NOT EXISTS MinorCiv_NorthWestEuropeStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_NorthWestEuropeStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_MediterraneanStartPosition (Mediterranaean)
CREATE TABLE IF NOT EXISTS MinorCiv_MediterraneanStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_MediterraneanStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

INSERT INTO MinorCiv_MediterraneanStartPosition
			(Type,									    X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_OUGADOUGOU',				   46,	   27,		null,	null);	

-- Civilizations_BritishIslesStartPosition (British Isles)
CREATE TABLE IF NOT EXISTS MinorCiv_BritishIslesStartPosition(Type, X, Y, AltX, AltY);
DELETE FROM MinorCiv_BritishIslesStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_AmericaStandardStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AmericaStandardStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AmericaStandardStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_NorthEastAsiaStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_NorthEastAsiaStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_NorthEastAsiaStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_PacificStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_PacificStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_PacificStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_EastAsiaStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_EastAsiaStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_EastAsiaStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_SouthPacificStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_SouthPacificStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_SouthPacificStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_AegeanStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AegeanStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AegeanStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_AfricaLargeStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AfricaLargeStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AfricaLargeStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_AmericasStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AmericasStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AmericasStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_ApennineStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_ApennineStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_ApennineStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

INSERT INTO MinorCiv_ApennineStartPosition
			(Type,									    X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_OUGADOUGOU',				   35,	    2,		  34,	  3);	

-- Civilizations_AsiaStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_AsiaStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_AsiaStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_CaribbeanStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_CaribbeanStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_CaribbeanStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_NileValleyStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_NileValleyStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_NileValleyStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

-- Civilizations_NorthAtlanticStartPosition
CREATE TABLE IF NOT EXISTS MinorCiv_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);	
DELETE FROM MinorCiv_NorthAtlanticStartPosition WHERE Type IN ('MINOR_CIV_OUGADOUGOU');

INSERT INTO MinorCiv_NorthAtlanticStartPosition
			(Type,									    X,		Y,		AltX,	AltY)
VALUES		('MINOR_CIV_OUGADOUGOU',				   103,	   13,		 103,	  15);
