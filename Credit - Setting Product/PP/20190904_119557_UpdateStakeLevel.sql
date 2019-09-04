/*
	Created by: Winnie
	Date: 20190904
	Task: Pragmatic - Update bet limit setting of GBP currency and remove the game " Da Vincci Treasure " [Redmine:#119557]	
	DB: DBCUST/CustDB
*/
UPDATE a
	SET a.MaxStake=5.00,a.MaxLabel='5.00'
FROM StakeLevelGroupDetail a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID	
WHERE a.GameTypeID IN(4116,4132,4176,4012) AND b.GameTypeID =4101 AND b.ExchangeID=12 AND b.GameGroupID=6

UPDATE a
	SET a.MaxStake=8.00,a.MaxLabel='8.00'
FROM StakeLevelGroupDetail a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID	
WHERE a.GameTypeID =4161 AND b.GameTypeID=4101 AND b.ExchangeID=12 AND b.GameGroupID=6

UPDATE a
	SET a.MaxStake=4.00,a.MaxLabel='4.00'
FROM StakeLevelGroupDetail a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID	
WHERE a.GameTypeID =4184 AND b.GameTypeID=4101 AND b.ExchangeID=12 AND b.GameGroupID=6

DELETE a
FROM StakeLevelGroupDetail a WITH(ROWLOCK,UPDLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID	
WHERE a.GameTypeID =4272 AND b.GameTypeID=4101