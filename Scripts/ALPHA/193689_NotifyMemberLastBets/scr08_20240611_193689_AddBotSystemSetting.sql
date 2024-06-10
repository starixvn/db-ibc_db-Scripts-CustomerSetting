/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240611
	Task:  Telegram Chatbot - Notify Member Last bets [Redmine: #193689]
	DB: DBBOT/bodb_ChatBot
*/

DECLARE @ServiceName VARCHAR(200) = 'LastBetsAlert'

DECLARE @SendLastNotificationId			VARCHAR(MAX)
		,@SendLastNotificationIdUAT		VARCHAR(MAX)

SELECT @SendLastNotificationId = value 
FROM BotSystemSetting (NOLOCK)
WHERE ServiceName = 'AutoTransferAlert' AND SettingName = 'SendLastNotificationId'

SELECT @SendLastNotificationIdUAT = value 
FROM BotSystemSetting (NOLOCK)
WHERE ServiceName = 'AutoTransferAlert' AND SettingName = 'SendLastNotificationIdUAT'

INSERT INTO BotSystemSetting(ServiceName, SettingName, Value)
	SELECT  @ServiceName, 'BatchSize', '5000' UNION ALL
	SELECT  @ServiceName, 'FilterLastTransId', NULL UNION ALL
	SELECT  @ServiceName, 'FilterLastTransIdUAT', NULL UNION ALL
	SELECT  @ServiceName, 'IncludeRealCurrencyUAT', '0' UNION ALL
	SELECT  @ServiceName, 'JobStatus', 'Completed' UNION ALL
	SELECT  @ServiceName, 'JobStatusUAT', 'Completed' UNION ALL
	SELECT  @ServiceName, 'LastRuntime', '2024-06-09' UNION ALL
	SELECT  @ServiceName, 'LastRuntimeUAT', '2024-06-09' UNION ALL
	SELECT  @ServiceName, 'MaxLogId', '0' UNION ALL
	SELECT  @ServiceName, 'MaxLogIdUAT', '0' UNION ALL
	SELECT  @ServiceName, 'SendLastNotificationId', @SendLastNotificationId UNION ALL
	SELECT  @ServiceName, 'SendLastNotificationIdUAT', @SendLastNotificationIdUAT UNION ALL
	SELECT  @ServiceName, 'ServiceFlag', '1' UNION ALL
	SELECT  @ServiceName, 'ServiceFlagUAT', '1' UNION ALL
	SELECT  @ServiceName, 'SyncSettingPRO', '0' 

