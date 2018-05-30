--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================


--PROMOTION_JFD_SNOW_IMMUNITY, PROMOTION_JFD_DESERT_IMMUNITY, PROMOTION_JFD_DISEASE_IMMUNITY, PROMOTION_JFD_JUNGLE_IMMUNITY, PROMOTION_JFD_SCUVRY_IMMUNITY

UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_HYPERBOREAN_DESC'
WHERE Type = 'TRAIT_HYPERBOREAN'
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_ATTRITION_SNOW' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_ATTRITION_TRAIT_CHANGES' AND Value = 1);

INSERT INTO Trait_FreePromotionUnitCombats
		(TraitType,				PromotionType,						UnitCombatType)
SELECT	('TRAIT_HYPERBOREAN'),	('PROMOTION_JFD_SNOW_IMMUNITY'),	Type
FROM UnitCombatInfos WHERE Type NOT IN ('UNITCOMBAT_AIR', 'UNITCOMBAT_FIGHTER', 'UNITCOMBAT_BOMBER', 'UNITCOMBAT_HELICOPTER') 
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_ATTRITION_SNOW' AND Value = 1)
AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_ATTRITION_TRAIT_CHANGES' AND Value = 1);