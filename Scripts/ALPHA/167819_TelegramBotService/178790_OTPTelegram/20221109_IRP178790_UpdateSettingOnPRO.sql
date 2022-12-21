/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221110@Johnson
	Task: update config on PRO for new function OTP [#RedmineID:#179780]
	DB: DBBOT/bodb_Chatbot
*/

UPDATE b
SET Status = 0
FROM BotAction b WITH(ROWLOCK)
WHERE ActionID IN (43)
GO

UPDATE b
SET Status = 0
FROM BotFunction b WITH(ROWLOCK)
WHERE FunctionID IN (15)
GO

--initial setting for newly linked accounts
INSERT INTO [dbo].[CustBotFunction]
           ([UserID]
           ,[FunctionID]
           ,[Status])
SELECT [UserID]
        ,[FunctionID]
        ,0
from CustBotAccount c WITH(NOLOCK)
CROSS APPLY (SELECT 15 as FunctionID			
			) t
WHERE NOT EXISTS (SELECT 1 FROM custBotFunction cf WITH(NOLOCK)
				WHERE c.UserId = cf.UserID
					AND t.FunctionID = cf.FunctionID)