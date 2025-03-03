/*<info serverAlias="DBLIC-bodb_Licensee"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBLIC-bodb_Licensee
	Note: Step 1 - Rename SPs no longer using
*/
USE bodb_Licensee
GO

DECLARE @command VARCHAR(MAX)
DECLARE @tmpRenameObjectsName TABLE ( command VARCHAR(MAX), IsRename BIT)

INSERT INTO @tmpRenameObjectsName (command)
SELECT 'sp_rename ' + name + ', DEL_' + name
FROM dbo.sysobjects
WHERE (type = 'P')
AND (
	name LIKE 'Acc_CustomerVirtualRateSelectBA%'
	OR name LIKE 'Acc_CustVRGetLicenseeBA%'
	OR name LIKE 'Acc_BA_DownlineCheck%'
	OR name LIKE 'Acc_BA_SpecialCust_GroupCommSel%'
	OR name LIKE 'Acc_BA_SpecialCustSearch%'

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
