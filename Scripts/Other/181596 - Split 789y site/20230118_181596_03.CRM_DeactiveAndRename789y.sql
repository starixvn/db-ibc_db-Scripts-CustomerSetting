/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230118@Tacy
	Task: Inactive 789y 
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCRM-bodb_CRM
*/

USE bodb_CRM
GO
UPDATE s SET SettingValue='789y (Old)', IsActive=0FROM crmSetting s WITH (ROWLOCK,UPDLOCK) WHERE SettingName  = 'SITE' and SettingValue='789y'