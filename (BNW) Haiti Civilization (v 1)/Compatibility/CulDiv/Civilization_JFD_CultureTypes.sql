--==========================================================================================================================
-- Civilization_LEUGI_CultureTypes
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS Civilization_JFD_CultureTypes(CivilizationType, CultureType, SplashScreenTag, SoundtrackTag);

INSERT OR REPLACE INTO Civilization_JFD_CultureTypes
			(CivilizationType,				CultureType,	SplashScreenTag,		SoundtrackTag)
VALUES		('CIVILIZATION_LEUGI_HAITI',	'JFD_Colonial',	'JFD_ColonialLatin',	'JFD_Bantu');
--==========================================================================================================================
--==========================================================================================================================

UPDATE Civilizations
  SET SoundtrackTag = 'JFD_Bantu'
	WHERE Type IN (SELECT CivilizationType FROM Civilization_JFD_CultureTypes WHERE SoundtrackTag = 'JFD_Bantu')
  AND EXISTS (SELECT 1 FROM Audio_Sounds WHERE SoundID = 'SND_JFD_ANDEAN_PEACE_01');


--==========================================================================================================================
--==========================================================================================================================
--==========================================================================================================================