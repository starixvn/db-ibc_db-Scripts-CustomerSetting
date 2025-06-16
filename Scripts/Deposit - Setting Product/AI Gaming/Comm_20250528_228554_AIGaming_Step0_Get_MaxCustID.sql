/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20250528
	Task: Get MaxCustID [redmine: #228554]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO
