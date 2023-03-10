/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230308@Johnson
	Task: initial virtualrate for basketball [redmine: #184339]
	DB: DBCUST/CustDB
*/
SELECT MAX(custid) FROM custinfo WITH(NOLOCK)