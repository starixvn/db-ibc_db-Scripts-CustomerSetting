USE [bodb_CRM]
GO

/*
	Created: 20191106@Winnie
	Task: Insert LogAction RedmineID:#122078
	DB: DBCRM/bodb_CRM
*/

INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           ,[ExcludedForCn88])
     VALUES
           (308
           ,'Acc_CRM_DefaultCommToolDel'
           ,'Delete default communication tool'
           ,0
           ,1)
GO
