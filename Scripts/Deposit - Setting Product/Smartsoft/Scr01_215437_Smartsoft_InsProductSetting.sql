/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created by: 20241217@Virgil
	Task: Smartsoft - Implement Customer Setting and Initial data [RedmineID: #210946]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @ProductID INT = 99,
		@SportType INT = 135,
		@BetType INT = 12150,
		@BitmapOrder INT = 55

-- Dep_ProductSetting
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel, RepUpdateTime)
SELECT 225 ProductSettingID, @ProductID ProductID, 4 SettingType, 0 TemplateID, 1 DisplayOrder, 1 SettingLevel, SYSDATETIME() -- ProductSatus
UNION ALL
SELECT 226 ProductSettingID, @ProductID ProductID, 1 SettingType, 0 TemplateID, 2 DisplayOrder, 1 SettingLevel, SYSDATETIME() -- Position Taking

-- Dep_ProductSettingDetail
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus, RepUpdateTime)
SELECT 225 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, SYSDATETIME() -- ProductSatus
UNION ALL
SELECT 226 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, SYSDATETIME() -- Position Taking

-- Dep_ProductStatusProfile 
INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype, Bettype, bitmapOrder, RepUpdateTime)
VALUES (@SportType, @BetType, @BitmapOrder, SYSDATETIME())

