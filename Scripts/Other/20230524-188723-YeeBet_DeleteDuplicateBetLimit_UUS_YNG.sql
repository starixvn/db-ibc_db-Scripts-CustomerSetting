/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20230524
	Task: NAP - IT Configuration - Initializing Bet Limit - Yeebet - Duplicated value for UUS and YNG currency 
		[redmine : #188723]
	DB: DBCUST/CustDB
*/
CREATE TABLE #tmpStakeLevel (StakeLevelID INT PRIMARY KEY)

;WITH tmp AS (
SELECT StakeLevelID,
	ROW_NUMBER() OVER (PARTITION BY MinStake, MaxStake,sl.ExchangeId ORDER BY (StakeLevelID)) AS rn
FROM StakeLevel sl WITH (NOLOCK)
INNER JOIN exchange e WITH (NOLOCK) ON e.ExchangeId=sl.ExchangeId
WHERE GameTypeID=3151
AND e.currency IN ('UUS', 'YNG')
)
INSERT INTO #tmpStakeLevel (StakeLevelID)
SELECT StakeLevelID
FROM tmp
WHERE rn=2

DELETE sl
FROM StakeLevel sl WITH (ROWLOCK)
INNER JOIN #tmpStakeLevel t ON t.StakeLevelID=sl.StakeLevelID

GO