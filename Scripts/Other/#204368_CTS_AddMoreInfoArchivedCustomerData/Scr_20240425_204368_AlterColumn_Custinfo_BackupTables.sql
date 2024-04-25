/*<info serverAlias="DBARCCUST-Bodb_Archive_Customer_Licensee"></info>*/
/*
	Created: 20240425@Eden
	Task: Add column ArchivedDate into Bodb_Archive_Customer_Licensee.dbo.Custinfo table - support CTS request [Redmine: #204368]
	DB: DBARCCUST-Bodb_Archive_Customer_Licensee 
*/ 

--Deposit table
USE Bodb_Archive_Customer_Licensee
GO
ALTER TABLE Custinfo ADD ArchivedDate DATETIME NULL CONSTRAINT DF_custInfo_ArchivedDate DEFAULT(GETDATE())
GO
CREATE NONCLUSTERED INDEX ix_Custinfo_ArchivedDate ON Custinfo(ArchivedDate) WITH (ONLINE=ON)

/*
DROP INDEX Custinfo.ix_Custinfo_ArchivedDate
ALTER TABLE Custinfo  DROP CONSTRAINT  DF_custInfo_ArchivedDate
ALTER TABLE Custinfo  DROP COLUMN  ArchivedDate
*/