/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240620@Johnson
	Task: Migrate data for bet setting SB [redmine: #199915]
	DB: DBCUST-CustDB
*/ 
SELECT MAX(custid) FROM custinfo (NOLOCK)