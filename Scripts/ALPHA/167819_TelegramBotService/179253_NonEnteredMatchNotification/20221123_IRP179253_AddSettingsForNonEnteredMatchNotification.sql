/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221123@Johnson
	Task: Initial system settings for chatbot [#RedmineID:#179253]
	DB: DBBOT/bodb_Chatbot
*/


-------------------------------------------
--add new botAction	
;WITH T AS (
SELECT 44 ActionID,	'Non-Entered Matches' ActionName, 1 Type, 'ne' Command, 4 FunctionID, 4 ParentID, 1 Status, 1 IsEndAction, 404 [Order]
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
SELECT 	'Action_Name'	ResourceName,	'44'	ResourceKey,	'en-US'	Language,	N'Non-Entered Matches' Value
)	
INSERT INTO [dbo].[BotResource]
           ([ResourceName]
           ,[ResourceKey]
           ,[Language]
           ,[Value])
SELECT ResourceName, ResourceKey, Language, Value
FROM T
