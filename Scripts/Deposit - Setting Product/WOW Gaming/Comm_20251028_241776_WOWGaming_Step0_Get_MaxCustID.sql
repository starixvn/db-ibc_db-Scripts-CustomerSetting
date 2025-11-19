/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
        Created: Tacy@20251028
        Task: Get MaxCustID [redmine: #241776]
        DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO