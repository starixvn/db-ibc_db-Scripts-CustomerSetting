/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created by: Tacy@20241105
	Task: New range CC for SMA - Update HiddenSite [Redmine:#212681] 
	DB:	DBCUST-CustDB
*/

USE CustDB
GO

UPDATE cc
SET cc.HiddenSite=1
FROM CategoryConfig cc WITH (ROWLOCK, UPDLOCK)
WHERE cc.CategoryID IN (32700, 32707, 32708, 32715)
GO