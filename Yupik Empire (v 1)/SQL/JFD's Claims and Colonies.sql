-- Civilization_JFD_ColonialCityNames
------------------------------------------------------------    
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    ColonyName                                  text                                        default null,
    LinguisticType                              text                                        default null,
    CultureType                                 text                                        default null);
/*
JFD_Germanic, JFD_Latinate, JFD_Tai_Khmer, JFD_Austronesian, JFD_Arabic, JFD_Slavic, JFD_Mesopotamian, JFD_Mesoamerican, JFD_Oriental,
JFD_Finno_Ugric, JFD_Semitic, JFD_Hellenic, JFD_Bantu, JFD_Songhay, JFD_Indo_Iranian, JFD_Altaic, JFD_Celtic, JFD_NorthAmerican, JFD_Quechumaran
*/
INSERT INTO Civilization_JFD_ColonialCityNames
        (CivilizationType,                      ColonyName,                             LinguisticType)
VALUES      ('CIVILIZATION_YUPIK',             null,                                   'JFD_Finno_Ugric'),
			('CIVILIZATION_YUPIK',             null,                                   'JFD_Finno_Ugric'),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_01',	null),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_02',	null),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_03',	null),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_04',	null),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_05',	null),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_06',	null),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_07',	null),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_08',	null),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_09',	null),
			('CIVILIZATION_YUPIK',		'TXT_KEY_COLONY_NAME_YUPIK_10',	null);




