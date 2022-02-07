/*<info serverAlias="DBCRM-bodb_CRM"></info>*/
/*
	Created: 20220207@Elodie
	Task : config setting for Auto void fb CRM [redmine:#168254]
	DB: DBCRM/bodb_CRM
*/



USE [bodb_CRM]
GO
	

UPDATE m 
SET IsProcessedUAT = 0
FROM crmVoidingMessage m WITH(UPDLOCK,ROWLOCK)
WHERE MessageId = 1457088	

