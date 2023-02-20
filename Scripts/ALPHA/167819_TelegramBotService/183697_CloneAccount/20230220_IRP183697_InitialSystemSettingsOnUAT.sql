/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230220@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#183697]
	DB: DBBOT/bodb_Chatbot
*/

--update BotFunction
UPDATE BotFunction WITH(ROWLOCK)
SET [Order] = 201
WHERE FunctionID = 12 --Settings
GO

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
SELECT 18, 'Customer Setting', 'CustomerSetting', 1, '/cs', 1, 200, NULL, NULL
GO
	
--Update BotAction
UPDATE BotAction WITH(ROWLOCK)
SET [Order] = 6
WHERE ActionID = 11	--Settings
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
SELECT 46 ActionID,	'Customer Setting' ActionName, 1 Type, '/cs' Command, 18 FunctionID, 0 ParentID, 1 Status, 0 IsEndAction, 5 [Order]
UNION SELECT 47, 'New Customer(s)', 4, 'NULL', 18, 46, 1, 1, 601
GO

	
-----------------------------------------------------
--add botResource
;WITH T AS(
SELECT 	'Function_Name'	ResourceName,	'18'	ResourceKey,	'en-US'	Language,	N'Customer Setting' Value
UNION SELECT 'Action_Name', '46', 'en-US', 'Customer Setting'
UNION SELECT 'Action_Name', '47', 'en-US', 'New Customer(s)'
)	
INSERT INTO [dbo].[BotResource]
           ([ResourceName]
           ,[ResourceKey]
           ,[Language]
           ,[Value])
SELECT ResourceName, ResourceKey, Language, Value
FROM T
GO
