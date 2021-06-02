/*
	Created: 20210526@Johnson
	Task: prevent CSD create new feedback mistakenly If the licensee is terminated
	DB: DBCRM/bodb_CRM
*/

INSERT INTO SystemSetting(SettingName,Value,ServiceName)
SELECT 'ConfigTestLicensee',1,'SyncOICLicensee'
