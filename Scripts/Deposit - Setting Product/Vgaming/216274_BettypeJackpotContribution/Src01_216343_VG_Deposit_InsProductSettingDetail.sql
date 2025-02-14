/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250103@Virgil
	Task: Vgaming - Integrate Bettype Jackpot Contribution (Remove code using VendorGlobalSetting) [RedmineID: #216274]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @BetType INT, @SportType INT, @BitmapOrder INT

SET @SportType = 171
SET @BetType = 3898

-- Dep_ProductSettingDetail
INSERT INTO [dbo].[Dep_ProductSettingDetail] (ProductSettingID, SportType, BetType, IsLive, MaxDefaultValue, SettingStatus, RepUpdateTime)
SELECT 102 ProductSettingID, @SportType SportType, @BetType BetType, 0 IsLive, 0 MaxDefaultValue, 1 SettingStatus, dbo.f_GetDateTime2() RepUpdateTime -- Position Taking
