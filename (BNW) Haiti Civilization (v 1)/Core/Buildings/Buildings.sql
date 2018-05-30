--==========================================================================================================================
-- Building Classes
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 								DefaultBuilding,			Description)
VALUES		('BUILDINGCLASS_HAITI_BONUS',		'BUILDING_HAITI_BONUS',		'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT'),
			('BUILDINGCLASS_HAITI_CHECK',		'BUILDING_HAITI_CHECK',		'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT'),
			('BUILDINGCLASS_HAITI_IDEOLOGY',	'BUILDING_HAITI_IDEOLOGY',	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT'),
			('BUILDINGCLASS_HAITI_IDEOLOGY_0',	'BUILDING_HAITI_IDEOLOGY_0',	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT'),
			('BUILDINGCLASS_HAITI_TOURISM',		'BUILDING_HAITI_TOURISM',	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT');

--==========================================================================================================================
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 											BuildingClass,						Cost,	FaithCost,	NukeImmune, MinAreaSize, NeverCapture,	Description, 							Civilopedia, 						Help, 								Strategy,							PortraitIndex, 	IconAtlas,				GreatWorkCount,	GreatWorkSlotType,			PolicyCostModifier, XBuiltTriggersIdeologyChoice,	TechEnhancedTourism,	FreeBuildingThisCity)
VALUES		('BUILDING_HAITI_BONUS',						'BUILDINGCLASS_HAITI_BONUS',		-1,		-1,			1,			-1,			1,				'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 		'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT',	1,				'LEUGI_HAITI_ATLAS',	-1,				'GREAT_WORK_SLOT_MUSIC',	-25,				0,								0,						-1),
			('BUILDING_HAITI_CHECK',						'BUILDINGCLASS_HAITI_CHECK',		-1,		-1,			1,			-1,			1,				'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 		'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT',	1,				'LEUGI_HAITI_ATLAS',	-1,				'GREAT_WORK_SLOT_MUSIC',	0,					0,								0,						-1),
			('BUILDING_HAITI_IDEOLOGY',					'BUILDINGCLASS_HAITI_IDEOLOGY',		-1,		-1,			1,			-1,			1,				'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 		'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT',	1,				'LEUGI_HAITI_ATLAS',	-1,				'GREAT_WORK_SLOT_MUSIC',	0,					1,								0,						'BUILDING_HAITI_IDEOLOGY'),
			('BUILDING_HAITI_IDEOLOGY_0',				'BUILDINGCLASS_HAITI_IDEOLOGY_0',	-1,		-1,			1,			-1,			1,				'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 		'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT',	1,				'LEUGI_HAITI_ATLAS',	-1,				'GREAT_WORK_SLOT_MUSIC',	0,					0,								0,						-1),
			('BUILDING_HAITI_TOURISM',						'BUILDINGCLASS_HAITI_TOURISM',		-1,		-1,			1,			-1,			1,				'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 		'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT', 	'TXT_KEY_TRAIT_LEUGI_HAITI_SHORT',	1,				'LEUGI_HAITI_ATLAS',	-1,				'GREAT_WORK_SLOT_MUSIC',	0,					0,								4,						-1);



INSERT INTO Buildings 	
			(Type, 									GoldMaintenance, 	BuildingClass, Cost,	FaithCost,	NukeImmune, MinAreaSize, NeverCapture,	Description, 	Civilopedia, 	Help, 	Strategy,	PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_LEUGI_FAKE_COURTHOUSE'),		GoldMaintenance, 	BuildingClass, -1,		-1,			NukeImmune, MinAreaSize, 1,				Description, 	Civilopedia, 	Help, 	Strategy,	PortraitIndex, 	IconAtlas
FROM Buildings WHERE (Type = 'BUILDING_COURTHOUSE');


--==========================================================================================================================	
--==========================================================================================================================	