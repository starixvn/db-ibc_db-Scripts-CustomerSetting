/*
	Created: Winnie
	Date: 20190515
	Task: Pragmatic Update triple-tigers RedmineID:#112836
	DB: DBCUST/CUSTDB
*/
--INH
UPDATE a
SET a.MinStake=4.50,a.MaxStake=1800.00,a.MinLabel='4.50',a.MaxLabel='1,800.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=6 AND ExchangeID=51

UPDATE a
SET a.MinStake=4.50,a.MaxStake=3600.00,a.MinLabel='4.50',a.MaxLabel='3,600.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=7 AND ExchangeID=51
--THB
UPDATE a
SET a.MinStake=7.50,a.MaxStake=3000.00,a.MinLabel='7.50',a.MaxLabel='3,000.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=6 AND ExchangeID=43

UPDATE a
SET a.MinStake=7.50,a.MaxStake=6000.00,a.MinLabel='7.50',a.MaxLabel='6,000.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=7 AND ExchangeID=43
--WON
UPDATE a
SET a.MinStake=250.00,a.MaxStake=100000.00,a.MinLabel='250.00',a.MaxLabel='100,000.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=6 AND ExchangeID=45

UPDATE a
SET a.MinStake=250.00,a.MaxStake=200000.00,a.MinLabel='250.00',a.MaxLabel='200,000.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=7 AND ExchangeID=45
--GBP
UPDATE a
SET a.MinStake=0.01,a.MaxStake=50.00,a.MinLabel='0.01',a.MaxLabel='50.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=6 AND ExchangeID=12

UPDATE a
SET a.MinStake=0.01,a.MaxStake=100.00,a.MinLabel='0.01',a.MaxLabel='100.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=7 AND ExchangeID=12
--INR
UPDATE a
SET a.MinStake=12.50,a.MaxStake=5000.00,a.MinLabel='12.50',a.MaxLabel='5,000.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=6 AND ExchangeID=61

UPDATE a
SET a.MinStake=12.50,a.MaxStake=10000.00,a.MinLabel='12.50',a.MaxLabel='10,000.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=7 AND ExchangeID=61
--JPY
UPDATE a
SET a.MinStake=25.00,a.MaxStake=10000.00,a.MinLabel='25.00',a.MaxLabel='10,000.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=6 AND ExchangeID=32

UPDATE a
SET a.MinStake=25.00,a.MaxStake=20000.00,a.MinLabel='25.00',a.MaxLabel='20,000.00'
FROM StakeLevelGroupDetail a WITH(NOLOCK)
	INNER JOIN StakeLevel b WITH(NOLOCK) ON a.StakeLevelID=b.StakeLevelID
WHERE a.GameTypeID=4102 AND GameGroupID=7 AND ExchangeID=32