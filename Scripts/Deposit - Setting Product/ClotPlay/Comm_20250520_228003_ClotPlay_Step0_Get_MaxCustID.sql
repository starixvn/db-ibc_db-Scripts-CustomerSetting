/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20250520
	Task: Get MaxCustID [redmine: #228003]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO
