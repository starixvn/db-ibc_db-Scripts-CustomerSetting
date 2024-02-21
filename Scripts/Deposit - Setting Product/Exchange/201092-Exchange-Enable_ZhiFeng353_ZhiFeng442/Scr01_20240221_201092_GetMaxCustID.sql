/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240221
	Task: Get MaxCustID [Redmine:#201092]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
