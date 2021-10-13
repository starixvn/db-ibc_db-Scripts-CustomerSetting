/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20210908@Winfred
	Task : Update setting crmVoidingMessage setting for Amendment Notification  CRM [redmine:#157481]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO

UPDATE crmVoidingMessage WITH(UPDLOCK,ROWLOCK)
SET IsProcessed = 1 , IsProcessedUAT = 1

	

