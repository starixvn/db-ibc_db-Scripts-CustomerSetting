/*<info serverAlias="DBMSG-bodb_Message"></info>*/
/*
	Created: 20230915@Tacy
	Task: Support to update SiteLabel for MBC
		 https://nexdev.net/issues/194034 [RedmineID: #194034]

	Database: DBMSG-bodb_Message
*/

USE bodb_Message
GO

UPDATE a
SET a.Systems = REPLACE(a.Systems, 'Nova88', 'MBC')
FROM Announcements a WITH (ROWLOCK, UPDLOCK)
WHERE Systems LIKE '%Nova88%'
GO