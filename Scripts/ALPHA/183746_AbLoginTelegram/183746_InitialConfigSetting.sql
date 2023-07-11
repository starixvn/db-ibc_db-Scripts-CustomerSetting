/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230425@Winfred
	Task: Notify abnormal login via Telegram chatbot [#RedmineID:#183746]
	DB: DBBOT/bodb_Chatbot
*/
	
-------------------------------------------
--add new botAction	
;WITH T AS (
SELECT 49 ActionID,	'Abnormal Login Alert' ActionName, 1 Type, 20 Command, 20 FunctionID, 26 ParentID, 1 Status, 1 IsEndAction, 5011 [Order]
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
--add new functions

;WITH T AS (
SELECT  20 FunctionID, 'Abnormal Login Alert' FunctionName, 'AbnormalLoginAlert' FunctionKey, 1 Type, NULL Command,	1 Status, 110 [Order], 9 Priority
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


------------------------------------------------------
--add system setting for service 'SystemAnnouncement'

INSERT INTO BotSystemSetting (ServiceName, SettingName, Value)
SELECT ServiceName, SettingName, Value
FROM (
	VALUES 
		('AbnormalLoginAlert','BatchSize','5000')
		,('AbnormalLoginAlert','JobStatus','Completed')
		,('AbnormalLoginAlert','JobStatusUAT','Completed')
		,('AbnormalLoginAlert','LastRuntime','2023-05-17')
		,('AbnormalLoginAlert','LastRuntimeUAT','2023-05-17')
		,('AbnormalLoginAlert','ServiceFlag','1')
		,('AbnormalLoginAlert','ServiceFlagUAT','1')
		,('AbnormalLoginAlert','MaxLogId','0')
		,('AbnormalLoginAlert','MaxLogIdUAT','0')
		,('AbnormalLoginAlert','IncludeRealCurrencyUAT','0')
		,('AbnormalLoginAlert','SendLastNotificationId','0')
		,('AbnormalLoginAlert','SendLastNotificationIdUAT','0')
		,('AbnormalLoginAlert','SyncSettingPRO','0')
) n (ServiceName, SettingName, Value)

-----------------------------------------------------
--add botResource
;WITH T AS(
	  SELECT  'Function_Name' ResourceName,	'20' ResourceKey,	'en-US'	Language,	N'Abnormal Login Alert' Value
UNION SELECT  'Action_Name'				  ,	'49'			,	'en-US'			,	N'Abnormal Login Alert'
UNION SELECT  'Function_Description'	  ,	'20'			,	'en-US'			,	N'Notify Abnormal Login Action'
UNION SELECT  'Action_Description'		  ,	'49'			,	'en-US'			,	N'Notify Abnormal Login Action'
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
        ,1
from CustBotAccount c WITH(NOLOCK)
CROSS APPLY (SELECT 20 as FunctionID) t
WHERE NOT EXISTS (SELECT 1 FROM custBotFunction cf WITH(NOLOCK)
				WHERE c.UserId = cf.UserID
					AND t.FunctionID = cf.FunctionID)
