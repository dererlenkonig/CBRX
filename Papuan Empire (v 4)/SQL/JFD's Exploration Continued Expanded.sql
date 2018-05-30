--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================


--PROMOTION_JFD_SNOW_IMMUNITY, PROMOTION_JFD_DESERT_IMMUNITY, PROMOTION_JFD_DISEASE_IMMUNITY, PROMOTION_JFD_JUNGLE_IMMUNITY, PROMOTION_JFD_SCUVRY_IMMUNITY

CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_PAPUA',		'CIVILIZATION_INDONESIA');




UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_MASYARAKATADAT_DESC'
WHERE Type = 'TRAIT_MASYARAKATADAT'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_EXCE_ATTRITION_CORE_JUNGLE' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_ATTRITION_TRAIT_CHANGES' AND Value = 1);


INSERT INTO Trait_FreePromotionUnitCombats
		(TraitType,				PromotionType,						UnitCombatType)
SELECT	('TRAIT_MASYARAKATADAT'),	('PROMOTION_JFD_JUNGLE_IMMUNITY'),	Type
FROM UnitCombatInfos WHERE Type NOT IN ('UNITCOMBAT_AIR', 'UNITCOMBAT_FIGHTER', 'UNITCOMBAT_BOMBER', 'UNITCOMBAT_HELICOPTER') 
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_EXCE_ATTRITION_CORE_JUNGLE' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_ATTRITION_TRAIT_CHANGES' AND Value = 1);



INSERT INTO Unit_FreePromotions
		(UnitType, 				PromotionType)
SELECT	('UNIT_PAPUAN_MOTU_WARRIOR'),	('PROMOTION_JFD_JUNGLE_IMMUNITY')
WHERE EXISTS (SELECT Type FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_JUNGLE_IMMUNITY');
