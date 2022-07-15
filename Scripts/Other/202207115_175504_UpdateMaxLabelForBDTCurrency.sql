/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220715@Tacy
	Task: Update data into column MaxLabel on table Dep_StakeLevelGroupDetail for BDT currency.
		 https://nexdev.net/issues/175504 [RedmineID: #175504]
	Database: DBCUST/CustDB
*/

UPDATE a
SET a.MaxLabel=a.MaxStake*2.5
FROM Dep_StakeLevelGroupDetail a WITH (ROWLOCK, UPDLOCK)
	INNER JOIN Dep_StakeLevel b WITH (NOLOCK) ON b.StakeLevelID=a.StakeLevelID
WHERE a.GameTypeID=2101 AND b.GameTypeID IN (2103,2112,2121,2181,2203)
	AND b.ExchangeID=97
