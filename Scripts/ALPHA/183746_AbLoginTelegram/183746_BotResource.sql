/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20230425@Winfred
	Task: Notify abnormal login via Telegram chatbot for BotResource [#RedmineID:#183746]
	DB: DBBOT/bodb_Chatbot
*/
-------------------------------------------
--add botResource
;WITH T AS(
	  SELECT  'Function_Name' ResourceName,	'20' ResourceKey,	'en-US'	Language,	N'Abnormal Login Alert' Value
UNION SELECT  'Function_Name'			  ,	'20'			,	'zh-Hans'		,	N'登入异常提示'
UNION SELECT  'Function_Name'			  ,	'20'			,	'zh-Hant'		,	N'登入異常提示'
UNION SELECT  'Function_Name'			  ,	'20'			,	'th-TH'			,	N'แจ้งเตือนการเข้าสู่ระบบที่ผิดปกติ '
UNION SELECT  'Function_Description'	  ,	'20'			,	'en-US'			,	N'Notify for suspicious account login activities.'
UNION SELECT  'Function_Description'	  ,	'20'			,	'zh-Hans'		,	N'通知可疑账号登入行为。'
UNION SELECT  'Function_Description'	  ,	'20'			,	'zh-Hant'		,	N'通知可疑賬號登入行為。'
UNION SELECT  'Function_Description'	  ,	'20'			,	'th-TH'			,	N'แจ้งเตือนพฤติกรรมการเข้าสู่ระบบที่น่าสงสัย'
UNION SELECT  'Action_Name'				  ,	'49'			,	'en-US'			,	N'Abnormal Login Alert'
UNION SELECT  'Action_Name'				  ,	'49'			,	'zh-Hans'		,	N'登入异常提示'
UNION SELECT  'Action_Name'				  ,	'49'			,	'zh-Hant'		,	N'登入異常提示'
UNION SELECT  'Action_Name'				  ,	'49'			,	'th-TH'			,	N'แจ้งเตือนการเข้าสู่ระบบที่ผิดปกติ '
UNION SELECT  'Action_Description'		  ,	'49'			,	'en-US'			,	N'Notify for suspicious account login activities.'
UNION SELECT  'Action_Description'		  ,	'49'			,	'zh-Hans'		,	N'通知可疑账号登入行为。'
UNION SELECT  'Action_Description'		  ,	'49'			,	'zh-Hant'		,	N'通知可疑賬號登入行為。'
UNION SELECT  'Action_Description'		  ,	'49'			,	'th-TH'			,	N'แจ้งเตือนพฤติกรรมการเข้าสู่ระบบที่น่าสงสัย'
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

--UPDATE BotSystemSetting SET Value = '0' WHERE ServiceName  = 'AbnormalLoginAlert' AND (SettingName = 'MaxLogId' OR SettingName = 'MaxLogIdUAT' )
