/*
	Created: 20200915@Johnson
	Task: add log action for CRM
	DB: DBCRM/bodb_CRM
*/

INSERT INTO [dbo].[crmLogAction]
           ([ActionID]
           ,[SPName]
           ,[ActionNameEN]
           ,[IsInternal]
          )
     VALUES
           (106
           ,'Acc_CRM_CustomerSiteUpd'
           ,'Update customer info'
           ,0
           )
GO