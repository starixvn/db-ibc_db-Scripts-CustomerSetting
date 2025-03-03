/*<info serverAlias="DBCust-bodb_Licensee"></info>*/
/*
	Created: 20250228@Virgil
	Task: BA Admin & LAP - Drop BA functions [RedmineID: #216882]
	DB:	DBCust-bodb_Licensee
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
	name LIKE 'DEL_Acc_BA_GroupCurrencyUpd%'
	OR name LIKE 'DEL_Acc_BA_GroupCurrencySel%'
	OR name LIKE 'DEL_Acc_BA_LicConfigUpd%'
	OR name LIKE 'DEL_Acc_BA_SpecialCustAdd%'
	OR name LIKE 'DEL_Acc_BA_SpecialCustDel%'
	OR name LIKE 'DEL_Acc_BA_SpecialCustSel%'
	OR name LIKE 'DEL_Acc_BA_SpecialCustUpd%'
	OR name LIKE 'DEL_Acc_BA_LicConfigSel%'
	OR name LIKE 'DEL_Lrf_WriteLog_UserLog_LicenseeBAConfig_Wrapper%'
	OR name LIKE 'DEL_Lrf_WriteLog_UserLog_LicenseeCurrencyBAGroup_Wrapper%'
	OR name LIKE 'DEL_Nap_LM_LicenseeBAConfig_Ins%'
	OR name LIKE 'DEL_Lrf_LicenseeBACustUpdComm%'
	OR name LIKE 'DEL_Lrf_LicenseeBAHistoryIns%'
	OR name LIKE 'DEL_Lrf_LicenseeBAHistoryUpdDone%'
	OR name LIKE 'DEL_Task_CheckMissingActiveBAMember%'
	OR name LIKE 'DEL_DBA_AddLicenseeToBA%'
	OR name LIKE 'DEL_DBA_LicenseeBAConfig_Ins%'
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

