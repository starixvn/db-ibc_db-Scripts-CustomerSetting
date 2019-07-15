/*
	Created: Winnie
	Date: 20190628
	Task:  Insert Cardclub [VendorGlobalSetting] RedmineID:#107643
	DB: DBCust/CustDB
*/
USE [CustDB]
GO
DELETE FROM VendorGlobalSetting WHERE [VendorId]=33
INSERT INTO [dbo].[VendorGlobalSetting]
           ([VendorId]
           ,[VName]
           ,[NumberValue]
           ,[sporttype]
           ,[bettype])
     VALUES
           (33
           ,'3rdCashWLShareRate'
           ,0.025
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
           (33
           ,'3rdCreditWLShareRate'
           ,0.025
           ,NULL
           ,NULL)
GO


