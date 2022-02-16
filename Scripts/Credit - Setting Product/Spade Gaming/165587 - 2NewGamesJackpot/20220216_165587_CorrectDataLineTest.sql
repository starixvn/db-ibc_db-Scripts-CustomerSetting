/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Winfred
	Date: 20220216
	Task:  Correct Direct account RedmineID:#165587
	DB: DBCust/CustDB
*/

USE CustDB
GO

DELETE a
FROM CustDirectAccount a WITH(ROWLOCK)
WHERE a.CustID = 23003231 --SupertestTE0101 