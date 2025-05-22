/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250520@Tacy
	Task: Get MaxCustID [redmine: #227852]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO
