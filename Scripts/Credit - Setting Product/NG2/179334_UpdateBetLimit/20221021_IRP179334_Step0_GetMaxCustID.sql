/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20221021
	Task: Update bet limit for NG2  [RedmineID:#179334]
	DB: DBCust/CustDB
*/

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)