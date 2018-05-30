--=======================================================================================================================
-- Leader_SharedTraits
--=======================================================================================================================
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,             TraitOne,                  TraitTwo)
VALUES      ('LEADER_ABDELKADER_EL_DJEZAIRI',	 'POLICY_SPIRITUAL_X',	'POLICY_PROTECTIVE_X');
--=======================================================================================================================
-- Leaders
--=======================================================================================================================
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Abdelkader [ICON_PEACE][ICON_STRENGTH]'
	ELSE 'Abdelkader' END) 
WHERE Type = 'LEADER_ABDELKADER_EL_DJEZAIRI';

CREATE TRIGGER CivIVTraitsAlgeria
AFTER INSERT ON Leaders WHEN 'LEADER_ABDELKADER_EL_DJEZAIRI' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Abdelkader [ICON_PEACE][ICON_STRENGTH]'
		ELSE 'Abdelkader' END) 
	WHERE Type = 'LEADER_ABDELKADER_EL_DJEZAIRI';
END;	
--=======================================================================================================================
--=======================================================================================================================
