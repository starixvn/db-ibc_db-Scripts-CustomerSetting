/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250716@Tacy
	Task: Get MaxCustID [redmine: #232298]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO
