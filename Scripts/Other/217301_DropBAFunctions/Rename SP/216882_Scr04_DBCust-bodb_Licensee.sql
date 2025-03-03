/*<info serverAlias="DBCust-bodb_Licensee"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBCust-bodb_Licensee
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
	name LIKE 'Acc_BA_GroupCurrencyUpd%'
	OR name LIKE 'Acc_BA_GroupCurrencySel%'
	OR name LIKE 'Acc_BA_LicConfigUpd%'
	OR name LIKE 'Acc_BA_SpecialCustAdd%'
	OR name LIKE 'Acc_BA_SpecialCustDel%'
	OR name LIKE 'Acc_BA_SpecialCustSel%'
	OR name LIKE 'Acc_BA_SpecialCustUpd%'
	OR name LIKE 'Acc_BA_LicConfigSel%'
	OR name LIKE 'Lrf_WriteLog_UserLog_LicenseeBAConfig_Wrapper%'
	OR name LIKE 'Lrf_WriteLog_UserLog_LicenseeCurrencyBAGroup_Wrapper%'
	OR name LIKE 'Nap_LM_LicenseeBAConfig_Ins%'
	OR name LIKE 'Lrf_LicenseeBACustUpdComm%'
	OR name LIKE 'Lrf_LicenseeBAHistoryIns%'
	OR name LIKE 'Lrf_LicenseeBAHistoryUpdDone%'
	OR name LIKE 'Task_CheckMissingActiveBAMember%'
	OR name LIKE 'DBA_AddLicenseeToBA%'
	OR name LIKE 'DBA_LicenseeBAConfig_Ins%'
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
