/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211129@Johnson
	Task: Get max custid
	DB: DBCust/CustDB
*/

SELECT MAX(custid) FROM Custinfo WITH(NOLOCK)