/*<info serverAlias="DBEXT-bodb02"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBEXT-bodb02
	Note: Step 1 - Rename SPs no longer using
*/
USE bodb02
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpRenameObjectsName TABLE ( command VARCHAR(MAX), IsRename BIT)

INSERT INTO @tmpRenameObjectsName (command)
SELECT 'sp_rename ' + name + ', DEL_' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'Acc_Rpt_BALicWinloss%'
	OR name LIKE 'Acc_Rpt_BALicWinlossdaily%'
	OR name LIKE 'Acc_Rpt_BALicWinlossMonthly%'
	OR name LIKE 'Acc_Rpt_BAWinlossByLicensee%'
	OR name LIKE 'Acc_Rpt_BAWinlossByLicenseeDetail%'
	OR name LIKE 'Acc_Rpt_BAWinlossByLicenseeDetail_Ag%'
	OR name LIKE 'Acc_Rpt_HouseNetIncome_SB_Deposit%'
	OR name LIKE 'Acc_BA_CurrencySel%'
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