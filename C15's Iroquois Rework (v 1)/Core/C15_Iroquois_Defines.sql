
CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type	text	default null,
	Value	integer	default 1);

-- Art

INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES		('ATLAS_C15_IROQUOIS_UU_ICON',			256,		'C15_Iroquois_Tomahawk256.dds',				1,				1),
			('ATLAS_C15_IROQUOIS_UU_ICON',			128,		'C15_Iroquois_Tomahawk128.dds',				1,				1),
			('ATLAS_C15_IROQUOIS_UU_ICON',			80,			'C15_Iroquois_Tomahawk80.dds',				1,				1),
			('ATLAS_C15_IROQUOIS_UU_ICON',			64,			'C15_Iroquois_Tomahawk64.dds',				1,				1),
			('ATLAS_C15_IROQUOIS_UU_ICON',			45,			'C15_Iroquois_Tomahawk45.dds',				1,				1),
			('ATLAS_C15_IROQUOIS_UU_FLAG',			32,			'C15_Iroquois_TomahawkFlag32.dds',			1,				1);

-- UA

INSERT INTO Traits
		(Type,					Description,					ShortDescription,					MoveFriendlyWoodsAsRoad)
VALUES	('TRAIT_C15_IROQUOIS',	'TXT_KEY_TRAIT_C15_IROQUOIS',	'TXT_KEY_TRAIT_C15_IROQUOIS_SHORT',	1);

DELETE FROM Leader_Traits WHERE LeaderType = 'LEADER_HIAWATHA' AND TraitType = 'TRAIT_IGNORE_TERRAIN_IN_FOREST';

INSERT INTO Leader_Traits
		(LeaderType,			TraitType)
VALUES	('LEADER_HIAWATHA',		'TRAIT_C15_IROQUOIS');

CREATE TABLE IF NOT EXISTS C15_Iroquois_Nations (ID INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT UNIQUE NOT NULL, Description TEXT DEFAULT 'TXT_KEY_NATION_C15_DEFAULT', Help TEXT DEFAULT 'TXT_KEY_NATION_C15_DEFAULT', BuildingType TEXT, LonghouseDummyType TEXT, PromotionType TEXT);
CREATE TABLE IF NOT EXISTS C15_Iroquois_Nation_Cities (NationType TEXT NOT NULL, CityName TEXT NOT NULL, PRIMARY KEY (NationType, CityName));

INSERT INTO C15_Iroquois_Nations
		(Type,					Description,					Help,								BuildingType,								LonghouseDummyType,								PromotionType)
VALUES	('NATION_C15_MOHAWK',	'TXT_KEY_NATION_C15_MOHAWK',	'TXT_KEY_NATION_C15_MOHAWK_HELP',	'BUILDING_C15_IROQUOIS_NATION_MOHAWK',		'BUILDING_C15_IROQUOIS_LONGHOUSE_MOHAWK',		'PROMOTION_C15_IROQUOIS_NATION_MOHAWK'),
		('NATION_C15_ONONDAGA',	'TXT_KEY_NATION_C15_ONONDAGA',	'TXT_KEY_NATION_C15_ONONDAGA_HELP',	'BUILDING_C15_IROQUOIS_NATION_ONONDAGA',	'BUILDING_C15_IROQUOIS_LONGHOUSE_ONONDAGA',		'PROMOTION_C15_IROQUOIS_NATION_ONONDAGA'),
		('NATION_C15_ONEIDA',	'TXT_KEY_NATION_C15_ONEIDA',	'TXT_KEY_NATION_C15_ONEIDA_HELP',	'BUILDING_C15_IROQUOIS_NATION_ONEIDA',		'BUILDING_C15_IROQUOIS_LONGHOUSE_ONEIDA',		'PROMOTION_C15_IROQUOIS_NATION_ONEIDA'),
		('NATION_C15_CAYUGA',	'TXT_KEY_NATION_C15_CAYUGA',	'TXT_KEY_NATION_C15_CAYUGA_HELP',	'BUILDING_C15_IROQUOIS_NATION_CAYUGA',		'BUILDING_C15_IROQUOIS_LONGHOUSE_CAYUGA',		'PROMOTION_C15_IROQUOIS_NATION_CAYUGA'),
		('NATION_C15_SENECA',	'TXT_KEY_NATION_C15_SENECA',	'TXT_KEY_NATION_C15_SENECA_HELP',	'BUILDING_C15_IROQUOIS_NATION_SENECA',		'BUILDING_C15_IROQUOIS_LONGHOUSE_SENECA',		'PROMOTION_C15_IROQUOIS_NATION_SENECA'),
		('NATION_C15_TUSCO',	'TXT_KEY_NATION_C15_TUSCO',		'TXT_KEY_NATION_C15_TUSCO_HELP',	'BUILDING_C15_IROQUOIS_NATION_C15_TUSCO',	NULL,											'PROMOTION_C15_IROQUOIS_NATION_C15_TUSCO');
		
UPDATE C15_Iroquois_Nations
SET Help = 'TXT_KEY_NATION_C15_ONONDAGA_HELP_JFDDLC'
WHERE Type = 'NATION_C15_ONONDAGA' AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_RTP_SOVEREIGNTY_CORE' AND Value = 1);

