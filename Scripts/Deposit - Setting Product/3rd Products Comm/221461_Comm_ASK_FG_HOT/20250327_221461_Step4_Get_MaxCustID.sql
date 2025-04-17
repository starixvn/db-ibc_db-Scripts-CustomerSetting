/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20250327@Tacy
	Task: Get MaxCustID [redmine: #221461]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO