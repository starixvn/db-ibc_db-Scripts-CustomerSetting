/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240108 
	Task: Deposit - Merge VS1, VS2, VS3 into Virtual Sports [redmine: #198008]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder)
SELECT 9908,	1201,	42
GO

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
	  SELECT 182, 5, 4, 0, 1, 1
UNION SELECT 183, 5, 1, 0, 2, 1
UNION SELECT 184, 5, 2, 0, 3, 1
UNION SELECT 185, 5, 9, 0, 4, 1
GO

INSERT INTO [dbo].[Dep_ProductSettingDetail]
           ([ProductSettingID]
           ,[SportType]
           ,[BetType]
           ,[IsLive]
           ,[MaxDefaultValue]
           ,[SettingStatus]
           ,[MinDefaultValue]
           ,[IsApplyBA])
SELECT       182, 9908, 1201, 0, 0, 1, NULL, 0
UNION SELECT 183, 9908, 1201, 0, 0, 1, NULL, 0
UNION SELECT 184, 9908, 1201, 0, 0, 1, NULL, 0
UNION SELECT 185, 9908, 1201, 0, 0, 1, NULL, 0
GO
