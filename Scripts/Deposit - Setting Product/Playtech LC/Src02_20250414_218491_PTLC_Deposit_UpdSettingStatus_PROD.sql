/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250414@Tacy
	Task: Playtech Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #218491]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @Sporttype SMALLINT = 129,
		@Bettype   SMALLINT	= 15600

UPDATE Y
SET SettingStatus = 0,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM [dbo].[Dep_ProductSettingDetail] Y WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype
	AND BetType IN (@Bettype, 15798) --Contribution bettype

GO
