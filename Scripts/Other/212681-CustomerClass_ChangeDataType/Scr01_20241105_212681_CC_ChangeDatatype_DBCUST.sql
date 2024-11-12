/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241105
	Task: Apply new range CC for SMA 
		CategoryConfig & CustCategoryHistory >> Change column datatype SMALLINT --> INT  [Redmine:#212681] 
	DB:	DBCUST-CustDB
*/

USE CustDB
GO

--CategoryConfig
ALTER TABLE CategoryConfig ALTER COLUMN CustomerClass INT
GO

--CustCategoryHistory
DROP INDEX CustCategoryHistory.IX_CustCategoryHistory_CustID_CC --created on #204089, but unused
GO 

ALTER TABLE CustCategoryHistory ALTER COLUMN CategoryID INT
GO
ALTER TABLE CustCategoryHistory ALTER COLUMN CustomerClass INT
GO
ALTER TABLE CustCategoryHistory ALTER COLUMN OldCustomerClass INT
GO