/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: Tacy@20250505
	Task: W Casino - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #225850]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @SportType SMALLINT = 136
		,@Bettype	SMALLINT = 12000

UPDATE Y
SET SettingStatus = 0,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM [dbo].[Dep_ProductSettingDetail] Y WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype
	AND BetType = @Bettype

GO
