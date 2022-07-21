/*<info serverAlias="DBTP-bodb02"></info>*/

/*
	Created: 20220704@Tacy
	Task: Delete data from CustMaxBetSetting_History
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBTP-bodb02
*/
DECLARE @CustList VARCHAR(MAX)=NULL

CREATE TABLE #tmp (
			CustID			INT
		,	SportType		SMALLINT
		,	BetType			INT
		,	UpdateTime		DATETIME
	)


INSERT INTO #tmp (CustID, SportType, BetType, UpdateTime)
SELECT a.CustID, a.SportType, a.BetType, a.UpdateTime
FROM DBCUST.CustDB. dbo.CustMaxBetSetting_History a WITH (ROWLOCK)
	INNER JOIN CustMaxBetSetting_History b WITH (NOLOCK)
		ON a.CustID=b.CustID
		AND a.SportType=b.SportType
		AND a.BetType=b.BetType
		AND a.UpdateTime=b.UpdateTime

SET @CustList = (SELECT	CustID				AS '@CustID',
						SportType			AS '@SportType',
						BetType				AS '@BetType',
						UpdateTime			AS '@UpdateTime'
				FROM #tmp
				FOR XML PATH('r'), ROOT ('root')
				)

--Delete data - DBCUST.CustDB
EXEC DBCUST.CustDB.dbo.Task_DetectBet_DelBetSettingHistory @Mode=1, @History_List=@CustList

DROP TABLE #tmp