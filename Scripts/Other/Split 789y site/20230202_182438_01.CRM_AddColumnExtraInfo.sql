/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20230202@Tacy
	Task: 01. Add column ExtraInfo on table crmSetting
		 https://nexdev.net/issues/182438 [RedmineID: #182438]
	Database: DBCRM-bodb_CRM
*/

USE bodb_CRM
GO

ALTER TABLE [dbo].[crmSetting] ADD ExtraInfo VARCHAR(50) NULL;
