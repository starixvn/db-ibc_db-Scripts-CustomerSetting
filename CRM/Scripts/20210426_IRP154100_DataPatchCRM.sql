/*
	Created: 20210426@Johnson
	Task: data patch crm feedback setting
	DB: DBCRM/bodb_CRM
*/
--246 rows affect
UPDATE crmFeedbackSetting with(rowlock)
SET SettingID = 3025
WHERE SettingID = 3012
GO


DELETE crmSetting WITH(ROLOCK)
WHERE SettingID = 3012