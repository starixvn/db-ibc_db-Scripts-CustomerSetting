/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Date: 20221118
	Created: Johnson 
	Task: Seal Entertainment - Incorporate to Licensee Sites [redmine : #180380]
	DB: DBCUST/CUSTDB
*/

SELECT max(custid) FROM custinfo WITH(NOLOCK)