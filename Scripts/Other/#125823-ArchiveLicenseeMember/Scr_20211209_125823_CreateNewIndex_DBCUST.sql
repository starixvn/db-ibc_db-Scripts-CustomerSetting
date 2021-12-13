/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
    Created: Eden@20211209
    Task: Create index for Dep_Customer_Archived table
    DB: DBCUST/CustDB
*/ 

USE CustDB
GO
CREATE NONCLUSTERED INDEX ix_Dep_Customer_Archived_status_Date
ON Dep_Customer_Archived(status,ArchivedDate,CustID) INCLUDE (CustIDBalanceDummy,ClosingBalance,recommend)