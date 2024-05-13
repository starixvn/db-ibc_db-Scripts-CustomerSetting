/*<info serverAlias="DBCUST-custDB"></info>*/
/*
	Created:20240513@Eden
	Task: Delete SportNonOfferedSiteCurrency for dummy Product Live & RNG Casino [RM:#198960]
	DB: DBCUST-custDB 
*/
DELETE FROM SportNonOfferedSiteCurrency WITH(ROWLOCK) WHERE SportType IN (9906,9904)