/*<info serverAlias="DBAGE-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240126
	Task:  Alpha - Automate Transfer Enhancement Phase 3 [Redmine: #199951]
	DB: DBAGE/bodb_ChatBot
*/

use bodb_ChatBot
go

UPDATE f
SET f.Status = 0
FROM BotFunction f WITH (ROWLOCK, UPDLOCK)
WHERE FunctionID IN (21,22)

UPDATE a
SET a.Status = 0
FROM BotAction a WITH (ROWLOCK, UPDLOCK)
WHERE ActionID IN (50,51,52,53)