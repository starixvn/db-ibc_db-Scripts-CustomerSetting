/*<info serverAlias="DBBOT-bodb_ChatBot" executers="bodbDownlineNet" isFunction="0" isNested="0"></info>*/

/*
	Created: 20221124@Malcolm
	DB: DBBOT-bodb_ChatBot
	Task: Add Settings
*/

INSERT INTO BotSystemSetting (ServiceName, SettingName, Value)
SELECT ServiceName, SettingName, Value
FROM (
	VALUES 
		('YesterdayNonEntered','BatchSize','1000')
		,('YesterdayNonEntered','JobStatus','Completed')
		,('YesterdayNonEntered','JobStatusUAT','Completed')
		,('YesterdayNonEntered','LastRuntime','2022-05-01')
		,('YesterdayNonEntered','LastRuntimeUAT','2022-05-01')
		,('YesterdayNonEntered','ServiceFlag','1')
		,('YesterdayNonEntered','ServiceFlagUAT','1')
		,('YesterdayNonEntered','WinlostDate','2022-05-01')
		,('YesterdayNonEntered','WinlostDateUAT','2022-05-01')
		,('YesterdayNonEntered','MaxUserId','0')
		,('YesterdayNonEntered','MaxUserIdUAT','0')
		,('YesterdayNonEntered','IncludeRealCurrencyUAT','0')
		,('YesterdayNonEntered','SendLastNotificationId','0')
		,('YesterdayNonEntered','SendLastNotificationIdUAT','0')
		,('YesterdayNonEntered','SyncSettingPRO','1')
) n (ServiceName, SettingName, Value)

