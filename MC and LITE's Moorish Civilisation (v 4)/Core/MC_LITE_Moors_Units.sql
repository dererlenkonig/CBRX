--==========================================================================================================================
-- Units
--==========================================================================================================================	
INSERT INTO Units 	
			(Class,	Type, 									PrereqTech,			Range, RangedCombat,Combat,		FaithCost,	RequiresFaithPurchaseEnabled, Cost,	Moves, 		CombatClass, Domain, DefaultUnitAI, Description, 									Civilopedia, 										Strategy, 											Help, 												MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 							UnitFlagAtlas, 								UnitFlagIconOffset, PortraitIndex,	IconAtlas,						MoveRate)
SELECT		Class,	('UNIT_MC_LITE_GRANADINE_CAVALRY'), 	PrereqTech,			Range, RangedCombat, Combat,	FaithCost,	RequiresFaithPurchaseEnabled, Cost,	Moves+2, 	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_MC_LITE_GRANADINE_CAVALRY'), 	('TXT_KEY_CIV5_MC_LITE_GRANADINE_CAVALRY_TEXT'),	('TXT_KEY_UNIT_MC_LITE_GRANADINE_CAVALRY_STRATEGY'), ('TXT_KEY_UNIT_MC_LITE_GRANADINE_CAVALRY_HELP'),	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_MC_GRANADINECAVALRY'), 	('MC_LITE_MOORS_GRANADINE_CAVALRY_FLAG'),	0,					2, 				('MC_LITE_MOORS_ATLAS'),		('QUADRUPED')
FROM Units WHERE (Type = 'UNIT_CROSSBOWMAN');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_MC_LITE_GRANADINE_CAVALRY'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_CROSSBOWMAN');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================	
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_MC_LITE_GRANADINE_CAVALRY'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_CROSSBOWMAN');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================	
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_MC_LITE_GRANADINE_CAVALRY'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_CROSSBOWMAN');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 								PromotionType)
SELECT		('UNIT_MC_LITE_GRANADINE_CAVALRY'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_CROSSBOWMAN');

INSERT INTO Unit_FreePromotions 
			(UnitType, 				PromotionType)
VALUES		('UNIT_MC_LITE_GRANADINE_CAVALRY', 	'PROMOTION_CAN_MOVE_AFTER_ATTACKING');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 							UnitClassType)
SELECT		('UNIT_MC_LITE_GRANADINE_CAVALRY'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_CROSSBOWMAN');
--==========================================================================================================================	
--==========================================================================================================================	