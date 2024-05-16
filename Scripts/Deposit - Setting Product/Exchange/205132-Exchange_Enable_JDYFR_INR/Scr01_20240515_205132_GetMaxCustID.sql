/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240515
	Task: Get MaxCustID [Redmine:#205132]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
