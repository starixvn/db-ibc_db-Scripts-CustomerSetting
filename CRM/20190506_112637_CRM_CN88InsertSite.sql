
/*
	Created: 20190506@Winnie
	Task: Add User . Site builder RedmineID:#112637
	DB: DBCRM/bodb_CRM
*/
USE [bodb_CRM]
GO

INSERT INTO [dbo].[crmSetting]
           ([SettingName]
           ,[SettingID]
           ,[SettingValue]
           ,[DisplayOrder]
           ,[IsActive])
     VALUES
           ('SiteCategory'
           ,33002
           ,'CN88'
           ,3
           ,1)
GO


