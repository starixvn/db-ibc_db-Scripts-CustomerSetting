/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20240528
	Task: Get MaxCustID [Redmine:#205675]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) AS MaxCustID
FROM custInfo WITH (NOLOCK)
GO
