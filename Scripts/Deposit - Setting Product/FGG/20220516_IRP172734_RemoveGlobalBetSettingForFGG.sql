/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220516@Johnson
	Task: remove global bet setting for FGG [Redmine: #172734]
	DB: DBCUST/CustDB
*/

;WITH T AS (
	SELECT ROW_NUMBER() OVER(PARTITION by ExchangeID,SiteID order by MaxStake asc) rn, * 
	FROM Dep_StakeLevel WITH(NOLOCK) 
	WHERE GameTypeID = 8201
)
DELETE Dep_StakeLevel WITH(ROWLOCK)
WHERE GameTypeID = 8201
	AND StakeLevelID NOT IN (
		SELECT StakeLevelID FROM t WHERE rn = 1
	)