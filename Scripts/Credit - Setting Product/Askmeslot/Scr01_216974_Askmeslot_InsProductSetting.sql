/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: 20250204@Dave
	Task: Askmeslot - Implement Customer Setting and initial data [RedmineID: #216977]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @ProductID INT = 103,
		@SportType INT = 130,
		@BetType INT = 15000,
		@BitmapOrder INT = 56 

-- Dep_ProductSetting
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID,ProductID,SettingType,TemplateID,DisplayOrder,SettingLevel, RepUpdateTime)
SELECT 228 ProductSettingID, @ProductID ProductID, 4 SettingType, 0 TemplateID, 1 DisplayOrder, 1 SettingLevel, SYSDATETIME() -- ProductSatus
UNION ALL
SELECT 229 ProductSettingID, @ProductID ProductID, 1 SettingType, 0 TemplateID, 2 DisplayOrder, 1 SettingLevel, SYSDATETIME(); -- Position Taking

-- Dep_ProductSettingDetail
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID,SportType,BetType,IsLive,MaxDefaultValue,SettingStatus, RepUpdateTime)
SELECT 228 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, SYSDATETIME() -- ProductSatus
UNION ALL
SELECT 229 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, SYSDATETIME(); -- Position Taking

-- Dep_ProductStatusProfile 
INSERT INTO [dbo].Dep_ProductStatusProfile (Sporttype, Bettype, bitmapOrder, RepUpdateTime)
VALUES (@SportType, @BetType, @BitmapOrder, SYSDATETIME());

