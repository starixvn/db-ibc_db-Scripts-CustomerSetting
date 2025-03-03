/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBLOG-bodb_CustomerLog
	Note: Step 1 - Rename SPs no longer using
*/
USE bodb_CustomerLog
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpRenameObjectsName TABLE ( command VARCHAR(MAX), IsRename BIT)

INSERT INTO @tmpRenameObjectsName (command)
SELECT 'sp_rename ' + name + ', DEL_' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'Acc_BA_GroupCurrency_ViewLog%'
	OR name LIKE 'Acc_BA_SpecialCust_ViewLog%'
	OR name LIKE 'Acc_BA_LicConfig_ViewLog%'
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
