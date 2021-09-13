
/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created: Eden@20210913
	Task: Create Index for ArchiveDate of backup table of Credit and deposit [Redmine: #159611]   
	DB: DBARCCUST/bodb_Customer , DBARCCUST/bodb02
*/
--Credit
USE bodb_Customer
GO
CREATE NONCLUSTERED INDEX ix_CustInfo_Old_ArchiveDate ON CustInfo_Old(ArchiveDate)

--Deposit
USE bodb02
GO
CREATE NONCLUSTERED INDEX ix_Dep_Customer_Archived_ArchiveDate ON Dep_Customer_Archived(ArchivedDate)

