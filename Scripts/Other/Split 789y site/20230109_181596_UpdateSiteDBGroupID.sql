/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20221221@Tacy
	Task: Update SiteDBGroupID
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/
USE CustDB
GO

UPDATE s
SET s.SiteDBGroupID = CASE WHEN siteid<>3 THEN 3 ELSE SiteDBGroupID END
FROM Site s WITH(UPDLOCK, ROWLOCK)
WHERE isLicensee=0