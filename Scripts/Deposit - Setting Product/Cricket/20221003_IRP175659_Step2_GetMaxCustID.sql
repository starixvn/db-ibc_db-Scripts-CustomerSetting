/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221003@Johnson
	Task: Initial setting for Cricket & Saba Cricket for Deposit customers [#RedmineID:#175659]
	DB: DBCUST/CustDB
*/ 

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)