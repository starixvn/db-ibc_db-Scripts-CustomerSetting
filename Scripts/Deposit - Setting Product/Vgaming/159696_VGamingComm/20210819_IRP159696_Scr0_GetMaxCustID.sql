/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210819@Johnson
	Task: Get max custid
	DB: DBCust/CustDB
*/

SELECT MAX(custid) FROM custinfo (NOLOCK)