--DELETE FROM Civilization_CityNames WHERE CivilizationType = 'CIVILIZATION_IROQUOIS';
/*
INSERT INTO Civilization_CityNames
		(CivilizationType,			CityName)
VALUES	('CIVILIZATION_IROQUOIS',	'TXT_KEY_IROQ_CITY_NAME_ONONDAGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_IROQ_CITY_NAME_OSININKA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_IROQ_CITY_NAME_CHONDOTE'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CHITTENANGO'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANADASAGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_KANOWOKO'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA'),
		('CIVILIZATION_IROQUOIS',	'TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA');*/
		
INSERT INTO C15_Iroquois_Nation_Cities 
		(CityName, NationType) 
VALUES	('TXT_KEY_C15_IROQ_CITY_NAME_CHONODOTE', 'NATION_C15_CAYUGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_GANOGEH', 'NATION_C15_CAYUGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_GOIOGOUEN', 'NATION_C15_CAYUGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_TIOHERO', 'NATION_C15_CAYUGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_ONONTARE', 'NATION_C15_CAYUGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_NEODAKHEAT', 'NATION_C15_CAYUGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_AKWESASNE', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_ANDAGARON', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CAHANIAGA', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CANASTIGAONE', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CANIENGA', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CAUGHNAWAGA', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_IROQ_CITY_NAME_GANIENKEH', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_GAROGA', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_KANATSIOHAREKE', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_IROQ_CITY_NAME_KANESATAKE', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_NOWADAGA', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_ONOALAGONA', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_OSSERNENON', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_SARATOGA', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_IROQ_CITY_NAME_SCHOHARIE', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_TEWANONDADON', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_TIONONDEROGE', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_TIONONDOGEN', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_TYENDINAGA	', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CANOJAHARIE', 'NATION_C15_MOHAWK'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CHITTENANGO', 'NATION_C15_ONEIDA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_GANNEIOUS', 'NATION_C15_ONEIDA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_HOSTAYUNTWA', 'NATION_C15_ONEIDA'),	
		('TXT_KEY_IROQ_CITY_NAME_KANONWALOHALE', 'NATION_C15_ONEIDA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_ONEIDA', 'NATION_C15_ONEIDA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_ONAQUAGA', 'NATION_C15_ONEIDA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_DESEROKEN', 'NATION_C15_ONONDAGA'),	
		('TXT_KEY_IROQ_CITY_NAME_ONONDAGA', 'NATION_C15_ONONDAGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_ONONDAGHARA', 'NATION_C15_ONONDAGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_ONONDAGHGEHGAHGEH', 'NATION_C15_ONONDAGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_OSWEGATCHIE', 'NATION_C15_ONONDAGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_TOUENHO', 'NATION_C15_ONONDAGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_GADOQUAT', 'NATION_C15_ONONDAGA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CANADAIGUA', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CANAWAUGUS', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CATTARAUGUS', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_CHENUSSIO', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_GANATSEKWYAGON', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_GANDATSETIAGON', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_GANONDAGAN', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_KANADASEAGA', 'NATION_C15_SENECA'),	
		('TXT_KEY_IROQ_CITY_NAME_OSININKA', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_TOTIAKTON', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_KENDAIA', 'NATION_C15_SENECA'),	
		('TXT_KEY_C15_IROQ_CITY_NAME_TEIAIAGON', 'NATION_C15_SENECA');

/*
INSERT INTO C15_Iroquois_Nation_Cities
		(NationType,				CityName)
VALUES	('NATION_C15_ONONDAGA', 	'TXT_KEY_IROQ_CITY_NAME_ONONDAGA'),
		('NATION_C15_SENECA', 		'TXT_KEY_IROQ_CITY_NAME_OSININKA'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_GRAND_RIVER'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_AKWESASNE'),
		('NATION_C15_SENECA',	 	'TXT_KEY_IROQ_CITY_NAME_BUFFALO_CREEK'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_BRANTFORD'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_MONTREAL'),
		('NATION_C15_SENECA', 		'TXT_KEY_IROQ_CITY_NAME_GENESSE_RIVER'),
		('NATION_C15_SENECA', 		'TXT_KEY_IROQ_CITY_NAME_CANANDAIGUA_LAKE'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_LAKE_SIMCOE'),
		('NATION_C15_SENECA', 		'TXT_KEY_IROQ_CITY_NAME_SALAMANCA'),
		('NATION_C15_SENECA', 		'TXT_KEY_IROQ_CITY_NAME_GOWANDA'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_BUFFALO'),
		('NATION_C15_SENECA', 		'TXT_KEY_IROQ_CITY_NAME_CUBA'),
		('NATION_C15_SENECA', 		'TXT_KEY_IROQ_CITY_NAME_AKRON'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_KANESATAKE'),
		('NATION_C15_MOHAWK',	 	'TXT_KEY_IROQ_CITY_NAME_GANIENKEH'),
		('NATION_C15_CAYUGA', 		'TXT_KEY_IROQ_CITY_NAME_CAYUGA_CASTLE'),
		('NATION_C15_CAYUGA', 		'TXT_KEY_IROQ_CITY_NAME_CHONDOTE'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_CANAJOHARIE'),
		('NATION_C15_ONONDAGA', 	'TXT_KEY_IROQ_CITY_NAME_NEDROW'),
		('NATION_C15_ONONDAGA', 	'TXT_KEY_IROQ_CITY_NAME_SYRACUSE'),
		('NATION_C15_ONEIDA', 		'TXT_KEY_IROQ_CITY_NAME_ONEIDA_LAKE'),
		('NATION_C15_ONEIDA', 		'TXT_KEY_IROQ_CITY_NAME_KANONWALOHALE'),
		('NATION_C15_ONEIDA', 		'TXT_KEY_IROQ_CITY_NAME_GREEN_BAY'),
		('NATION_C15_ONEIDA', 		'TXT_KEY_IROQ_CITY_NAME_SOUTHWOLD'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_MOHAWK_VALLEY'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_SCHOHARIE'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_BAY_OF_QUINTE'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_KANAWALE'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_KANATSIOKAREKE'),
		('NATION_C15_MOHAWK', 		'TXT_KEY_IROQ_CITY_NAME_TYENDINAGA');*/
		--('CIVILIZATION_IROQUOIS', 	'TXT_KEY_IROQ_CITY_NAME_HAHTA'); -- Apparently not Iroquois...

INSERT OR REPLACE INTO BuildingClasses
		(Type,													Description,	DefaultBuilding)
SELECT	(REPLACE(BuildingType, 'BUILDING_', 'BUILDINGCLASS_')),	Description,	BuildingType
FROM C15_Iroquois_Nations;

INSERT OR REPLACE INTO BuildingClasses
		(Type,															Description,	DefaultBuilding)
SELECT	(REPLACE(LonghouseDummyType, 'BUILDING_', 'BUILDINGCLASS_')),	Description,	LonghouseDummyType
FROM C15_Iroquois_Nations WHERE LonghouseDummyType NOT NULL;

INSERT OR REPLACE INTO Buildings
		(Type,					BuildingClass,											Description,			ConquestProb,		NukeImmune,		Cost,	FaithCost,	PrereqTech,	GreatWorkCount,	IconAtlas,		PortraitIndex,		TrainedFreePromotion)
SELECT	BuildingType,			(REPLACE(BuildingType, 'BUILDING_', 'BUILDINGCLASS_')),	Description,			100,				1,				-1,		-1,			NULL,		-1,				'BW_ATLAS_1',	19,					PromotionType
FROM C15_Iroquois_Nations;

INSERT OR REPLACE INTO Buildings
		(Type,					BuildingClass,													Description,			ConquestProb,		NukeImmune,		Cost,	FaithCost,	PrereqTech,	GreatWorkCount,	IconAtlas,		PortraitIndex)
SELECT	LonghouseDummyType,		(REPLACE(LonghouseDummyType, 'BUILDING_', 'BUILDINGCLASS_')),	Description,			100,				1,				-1,		-1,			NULL,		-1,				'BW_ATLAS_1',	19
FROM C15_Iroquois_Nations WHERE LonghouseDummyType NOT NULL;

INSERT OR REPLACE INTO UnitPromotions
		(Type,					Description,		Help,							CannotBeChosen,			IconAtlas,			PortraitIndex,	PediaType,			PediaEntry)
SELECT	PromotionType,			Description,		Description||'_PROMOTION_HELP',	1,						'ABILITY_ATLAS',	59,				'PEDIA_ATTRIBUTES',	Description
FROM C15_Iroquois_Nations;

INSERT INTO UnitPromotions_UnitCombats
		(PromotionType,			UnitCombatType)
SELECT	a.PromotionType,		b.Type
FROM C15_Iroquois_Nations a, UnitCombatInfos b;

CREATE TRIGGER IF NOT EXISTS C15_Iroquois_NationPromotionCombats
AFTER INSERT ON UnitCombatInfos
BEGIN
	INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,			UnitCombatType)
	SELECT	PromotionType,			NEW.Type
	FROM C15_Iroquois_Nations;
