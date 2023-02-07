/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221227@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#181067]
	DB: DBBOT/bodb_Chatbot
*/

UPDATE BotFunction WITH(ROWLOCK)
SET [Order] = 0,
	ParentID = 17
WHERE FunctionID IN (8,14)
GO

UPDATE BotFunction WITH(ROWLOCK)
SET [Status] = 0
WHERE FunctionID IN (17)
GO

UPDATE BotAction WITH(ROWLOCK)
SET [Status] = 2
WHERE ActionID IN (30,42)
GO

UPDATE BotAction WITH(ROWLOCK)
SET [Status] = 0
WHERE ActionID IN (45)
GO

--initial setting for linked accounts Real
INSERT INTO [dbo].[CustBotFunction]
           ([UserID]
           ,[FunctionID]
           ,[Status])
SELECT c.[UserID]
        ,t.[FunctionID]
        ,c2.Status
FROM CustBotAccount c WITH(NOLOCK)
CROSS APPLY (SELECT 17 as FunctionID			
			) t
INNER JOIN (
			SELECT UserID, Max(CASE WHEN status = 0 THEN 0 ELSE 1 END) as Status
			FROM CustBotFunction WITH(NOLOCK)
			WHERE FunctionID IN (8,14)
			GROUP BY UserID 
		) c2 ON c.UserID = c2.UserID		
WHERE NOT EXISTS (SELECT 1 FROM custBotFunction cf WITH(NOLOCK)
				WHERE c.UserId = cf.UserID
					AND t.FunctionID = cf.FunctionID)
GO

DELETE CustBotFunction WITH(ROWLOCK)
WHERE FunctionID IN (8,14)				
					