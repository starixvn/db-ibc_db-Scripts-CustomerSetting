/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230915@Tacy
	Task: Support to update SiteLabel for MBC
		 https://nexdev.net/issues/194034 [RedmineID: #194034]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE s
SET s.SiteLabel='MBC',
	s.RepUpdateTime=sysdatetime()
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE SiteLabel='Nova88'
GO