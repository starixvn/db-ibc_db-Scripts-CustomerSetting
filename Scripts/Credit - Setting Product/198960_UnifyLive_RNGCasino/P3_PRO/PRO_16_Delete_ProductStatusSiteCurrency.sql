/*<info serverAlias="DBCUST-custDB"></info>*/
/*
	Created:20240513@Eden
	Task: Delete ProductStatusSiteCurrency for dummy Product Live & RNG Casino [RM:#198960]
	DB: DBSIC/bodb02 --Credit SiteDB Only
*/
DELETE FROM ProductStatusSiteCurrency WITH(ROWLOCK) WHERE SportType IN (9906,9904)