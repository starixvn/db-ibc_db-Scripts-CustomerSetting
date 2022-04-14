/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20220413@Johnson
	Task: Dep Initial setting for new games of Virtual Games [Redmine: #169418]
	DB: DBCUST/CustDB
*/

SELECT max(custid) FROM custinfo WITH(NOLOCK)