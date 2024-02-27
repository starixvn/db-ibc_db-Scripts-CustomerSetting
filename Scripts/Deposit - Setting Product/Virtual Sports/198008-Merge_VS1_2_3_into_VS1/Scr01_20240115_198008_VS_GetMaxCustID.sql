/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240115
	Task: Deposit - Merge VS1, VS2, VS3 into Virtual Sports - SIT[redmine: #198008]
	DB: DBCUST/CUSTDB
*/
USE CustDB
GO

SELECT MAX(custid) AS Max_CustID
FROM custInfo WITH (NOLOCK)
GO