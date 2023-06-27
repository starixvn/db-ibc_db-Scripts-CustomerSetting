/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*	
	Created: 20230602@Eden
	Task: Create new index for Cust_ArchiveAccount table [#183447]
	DB: DBCUST/CUSTDB 
*/
GO
CREATE NONCLUSTERED INDEX IX_Cust_ArchiveAccount_Username ON Cust_ArchiveAccount(Username ASC)
GO
