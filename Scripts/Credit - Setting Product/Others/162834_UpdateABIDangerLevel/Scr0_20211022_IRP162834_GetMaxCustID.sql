/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211022@Johnson
	Task: update basketball danger level 
	DB: DBCust/CustDB
*/

SELECT MAX(custid) FROM custinfo (NOLOCK)