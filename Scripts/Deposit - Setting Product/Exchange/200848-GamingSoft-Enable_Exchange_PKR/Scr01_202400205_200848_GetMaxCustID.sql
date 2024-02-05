/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240205
	Task: Get MaxCustID [Redmine:#200848]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
