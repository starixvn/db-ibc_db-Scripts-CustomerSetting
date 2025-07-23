/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Tacy@20250627
	Task: Get MaxCustID [redmine: #231521]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO
