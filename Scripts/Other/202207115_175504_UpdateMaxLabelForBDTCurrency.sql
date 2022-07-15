/*<info serverAlias="DBCUST-CustDB"></info>*/

/*
	Created: 20220715@Tacy
	Task: Update data into column MaxLabel on table Dep_StakeLevelGroupDetail for BDT currency.
		 https://nexdev.net/issues/175504 [RedmineID: #175504]
	Database: DBCUST/CustDB
*/

UPDATE a
SET a.MaxLabel=CASE WHEN a.MaxStake*2.5 > 999		THEN REVERSE(STUFF (REVERSE(a.MaxStake*2.5),CHARINDEX('.',REVERSE(a.MaxStake*2.5),0) + 4,0,','))
					WHEN a.MaxStake*2.5 > 999999	THEN REVERSE(STUFF (REVERSE(a.MaxStake*2.5),CHARINDEX('.',REVERSE(a.MaxStake*2.5),0) + 8,0,','))
					ELSE a.MaxStake*2.5
				END
FROM Dep_StakeLevelGroupDetail a WITH (ROWLOCK, UPDLOCK)
	INNER JOIN Dep_StakeLevel b WITH (NOLOCK) ON b.StakeLevelID=a.StakeLevelID
WHERE b.GameTypeID=2101 AND a.GameTypeID IN (2103,2112,2121,2181,2203)
	AND b.ExchangeID=97
