--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units
(Type, 									Class, Cost, Range, PrereqTech, Combat, Moves, FaithCost, RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, Description, 						Civilopedia, 							Help, 									Strategy,									AdvancedStartCost,	UnitArtInfo, 					  UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		('UNIT_CL_MARBULL'),		Class, 18, Range, PrereqTech,		3, Moves, FaithCost, RequiresFaithPurchaseEnabled, CombatClass, MilitarySupport, MilitaryProduction, Domain, Pillage, IgnoreBuildingDefense, ObsoleteTech, GoodyHutUpgradeUnitClass, XPValueAttack, XPValueDefense, Conscription,  DefaultUnitAI, ('TXT_KEY_UNIT_CL_MARBULL'),	('TXT_KEY_UNIT_CIV5_CL_MARBULL_TEXT'), 	('TXT_KEY_UNIT_CL_MARBULL_HELP'), 	('TXT_KEY_UNIT_CL_MARBULL_STRATEGY'),			AdvancedStartCost, 	('ART_DEF_UNIT_CL_MARBULL'),  0,					('CL_UNIT_FLAG_MARBULL_ATLAS'),	2, 				('CL_MURRI_ATLAS')
FROM Units WHERE (Type = 'UNIT_SCOUT');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts
(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_CL_MARBULL'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SCOUT');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes
(UnitType, 					UnitAIType)
SELECT		('UNIT_CL_MARBULL'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SCOUT');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades
(UnitType, 					UnitClassType)
SELECT		('UNIT_CL_MARBULL'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_SCOUT');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors
(UnitType, 					FlavorType, Flavor)
SELECT		'UNIT_CL_MARBULL', 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SCOUT');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
VALUES		('UNIT_CL_MARBULL', 		'PROMOTION_CL_MURRI_ENEMY_ROUTE');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
SELECT		'UNIT_CL_MARBULL',		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_SCOUT');
--==========================================================================================================================
--==========================================================================================================================
