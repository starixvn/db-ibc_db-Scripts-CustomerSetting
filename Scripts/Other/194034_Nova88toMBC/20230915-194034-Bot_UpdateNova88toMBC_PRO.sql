/*<info serverAlias="DBBOT-bodb_chatbot"></info>*/
/*	
	Created: 20230915@Tacy
	Task: Support to update SiteLabel for MBC on PRO
		 https://nexdev.net/issues/194034 [RedmineID: #194034]
	DB: DBBOT-bodb_chatbot
*/
USE bodb_ChatBot
GO

UPDATE b
SET B.System = 'MBC'
FROM Bot b WITH (ROWLOCK, UPDLOCK)
WHERE System IN ('Nova88')
GO