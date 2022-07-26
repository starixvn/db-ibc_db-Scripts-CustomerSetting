/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220621@Johnson
	Task: update database structure for telegram bot service [#RedmineID:#165682]
	DB: DBBOT/bodb_Chatbot
*/
--20220628: update displayName bot UAT

UPDATE bot WITH(ROWLOCK)
SET DisplayName = username
WHERE IsTest = 1

/*
--20220624: add column Bot
EXEC sp_rename 'Bot.Name','username'
GO

ALTER TABLE Bot ADD DisplayName VARCHAR(200)

;WITH T AS (
	SELECT 'Elsa9Bot' as username, 'Elsa' as DisplayName
	UNION SELECT 'Eva88Bot', 'Eva'
	UNION SELECT 'Eden9Bot', 'Eden'
)
UPDATE b
SET DisplayName = t.DisplayName
FROM Bot b WITH(ROWLOCK)
	INNER JOIN T ON b.username = t.username
*/
	
/*
--20220621: ADD UpdatedTime
ALTER TABLE [CustBotMessenger] ADD UpdatedTime DATETIME 
*/