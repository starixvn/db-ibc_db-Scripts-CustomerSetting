USE [bodb_CRM]
GO

/*
	Created: 20190509@Winnie
	Task: CN88 Insert crmsetting RedmineID:#112637
	DB: DBCRM/bodb_CRM
*/
INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           ,[ExcludedForCn88])
     VALUES
           (801
           ,'Acc_CRM_CN88_SettingIns'
           ,'Insert settings CN88'
           ,0
           ,0)
GO


INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           ,[ExcludedForCn88])
     VALUES
           (800
           ,'Acc_CRM_CN88_SettingUpd'
           ,'Update settings CN88'
           ,0
           ,0)
GO


