/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230103
	Task: get max custID to clean setting
		https://nexdev.net/issues/174511
	DB: DBCust/CustDB
*/ 

SELECT MAX (custid) AS max_custid
FROM custInfo WITH (NOLOCK)
