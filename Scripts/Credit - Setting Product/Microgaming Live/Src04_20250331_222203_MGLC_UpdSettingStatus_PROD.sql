/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250331@Tacy
	Task: Microgaming Live - Integrate new Live Casino product - Implement Setting and Initial data [RedmineID: #222203]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

DECLARE @Sporttype SMALLINT = 124,
		@Bettype   SMALLINT = 13900

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
