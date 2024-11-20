/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241120
	Task: remove [CustomerClass]  [Redmine:#212681] 
	DB:	DBCUST-CustDB
*/

USE CustDB
GO

DELETE TOP (17)
FROM CategoryConfig WITH (ROWLOCK)
WHERE CustomerClass IN (30000,31000)
GO