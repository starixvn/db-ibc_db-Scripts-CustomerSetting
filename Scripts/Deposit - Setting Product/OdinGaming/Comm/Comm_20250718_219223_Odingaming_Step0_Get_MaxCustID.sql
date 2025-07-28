/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
        Created: Tacy@20250718
        Task: Get MaxCustID [redmine: #219223]
        DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO