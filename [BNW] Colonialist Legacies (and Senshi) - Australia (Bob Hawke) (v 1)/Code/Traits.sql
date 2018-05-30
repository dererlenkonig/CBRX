--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 						Description, 						ShortDescription)					
VALUES		('TRAIT_SENSHI_HAWKE', 	'TXT_KEY_TRAIT_SENSHI_HAWKE', 	'TXT_KEY_TRAIT_SENSHI_HAWKE_SHORT');

INSERT INTO Policies
		(Type,							Description,						HalfSpecialistFood,	HalfSpecialistUnhappiness)
VALUES	('POLICY_SENSHI_HAWKE',			'TXT_KEY_TRAIT_SENSHI_HAWKE_SHORT',	1,					1),
		('POLICY_SENSHI_HAWKE_DUMMY',	'TXT_KEY_TRAIT_SENSHI_HAWKE_SHORT',	0,					0);