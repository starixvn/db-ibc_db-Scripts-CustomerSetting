/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: {Nickname}@{date}
	Task: {ProductName} - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #xxx]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT = {Sporttype},
		@Bettype   SMALLINT = {Bettype}

UPDATE X 
SET X.CreationStatus = 0,
	X.SettingStatus = 0,
	X.RepUpdateTime = dbo.f_GetDateTime2()
FROM ProductSettingProfile X WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype 
	AND BetType = @Bettype

UPDATE Y
SET Y.SettingStatus = 0,
	Y.RepUpdateTime = dbo.f_GetDateTime2()
FROM ProductSettingDetail Y WITH (ROWLOCK, UPDLOCK)
WHERE SportType = @Sporttype 
	AND BetType = @Bettype

GO
