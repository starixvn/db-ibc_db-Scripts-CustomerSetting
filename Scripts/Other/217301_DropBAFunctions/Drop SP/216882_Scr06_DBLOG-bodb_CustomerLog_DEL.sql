/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBLOG-bodb_CustomerLog
	Note: Step 2 - Drop SPs
*/
USE bodb_CustomerLog
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpDropObjectsName TABLE ( command VARCHAR(MAX), IsDrop BIT)

INSERT INTO @tmpDropObjectsName (command)
SELECT 'DROP PROCEDURE ' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'DEL_Acc_BA_GroupCurrency_ViewLog%'
	OR name LIKE 'DEL_Acc_BA_SpecialCust_ViewLog%'
	OR name LIKE 'DEL_Acc_BA_LicConfig_ViewLog%'
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


