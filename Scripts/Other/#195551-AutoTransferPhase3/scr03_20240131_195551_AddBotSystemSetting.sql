/*<info serverAlias="DBAGE-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240126
	Task:  Alpha - Automate Transfer Enhancement Phase 3 [Redmine: #199951]
	DB: DBAGE/bodb_ChatBot
*/

DECLARE @ServiceName VARCHAR(200) = 'AutoTransferAlert'

DECLARE @SendLastNotificationId			VARCHAR(1000)
		,@SendLastNotificationIdUAT		VARCHAR (1000)

SELECT @SendLastNotificationId = value 
FROM BotSystemSetting (NOLOCK)
WHERE ServiceName = 'AbnormalLoginAlert' AND SettingName = 'SendLastNotificationId'

SELECT @SendLastNotificationIdUAT = value 
FROM BotSystemSetting (NOLOCK)
WHERE ServiceName = 'AbnormalLoginAlert' AND SettingName = 'SendLastNotificationIdUAT'

INSERT INTO BotSystemSetting(ServiceName, SettingName, Value)
	SELECT  @ServiceName, 'BatchSize', '5000' UNION ALL
	SELECT  @ServiceName, 'JobStatus', 'Completed' UNION ALL
	SELECT  @ServiceName, 'JobStatusUAT', 'Completed' UNION ALL
	SELECT  @ServiceName, 'LastRuntime', '2024-03-28' UNION ALL
	SELECT  @ServiceName, 'LastRuntimeUAT', '2024-03-28' UNION ALL
	SELECT  @ServiceName, 'ServiceFlag', '1' UNION ALL
	SELECT  @ServiceName, 'ServiceFlagUAT', '1' UNION ALL
	SELECT  @ServiceName, 'MaxLogId', '0' UNION ALL
	SELECT  @ServiceName, 'MaxLogIdUAT', '0' UNION ALL
	SELECT  @ServiceName, 'IncludeRealCurrencyUAT', '0' UNION ALL
	SELECT  @ServiceName, 'SendLastNotificationId', @SendLastNotificationId UNION ALL
	SELECT  @ServiceName, 'SendLastNotificationIdUAT', @SendLastNotificationIdUAT UNION ALL
	SELECT  @ServiceName, 'SyncSettingPRO', '0' 
