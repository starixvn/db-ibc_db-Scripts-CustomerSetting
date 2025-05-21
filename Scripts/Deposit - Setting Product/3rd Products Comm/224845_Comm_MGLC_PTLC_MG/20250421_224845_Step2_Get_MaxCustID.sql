/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250421@Tacy
	Task: Get MaxCustID [redmine: #224845]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO
