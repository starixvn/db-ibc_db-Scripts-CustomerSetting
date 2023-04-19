/*<info serverAlias="DBBOT-bodb_chatbot"></info>*/
/*	
	Created: 20221201@Tacy
	Task: Update system's value on table [BOT] on UAT
	Redmine: https://nexdev.net/issues/181596
	DB: DBBOT-bodb_chatbot
*/
USE bodb_ChatBot
GO

UPDATE b
SET B.System = CASE WHEN b.System='IBCBET' THEN 'Nova88'
					WHEN b.System='IBCIndo' THEN 'IBC'
				END
FROM Bot b WITH (ROWLOCK, UPDLOCK)
WHERE System IN ('IBCBET','IBCIndo')
AND IsTest=1