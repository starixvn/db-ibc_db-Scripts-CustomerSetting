/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220215@Johnson
	Task: Dep Initial setting for FGG [Redmine: #165682]
	DB: DBCUST/CustDB
*/

SELECT max(custid) FROM custinfo WITH(NOLOCK)