/*
	Created: 20200807@Johnson
	Task: data patch for missing crm feedback
	DB: DBCRM/bodb_CRM
*/

UPDATE crmMessageImport WITH(UPDLOCK,ROWLOCK)
SET isProcessed = 0		
WHERE MessageID = 966948