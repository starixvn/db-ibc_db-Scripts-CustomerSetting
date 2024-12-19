/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20241120@Virgil
	Task: GPI Live Casino - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #213485]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID INT, @BetType INT, @SportType INT, @BitmapOrder INT

SET @ProductID = 90
SET @SportType = 144
SET @BetType = 11500
SET @BitmapOrder = 53

-- Dep_ProductSetting
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel, RepUpdateTime)
SELECT 217 ProductSettingID, @ProductID ProductID, 4 SettingType, 0 TemplateID, 1 DisplayOrder, 1 SettingLevel, dbo.f_GetDateTime2() RepUpdateTime -- ProductSatus
UNION ALL
SELECT 218 ProductSettingID, @ProductID ProductID, 7 SettingType, 0 TemplateID, 2 DisplayOrder, 3 SettingLevel, dbo.f_GetDateTime2() RepUpdateTime -- Stake Level
UNION ALL
SELECT 219 ProductSettingID, @ProductID ProductID, 1 SettingType, 0 TemplateID, 3 DisplayOrder, 1 SettingLevel, dbo.f_GetDateTime2() RepUpdateTime -- Position Taking

-- Dep_ProductSettingDetail
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, RepUpdateTime)
SELECT 217 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, dbo.f_GetDateTime2() RepUpdateTime -- ProductSatus
UNION ALL
SELECT 218 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, dbo.f_GetDateTime2() RepUpdateTime -- Stake Level
UNION ALL
SELECT 219 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, dbo.f_GetDateTime2() RepUpdateTime -- Position Taking

-- Dep_ProductStatusProfile 
INSERT INTO [dbo].[Dep_ProductStatusProfile] (Sporttype, Bettype, bitmapOrder, RepUpdateTime)
VALUES (@SportType, @BetType, @BitmapOrder, dbo.f_GetDateTime2())
