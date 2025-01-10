/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20241217@Virgil
	Task: PLAY STAR - Implement setting and initial data [RedmineID: #208021]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID INT = 91,
		@SportType INT = 143,
		@BetType INT = 11600,
		@BitmapOrder INT = 54

-- Dep_ProductSetting
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel, RepUpdateTime)
SELECT 223 ProductSettingID, @ProductID ProductID, 4 SettingType, 0 TemplateID, 1 DisplayOrder, 1 SettingLevel, SYSDATETIME() -- ProductSatus
UNION ALL
SELECT 224 ProductSettingID, @ProductID ProductID, 1 SettingType, 0 TemplateID, 2 DisplayOrder, 1 SettingLevel, SYSDATETIME() -- Position Taking

-- Dep_ProductSettingDetail
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus, RepUpdateTime)
SELECT 223 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, SYSDATETIME() -- ProductSatus
UNION ALL
SELECT 224 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, SYSDATETIME() -- Position Taking

-- Dep_ProductStatusProfile 
INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype, Bettype, bitmapOrder, RepUpdateTime)
VALUES (@SportType, @BetType, @BitmapOrder, SYSDATETIME())

