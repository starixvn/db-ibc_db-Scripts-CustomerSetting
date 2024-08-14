/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20240513@Tacy
	Task: CustCategoryHistory - Create nonclustered index [Redmine: #204089]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

CREATE NONCLUSTERED INDEX [IX_CustCategoryHistory_CustID_CC] ON [dbo].[CustCategoryHistory]
(
	[custid] ASC,
	[CustomerClass] ASC
)
GO