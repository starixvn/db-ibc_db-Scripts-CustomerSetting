/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20230308@Tacy
	Task: Update SiteLabel on table Age_DomainList
		 https://nexdev.net/issues/181596 [RedmineID: #181596]
	Database: DBCUST/CustDB
*/

USE CustDB
GO

UPDATE d
SET SiteLabel=CASE WHEN SiteLabel='IBCBET' THEN 'Nova88' ELSE 'IBC' END
FROM Age_DomainList d WITH(ROWLOCK, UPDLOCK)
WHERE SiteLabel IN ('IBCBET','IBCIndo')