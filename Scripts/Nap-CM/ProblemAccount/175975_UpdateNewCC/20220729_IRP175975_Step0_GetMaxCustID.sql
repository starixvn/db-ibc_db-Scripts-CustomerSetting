/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220729@Johnson
	Task: Update New customer class [redmine:#175975]
	DB: DBCUST/CustDB
*/

SELECT MAX(custid) FROM Custinfo WITH(NOLOCK)