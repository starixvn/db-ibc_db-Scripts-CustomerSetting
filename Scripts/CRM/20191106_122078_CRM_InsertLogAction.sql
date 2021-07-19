USE [bodb_CRM]
GO

/*
	Created: 20191106@Winnie
	Task: Insert LogAction RedmineID:#122078
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
           ,'Acc_CRM_crmDefaultCommToolIns'
           ,'Insert default communication tool'
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
           ,'Update default communication tool'
           ,0
           ,1)
GO
