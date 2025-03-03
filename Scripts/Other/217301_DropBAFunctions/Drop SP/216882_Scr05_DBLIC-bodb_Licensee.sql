/*<info serverAlias="DBLIC-bodb_Licensee"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBLIC-bodb_Licensee
	Note: Step 2 - Drop SPs
*/
USE bodb_Licensee
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpDropObjectsName TABLE ( command VARCHAR(MAX), IsDrop BIT)

INSERT INTO @tmpDropObjectsName (command)
SELECT 'DROP PROCEDURE ' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'DEL_Acc_CustomerVirtualRateSelectBA%'
	OR name LIKE 'DEL_Acc_CustVRGetLicenseeBA%'
	OR name LIKE 'DEL_Acc_BA_DownlineCheck%'
	OR name LIKE 'DEL_Acc_BA_SpecialCust_GroupCommSel%'
	OR name LIKE 'DEL_Acc_BA_SpecialCustSearch%'

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

