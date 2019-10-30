USE [bodb_CRM]
GO
/*  
Created: Winnie  
Date: 20191018
Task : CRM - Support Default Communication Tool RedmineID: #122078
DB: DBCRM/bodb_CRM  
*/  


CREATE TABLE [dbo].[crmDefaultCommTool](
	[DefaultCommID] [int] NOT NULL,
	[CustID] [int] NOT NULL,
	[SettingID] [int] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
 CONSTRAINT [PK_crmDefaultComm] PRIMARY KEY CLUSTERED 
(
	[DefaultCommID] ASC,
	[CustID] ASC,
	[SettingID] ASC,
	[SettingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO


INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           ,[ExcludedForCn88])
     VALUES
           (306
           ,'Acc_CRM_DefaultCommToolIns'
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
           ,'Acc_CRM_DefaultCommToolUpd'
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
           ,'Acc_CRM_DefaultCommToolDel'
           ,'Delete default communication tool setting'
           ,0
           ,1)
GO




