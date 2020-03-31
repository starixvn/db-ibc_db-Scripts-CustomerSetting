/*
Created: 20200331@Johnson
Task: Insert log action - [Redmine:#130647]
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
           (95009
           ,4
           ,'EAS_CustomerInsMember_CloneSetting_Com'
           ,'Add the general information for super from existing super'
           ,'Add the general information for super from existing super'
           ,'Add the general information for super from existing super'
           ,'Add the general information for super from existing super'
           ,'Add the general information for super from existing super'
           ,'Add the general information for super from existing super'
           ,'Add the general information for super from existing super'
           ,NULL
           ,1
           ,'Add the general information for super from existing super')
GO


