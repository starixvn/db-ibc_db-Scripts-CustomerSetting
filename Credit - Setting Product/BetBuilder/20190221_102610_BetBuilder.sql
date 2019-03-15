/*
	Created: Winnie
	Date: 20190221
	Task: Bet Builder RedmineID:#102610
	DB: DBCust/CustDB
*/

DELETE FROM [VendorGlobalSetting] WHERE [VendorId]=34 AND [VName]='3rdPartyFee' AND [bettype]=38

INSERT INTO [CustDB].[dbo].[VendorGlobalSetting]
           ([VendorId]
           ,[VName]
           ,[NumberValue]
           ,[sporttype]
           ,[bettype])
     VALUES
           (34
           ,'3rdPartyFee'
           ,0.04
           ,1
           ,38)
GO


