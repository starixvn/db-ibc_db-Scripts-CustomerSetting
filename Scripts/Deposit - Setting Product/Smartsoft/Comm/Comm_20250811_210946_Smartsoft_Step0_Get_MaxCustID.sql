/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
        Created: Tacy@20250811
        Task: Get MaxCustID [redmine: #210946]
        DB: DBCUST/CustDB
*/
USE CustDB
GO

SELECT MAX(custid) FROM custinfo WITH(NOLOCK)
GO