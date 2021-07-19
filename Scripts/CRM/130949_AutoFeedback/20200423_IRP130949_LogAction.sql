/*
	Created: 20200423@Johnson
	Task: add log action for auto fb [redmine: #130949]
	DB: DBCRM-bodb_CRM
*/
INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           )
SELECT 309,'Acc_CRM_SourceSettingMappingUpd','Update source mapping',0
UNION SELECT 310,'Acc_CRM_SourceLicenseeMappingUpd','Update source licensee mapping',0


