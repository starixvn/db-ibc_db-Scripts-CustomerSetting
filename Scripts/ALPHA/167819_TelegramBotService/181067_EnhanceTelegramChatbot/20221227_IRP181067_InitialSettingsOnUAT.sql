/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221227@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#181067]
	DB: DBBOT/bodb_Chatbot
*/

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
SELECT 17, 'Risk Alert', 'RiskAlert', 2, NULL, 1, 103, NULL, NULL
GO

-------------------------------------------
--add new botAction	
INSERT INTO [dbo].[BotAction]
           ([ActionID]
           ,[ActionName]
           ,[Type]
           ,[Command]
           ,[FunctionID]
           ,[ParentID]
           ,[Status]
           ,[IsEndAction]
           ,[Order])
SELECT 45 ActionID,	'Risk Alert' ActionName, 1 Type, '17' Command, 17 FunctionID, 26 ParentID, 1 Status, 1 IsEndAction, 5002 [Order]
GO
		
-----------------------------------------------------
--add botResource
;WITH T AS(
SELECT 	'Action_Name'	ResourceName,	'45'	ResourceKey,	'en-US'	Language,	N'Risk Alert' Value
UNION SELECT 'Function_Description', '17', 'en-US', N'Alert to your Telegram whenever winloss reached your configurations on Risk Management functions'
UNION SELECT 'Function_Name', '17', 'en-US', N'Risk Alert'
)	
INSERT INTO [dbo].[BotResource]
           ([ResourceName]
           ,[ResourceKey]
           ,[Language]
           ,[Value])
SELECT ResourceName, ResourceKey, Language, Value
FROM T
GO

--initial setting for linked accounts UUS on UAT
INSERT INTO [dbo].[CustBotFunction]
           ([UserID]
           ,[FunctionID]
           ,[Status])
SELECT c.[UserID]
        ,t.[FunctionID]
        ,c2.Status
FROM CustBotAccount c WITH(NOLOCK)
INNER JOIN bodb02.dbo.custinfo ci WITH(NOLOCK) ON c.custid = ci.custid
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
	AND ci.currency = 20					