/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240416
	Task: Get MaxCustID [Redmine:#203891]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
