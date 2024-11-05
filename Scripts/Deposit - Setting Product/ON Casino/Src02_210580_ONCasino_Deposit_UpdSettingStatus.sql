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

	UPDATE Y
	SET SettingStatus = 0,
		RepUpdateTime = dbo.f_GetDateTime2()
	FROM [dbo].[Dep_ProductSettingDetail] Y WITH (ROWLOCK, UPDLOCK)
	WHERE ProductSettingID IN (204,205,206)
		AND SportType = @Sporttype
		AND BetType = @Bettype

GO