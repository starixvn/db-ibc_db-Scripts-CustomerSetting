/*<info serverAlias="DBCHECK-CheckResultDB"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBCHECK-CheckResultDB
	Note: Step 2 - Drop SPs
*/
USE CheckResultDB
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpDropObjectsName TABLE (command VARCHAR(MAX), IsDrop BIT)

INSERT INTO @tmpDropObjectsName (command)
SELECT 'DROP PROCEDURE ' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'DEL_DBA_CheckComm_Dep%'
	OR name LIKE 'DEL_DBA_CheckComm_Deposit%'
	OR name LIKE 'DEL_DBA_CheckPT_Dep%'
	OR name LIKE 'DEL_DBA_CheckPositionTaking_DepCustsetting%'
	OR name LIKE 'DEL_DBA_CheckPositionTaking_Deposit%'
)

SELECT * FROM @tmpDropObjectsName

WHILE (1=1)
BEGIN
	UPDATE TOP (1) @tmpDropObjectsName
	SET @command = command, 
		IsDrop = 1
	WHERE IsDrop IS NULL

	IF @@ROWCOUNT = 0
		BREAK;
	
	EXEC (@command)

END

