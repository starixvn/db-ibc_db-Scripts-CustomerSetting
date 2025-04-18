/*<info serverAlias="DBGLOB-GlobCustDB"></info>*/
/*
	Created: {Nickname}@{date}
	Task: {ProductName} - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #xxx]
	DB: DBGLOB-GlobCustDB
*/
USE GlobCustDB
GO

DECLARE @SportType SMALLINT = {SportType}
		,@Bettype	SMALLINT = {Bettype}

UPDATE Y
SET SettingStatus = 0,
	RepUpdateTime = dbo.f_GetDateTime2()
FROM [dbo].[Dep_ProductSettingDetail] Y WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype
	AND BetType = @Bettype

GO
