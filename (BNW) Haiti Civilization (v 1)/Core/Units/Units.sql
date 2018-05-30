--==========================================================================================================================
-- Units
--==========================================================================================================================	
INSERT INTO Units 	
			(Class, 	Type, 						PrereqTech, Combat, Cost, 	FaithCost,	RequiresFaithPurchaseEnabled,	Moves, 	CombatClass, Domain, DefaultUnitAI, Description, 					Civilopedia, 							Strategy, 									Help, 								 MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, UnitArtInfo, 					UnitFlagIconOffset, UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		Class, 		('UNIT_LEUGI_MAWON'), 		PrereqTech, Combat, Cost, 	FaithCost,	RequiresFaithPurchaseEnabled,	Moves, 	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_LEUGI_MAWON'), 	('TXT_KEY_CIV5_LEUGI_MAWON_TEXT'), 		('TXT_KEY_UNIT_LEUGI_MAWON_STRATEGY'),		('TXT_KEY_UNIT_HELP_LEUGI_MAWON'),	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, ('ART_DEF_UNIT_MAWON'), 0,					('LEUGI_UNIT_FLAG_MAWON_ATLAS'),	2, 				('LEUGI_HAITI_ATLAS')
FROM Units WHERE (Type = 'UNIT_MUSKETMAN');

INSERT INTO Units 	
			(Class,	Type, 						PrereqTech, Combat,	Cost, FaithCost,	Moves, CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,							PortraitIndex, 	IconAtlas,		MoveRate,	UnitArtInfoEraVariation,	ReligionSpreads,	ReligiousStrength,	SpreadReligion)
SELECT		Class,	('UNIT_LEUGI_HOUNGAN'),		PrereqTech, Combat, Cost, 0,	Moves, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_LEUGI_HOUNGAN'), 	('TXT_KEY_CIV5_LEUGI_HOUNGAN_TEXT'), 	('TXT_KEY_UNIT_LEUGI_HOUNGAN_STRATEGY'), 	('TXT_KEY_UNIT_HELP_LEUGI_HOUNGAN'), 	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, ('ART_DEF_UNIT_HOUNGAN'),	0,					('LEUGI_UNIT_FLAG_HOUNGAN_ATLAS'),	4, 				('LEUGI_HAITI_ATLAS'),	MoveRate,			1,							2,					1000,	SpreadReligion
FROM Units WHERE (Type = 'UNIT_MISSIONARY');

INSERT INTO Units 	
			(Class,	Type, 						PrereqTech, Combat,	Cost, 	Moves, CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,							PortraitIndex, 	IconAtlas,		MoveRate,	UnitArtInfoEraVariation,	ReligionSpreads,	ReligiousStrength,	SpreadReligion)
SELECT		Class,	('UNIT_LEUGI_UBER_HOUNGAN'),PrereqTech, Combat, Cost,	Moves, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_LEUGI_HOUNGAN'), 	('TXT_KEY_CIV5_LEUGI_HOUNGAN_TEXT'), 	('TXT_KEY_UNIT_LEUGI_HOUNGAN_STRATEGY'), 	('TXT_KEY_UNIT_HELP_LEUGI_HOUNGAN'), 	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, ('ART_DEF_UNIT_HOUNGAN'),	0,					('LEUGI_UNIT_FLAG_HOUNGAN_ATLAS'),	5, 				('LEUGI_HAITI_ATLAS'),	MoveRate,			1,							4,					1500,	SpreadReligion
FROM Units WHERE (Type = 'UNIT_MISSIONARY');



--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_LEUGI_MAWON'), 			SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_MAWON');
	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_LEUGI_HOUNGAN'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_MISSIONARY');	


INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_LEUGI_UBER_HOUNGAN'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_MISSIONARY');	

--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================	
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_LEUGI_MAWON'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_MUSKETMAN');	
	
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_LEUGI_HOUNGAN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_MISSIONARY');	

INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_LEUGI_HOUNGAN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_GENERAL');	


INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_LEUGI_UBER_HOUNGAN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_GENERAL');	

--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================	
--INSERT INTO Unit_ResourceQuantityRequirements 	
--			(UnitType, 						ResourceType)
--SELECT		('UNIT_LEUGI_HOUNGAN'), 		ResourceType
--FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_CAVALRY');	
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 						UnitClassType)
SELECT		('UNIT_LEUGI_MAWON'),			UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_MUSKETMAN');	

--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================	
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_LEUGI_MAWON'), 			FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_MUSKETMAN');	

INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_LEUGI_HOUNGAN'),		FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_MISSIONARY');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================	
INSERT INTO Unit_FreePromotions 	
			(UnitType, 						PromotionType)
SELECT		('UNIT_LEUGI_MAWON'),			PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_MUSKETMAN');

INSERT INTO Unit_FreePromotions 
			(UnitType, 					PromotionType)
VALUES		('UNIT_LEUGI_HOUNGAN', 	'PROMOTION_RIVAL_TERRITORY'),
			('UNIT_LEUGI_HOUNGAN', 	'PROMOTION_SIGHT_PENALTY'),
			('UNIT_LEUGI_HOUNGAN', 	'PROMOTION_MEDIC'),
			('UNIT_LEUGI_UBER_HOUNGAN', 	'PROMOTION_RIVAL_TERRITORY'),
			('UNIT_LEUGI_UBER_HOUNGAN', 	'PROMOTION_MEDIC'),
			('UNIT_LEUGI_UBER_HOUNGAN', 	'PROMOTION_MEDIC_II'),
			('UNIT_LEUGI_UBER_HOUNGAN', 	'PROMOTION_GREAT_GENERAL'),
			('UNIT_LEUGI_MAWON', 	'PROMOTION_LEUGI_FREEDOM_CRY');

--==========================================================================================================================
-- Unit_UniqueNames
--==========================================================================================================================
INSERT INTO Unit_UniqueNames 
			(UnitType, 						UniqueName)
VALUES		('UNIT_LEUGI_UBER_HOUNGAN', 'TXT_KEY_GREAT_PERSON_DUTTY_BOUKMAN');
--==========================================================================================================================
--==========================================================================================================================		
		

-- The following is to add the Faith Cost if and only if Whoward's DLL is active
UPDATE Units
  SET FaithCost = 200
  WHERE Type = 'UNIT_LEUGI_HOUNGAN'
  AND EXISTS (SELECT 1 FROM Yields WHERE Type = 'YIELD_GOLDEN_AGE_POINTS');