END;

INSERT INTO Building_FeatureYieldChanges
		(BuildingType,									FeatureType,		YieldType,			Yield)
VALUES	('BUILDING_C15_IROQUOIS_LONGHOUSE_MOHAWK',		'FEATURE_FOREST',	'YIELD_PRODUCTION',	1),
		('BUILDING_C15_IROQUOIS_LONGHOUSE_ONONDAGA',	'FEATURE_FOREST',	'YIELD_CULTURE',	1),
		('BUILDING_C15_IROQUOIS_LONGHOUSE_ONEIDA',		'FEATURE_FOREST',	'YIELD_FAITH',		1),
		('BUILDING_C15_IROQUOIS_LONGHOUSE_CAYUGA',		'FEATURE_FOREST',	'YIELD_GOLD',		1),
		('BUILDING_C15_IROQUOIS_LONGHOUSE_SENECA',		'FEATURE_FOREST',	'YIELD_FOOD',		1);

-- Dummies

INSERT INTO BuildingClasses
		(Type,											Description,					DefaultBuilding)
VALUES	('BUILDINGCLASS_C15_IROQUOIS_MOHAWK_XP',		'TXT_KEY_NATION_C15_MOHAWK',	'BUILDING_C15_IROQUOIS_MOHAWK_XP'),
		('BUILDINGCLASS_C15_IROQUOIS_ONEIDA_DEF',		'TXT_KEY_NATION_C15_ONEIDA',	'BUILDING_C15_IROQUOIS_ONEIDA_DEF'),
		('BUILDINGCLASS_C15_IROQUOIS_CAYUGA_TRADE',		'TXT_KEY_NATION_C15_CAYUGA',	'BUILDING_C15_IROQUOIS_CAYUGA_TRADE');

