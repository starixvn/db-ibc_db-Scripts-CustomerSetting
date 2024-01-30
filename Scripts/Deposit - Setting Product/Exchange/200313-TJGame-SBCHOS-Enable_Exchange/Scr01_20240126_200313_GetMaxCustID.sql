/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240126
	Task: Get MaxCustID [Redmine:#200313]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
