/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220704@Tacy
	Task: Delete data from CustMaxBetSetting_History
		 https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCUST-CustDB
*/
USE CustDB
GO 

CREATE TABLE #tmp (
			CustID			INT
		,	SportType		SMALLINT
		,	BetType			INT
		,	UpdateTime		DATETIME
	)


INSERT INTO #tmp (CustID, SportType, BetType, UpdateTime)
SELECT a.CustID, a.SportType, a.BetType, a.UpdateTime
FROM DBTP.bodb02.dbo.CustMaxBetSetting_History a WITH (ROWLOCK)
	INNER JOIN CustMaxBetSetting_History b WITH (NOLOCK)
		ON a.CustID=b.CustID
		AND a.SportType=b.SportType
		AND a.BetType=b.BetType
		AND a.UpdateTime=b.UpdateTime

DELETE a
FROM CustMaxBetSetting_History a
	INNER JOIN #tmp b
	ON a.CustID=b.CustID
		AND a.SportType=b.SportType
		AND a.BetType=b.BetType
		AND a.UpdateTime=b.UpdateTime

DROP TABLE #tmp
