/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20211216@Winfred
	Task : config setting for Amendment Notification  CRM UAT [redmine:#163833]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

UPDATE CRMMESSAGEIMPORT WITH(UPDLOCK,ROWLOCK)
SET ISPROCESSED = 1
WHERE MessageID > 1433281 AND ISPROCESSED =0

