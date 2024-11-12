/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created by: Tacy@20241105
	Task: Apply new range CC for SMA 
		CustCategoryHistory_Old >> Change column datatype SMALLINT --> INT  [Redmine:#212681] 
	DB:	DBLOG-bodb_CustomerLog
*/

USE bodb_CustomerLog
GO

--CustCategoryHistory_Old
ALTER TABLE CustCategoryHistory_Old ALTER COLUMN CategoryID INT
GO
ALTER TABLE CustCategoryHistory_Old ALTER COLUMN CustomerClass INT
GO