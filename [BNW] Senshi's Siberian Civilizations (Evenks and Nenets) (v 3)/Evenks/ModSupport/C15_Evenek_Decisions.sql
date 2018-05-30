
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('C15_Eveneks_Decisions.lua');

INSERT INTO Policies
		(Type,							Description)
VALUES	('POLICY_C15_EVENEK_SADDLE',	'TXT_KEY_POLICY_C15_EVENEK_SADDLE');

INSERT INTO Policy_ImprovementCultureChanges
		(PolicyType,					ImprovementType,	CultureChange)
VALUES	('POLICY_C15_EVENEK_SADDLE',	'IMPROVEMENT_CAMP',	1);

INSERT INTO UnitPromotions
			(Type, 											Description, 												Help, 													CannotBeChosen, 		Sound, 				PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry,								MovesChange)
VALUES		('PROMOTION_C15_EVENEK_SADDLE',					'TXT_KEY_POLICY_C15_EVENEK_SADDLE',							'TXT_KEY_PROMOTION_C15_EVENEK_SADDLE_HELP',				1,						'AS2D_IF_LEVELUP',	33,				'PROMOTION_ATLAS',	'PEDIA_ATTRIBUTES',	'TXT_KEY_POLICY_C15_EVENEK_SADDLE',		1);

INSERT INTO UnitPromotions_UnitCombats
		(PromotionType,						UnitCombatType)
VALUES	('PROMOTION_C15_EVENEK_SADDLE',		'UNITCOMBAT_MOUNTED');

INSERT INTO Policy_FreePromotions
			(PolicyType,						PromotionType)
VALUES		('POLICY_C15_EVENEK_SADDLE',		'PROMOTION_C15_EVENEK_SADDLE');

INSERT INTO BuildingClasses
		(Type,									DefaultBuilding,			Description)
VALUES	('BUILDINGCLASS_C15_NIMAT',				'BUILDING_C15_NIMAT',		'TXT_KEY_DECISION_C15_EVENK_NIMAT'),
		('BUILDINGCLASS_C15_NIMAT2',			'BUILDING_C15_NIMAT2',		'TXT_KEY_DECISION_C15_EVENK_NIMAT'),
		('BUILDINGCLASS_C15_NIMAT4',			'BUILDING_C15_NIMAT4',		'TXT_KEY_DECISION_C15_EVENK_NIMAT'),
		('BUILDINGCLASS_C15_NIMAT8',			'BUILDING_C15_NIMAT8',		'TXT_KEY_DECISION_C15_EVENK_NIMAT'),
		('BUILDINGCLASS_C15_NIMAT16',			'BUILDING_C15_NIMAT16',		'TXT_KEY_DECISION_C15_EVENK_NIMAT'),
		('BUILDINGCLASS_C15_NIMAT_FURS',		'BUILDING_C15_NIMAT_FURS',	'TXT_KEY_DECISION_C15_EVENK_NIMAT');

INSERT INTO Buildings
		(Type,								BuildingClass,							Description,							Cost,	FaithCost,	GreatWorkCount,		PrereqTech,		NeverCapture,	NukeImmune,		PortraitIndex,	IconAtlas,		NumTradeRouteBonus)
VALUES	('BUILDING_C15_NIMAT',				'BUILDINGCLASS_C15_NIMAT',				'TXT_KEY_DECISION_C15_EVENK_NIMAT',		-1,		-1,			-1,					NULL,			1,				1,				19,				'BW_ATLAS_1',	1),
		('BUILDING_C15_NIMAT2',				'BUILDINGCLASS_C15_NIMAT2',				'TXT_KEY_DECISION_C15_EVENK_NIMAT',		-1,		-1,			-1,					NULL,			1,				1,				19,				'BW_ATLAS_1',	2),
		('BUILDING_C15_NIMAT4',				'BUILDINGCLASS_C15_NIMAT4',				'TXT_KEY_DECISION_C15_EVENK_NIMAT',		-1,		-1,			-1,					NULL,			1,				1,				19,				'BW_ATLAS_1',	4),
		('BUILDING_C15_NIMAT8',				'BUILDINGCLASS_C15_NIMAT8',				'TXT_KEY_DECISION_C15_EVENK_NIMAT',		-1,		-1,			-1,					NULL,			1,				1,				19,				'BW_ATLAS_1',	8),
		('BUILDING_C15_NIMAT16',			'BUILDINGCLASS_C15_NIMAT16',			'TXT_KEY_DECISION_C15_EVENK_NIMAT',		-1,		-1,			-1,					NULL,			1,				1,				19,				'BW_ATLAS_1',	16),
		('BUILDING_C15_NIMAT_FURS',			'BUILDINGCLASS_C15_NIMAT_FURS',			'TXT_KEY_DECISION_C15_EVENK_NIMAT',		-1,		-1,			-1,					NULL,			1,				1,				19,				'BW_ATLAS_1',	0);

INSERT INTO Building_ResourceQuantity
		(BuildingType,						ResourceType,				Quantity)
VALUES	('BUILDING_C15_NIMAT_FURS',			'RESOURCE_FUR',				1);