/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20240409@Kelvin	
	Task: Set up config TotalBets function [Redmine: #202421]
	DB: DBBOT/bodb_Chatbot
*/

--Check if existed [FunctionID] = 24 -> RETURN
IF EXISTS (SELECT TOP 1 1 FROM [BotFunction](NOLOCK) WHERE [FunctionID] = 24 AND [FunctionKey] <> 'TotalBets')
BEGIN
	RAISERROR('FunctionID 24 is existed! Please check with DEV.',16,1)
	RETURN
END
GO

--BotFunction
DELETE FROM [BotFunction] WHERE [FunctionID] = 24 AND [FunctionKey] = 'TotalBets'

;WITH T AS (
SELECT  24 [FunctionID], 'Total Bets' [FunctionName], 'TotalBets' [FunctionKey], 1 [Type], NULL [Command], 1 [Status], 113 [Order], NULL [Priority], NULL [ParentID]
)
INSERT INTO [dbo].[BotFunction]
           ([FunctionID]
           ,[FunctionName]
           ,[FunctionKey]
           ,[Type]
           ,[Command]
           ,[Status]
           ,[Order]
           ,[Priority]
           ,[ParentID])
SELECT [FunctionID]
	   ,[FunctionName]
	   ,[FunctionKey]
	   ,[Type]
	   ,[Command]
	   ,[Status]
	   ,[Order]
	   ,[Priority]
	   ,[ParentID]
FROM T
GO

--CustBotFunction
INSERT INTO [dbo].[CustBotFunction]
           ([UserID]
           ,[FunctionID]
           ,[Status])
SELECT   [UserID]
        ,24 [FunctionID]
        ,0
FROM CustBotAccount c WITH(NOLOCK)
CROSS APPLY (SELECT 24 as FunctionID			
			) t
WHERE NOT EXISTS (SELECT 1 FROM custBotFunction cf WITH(NOLOCK)
					WHERE c.UserId = cf.UserID
					AND t.FunctionID = cf.FunctionID)
GO

--BotResource
DELETE FROM [BotResource] WHERE [ResourceName] = 'Action_Name' AND [ResourceKey] = 24

INSERT INTO [dbo].[BotResource]
           ([ResourceName]
           ,[ResourceKey]
           ,[Language]
           ,[Value])
VALUES 
('Action_Name', 24, 'en-US', 'Total Bets')
,('Action_Name', 24, 'th-TH', 'Total Bets')
,('Action_Name', 24, 'zh-Hans', 'Total Bets')
,('Action_Name', 24, 'zh-Hant', 'Total Bets')


