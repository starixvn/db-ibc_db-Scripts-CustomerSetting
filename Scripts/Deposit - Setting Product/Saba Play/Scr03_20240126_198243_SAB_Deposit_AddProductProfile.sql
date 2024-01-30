/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240126 
	Task: Saba Play - Integrate New Product [redmine: #198243]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

INSERT INTO Dep_ProductStatusProfile(SportType,Bettype,BitmapOrder)
SELECT 9917,	2000,	43
GO

INSERT INTO [dbo].[Dep_ProductSetting]
           ([ProductSettingID]
           ,[ProductID]
           ,[SettingType]
           ,[TemplateID]
           ,[DisplayOrder]
           ,[SettingLevel])
SELECT       186, 82, 4, 0, 1, 1
UNION SELECT 187, 82, 1, 0, 2, 1
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
SELECT       186, 9917, 2000, 0, 0, 1, NULL, 0
UNION SELECT 187, 9917, 2000, 0, 0, 1, NULL, 0
GO
