/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250722@Tacy
	Task: Playtech - Implement Setting and Initial data [RedmineID: #233150]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @ProductID INT, @BetType_Jackpot INT
		, @SportType INT, @psID INT 

SET @psID = 215

SET @ProductID = 100
SET @SportType = 148
SET @BetType_Jackpot = 12998 --Jackpot Contribution

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dep_ProductSettingDetail
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, RepUpdateTime)
SELECT @psID, @SportType SportType, @BetType_Jackpot BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, dbo.f_GetDateTime2() RepUpdateTime -- Position Taking
