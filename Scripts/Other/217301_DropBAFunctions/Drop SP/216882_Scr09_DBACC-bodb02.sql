/*<info serverAlias="DBACC-bodb02"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBACC-bodb02
	Note: Step 2 - Drop SPs
*/
USE bodb02
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpDropObjectsName TABLE ( command VARCHAR(MAX), IsDrop BIT)

INSERT INTO @tmpDropObjectsName (command)
SELECT 'DROP PROCEDURE ' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'DEL_Acc_Rpt_BALicWinlossByCommissionLevel%'
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

