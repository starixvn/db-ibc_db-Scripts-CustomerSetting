USE [bodb_CRM]
GO
/*  
Created: Winnie  
Date: 20191018
Task : CRM - Support Default Communication Tool RedmineID: #122078
DB: DBCRM/bodb_CRM  
*/  
INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           ,[ExcludedForCn88])
     VALUES
           (306
           ,'Acc_CRM_crmDefaultCommToolIns'
           ,'Create new default communication tool setting'
           ,0
           ,1)
GO

INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           ,[ExcludedForCn88])
     VALUES
           (307
           ,'Acc_CRM_crmDefaultCommToolUpd'
           ,'Update default communication tool setting'
           ,0
           ,1)
GO


INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           ,[ExcludedForCn88])
     VALUES
           (308
           ,'Acc_CRM_crmDefaultCommToolDel'
           ,'Delete default communication tool setting'
           ,0
           ,1)
GO





