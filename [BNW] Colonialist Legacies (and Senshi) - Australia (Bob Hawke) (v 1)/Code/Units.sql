--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 												Class, Cost, Range, PrereqTech, Combat, RangedCombat, Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_SENSHI_SASR'),		Class, Cost, Range, PrereqTech, Combat, RangedCombat, Moves, FaithCost, RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_SENSHI_SASR'),	('TXT_KEY_UNIT_CIV5_SENSHI_SASR_TEXT'), 	('TXT_KEY_UNIT_SENSHI_SASR_HELP'), 	('TXT_KEY_UNIT_SENSHI_SASR_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_SENSHI_SASR'),  0,					('SENSHI_SASR_FLAG'),	2, 				('SENSHI_HAWKE_ATLAS')
FROM Units WHERE (Type = 'UNIT_PARATROOPER');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_SENSHI_SASR'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_PARATROOPER');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_SENSHI_SASR'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_PARATROOPER');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_SENSHI_SASR'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_PARATROOPER');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_SENSHI_SASR', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_PARATROOPER');
--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills 	
			(UnitType, 				YieldType,			Yield)
VALUES		('UNIT_SENSHI_SASR', 	'YIELD_SCIENCE',	50);
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
VALUES		('UNIT_SENSHI_SASR', 		'PROMOTION_SENSHI_SASR');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
SELECT		'UNIT_SENSHI_SASR',		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_PARATROOPER');
--==========================================================================================================================
--==========================================================================================================================
