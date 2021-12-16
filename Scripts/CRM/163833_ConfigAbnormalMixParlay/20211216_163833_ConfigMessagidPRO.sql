/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20211216@Winfred
	Task : config setting for Amendment Notification  CRM UAT [redmine:#163833]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

UPDATE crmMessageImport WITH(UPDLOCK,ROWLOCK)
SET IsProcessed = 1
WHERE MessageID IN (1433303,1433304,1433308,1433312,1433313,1433314,1433316,1433317,1433324) AND IsProcessed =0