INSERT INTO Buildings
		(Type,									BuildingClass,								Description,					NeverCapture,		NukeImmune,		Cost,	FaithCost,	PrereqTech,	GreatWorkCount,	IconAtlas,		PortraitIndex)
VALUES	('BUILDING_C15_IROQUOIS_MOHAWK_XP',		'BUILDINGCLASS_C15_IROQUOIS_MOHAWK_XP',		'TXT_KEY_NATION_C15_MOHAWK',	1,					1,				-1,		-1,			NULL,		-1,				'BW_ATLAS_1',	19),
		('BUILDING_C15_IROQUOIS_ONEIDA_DEF',	'BUILDINGCLASS_C15_IROQUOIS_ONEIDA_DEF',	'TXT_KEY_NATION_C15_ONEIDA',	1,					1,				-1,		-1,			NULL,		-1,				'BW_ATLAS_1',	19),
		('BUILDING_C15_IROQUOIS_CAYUGA_TRADE',	'BUILDINGCLASS_C15_IROQUOIS_CAYUGA_TRADE',	'TXT_KEY_NATION_C15_CAYUGA',	1,					1,				-1,		-1,			NULL,		-1,				'BW_ATLAS_1',	19);

UPDATE Buildings
SET Defense = 100
WHERE Type = 'BUILDING_C15_IROQUOIS_ONEIDA_DEF';

UPDATE Buildings
SET TradeRouteRecipientBonus = 1
WHERE Type = 'BUILDING_C15_IROQUOIS_CAYUGA_TRADE';
		
INSERT INTO Building_DomainFreeExperiences
		(BuildingType,							DomainType,	Experience)
SELECT	'BUILDING_C15_IROQUOIS_MOHAWK_XP',		Type,		10
FROM Domains;

CREATE TRIGGER IF NOT EXISTS C15_Iroquois_MohawkDomainCheck
AFTER INSERT ON Domains
BEGIN
	INSERT INTO Building_DomainFreeExperiences
			(BuildingType,							DomainType,	Experience)
	VALUES	('BUILDING_C15_IROQUOIS_MOHAWK_XP',		NEW.Type,	10);
END;	

INSERT INTO UnitPromotions
		(Type,												Description,												Help,															CannotBeChosen,			IconAtlas,			PortraitIndex,	PediaType,			PediaEntry,													CombatPercent)
VALUES	('PROMOTION_C15_IROQUOIS_NATION_SENECA_COMBAT',		'TXT_KEY_PROMOTION_C15_IROQUOIS_NATION_SENECA_COMBAT',		'TXT_KEY_PROMOTION_C15_IROQUOIS_NATION_SENECA_COMBAT_HELP',		1,						'ABILITY_ATLAS',	59,				'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_C15_IROQUOIS_NATION_SENECA_COMBAT',		20),
		('PROMOTION_C15_IROQUOIS_GREAT_LAW_PEACE_COMBAT',	'TXT_KEY_PROMOTION_C15_IROQUOIS_GREAT_LAW_PEACE_COMBAT',	'TXT_KEY_PROMOTION_C15_IROQUOIS_GREAT_LAW_PEACE_COMBAT_HELP',	1,						'ABILITY_ATLAS',	59,				'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_C15_IROQUOIS_GREAT_LAW_PEACE_COMBAT',	20),
		('PROMOTION_C15_IROQUOIS_NATION_TUSCO_BONUSES',		'TXT_KEY_PROMOTION_C15_IROQUOIS_NATION_TUSCO_BONUSES',		'TXT_KEY_PROMOTION_C15_IROQUOIS_NATION_TUSCO_BONUSES_HELP',		1,						'ABILITY_ATLAS',	59,				'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_C15_IROQUOIS_NATION_TUSCO_BONUSES',		0);

UPDATE UnitPromotions
SET FlankAttackModifier = 50, ExtraWithdrawal = 80
WHERE Type = 'PROMOTION_C15_IROQUOIS_NATION_TUSCO_BONUSES';

INSERT INTO Policies
		(Type,												Description)
VALUES	('POLICY_C15_IROQUOIS_MOHAWK_BLOCK',				'TXT_KEY_UNIT_IROQUOIAN_MOHAWKWARRIOR');

-- Tomahawk

INSERT INTO ArtDefine_UnitInfos
		(Type, 									DamageStates, Formation)
SELECT	'ART_DEF_UNIT_C15_IROQUOIS_TOMAHAWK', 	DamageStates, Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_HAND_AXE_BARBARIAN';

INSERT INTO ArtDefine_UnitInfoMemberInfos
		(UnitInfoType, 							UnitMemberInfoType, 							NumMembers)
