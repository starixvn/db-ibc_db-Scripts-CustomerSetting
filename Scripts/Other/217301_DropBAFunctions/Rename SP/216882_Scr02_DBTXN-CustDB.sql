/*<info serverAlias="DBTXN-CustDB"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBTXN-CustDB
*/

USE CustDB
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpRenameObjectsName TABLE ( command VARCHAR(MAX), IsRename BIT)

INSERT INTO @tmpRenameObjectsName (command)
SELECT 'sp_rename ' + name + ', DEL_' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'Acc_AutoFollowBetSelBACustomer%'
	OR name LIKE 'Acc_AutoFollowBetDelCustomer%'
	OR name LIKE 'Acc_AutoFollowBetInsBACustomer%'
	OR name LIKE 'Acc_AutoFollowBetSelCustomer%'
	OR name LIKE 'Dot_CustBAActive_IsBAMember%'
)

WHILE (1=1)
BEGIN
	UPDATE TOP (1) @tmpRenameObjectsName
	SET @command = command, 
		IsRename = 1
	WHERE IsRename IS NULL

	IF @@ROWCOUNT = 0
		BREAK;
	
	EXEC (@command)

END

SELECT * FROM @tmpRenameObjectsName

