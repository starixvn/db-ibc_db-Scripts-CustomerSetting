/*
	Created: Winnie
	Date: 20191220
	Task:  Insert SG [VendorGlobalSetting] RedmineID:#122351
	DB: DBCust/CustDB
*/
USE [CustDB]
GO
DELETE FROM VendorGlobalSetting WHERE [VendorId]=36
INSERT INTO [dbo].[VendorGlobalSetting]
           ([VendorId]
           ,[VName]
           ,[NumberValue]
           ,[sporttype]
           ,[bettype])
     VALUES
           (36
           ,'3rdCashWLShareRate'
           ,0.035
           ,NULL
           ,NULL)
GO


INSERT INTO [dbo].[VendorGlobalSetting]
           ([VendorId]
           ,[VName]
           ,[NumberValue]
           ,[sporttype]
           ,[bettype])
     VALUES
           (36
           ,'3rdCreditWLShareRate'
           ,0.035
           ,NULL
           ,NULL)
GO


