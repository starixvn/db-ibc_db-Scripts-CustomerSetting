/*
	Created: 20200328@Helen
	Task: Update StakeLevel of Allbet for defined currency
	DB: DBCUST/CUSTDB
	
	Notes: No need UM. Thanks
*/
-- resouce 3
UPDATE S
	SET ResourceId = 331, MinStake = 40, MinLabel='40', MaxStake=10000, MaxLabel='10,000'
FROM StakeLevel S WITH(ROWLOCK)
WHERE ResourceId = 3 
	AND MinStake = 100 
	AND MaxStake = 10000
	AND ExchangeId IN (15,22,33,34,47) --( 'IDD', 'IDR', 'IN', 'IND','DDD')
	AND GameTypeID = 2401
GO

-- resouce 30
UPDATE S
	SET ResourceId = 15, MinStake = 40, MinLabel='40', MaxStake=20000, MaxLabel='20,000'
FROM StakeLevel S WITH(ROWLOCK)
WHERE ResourceId = 30 
	AND MinStake = 250 
	AND MaxStake = 25000
	AND ExchangeId IN (15,22,33,34,47) --( 'IDD', 'IDR', 'IN', 'IND','DDD')
	AND GameTypeID = 2401	
GO	
-- resouce 5
UPDATE S
	SET ResourceId = 332, MinStake = 40, MinLabel='40', MaxStake=30000, MaxLabel='30,000'
FROM StakeLevel S WITH(ROWLOCK)
WHERE ResourceId = 5 
	AND MinStake = 300 
	AND MaxStake = 30000
	AND ExchangeId IN (15,22,33,34,47) --( 'IDD', 'IDR', 'IN', 'IND','DDD')
	AND GameTypeID = 2401
