/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211025@Johnson
	Task: copy settings for new games keno
	DB: DBCust/CustDB
*/

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)