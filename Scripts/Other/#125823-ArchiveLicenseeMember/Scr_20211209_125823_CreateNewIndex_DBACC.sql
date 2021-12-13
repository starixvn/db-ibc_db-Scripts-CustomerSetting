/*<info serverAlias="DBACC-bodb02"></info>*/
/*
    Created: Eden@20211209
    Task: Create index for Dep_Customer_Archived table
    DB: DBACC/bodb02
*/ 

USE bodb02
GO
CREATE NONCLUSTERED INDEX ix_Dep_Customer_Archived_status ON Dep_Customer_Archived(status)