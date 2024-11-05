/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 202409009@Virgil
	Task:  ON Casino - Implement customer setting [RedmineID: #210025]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

	DECLARE @Sporttype	SMALLINT	= 138,
			@Bettype	SMALLINT	= 11850

	UPDATE X 
	SET X.CreationStatus = 0,
		X.SettingStatus = 0,
		X.RepUpdateTime = dbo.f_GetDateTime2()
	FROM ProductSettingProfile X WITH (ROWLOCK, UPDLOCK)
	WHERE SportType = @Sporttype 
		AND BetType = @Bettype

GO