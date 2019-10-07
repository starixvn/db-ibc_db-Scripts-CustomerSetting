USE [bodb_CRM]
GO

/*
	Created: 20190925@Winnie
	Task: Insert LogAction RedmineID:#120596
	DB: DBCRM/bodb_CRM
*/
INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           ,[ExcludedForCn88])
     VALUES
           (206
           ,'Acc_CRM_CustomerFeedbackQuickUpd'
           ,'Quick update feedback'
           ,0
           ,1)
GO
