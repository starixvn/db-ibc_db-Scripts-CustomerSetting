/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Johnson
	Date: 20211029
	Task: update licensee odds group for customers
	DB: DBCust/CustDB
*/

UPDATE customer WITH(ROWLOCK)
SET ugroup = 'd'
WHERE custid IN (52122771,52123188)