SELECT	'ART_DEF_UNIT_C15_IROQUOIS_TOMAHAWK',	'ART_DEF_UNIT_MEMBER_C15_IROQUOIS_TOMAHAWK',	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_HAND_AXE_BARBARIAN';

INSERT INTO ArtDefine_UnitMemberInfos
		(Type, 											Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_C15_IROQUOIS_TOMAHAWK',	Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_HAND_AXE_BARBARIAN';

INSERT INTO ArtDefine_UnitMemberCombats
		(UnitMemberType, 								EnableActions, ShortMoveRadius, ShortMoveRate, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat)
SELECT	'ART_DEF_UNIT_MEMBER_C15_IROQUOIS_TOMAHAWK',	EnableActions, ShortMoveRadius, ShortMoveRate, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_HAND_AXE_BARBARIAN';

INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, ProjectileSpeed, WeaponTypeTag, WeaponTypeSoundOverrideTag, MissTargetSlopRadius)
  VALUES ('ART_DEF_UNIT_MEMBER_C15_IROQUOIS_TOMAHAWK', 0, 0, 3.0, 'ARROW', 'ARROW', 5.0);
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, WeaponTypeTag, MissTargetSlopRadius)
  VALUES ('ART_DEF_UNIT_MEMBER_C15_IROQUOIS_TOMAHAWK', 1, 0, 10.0, 20.0, 'FLAMING_ARROW', 10.0);

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType, 					TileType, 	Asset)
VALUES 	('ART_DEF_UNIT_C15_IROQUOIS_TOMAHAWK', 	'Unit', 	'C15_Iroquois_TomahawkFlag128.dds');

INSERT INTO UnitPromotions
		(Type,								Description,								Help,												Sound,				IgnoreZoC,		CannotBeChosen,		IconAtlas,			PortraitIndex,		PediaType,			PediaEntry)
VALUES	('PROMOTION_C15_IROQUOIS_TOMAHAWK',	'TXT_KEY_PROMOTION_C15_IROQUOIS_TOMAHAWK',	'TXT_KEY_PROMOTION_C15_IROQUOIS_TOMAHAWK_HELP',		'AS2D_IF_LEVELUP',	1,				1,					'ABILITY_ATLAS',	59,					'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_C15_IROQUOIS_TOMAHAWK');

INSERT INTO Units
		(Type,							Class,					Description,							Help,											Strategy,										Civilopedia,								Combat,		RangedCombat,		Cost,		FaithCost,		RequiresFaithPurchaseEnabled,		Moves,		Range,			CombatClass,			Domain,			DefaultUnitAI,		PrereqTech,		ObsoleteTech,		GoodyHutUpgradeUnitClass,	HurryCostModifier,		AdvancedStartCost,		UnitArtInfo,							MoveRate,		UnitFlagIconOffset,		PortraitIndex,		IconAtlas,						UnitFlagAtlas,					Pillage)
SELECT	'UNIT_C15_IROQUOIS_TOMAHAWK',	'UNITCLASS_SWORDSMAN',	'TXT_KEY_UNIT_C15_IROQUOIS_TOMAHAWK',	'TXT_KEY_UNIT_C15_IROQUOIS_TOMAHAWK_HELP',		'TXT_KEY_UNIT_C15_IROQUOIS_TOMAHAWK_STRATEGY',	'TXT_KEY_UNIT_C15_IROQUOIS_TOMAHAWK_PEDIA',	Combat,		Combat,				Cost,		FaithCost,		RequiresFaithPurchaseEnabled,		Moves,		1,				'UNITCOMBAT_ARCHER',	Domain,			'UNITAI_ATTACK',	PrereqTech,		'TECH_GUNPOWDER',	'UNITCLASS_CROSSBOWMAN',	HurryCostModifier,		AdvancedStartCost,		'ART_DEF_UNIT_C15_IROQUOIS_TOMAHAWK',	MoveRate,		0,						0,					'ATLAS_C15_IROQUOIS_UU_ICON',	'ATLAS_C15_IROQUOIS_UU_FLAG',	Pillage
FROM Units WHERE Type = 'UNIT_SWORDSMAN';

INSERT INTO Unit_ClassUpgrades
		(UnitType,						UnitClassType)
VALUES	('UNIT_C15_IROQUOIS_TOMAHAWK',	'UNITCLASS_CROSSBOWMAN');

INSERT INTO Unit_FreePromotions
		(UnitType,						PromotionType)
VALUES	('UNIT_C15_IROQUOIS_TOMAHAWK',	'PROMOTION_WOODSMAN'),
		('UNIT_C15_IROQUOIS_TOMAHAWK',	'PROMOTION_C15_IROQUOIS_TOMAHAWK');
		
INSERT INTO Unit_AITypes
		(UnitType,						UnitAIType)
VALUES	('UNIT_C15_IROQUOIS_TOMAHAWK',	'UNITAI_RANGED');

INSERT INTO Unit_Flavors
		(UnitType,						FlavorType,			Flavor)
SELECT	'UNIT_C15_IROQUOIS_TOMAHAWK',	FlavorType,			Flavor + 3
FROM Unit_Flavors WHERE UnitType = 'UNIT_COMPOSITE_BOWMAN';

