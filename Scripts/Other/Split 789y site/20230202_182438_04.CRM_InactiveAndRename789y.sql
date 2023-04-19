/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230202@Tacy
	Task: Inactive 789y 
		 https://nexdev.net/issues/182438 [RedmineID: #182438]
	Database: DBCRM-bodb_CRM
*/

USE bodb_CRM
GO

UPDATE s
SET SettingValue='789y (Old)', IsActive=0 
FROM crmSetting s WITH (ROWLOCK,UPDLOCK) 
WHERE SettingName = 'SITE' and SettingValue='789y'