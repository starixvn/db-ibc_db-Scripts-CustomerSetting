/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240306
	Task: Deposit - Clean VS1, VS2, VS3 - [redmine: #198008]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

SELECT MAX(custid) AS Max_CustID
FROM custInfo WITH (NOLOCK)
GO