INSERT INTO UnitGameplay2DScripts
		(UnitType,						SelectionSound,				FirstSelectionSound)
SELECT	'UNIT_C15_IROQUOIS_TOMAHAWK',	SelectionSound,				FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_IROQUOIAN_MOHAWKWARRIOR';

INSERT INTO Civilization_UnitClassOverrides
		(CivilizationType,				UnitClassType,			UnitType)
VALUES	('CIVILIZATION_IROQUOIS',		'UNITCLASS_SWORDSMAN',	'UNIT_C15_IROQUOIS_TOMAHAWK');

-- Mohawk

INSERT INTO UnitClasses
		(Type,								Description,							DefaultUnit)
VALUES	('UNITCLASS_C15_IROQUOIS_MOHAWK',	'TXT_KEY_UNIT_IROQUOIAN_MOHAWKWARRIOR',	'UNIT_IROQUOIAN_MOHAWKWARRIOR');

UPDATE Units
SET Class = 'UNITCLASS_C15_IROQUOIS_MOHAWK', Help = 'TXT_KEY_UNIT_C15_IROQUOIS_MOHAWK_HELP',	Strategy = 'TXT_KEY_UNIT_C15_IROQUOIS_MOHAWK_STRAT', PolicyType = 'POLICY_C15_IROQUOIS_MOHAWK_BLOCK'
WHERE Type = 'UNIT_IROQUOIAN_MOHAWKWARRIOR';

INSERT INTO Unit_FreePromotions
		(UnitType,							PromotionType)
VALUES	('UNIT_IROQUOIAN_MOHAWKWARRIOR',	'PROMOTION_WOODSMAN');

INSERT INTO Unit_BuildingClassRequireds
		(UnitType,							BuildingClassType)
VALUES	('UNIT_IROQUOIAN_MOHAWKWARRIOR',	'BUILDINGCLASS_C15_IROQUOIS_NATION_MOHAWK');

DELETE FROM Civilization_UnitClassOverrides WHERE CivilizationType = 'CIVILIZATION_IROQUOIS' AND UnitType = 'UNIT_IROQUOIAN_MOHAWKWARRIOR';

INSERT INTO Civilization_UnitClassOverrides
		(CivilizationType,	UnitClassType,						UnitType)
SELECT	Type,				'UNITCLASS_C15_IROQUOIS_MOHAWK',	NULL
FROM Civilizations WHERE Type != 'CIVILIZATION_IROQUOIS';

CREATE TRIGGER IF NOT EXISTS C15_Iroquois_MohawkBlock
AFTER INSERT ON Civilizations
BEGIN
	INSERT INTO Civilization_UnitClassOverrides
			(CivilizationType,	UnitClassType,						UnitType)
	VALUES	(NEW.Type,			'UNITCLASS_C15_IROQUOIS_MOHAWK',	NULL);
END;

