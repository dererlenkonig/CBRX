--==========================================================================================================================
-- DecisionsAddin_Support
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('MC_LITE_Moors_Decisions.lua');
--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================
INSERT INTO BuildingClasses 	
			(Type, 						 		 				DefaultBuilding, 							Description, 									MaxGlobalInstances, MaxPlayerInstances)
VALUES		('BUILDINGCLASS_DECISIONS_MC_LITE_MOSQUECORDOBA', 	'BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA', 'TXT_KEY_BUILDING_MC_LITE_MOSQUE_CORDOBA',    	1,					-1),
			('BUILDINGCLASS_DECISIONS_MC_LITE_MOSQUECORDOBA2', 	'BUILDING_MC_LITE_MOSQUECORDOBA2', 			'TXT_KEY_BUILDING_MC_LITE_MOSQUE_CORDOBA',    	-1,					-1),
			('BUILDINGCLASS_DECISIONS_MC_LITE_CALIPHATE', 		'BUILDING_DECISIONS_MC_LITE_CALIPHATE', 	'TXT_KEY_DECISIONS_MC_LITE_CALIPHATE',    		-1,					-1);
--==========================================================================================================================
-- Buildings
--==========================================================================================================================
INSERT OR REPLACE INTO Buildings 
			(Type, 										BuildingClass, 										GreatWorkCount, Cost, 	FaithCost,	GoldMaintenance,	PrereqTech, NeverCapture,	Description, 													Help,															PortraitIndex, 	IconAtlas)							
VALUES		('BUILDING_DECISIONS_MC_LITE_CALIPHATE', 	'BUILDINGCLASS_DECISIONS_MC_LITE_CALIPHATE',		-1,				-1, 	-1,			0,					NULL, 		1,				'TXT_KEY_BUILDING_DECISIONS_MC_LITE_CALIPHATE',					'TXT_KEY_BUILDING_DECISIONS_MC_LITE_CALIPHATE_HELP',			5,				'MC_LITE_MOORS_ATLAS'),
			('BUILDING_MC_LITE_MOSQUECORDOBA2', 		'BUILDINGCLASS_DECISIONS_MC_LITE_MOSQUECORDOBA2',	-1,				-1, 	-1,			0,					NULL, 		0,				'TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_DESC',		'TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_HELP',		4,				'MC_LITE_MOORS_ATLAS');

UPDATE Buildings
	SET GreatPeopleRateModifier = 20
	WHERE Type = 'BUILDING_DECISIONS_MC_LITE_CALIPHATE';

INSERT INTO Buildings 	
			(Type, 						 					BuildingClass, 										Description,												Civilopedia,												Help,														Strategy,	Cost,	PrereqTech, 	ConquestProb,	IconAtlas, 				PortraitIndex)
VALUES		('BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA', 	'BUILDINGCLASS_DECISIONS_MC_LITE_MOSQUECORDOBA',	'TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_DESC',	'TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_PEDIA',	'TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_HELP',	null,		-1,  	null,			100,			'MC_LITE_MOORS_ATLAS',	4);

UPDATE Buildings
	SET Quote = 'TXT_KEY_WONDER_MC_LITE_MOSQUECORDOBA_QUOTE', NukeImmune = 1, WonderSplashImage = 'MosqueOfCordoba_Splash.dds', SpecialistType = 'SPECIALIST_SCIENTIST', SpecialistCount = 2, FreeBuildingThisCity = 'BUILDINGCLASS_DECISIONS_MC_LITE_MOSQUECORDOBA2'
	WHERE Type = 'BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA';

UPDATE Buildings
	SET SpecialistType = 'SPECIALIST_WRITER', SpecialistCount = 2, FaithCost = -1, GoldMaintenance = 0, Civilopedia = 'TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_PEDIA'
	WHERE Type = 'BUILDING_MC_LITE_MOSQUECORDOBA2';
--==========================================================================================================================
-- Building_BuildingClassYieldChanges
--==========================================================================================================================
INSERT INTO Building_BuildingClassYieldChanges 	
			(BuildingType, 								BuildingClassType,				YieldType, 		YieldChange)
VALUES		('BUILDING_DECISIONS_MC_LITE_CALIPHATE',	'BUILDINGCLASS_AMPHITHEATER',	'YIELD_FAITH',	1),
			('BUILDING_DECISIONS_MC_LITE_CALIPHATE',	'BUILDINGCLASS_LIBRARY',		'YIELD_FAITH',	1);
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================	
INSERT INTO Building_YieldChanges 	
			(BuildingType, 						YieldType, 			Yield)
VALUES		('BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA',	'YIELD_FAITH',		2),
			('BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA',	'YIELD_CULTURE',	2);
