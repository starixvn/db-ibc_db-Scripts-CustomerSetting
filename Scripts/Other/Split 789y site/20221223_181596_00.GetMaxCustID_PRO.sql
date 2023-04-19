/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20221223@Tacy
	Task: get max custID
		https://nexdev.net/issues/181596
	DB: DBCust/CustDB
*/ 

SELECT MAX (custid) AS max_custid
FROM custInfo WITH (NOLOCK)
