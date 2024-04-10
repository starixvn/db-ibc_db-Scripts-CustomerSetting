﻿/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240126
	Task:  Alpha - Automate Transfer Enhancement Phase 3 [Redmine: #199951]
	DB: DBBOT/bodb_ChatBot
*/

UPDATE a 
SET a.[Order] = 10 
FROM BotAction a WITH (ROWLOCK, UPDLOCK)
WHERE a.ActionID = 11 --Settings
