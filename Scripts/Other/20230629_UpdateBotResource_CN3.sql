/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230425@Elodie
	Task: Notify abnormal login via Telegram chatbot for BotResource [#RedmineID:#183746]
	DB: DBBOT/bodb_Chatbot
*/
-------------------------------------------
USE bodb_ChatBot
GO

--add botResource
;WITH T AS(
	  SELECT  'Function_Name' ResourceName,	'20' ResourceKey,	'en-US'	Language,	N'Abnormal Login Alert' Value
UNION SELECT  'Function_Name'			  ,	'20'			,	'vi-VN'			,	N'Cảnh báo đăng nhập lạ'
UNION SELECT  'Function_Description'	  ,	'20'			,	'en-US'			,	N'Notify for suspicious account login activities.'
UNION SELECT  'Function_Description'	  ,	'20'			,	'vi-VN'			,	N'Thông báo hoạt động đăng nhập bất thường.'
UNION SELECT  'Action_Name'				  ,	'49'			,	'en-US'			,	N'Abnormal Login Alert'
UNION SELECT  'Action_Name'				  ,	'49'			,	'vi-VN'			,	N'Cảnh báo đăng nhập lạ'
UNION SELECT  'Action_Description'		  ,	'49'			,	'en-US'			,	N'Notify for suspicious account login activities.'
UNION SELECT  'Action_Description'		  ,	'49'			,	'vi-VN'			,	N'Thông báo hoạt động đăng nhập bất thường.'
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

select top 100 * from BotResource with(nolock)where ResourceKey IN (20,49) AND Language = 'vi-VN'--DELETE from BotResource where ResourceKey IN (20,49) AND Language = 'vi-VN'