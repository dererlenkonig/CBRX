--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 												Class, Cost, Range, PrereqTech, Combat, RangedCombat,	Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_SENSHI_CHONGTONG'),				Class, Cost, Range, PrereqTech, 12,		24,				Moves, FaithCost,	RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction,	Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_SENSHI_CHONGTONG'),	('TXT_KEY_CIV5_UNIT_SENSHI_CHONGTONG_TEXT'), 	('TXT_KEY_UNIT_SENSHI_CHONGTONG_HELP'), 	('TXT_KEY_UNIT_SENSHI_CHONGTONG_STRATEGY'),	AdvancedStartCost, 	('ART_DEF_UNIT_SENSHI_CHONGTONG'),  0,					('UNIT_ATLAS_SENSHI_CHONGTONG_ALPHA'),	2, 				('SENSHI_KOREA_ATLAS')
FROM Units WHERE (Type = 'UNIT_CANNON');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_SENSHI_CHONGTONG'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_CANNON');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_SENSHI_CHONGTONG'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_CANNON');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_SENSHI_CHONGTONG'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_CANNON');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_SENSHI_CHONGTONG', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_CANNON');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
VALUES		('UNIT_SENSHI_CHONGTONG', 		'PROMOTION_SENSHI_CHONGTONG');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
SELECT		'UNIT_SENSHI_CHONGTONG',		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_CANNON');
--==========================================================================================================================
--==========================================================================================================================
