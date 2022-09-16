/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20220822@Johnson
	Task: Enable new notification functions for newly customer linked accounts [#RedmineID:#165682]
	DB: DBBOT/bodb_Chatbot
*/

UPDATE b
SET Status = 0
FROM BotAction b WITH(ROWLOCK)
WHERE ActionID IN (33,41)
GO

UPDATE b
SET Status = 0
FROM BotFunction b WITH(ROWLOCK)
WHERE FunctionID IN (11,13)
GO

--initial setting for newly linked accounts
INSERT INTO [dbo].[CustBotFunction]
           ([UserID]
           ,[FunctionID]
           ,[Status])
SELECT [UserID]
        ,[FunctionID]
        ,1
from CustBotAccount c WITH(NOLOCK)
CROSS APPLY (SELECT 11 as FunctionID
			UNION SELECT 13 
			) t
WHERE NOT EXISTS (SELECT 1 FROM custBotFunction cf WITH(NOLOCK)
				WHERE c.UserId = cf.UserID
					AND t.FunctionID = cf.FunctionID)