/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240423
	Task: Get MaxCustID [Redmine:#204214]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