--==========================================================================================================================
-- Language_en_US
--==========================================================================================================================
INSERT INTO Language_en_US (Tag, Text)
VALUES
	(
		'TXT_KEY_DECISIONS_MOORCALIPHATE',
		'Claim the Caliphate'
	),
	(
		'TXT_KEY_DECISIONS_MOORCALIPHATE_DESC',
		'We are the most worthy to fulfil our right, and the most entitled to complete our good fortune, and to put on the clothing granted by the nobility of God. Let us claim the title of Caliph, as a symbol of Moorish glory and power.[NEWLINE]
		[NEWLINE]Requirement/Restrictions:
		[NEWLINE][ICON_BULLET]Player must be the Moors
		[NEWLINE][ICON_BULLET]The Capital must contain at least 1 World Wonder[NEWLINE][ICON_BULLET]The Capital must have at least 10 [ICON_CITIZEN] Population[NEWLINE][ICON_BULLET]May only be enacted once per game
		[NEWLINE]Costs:
		[NEWLINE][ICON_BULLET]2 [ICON_MAGISTRATES] Magistrates
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]The empire becomes known as the Caliphate of Córdoba
		[NEWLINE][ICON_BULLET]+20% [ICON_GREAT_PEOPLE] Great Person generation in the Capital
		[NEWLINE][ICON_BULLET]+1 [ICON_PEACE] Faith from Libraries and Amphitheatres'
	),
	(
		'TXT_KEY_DECISIONS_MOORCALIPHATE_ENACTED_DESC',
		'We are the most worthy to fulfil our right, and the most entitled to complete our good fortune, and to put on the clothing granted by the nobility of God. Let us claim the title of Caliph, as a symbol of Moorish glory and power.[NEWLINE]
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]The empire becomes known as the Caliphate of Córdoba
		[NEWLINE][ICON_BULLET]+20% [ICON_GREAT_PEOPLE] Great Person generation in the Capital
		[NEWLINE][ICON_BULLET]+1 [ICON_PEACE] Faith from Libraries and Amphitheatres'
	),
	(
		'TXT_KEY_CIV_MC_LITE_CORDOBA_ADJECTIVE',
		'Córdoban'
	),
	(
		'TXT_KEY_CIV_MC_LITE_CORDOBA_DESC',
		'Caliphate of Córdoba'
	),
	(
		'TXT_KEY_CIV_MC_LITE_CORDOBA_SHORT_DESC',
		'Córdoba'
	),
	(
		'TXT_KEY_DECISIONS_MOORMOSQUE',
		'Construct the Great Mosque'
	),
	(
		'TXT_KEY_DECISIONS_MOORMOSQUE_DESC',
		'It is only thanks to the Grace of God that the Moorish Empire has achieved the heights it has; and so it would be fitting for us to construct a Great Mosque in our Capital, to his fame and his glory! A monument to stand testament to our faith![NEWLINE]
		[NEWLINE]Requirement/Restrictions:
		[NEWLINE][ICON_BULLET]Player must be the Moors
		[NEWLINE][ICON_BULLET]Must have researched Theology
		[NEWLINE][ICON_BULLET]May only be enacted once per game
		[NEWLINE]Costs:
		[NEWLINE][ICON_BULLET]{1_Num} [ICON_PEACE] Faith
		[NEWLINE][ICON_BULLET]1 [ICON_MAGISTRATES] Magistrates
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]The Great Mosque of Córdoba is constructed in the Capital'
	),
	(
		'TXT_KEY_DECISIONS_MOORMOSQUE_ENACTED_DESC',
		'It is only thanks to the Grace of God that the Moorish Empire has achieved the heights it has; and so it would be fitting for us to construct a Great Mosque in our Capital, to his fame and his glory! A monument to stand testament to our faith![NEWLINE]
		[NEWLINE]Rewards:
		[NEWLINE][ICON_BULLET]The Great Mosque of Córdoba is constructed in the Capital'
	),
	(
		'TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_DESC',
		'Great Mosque of Córdoba'
	),
	(
		'TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_PEDIA',
		'The Great Mosque of Córdoba (commonly referred to as La Mezquita) is one of the jewels of Islamic civilisation. It is to Córdoba what the Alhambra Palace is to Granada and the Giralda tower is to Seville, a unique focal point of identification.[NEWLINE][NEWLINE]The Great Mosque was begun by the Emir Abd al-Rahman I in 785, some 74 years after the conquest of the Visigoths by the Muslims, or Moors as they are more commonly called in the Spanish context. The Mosque was added to by Abd al-Rahman II in 833, before being completed by al-Hakam II and the vizier al-Mansur in the second half of the 10th century.[NEWLINE][NEWLINE]One of the largest mosques in the world, the Great Mosque is even by today''s standards an impressive building, measuring some 180 by 130 metres (23,400 sq metres, approximately 590 x 425 ft, or about 250,000 sq. ft.).'
	),
	(
		'TXT_KEY_WONDER_MC_LITE_MOSQUECORDOBA_QUOTE',
		'[NEWLINE][TAB][TAB]"Sacred for lovers of art, you are the glory of faith,[NEWLINE]You have made Andalusia pure as a holy land!" [NEWLINE]- Muhammad Iqbal[NEWLINE][TAB]'
	),	
	(
		'TXT_KEY_BUILDING_DECISIONS_MC_LITE_MOSQUECORDOBA_HELP',
		'Contains 2 Great Scientist and 2 Great Writer slots.'
	);
--==========================================================================================================================
--==========================================================================================================================