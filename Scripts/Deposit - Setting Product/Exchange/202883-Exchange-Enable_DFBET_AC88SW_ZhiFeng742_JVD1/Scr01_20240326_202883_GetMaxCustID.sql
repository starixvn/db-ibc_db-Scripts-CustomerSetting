/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240326
	Task: Get MaxCustID [Redmine:#202883]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
