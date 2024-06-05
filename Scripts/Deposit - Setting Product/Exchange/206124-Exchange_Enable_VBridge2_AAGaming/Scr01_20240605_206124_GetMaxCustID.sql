/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240605
	Task: Get MaxCustID [Redmine:#206124]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
