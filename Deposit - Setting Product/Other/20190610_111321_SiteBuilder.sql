/*
	Created: 20190610@Winnie
	DB: DBLOG/[bodb_CustomerLog]
	Task: Create Licensee Site builder #111321
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
           ,[ActionNameVI]
           ,[ActionNameCN])
     VALUES
           (2214
           ,NULL
           ,'Dot_Dep_CreateLicensee'
           ,'Create Licensee'
           ,'Create Licensee'
           ,'Create Licensee'
           ,'Create Licensee'
           ,'Create Licensee'
           ,'Create Licensee'
           ,'Create Licensee'
           ,NULL
           ,0
           ,'Create Licensee'
           ,'Create Licensee')
GO

