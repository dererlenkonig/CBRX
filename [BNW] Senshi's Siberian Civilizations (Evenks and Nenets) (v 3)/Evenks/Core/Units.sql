--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 												Class, Cost, Range, PrereqTech, Combat, RangedCombat, Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_SENSHI_REINDEER_ARCHER'),		Class, Cost, Range, PrereqTech, Combat, RangedCombat, Moves, FaithCost, RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_SENSHI_REINDEER_ARCHER'),	('TXT_KEY_CIV5_UNIT_SENSHI_REINDEER_ARCHER_TEXT'), 	('TXT_KEY_UNIT_SENSHI_REINDEER_ARCHER_HELP'), 	('TXT_KEY_UNIT_SENSHI_REINDEER_ARCHER_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_U_SENSHI_DEER'),  0,					('SENSHI_REINDEER_FLAG'),	2, 				('SENSHI_EVENKS_ATLAS')
FROM Units WHERE (Type = 'UNIT_CHARIOT_ARCHER');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_SENSHI_REINDEER_ARCHER'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_CHARIOT_ARCHER');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_SENSHI_REINDEER_ARCHER'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_CHARIOT_ARCHER');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_SENSHI_REINDEER_ARCHER'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_CHARIOT_ARCHER');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_SENSHI_REINDEER_ARCHER', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_CHARIOT_ARCHER');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
VALUES		('UNIT_SENSHI_REINDEER_ARCHER', 		'PROMOTION_NO_DEFENSIVE_BONUSES'),
			('UNIT_SENSHI_REINDEER_ARCHER', 		'PROMOTION_ONLY_DEFENSIVE'),
			('UNIT_SENSHI_REINDEER_ARCHER', 		'PROMOTION_WOODSMAN'),
			('UNIT_SENSHI_REINDEER_ARCHER', 		'PROMOTION_SENSHI_OPEN_PENALTY');
--==========================================================================================================================
--==========================================================================================================================
