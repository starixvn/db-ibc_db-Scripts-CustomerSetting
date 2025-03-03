/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBCHECK-CheckResultDB
*/
USE CheckResultDB
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpRenameObjectsName TABLE ( command VARCHAR(MAX), IsRename BIT)

INSERT INTO @tmpRenameObjectsName (command)
SELECT 'sp_rename ' + name + ', DEL_' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'DBA_CheckComm_Dep%'
	OR name LIKE 'DBA_CheckPT_Dep%'
	OR name LIKE 'DBA_CheckPositionTaking_DepCustsetting%'
	OR name LIKE 'DBA_CheckPositionTaking_Deposit%'
)
AND name NOT IN ('DBA_CheckComm_Deposit','DBA_CheckPT_Deposit')

WHILE (1=1)
BEGIN
	UPDATE TOP (1) @tmpRenameObjectsName
	SET @command = command, 
		IsRename = 1
	WHERE IsRename IS NULL

	IF @@ROWCOUNT = 0
		BREAK;
	
	--EXEC (@command)

END

SELECT * FROM @tmpRenameObjectsName
