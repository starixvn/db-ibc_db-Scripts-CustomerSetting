/*
	Created: 20200629@Johnson
	Task: turn off CANSEE For all currencies
	DB: DBCUST/CustDB
*/

--380 rows affected
UPDATE ProductLaunchedSiteCurrency WITH(UPLOCK,ROWLOCK)
SET IsLaunched = 0
where SportType = 244
	AND currency NOT IN (20,72)--uus & SA Gaming