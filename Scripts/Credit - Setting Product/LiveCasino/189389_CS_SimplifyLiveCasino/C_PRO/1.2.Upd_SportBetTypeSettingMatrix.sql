/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230904@Helios
	Task: Inital Data Setting SportBettypeSettingMatrix [#189389]
	DB: DBCUST-CustDB
*/


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

---------------------------SportBettypeSettingMatrix------------------------------------

	UPDATE mt
		SET
			mt.SporttypeRefWinlossLimit = 9911
		,	mt.BettypeRefWinlossLimit = 2400
		,	mt.RepUpdateTime	= SYSDATETIME()
	FROM SportBettypeSettingMatrix mt WITH (ROWLOCK,UPDLOCK)
	WHERE ProductID = 41
	AND isLicensee = 0
	AND Site = 'All'
	AND SporttypeRefWinlossLimit IS NULL