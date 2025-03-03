/*<info serverAlias="DBTXN-CustDB"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBTXN-CustDB
	Note: Step 2 - Drop SPs
*/

USE CustDB
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpDropObjectsName TABLE ( command VARCHAR(MAX), IsDrop BIT)

INSERT INTO @tmpDropObjectsName (command)
SELECT 'DROP PROCEDURE ' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'DEL_Acc_AutoFollowBetSelBACustomer%'
	OR name LIKE 'DEL_Acc_AutoFollowBetDelCustomer%'
	OR name LIKE 'DEL_Acc_AutoFollowBetInsBACustomer%'
	OR name LIKE 'DEL_Acc_AutoFollowBetSelCustomer%'
	OR name LIKE 'DEL_Dot_CustBAActive_IsBAMember%'
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


