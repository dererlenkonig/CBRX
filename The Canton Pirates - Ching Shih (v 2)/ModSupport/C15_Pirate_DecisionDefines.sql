
INSERT INTO UnitPromotions
		(Type,											Description,										Help,															Sound,				CannotBeChosen,		PortraitIndex,	IconAtlas,			PediaType,			PediaEntry,												HealOutsideFriendly)
VALUES	('PROMOTION_C15_ADMIRAL_DECISION_PROMOTION',	'TXT_KEY_PROMOTION_C15_ADMIRAL_DECISION_PROMOTION',	'TXT_KEY_PROMOTION_C15_ADMIRAL_DECISION_PROMOTION_HELP',		'AS2D_IF_LEVELUP',	1,					59,				'ABILITY_ATLAS',	'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_C15_ADMIRAL_DECISION_PROMOTION',		0),
		('PROMOTION_C15_SUPPLY_DUMMY_PROMOTION',		'TXT_KEY_PROMOTION_C15_SUPPLY_DUMMY_PROMOTION',		'TXT_KEY_PROMOTION_C15_SUPPLY_DUMMY_PROMOTION_HELP',			'AS2D_IF_LEVELUP',	1,					59,				'ABILITY_ATLAS',	'PEDIA_ATTRIBUTES',	'TXT_KEY_PROMOTION_C15_SUPPLY_DUMMY_PROMOTION',			1);
		
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('C15_Pirate_Decisions.lua');

CREATE TABLE IF NOT EXISTS 
JFD_GlobalUserSettings (
	Type 				text 			default null,
	Value 				integer 		default 1);
	
INSERT INTO Language_en_US
			(Tag,														Text)
VALUES		('TXT_KEY_PROMOTION_C15_ADMIRAL_DECISION_PROMOTION',		'Regimental Captain'),
			('TXT_KEY_PROMOTION_C15_ADMIRAL_DECISION_PROMOTION_HELP',	'Defines this Admiral as a Regimental Captain, allowing him to give nearby units the ability to heal outside Friendly Territory.'),
			('TXT_KEY_PROMOTION_C15_SUPPLY_DUMMY_PROMOTION',			'Regimental Organisation'),
			('TXT_KEY_PROMOTION_C15_SUPPLY_DUMMY_PROMOTION_HELP',		'This unit may heal outside Friendly Territory.'),
			('TXT_KEY_DECISIONS_C15_PIRATE_CAPTAINS',					'Appoint Regimental Captains'),
			('TXT_KEY_DECISIONS_C15_PIRATE_CAPTAINS_DESC',				'Organisation is the key to success; therefore, we should divide our grand navy up into Regiments, with a captain to lead each one. [NEWLINE][NEWLINE]Requirements:[NEWLINE][ICON_BULLET]Must have entered the Renaissance Era[NEWLINE][ICON_BULLET]Must have at least 4 Naval Units[NEWLINE][NEWLINE]Costs:[NEWLINE][ICON_BULLET]1 [ICON_MAGISTRATES] Magistrate[NEWLINE][ICON_BULLET]{1_Gold} [ICON_GOLD] Gold[NEWLINE][NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Recieve a Graet Admiral for every 4 Naval Units you own. These Admirals will give units within 2 tiles of them the ability to heal outside of Friendly Territory.'),
			('TXT_KEY_DECISIONS_C15_PIRATE_CAPTAINS_DESC_EE',			'Organisation is the key to success; therefore, we should divide our grand navy up into Regiments, with a captain to lead each one. [NEWLINE][NEWLINE]Requirements:[NEWLINE][ICON_BULLET]Must have entered the Enlightenment Era[NEWLINE][ICON_BULLET]Must have at least 4 Naval Units[NEWLINE][NEWLINE]Costs:[NEWLINE][ICON_BULLET]1 [ICON_MAGISTRATES] Magistrate[NEWLINE][ICON_BULLET]{1_Gold} [ICON_GOLD] Gold[NEWLINE][NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Recieve a Graet Admiral for every 4 Naval Units you own. These Admirals will give units within 2 tiles of them the ability to heal outside of Friendly Territory.'),
			('TXT_KEY_DECISIONS_C15_PIRATE_CAPTAINS_ENACTED_DESC',		'Organisation is the key to success; therefore, we should divide our grand navy up into Regiments, with a captain to lead each one. [NEWLINE][NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Recieve a Graet Admiral for every 4 Naval Units you own. These Admirals will give units within 2 tiles of them the ability to heal outside of Friendly Territory.'),
			('TXT_KEY_DECISIONS_C15_PIRATE_CODE',						'Establish the Pirate Code'),
			('TXT_KEY_DECISIONS_C15_PIRATE_CODE_DESC',					'In order to establish a cohesive empire, rules must be followed. Our pirate nation is no exception, and so we will enact a code of practice that will not only make our navy more formidable, but also morally superior to the common rabble. It should also get us more money, which is always nice.[NEWLINE][NEWLINE]Requirements:[NEWLINE][ICON_BULLET]Must have discovered Navigation[NEWLINE][ICON_BULLET]Must have at least 3 Naval Units[NEWLINE]Costs:[NEWLINE][ICON_BULLET]{1_Culture} [ICON_CULTURE] Culture[NEWLINE][ICON_BULLET]1 [ICON_MAGISTRATES] Magistrate[NEWLINE][NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Capturing cities with Wonders does not decrease their [ICON_CITIZEN] Population.[NEWLINE][ICON_BULLET]Recieve gold for each Wonder in a captured city, based on the Wonder`s [ICON_PRODUCTION] Production cost.'),
			('TXT_KEY_DECISIONS_C15_PIRATE_CODE_DESC_ENACTED',			'In order to establish a cohesive empire, rules must be followed. Our pirate nation is no exception, and so we will enact a code of practice that will not only make our navy more formidable, but also morally superior to the common rabble. It should also get us more money, which is always nice.[NEWLINE][NEWLINE]Rewards:[NEWLINE][ICON_BULLET]Capturing cities with Wonders does not decrease their [ICON_CITIZEN] Population.[NEWLINE][ICON_BULLET]Recieve gold for each Wonder in a captured city, based on the Wonder`s [ICON_PRODUCTION] Production cost.'),
			('TXT_KEY_DECISIONS_C15_PIRATE_CODE_WONDER_GOLD',			'We have recieved {1_Gold} [ICON_GOLD] Gold from the capture of {2_Description} in {3_City}.');	

			