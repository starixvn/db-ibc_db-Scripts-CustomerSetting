/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241119
	Task: CustCategoryHistory >> add column OldCategoryID [Redmine:#212681] 
	DB:	DBCUST-CustDB
*/

USE CustDB
GO

ALTER TABLE CustCategoryHistory ADD OldCategoryID INT
GO