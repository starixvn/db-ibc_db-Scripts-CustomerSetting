/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230425@Winfred
	Task: Notify abnormal login via Telegram chatbot [#RedmineID:#183746]
	DB: DBBOT/bodb_Chatbot
*/
	
-------------------------------------------
--initial setting for linked accounts
INSERT INTO [dbo].[CustBotFunction]
           ([UserID]
           ,[FunctionID]
           ,[Status])
SELECT [UserID]
        ,[FunctionID]
        ,1
from CustBotAccount c WITH(NOLOCK)
CROSS APPLY (SELECT 20 as FunctionID) t
WHERE NOT EXISTS (SELECT 1 FROM custBotFunction cf WITH(NOLOCK)
				WHERE c.UserId = cf.UserID
					AND t.FunctionID = cf.FunctionID)
