/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250512@Tacy
	Task: Get MaxCustID [redmine: #225850]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO
