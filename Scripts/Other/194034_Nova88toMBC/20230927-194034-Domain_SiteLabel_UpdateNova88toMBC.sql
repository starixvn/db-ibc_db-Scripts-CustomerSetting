/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230927@Tacy
	Task: Support to update SiteLabel for MBC
		 https://nexdev.net/issues/194034 [RedmineID: #194034]

	Database: DBCUST-CustDB
*/

USE CustDB
GO

UPDATE a
SET a.SiteLabel = 'MBC'
FROM Age_DomainList a WITH (ROWLOCK, UPDLOCK)
WHERE SiteLabel='Nova88'
GO