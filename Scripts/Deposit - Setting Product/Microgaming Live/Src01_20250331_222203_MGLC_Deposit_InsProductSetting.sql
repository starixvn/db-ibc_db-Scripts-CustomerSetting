/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Tacy
	Task: Microgaming Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #222203]
	DB: DBCUST-CustDB
*/
USE GlobCustDB
GO

DECLARE @ProductID INT, @BetType INT, @SportType INT
	, @BitmapOrder INT, @Max_psID INT 

SET @Max_psID = 238

SET @ProductID = 107
SET @SportType = 124
SET @BetType = 13900
SET @BitmapOrder = 60

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dep_ProductSetting
INSERT INTO [dbo].[Dep_ProductSetting] (ProductSettingID, ProductID, SettingType, TemplateID, DisplayOrder, SettingLevel, RepUpdateTime)
SELECT @Max_psID + 1, @ProductID ProductID, 4 SettingType, 0 TemplateID, 1 DisplayOrder, 1 SettingLevel, dbo.f_GetDateTime2() RepUpdateTime -- ProductSatus
UNION ALL
SELECT @Max_psID + 2, @ProductID ProductID, 7 SettingType, 0 TemplateID, 2 DisplayOrder, 3 SettingLevel, dbo.f_GetDateTime2() RepUpdateTime -- Stake Level
UNION ALL
SELECT @Max_psID + 3, @ProductID ProductID, 1 SettingType, 0 TemplateID, 3 DisplayOrder, 1 SettingLevel, dbo.f_GetDateTime2() RepUpdateTime -- Position Taking

-- Dep_ProductSettingDetail
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, RepUpdateTime)
SELECT @Max_psID + 1, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, dbo.f_GetDateTime2() RepUpdateTime -- ProductSatus
UNION ALL
SELECT @Max_psID + 2, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, dbo.f_GetDateTime2() RepUpdateTime -- Stake Level
UNION ALL
SELECT @Max_psID + 3, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, dbo.f_GetDateTime2() RepUpdateTime -- Position Taking

-- Dep_ProductStatusProfile 
INSERT INTO [dbo].[Dep_ProductStatusProfile] (Sporttype, Bettype, bitmapOrder, RepUpdateTime)
VALUES (@SportType, @BetType, @BitmapOrder, dbo.f_GetDateTime2())
