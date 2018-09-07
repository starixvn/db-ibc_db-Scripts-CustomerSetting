
/*
Created: 20180907@Winnie
Task: Insert log action - [Redmine:#100067]
DB: DBLOG.[bodb_CustomerLog]
Revisions:

*/
USE [bodb_CustomerLog]
GO

INSERT INTO [dbo].[LogAction]
           ([ActionID]
           ,[ActionTypeID]
           ,[SPName]
           ,[ActionNameEN]
           ,[ActionNameCH]
           ,[ActionNameCS]
           ,[ActionNameJP]
           ,[ActionNameIT]
           ,[ActionNameTH]
           ,[ActionNameKO]
           ,[XsltContent]
           ,[IsInternal]
           ,[ActionNameVI])
     VALUES
           (31503
           ,4
           ,'EAS_CustomerDateLimitMultipleUpd'
           ,'Update Customer Limit Date'
           ,'Update Customer Limit Date'
           ,'Update Customer Limit Date'
           ,'Update Customer Limit Date'
           ,'Update Customer Limit Date'
           ,'Update Customer Limit Date'
           ,'Update Customer Limit Date'
           ,NULL
           ,0
           ,'Update Customer Limit Date')
GO


