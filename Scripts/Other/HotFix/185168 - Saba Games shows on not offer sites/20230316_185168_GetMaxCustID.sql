/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created by: 20230316@Tacy
	Task: get max custID to update customer's status
		https://nexdev.net/issues/185168
	DB: DBCust/CustDB
*/ 

SELECT MAX (custid) AS max_custid
FROM custInfo WITH (NOLOCK)