/*<info serverAlias="DBARCCUST-Bodb_Archive_Customer_Licensee"></info>*/
/*
    Created: 20250515@Tacy
	Task: Rollback custinfo/customer - SWSiteUUS01013 [#226916]
	DB: DBARCCUST-Bodb_Archive_Customer_Licensee
*/
USE Bodb_Archive_Customer_Licensee
GO

DELETE FROM custInfo WITH (ROWLOCK) WHERE custid=64008503
GO

DELETE FROM Customer WITH (ROWLOCK) WHERE custid=64008503
GO
