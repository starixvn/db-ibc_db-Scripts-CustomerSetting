/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250722@Tacy
	Task: Playtech - Implement Setting and Initial data [RedmineID: #233150]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @Sporttype SMALLINT = 148,
		@BetType_Jackpot   SMALLINT	= 12998

UPDATE Y
SET SettingStatus = 0,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM [dbo].[Dep_ProductSettingDetail] Y WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype
	AND BetType IN (@BetType_Jackpot) --Contribution bettype
GO
