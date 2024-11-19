/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20240919@Virgil
	Task: Playtech - Implement customer setting [RedmineID: #210552]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID INT = 100,
		@SportType INT = 148,
		@BetType INT = 12500,
		@BitmapOrder INT = 52

-- Dep_ProductSetting
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel, RepUpdateTime)
SELECT 214 ProductSettingID, @ProductID ProductID, 4 SettingType, 0 TemplateID, 1 DisplayOrder, 1 SettingLevel, SYSDATETIME() -- ProductSatus
UNION ALL
SELECT 215 ProductSettingID, @ProductID ProductID, 1 SettingType, 0 TemplateID, 3 DisplayOrder, 1 SettingLevel, SYSDATETIME() -- Position Taking

-- Dep_ProductSettingDetail
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus, RepUpdateTime)
SELECT 214 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, SYSDATETIME() -- ProductSatus
UNION ALL
SELECT 215 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, SYSDATETIME() -- Position Taking

-- Dep_ProductStatusProfile 
INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype, Bettype, bitmapOrder, RepUpdateTime)
VALUES (@SportType, @BetType, @BitmapOrder, SYSDATETIME())


