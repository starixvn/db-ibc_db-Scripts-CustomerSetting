/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220928@Tacy
	Task: Delete data in SportNonOfferedSiteCurrency [redmine:#175853]
	DB: DBCust/CustDB
*/
DELETE FROM SportNonOfferedSiteCurrency WITH (ROWLOCK)
WHERE SportType=155 AND BetType BETWEEN 8401 AND 8449
AND Currency=0 AND SiteID=35