-- Longhouse

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_C15_IROQUOIS_LONGHOUSE_HELP', Strategy = 'TXT_KEY_BUILDING_C15_IROQUOIS_LONGHOUSE_STRAT'
WHERE Type = 'BUILDING_LONGHOUSE';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_C15_IROQUOIS_LONGHOUSE_HELP_JFDDLC', Strategy = 'TXT_KEY_BUILDING_C15_IROQUOIS_LONGHOUSE_STRAT_JFDDLC'
WHERE Type = 'BUILDING_LONGHOUSE' AND EXISTS (SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CID_HEALTH_BUILDING_CHANGES_LONGHOUSE' AND Value = 1);

DELETE FROM Building_FeatureYieldChanges WHERE BuildingType = 'BUILDING_LONGHOUSE' AND YieldType = 'YIELD_PRODUCTION';

INSERT INTO Building_YieldModifiers
		(BuildingType,			YieldType,		Yield)
SELECT	'BUILDING_LONGHOUSE',	YieldType,		Yield
FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_WORKSHOP';

DELETE FROM Building_ResourceQuantityRequirements WHERE BuildingType = 'BUILDING_LONGHOUSE' AND ResourceType = 'RESOURCE_JFD_POWER';

-- Decisions

CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('C15_Iroquois_Decisions.lua');

CREATE TABLE IF NOT EXISTS EventsAddin_Support(FileName);
INSERT INTO EventsAddin_Support (FileName) VALUES ('C15_Iroquois_Events.lua');

INSERT INTO BuildingClasses
		(Type,													DefaultBuilding,								Description)
VALUES	('BUILDINGCLASS_C15_IROQUOIS_DECISION_POLICY_REDUCE',	'BUILDING_C15_IROQUOIS_DECISION_POLICY_REDUCE',	'TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_ELDER');

INSERT INTO Buildings
		(Type,												BuildingClass,											Description,									NeverCapture,		NukeImmune,		Cost,	FaithCost,	PrereqTech,	GreatWorkCount,	IconAtlas,		PortraitIndex,	PolicyCostModifier)
VALUES	('BUILDING_C15_IROQUOIS_DECISION_POLICY_REDUCE',	'BUILDINGCLASS_C15_IROQUOIS_DECISION_POLICY_REDUCE',	'TXT_KEY_DECISIONS_C15_IROQUOIS_COUNCIL_ELDER',	1,					1,				-1,		-1,			NULL,		-1,				'BW_ATLAS_1',	13,				-5);

-- Event
CREATE TABLE IF NOT EXISTS CityEvents ('ID' integer primary key autoincrement , 'Type' text  not null unique , 'EventClass' text default NULL , 'Description' text , 'Help' text , 'CityEventAudio' text , 'CityEventArt' text , 'RandomChance' integer default 0 , 'RandomChanceDelta' integer default 0 , 'IsOneShot' boolean default 0 , 'EventCooldown' integer default 30 , 'NumChoices' integer default 1 , 'EraScaling' boolean default 0 , 'IgnoresGlobalCooldown' boolean default 0 , 'MinimumCityPopulation' integer default 0 , 'MaximumCityPopulation' integer default 0 , 'RequiredCiv' text default NULL , 'RequiredEra' text default NULL , 'ObsoleteEra' text default NULL , 'ImprovementRequired' text default NULL , 'NearbyFeature' text default NULL , 'NearbyTerrain' text default NULL , 'LocalResourceRequired' text default NULL , 'RequiredPolicy' text default NULL , 'RequiredIdeology' text default NULL , 'PrereqTech' text default NULL , 'ObsoleteTech' text default NULL , 'RequiredReligion' text default NULL , 'RequiredStateReligion' text default NULL , 'RequiresAnyStateReligion' boolean default 0 , 'RequiredBuildingClass' text default NULL , 'CannotHaveBuildingClass' text default NULL , 'HasTradeConnection' boolean default 0 , 'HasCityConnection' boolean default 0 , 'RequiresGarrison' boolean default 0 , 'RequiresHolyCity' boolean default 0 , 'RequiresIdeology' boolean default 0 , 'CapitalOnly' boolean default 0 , 'CoastalOnly' boolean default 0 , 'RiverOnly' boolean default 0 , 'RequiresWar' boolean default 0 , 'RequiresWarMinor' boolean default 0 , 'RequiresResistance' boolean default 0 , 'RequiresWLTKD' boolean default 0 , 'RequiresOccupied' boolean default 0 , 'RequiresRazing' boolean default 0 , 'HasAnyReligion' boolean default 0 , 'RequiresPuppet' boolean default 0 , 'HasMetAMajorCiv' boolean default 0 , 'CityHasPlayerReligion' boolean default 0 , 'CityLacksPlayerReligion' boolean default 0 , 'CityHasPlayerMajorityReligion' boolean default 0 , 'CityLacksPlayerMajorityReligion' boolean default 0 , 'IsVassalOfSomeone' boolean default 0 , 'IsMasterOfSomeone' boolean default 0 , 'RequiresPantheon' boolean default 0 , 'InDebt' boolean default 0 , 'LosingMoney' boolean default 0 , 'IsUnhappy' boolean default 0 , 'IsSuperUnhappy' boolean default 0 , 'RequiresNearbyNaturalWonder' boolean default 0 , 'RequiresNearbyMountain' boolean default 0 , foreign key (EventClass) references EventClassTypes(Type), foreign key (Description) references Language_en_US(Tag), foreign key (Help) references Language_en_US(Tag), foreign key (RequiredCiv) references Civilizations(Type), foreign key (RequiredEra) references Eras(Type), foreign key (ObsoleteEra) references Eras(Type), foreign key (ImprovementRequired) references Improvements(Type), foreign key (NearbyFeature) references Features(Type), foreign key (NearbyTerrain) references Terrains(Type), foreign key (LocalResourceRequired) references Resources(Type), foreign key (RequiredPolicy) references Policies(Type), foreign key (RequiredIdeology) references PolicyBranchTypes(Type), foreign key (PrereqTech) references Technologies(Type), foreign key (ObsoleteTech) references Technologies(Type), foreign key (RequiredReligion) references Religions(Type), foreign key (RequiredStateReligion) references Religions(Type), foreign key (RequiredBuildingClass) references BuildingClasses(Type), foreign key (CannotHaveBuildingClass) references BuildingClasses(Type));
CREATE TABLE IF NOT EXISTS CityEventChoices ('ID' integer primary key autoincrement , 'Type' text  not null unique , 'Description' text , 'Help' text , 'DisabledTooltip' text , 'EventChoiceAudio' text default 'AS2D_EVENT_CHOICE' , 'IsOneShot' boolean default 0 , 'EventDuration' integer default 30 , 'EventChance' integer default 0 , 'EraScaling' boolean default 0 , 'Expires' boolean default 0 , 'EventBuildingClassDestruction' text default NULL , 'EventBuildingClass' text default NULL , 'CityWideBuildingDestructionChance' integer default 0 , 'WLTKDTurns' integer default 0 , 'ResistanceTurns' integer default 0 , 'CityHappiness' integer default 0 , 'RandomBarbarianSpawn' integer default 0 , 'FreeUnitsTechAppropriate' integer default 0 , 'EventPromotion' text default NULL , 'ConvertToPlayerReligionPercent' integer default 0 , 'ConvertToPlayerMajorityReligionPercent' integer default 0 , 'MinimumCityPopulation' integer default 0 , 'MaximumCityPopulation' integer default 0 , 'RequiredCiv' text default NULL , 'RequiredEra' text default NULL , 'ObsoleteEra' text default NULL , 'ImprovementRequired' text default NULL , 'NearbyFeature' text default NULL , 'NearbyTerrain' text default NULL , 'RequiredPolicy' text default NULL , 'RequiredIdeology' text default NULL , 'LocalResourceRequired' text default NULL , 'PrereqTech' text default NULL , 'ObsoleteTech' text default NULL , 'RequiredReligion' text default NULL , 'RequiredStateReligion' text default NULL , 'RequiresAnyStateReligion' boolean default 0 , 'RequiredBuildingClass' text default NULL , 'CannotHaveBuildingClass' text default NULL , 'IsVassalOfSomeone' boolean default 0 , 'IsMasterOfSomeone' boolean default 0 , 'CityHasPlayerReligion' boolean default 0 , 'CityLacksPlayerReligion' boolean default 0 , 'CityHasPlayerMajorityReligion' boolean default 0 , 'CityLacksPlayerMajorityReligion' boolean default 0 , 'HasTradeConnection' boolean default 0 , 'HasCityConnection' boolean default 0 , 'RequiresGarrison' boolean default 0 , 'RequiresHolyCity' boolean default 0 , 'RequiresIdeology' boolean default 0 , 'CapitalOnly' boolean default 0 , 'CoastalOnly' boolean default 0 , 'RiverOnly' boolean default 0 , 'RequiresWar' boolean default 0 , 'RequiresWarMinor' boolean default 0 , 'RequiresResistance' boolean default 0 , 'RequiresWLTKD' boolean default 0 , 'RequiresOccupied' boolean default 0 , 'RequiresRazing' boolean default 0 , 'HasAnyReligion' boolean default 0 , 'RequiresPuppet' boolean default 0 , 'HasMetAMajorCiv' boolean default 0 , 'RequiresPantheon' boolean default 0 , 'InDebt' boolean default 0 , 'LosingMoney' boolean default 0 , 'IsUnhappy' boolean default 0 , 'IsSuperUnhappy' boolean default 0 , 'RequiresNearbyNaturalWonder' boolean default 0 , 'RequiresNearbyMountain' boolean default 0 , foreign key (Description) references Language_en_US(Tag), foreign key (Help) references Language_en_US(Tag), foreign key (DisabledTooltip) references Language_en_US(Tag), foreign key (EventBuildingClassDestruction) references BuildingClasses(Type), foreign key (EventBuildingClass) references BuildingClasses(Type), foreign key (EventPromotion) references UnitPromotions(Type), foreign key (RequiredCiv) references Civilizations(Type), foreign key (RequiredEra) references Eras(Type), foreign key (ObsoleteEra) references Eras(Type), foreign key (ImprovementRequired) references Improvements(Type), foreign key (NearbyFeature) references Features(Type), foreign key (NearbyTerrain) references Terrains(Type), foreign key (RequiredPolicy) references Policies(Type), foreign key (RequiredIdeology) references PolicyBranchTypes(Type), foreign key (LocalResourceRequired) references Resources(Type), foreign key (PrereqTech) references Technologies(Type), foreign key (ObsoleteTech) references Technologies(Type), foreign key (RequiredReligion) references Religions(Type), foreign key (RequiredStateReligion) references Religions(Type), foreign key (RequiredBuildingClass) references BuildingClasses(Type), foreign key (CannotHaveBuildingClass) references BuildingClasses(Type));
CREATE TABLE IF NOT EXISTS CityEvent_ParentEvents ('CityEventChoiceType' text , 'CityEventType' text , foreign key (CityEventChoiceType) references CityEventChoices(Type), foreign key (CityEventType) references CityEvents(Type));

INSERT INTO CityEvents
		(Type,												EventClass,				Description,												Help,															CityEventArt)
VALUES	('CITY_EVENT_C15_IROQUOIS_TUSCARORA_MIGRATION',		'EVENT_CLASS_GOOD',		'TXT_KEY_CITY_EVENT_C15_IROQUIOS_TUSCARORA_MIGRATION',		'TXT_KEY_CITY_EVENT_C15_IROQUIOS_TUSCARORA_MIGRATION',		NULL);

INSERT INTO CityEvent_ParentEvents
		(CityEventType,										CityEventChoiceType)
VALUES	('CITY_EVENT_C15_IROQUOIS_TUSCARORA_MIGRATION',		'CITY_EVENT_C15_IROQUOIS_TUSCARORA_MIGRATION_CHOICE_1');

INSERT INTO CityEventChoices
		(Type,														EventChoiceAudio,		Description,												Help,														DisabledTooltip)
VALUES	('CITY_EVENT_C15_IROQUOIS_TUSCARORA_MIGRATION_CHOICE_1',	'AS2D_EVENT_CHOICE',	'TXT_KEY_CITY_EVENT_C15_IROQUIOS_TUSCARORA_MIGRATION',		'TXT_KEY_CITY_EVENT_C15_IROQUIOS_TUSCARORA_MIGRATION_HELP',	'false');

