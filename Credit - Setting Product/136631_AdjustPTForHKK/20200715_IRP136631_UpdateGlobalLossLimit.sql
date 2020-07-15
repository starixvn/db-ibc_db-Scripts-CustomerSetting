/*
	Created: 20200715@Johnson
	Task: update global loss limit  
	DB: DBCUST/CUSTDB
*/

UPDATE cs
SET cs.MinLossLimit = cs2.MinLossLimit,
	cs.DefaultLossLimit = cs2.DefaultLossLimit
FROM LossLimit_GlobalSetting cs WITH(UPDLOCK,ROWLOCK)
	INNER JOIN LossLimit_GlobalSetting cs2 WITH(NOLOCK) ON cs.productid = cs2.productid
WHERE cs.productid IN (5,6,22,24,38,41,44)	
	AND cs.ExchangeId = 67--HKK
	AND cs2.ExchangeId = 2 
	
	