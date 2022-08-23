/*<info serverAlias="DBBOT-bodb_ChatBot" executers="bodbDownlineNet" isFunction="0" isNested="0"></info>*/

/*
	Created: 20220823@Malcolm
	DB: DBBOT-bodb_ChatBot
	Task: Initialize Data
*/

INSERT INTO BotSystemSetting (ServiceName, SettingName, Value)
SELECT ServiceName, SettingName, Value
FROM (
	VALUES 
		('MyWatchlist','BatchSize','1000')
		,('MyWatchlist','JobStatus','Completed')
		,('MyWatchlist','JobStatusUAT','Completed')
		,('MyWatchlist','LastRuntime','2022-08-01')
		,('MyWatchlist','LastRuntimeUAT','2022-08-01')
		,('MyWatchlist','ServiceFlag','1')
		,('MyWatchlist','ServiceFlagUAT','1')
		,('MyWatchlist','MaxLogId','0')
		,('MyWatchlist','MaxLogIdUAT','0')
		,('MyWatchlist','ServerName','0')
		,('MyWatchlist','ServerNameUAT','0')
		,('MyWatchlist','LastDataRow','')
		,('MyWatchlist','LastDataRowUAT','')
		,('MyWatchlist','IncludeRealCurrencyUAT','0')
		,('MyWatchlist','SendLastNotificationId','0')
		,('MyWatchlist','SendLastNotificationIdUAT','0')
		,('MyWatchlist','SyncSettingPRO','0')
) n (ServiceName, SettingName, Value)


