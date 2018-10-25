/*
	Created: Winnie
	Date: 20181025
	Task: Insert Log Action RedmineID:#100721
	DB: DBLOG/[bodb_CustomerLog]
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
           (2718
           ,1
           ,'Lrf_CustomerUpdMemberBAPositionTakingDCS'
           ,'Update Licensee BA Position Taking for member DCS'
           ,'Update Licensee BA Position Taking for member DCS'
           ,'Update Licensee BA Position Taking for member DCS'
           ,'Update Licensee BA Position Taking for member DCS'
           ,'Update Licensee BA Position Taking for member DCS'
           ,'Update Licensee BA Position Taking for member DCS'
           ,'Update Licensee BA Position Taking for member DCS'
           ,NULL
           ,0
           ,'Update Licensee BA Position Taking for member DCS')
GO


