/*<info serverAlias="DBEXT-bodb02"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBEXT-bodb02
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
	name LIKE 'DEL_Acc_Rpt_BALicWinloss%'
	OR name LIKE 'DEL_Acc_Rpt_BALicWinlossdaily%'
	OR name LIKE 'DEL_Acc_Rpt_BALicWinlossMonthly%'
	OR name LIKE 'DEL_Acc_Rpt_BAWinlossByLicensee%'
	OR name LIKE 'DEL_Acc_Rpt_BAWinlossByLicenseeDetail%'
	OR name LIKE 'DEL_Acc_Rpt_BAWinlossByLicenseeDetail_Ag%'
	OR name LIKE 'DEL_Acc_Rpt_HouseNetIncome_SB_Deposit%'
	OR name LIKE 'DEL_Acc_BA_CurrencySel%'
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
