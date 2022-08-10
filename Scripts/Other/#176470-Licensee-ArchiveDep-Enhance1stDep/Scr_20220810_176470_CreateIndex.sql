/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20220810
	Task: Alter index [IX_recommend_custID] include [Username] [Redmine: #176470]   
	DB: DBCUST/CUSTDB
*/
USE CUSTDB
GO
CREATE NONCLUSTERED INDEX [IX_recommend_custID] ON Dep_Customer_Archived([Recommend] ASC, [CustID] ASC)
INCLUDE([Username]) WITH (ONLINE=ON) ON [table_customer]
GO

--DROP INDEX Dep_Customer_Archived.[IX_recommend_custID]