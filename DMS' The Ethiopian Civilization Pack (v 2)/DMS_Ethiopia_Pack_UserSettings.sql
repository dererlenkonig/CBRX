--==========================================================================================================================
-- USER SETTINGS
--==========================================================================================================================
-- DMS_GlobalUserSettings
------------------------------------------------------------
CREATE TABLE IF NOT EXISTS 
DMS_GlobalUserSettings (
	Type 											text 										default null,
	Value 											integer 									default 1);
--==========================================================================================================================	
-- TROUBLESHOOTING
--==========================================================================================================================	
-- Debugging
--------------------------------------------------------------------------
/*
Enable to allow for print statements to be activated throughout the code for the specific civilizations. 
  1 = Enabled
  0 = Disabled  (Default)
*/

INSERT INTO DMS_GlobalUserSettings
		(Type,											Value)
VALUES	('DMS_AKSUM_DEBUGGING_ON',						0),
		('DMS_SEMIEN_DEBUGGING_ON',						0),
		('DMS_ETHIOPIA_AMDA_SEYON_I_DEBUGGING_ON',		0),
		('DMS_ETHIOPIA_ZARA_YAQOB_DEBUGGING_ON',		0),
		('DMS_ETHIOPIA_MENELIK_II_DEBUGGING_ON',		0),
		('DMS_ETHIOPIA_HAILE_SELASSIE_DEBUGGING_ON',	0),
		('DMS_ETHIOPIA_EVENTS_DEBUGGING_ON',			0),
		('DMS_ETHIOPIA_DECISIONS_DEBUGGING_ON',			0);
--==========================================================================================================================	
--==========================================================================================================================	