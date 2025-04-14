/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: 20250331@Tacy
	Task: Microgaming Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #222203]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @Sporttype SMALLINT = 124,
		@Bettype   SMALLINT	= 13900

UPDATE Y
SET SettingStatus = 0,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM [dbo].[Dep_ProductSettingDetail] Y WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype
	AND BetType = @Bettype

GO
