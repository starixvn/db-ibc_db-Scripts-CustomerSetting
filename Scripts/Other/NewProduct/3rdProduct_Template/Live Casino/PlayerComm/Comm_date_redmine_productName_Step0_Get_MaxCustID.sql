/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: {Nickname}@{date}
	Task: Get MaxCustID [redmine: #xxx]
	DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO
