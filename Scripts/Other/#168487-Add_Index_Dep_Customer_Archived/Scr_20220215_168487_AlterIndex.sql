/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20220215
	Task: Alter index IX_Username include Recommend [Redmine: #168487]   
	DB: DBARCCUST/bodb_Customer
*/
USE CUSTDB
GO
CREATE NONCLUSTERED INDEX IX_Username ON Dep_Customer_Archived(Username ASC)
INCLUDE(Recommend) WITH (DROP_EXISTING = ON, ONLINE=ON)
GO