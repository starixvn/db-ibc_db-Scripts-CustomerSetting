/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: Eden@20210617
	Task: Add new columns into Cust_ArchiveAccount [Redmine: #157123]   
	DB: DBCUST/bodb_Licensee
*/

USE CustDB
GO
ALTER TABLE dbo.Cust_ArchiveAccount 
ADD AccountDeletedDate DATETIME NULL,
	Username VARCHAR(30) NULL,
	Lastlogged  DATETIME
GO