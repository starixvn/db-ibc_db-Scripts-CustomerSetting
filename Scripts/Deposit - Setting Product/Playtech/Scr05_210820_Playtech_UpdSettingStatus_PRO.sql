/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 202409009@Virgil
	Task:  ON Casino - Implement customer setting [RedmineID: #210025]
	DB: DBCUST-CustDB
*/
USE CustDB
GO

	DECLARE @Sporttype	SMALLINT	= 148,
			@Bettype	SMALLINT	= 12500

	UPDATE DP
	SET SettingStatus = 0,
		RepUpdateTime = SYSDATETIME()
	FROM [dbo].[Dep_ProductSettingDetail] DP WITH (ROWLOCK, UPDLOCK)
	WHERE ProductSettingID IN (214, 215)
		AND SportType = @Sporttype
		AND BetType = @Bettype

GO