/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230112@Johnson
	Task: update bet limit for SB UUS customers [Redmine: #182810]
	DB: DBCUST/CustDB
*/

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)