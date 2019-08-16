/*
	Created by: Winnie
	Date: 20190816
	Task: Insert log action [Redmine:#99434]	
	DB: DBCRM/[bodb_CRM]
*/
USE [bodb_CRM]
GO

INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
           ,[ExcludedForCn88])
     VALUES
           (205
           ,'Acc_CRM_FeedbackUpdMultiple'
           ,'Update the feedback multiple'
           ,0
           ,0)
GO
