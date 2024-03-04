/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240304
	Task: Get MaxCustID [Redmine:#201783]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
