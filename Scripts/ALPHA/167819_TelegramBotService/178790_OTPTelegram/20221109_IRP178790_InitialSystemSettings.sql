/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221109@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#178790]
	DB: DBBOT/bodb_Chatbot
*/

-----------------------------------------------------
--add new functions

;WITH T AS (
SELECT  15 FunctionID, 'OTP' FunctionName, 'OTP' FunctionKey, 2 Type, NULL Command,	1 Status, 109 [Order], NULL Priority
)
INSERT INTO [dbo].[BotFunction]
           ([FunctionID]
           ,[FunctionName]
           ,[FunctionKey]
           ,[Type]
           ,[Command]
           ,[Status]
           ,[Order]
           ,[Priority])
SELECT [FunctionID]
	   ,[FunctionName]
	   ,[FunctionKey]
	   ,[Type]
	   ,[Command]
	   ,[Status]
	   ,[Order]
	   ,[Priority]
FROM T		   
GO
	
-------------------------------------------
--add new botAction	
;WITH T AS (
SELECT 43 ActionID,	'OTP' ActionName, 1 Type, 15 Command, 15 FunctionID, 26 ParentID, 1 Status, 1 IsEndAction, 5010 [Order]
)
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
SELECT [ActionID]
	   ,[ActionName]
	   ,[Type]
	   ,[Command]
	   ,[FunctionID]
	   ,[ParentID]
	   ,[Status]
	   ,[IsEndAction]
	   ,[Order]
FROM T  
GO


-----------------------------------------------------
--add botResource
;WITH T AS(
SELECT 	'Function_Name'	ResourceName,	'15'	ResourceKey,	'en-US'	Language,	N'OTP' Value
UNION SELECT 	'Function_Description'	,	'15'	,	'en-US'	,	N'Receive OTP via your Telegram chatbot'
UNION SELECT 	'Action_Name'	,	'15'	,	'en-US'	,	N'OTP'
)
MERGE BotResource as Target
USING (SELECT * FROM T) as Source 
ON Target.ResourceName = Source.ResourceName
	AND Target.ResourceKey = Source.ResourceKey
	AND Target.Language = Source.Language
WHEN MATCHED THEN UPDATE SET Target.VALUE = Source.Value	
WHEN NOT MATCHED THEN 
	INSERT ([ResourceName]
		   ,[ResourceKey]
		   ,[Language]
		   ,[Value])
	VALUES(Source.ResourceName,Source.ResourceKey,Source.Language,Source.Value);
GO

--initial setting for linked accounts
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
