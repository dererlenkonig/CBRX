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
VALUES	('JFD_Minoa_DTP.lua');
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
		(CivilizationType,				YieldType,				YieldSourcefunction,								YieldSourceToolTip)
VALUES	('CIVILIZATION_MC_MINOA',		'YIELD_GOLDEN_AGE',		'JFD_Minoa_GetGoldenAgePointsFromCoastalCities',	'TXT_KEY_MC_MINOA_GOLDEN_AGE_POINTS_FROM_COASTAL_CITIES');	
--==========================================================================================================================
--==========================================================================================================================