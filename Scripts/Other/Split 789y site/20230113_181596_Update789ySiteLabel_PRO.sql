/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230113@Tacy
	Task: Update 789y's SiteLabel on PRO
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE s
SET s.SiteLabel = '789y'
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE site='789y'