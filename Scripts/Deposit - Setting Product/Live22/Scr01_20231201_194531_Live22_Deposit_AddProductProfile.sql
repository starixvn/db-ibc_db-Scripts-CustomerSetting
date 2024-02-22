/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20231201 
	Task: Live22 - Integrate New Product [redmine: #194531]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder)
SELECT 227,	7601,	41
GO

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
SELECT       180, 79, 4, 0, 1, 1
UNION SELECT 181, 79, 1, 0, 2, 1
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
SELECT       180, 227, 7601, 0, 0, 1, NULL, 0
UNION SELECT 181, 227, 7601, 0, 0, 1, NULL, 0
GO