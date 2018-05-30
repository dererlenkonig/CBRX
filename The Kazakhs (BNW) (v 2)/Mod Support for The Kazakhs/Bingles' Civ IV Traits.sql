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
VALUES      ('LEADER_ABLAI_KHAN',	 'POLICY_AGGRESSIVE_X',	'POLICY_CHARISMATIC_X');
--=======================================================================================================================
-- Leaders
--=======================================================================================================================
UPDATE Leaders 
SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
	THEN 'Ablai Khan [ICON_WAR][ICON_HAPPINESS_1]'
	ELSE 'Ablai Khan' END) 
WHERE Type = 'LEADER_ABLAI_KHAN';

CREATE TRIGGER CivIVTraitsKazakh
AFTER INSERT ON Leaders WHEN 'LEADER_ABLAI_KHAN' = NEW.Type
BEGIN
	UPDATE Leaders 
	SET Description = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_PHILOSOPHICAL_X' )
		THEN 'Ablai Khan [ICON_WAR][ICON_HAPPINESS_1]'
		ELSE 'Ablai Khan' END) 
	WHERE Type = 'LEADER_ABLAI_KHAN';
END;	
--=======================================================================================================================
--=======================================================================================================================
