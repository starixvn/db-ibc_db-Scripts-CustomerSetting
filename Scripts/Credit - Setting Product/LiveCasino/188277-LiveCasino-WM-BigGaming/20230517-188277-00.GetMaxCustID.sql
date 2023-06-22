/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: Tacy@20230524
	Task: get max custID to clean setting
		https://nexdev.net/issues/188277
	DB: DBCust/CustDB
*/ 

SELECT MAX (custid) AS max_custid
FROM custInfo WITH (NOLOCK)