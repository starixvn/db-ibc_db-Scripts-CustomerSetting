/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: 04. Deactive: Site='789y' 
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE s
SET s.isActive=0
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE siteid=3