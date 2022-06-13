/*<info serverAlias="DBBOT-bodb_ChatBot" executers="bodbDownlineNet" isFunction="0" isNested="0"></info>*/

/*
	Created: 20220509@Malcolm
	DB: DBBOT-bodb_ChatBot
	Task: Initialize Data
*/

INSERT INTO BotSystemSetting (ServiceName, SettingName, Value)
SELECT ServiceName, SettingName, Value
FROM (
	VALUES 
		('PersonalMessage','BatchSize','5000')
		,('PersonalMessage','JobStatus','Completed')
		,('PersonalMessage','JobStatusUAT','Completed')
		,('PersonalMessage','LastRuntime','2022-05-01')
		,('PersonalMessage','LastRuntimeUAT','2022-05-01')
		,('PersonalMessage','ServiceFlag','1')
		,('PersonalMessage','ServiceFlagUAT','1')
		,('PersonalMessage','MaxMsgTargetId','634812')
		,('PersonalMessage','MaxMsgTargetIdUAT','0')
		,('PersonalMessage','IncludeRealCurrencyUAT','0')
		,('PersonalMessage','SendLastNotificationId','0')
		,('PersonalMessage','SendLastNotificationIdUAT','0')
		,('PersonalMessage','SyncSettingPRO','0')
		,('SendNotification','BatchSize','100')
		,('SendNotification','ServiceFlag','1')
		,('SendNotification','ServiceFlagUAT','1')
		,('SendNotification','SyncSettingPRO','0')
		
		,('YesterdayWinLoss','BatchSize','1000')
		,('YesterdayWinLoss','JobStatus','Completed')
		,('YesterdayWinLoss','JobStatusUAT','Completed')
		,('YesterdayWinLoss','LastRuntime','2022-05-01')
		,('YesterdayWinLoss','LastRuntimeUAT','2022-05-01')
		,('YesterdayWinLoss','ServiceFlag','1')
		,('YesterdayWinLoss','ServiceFlagUAT','1')
		,('YesterdayWinLoss','WinlostDate','2022-05-01')
		,('YesterdayWinLoss','WinlostDateUAT','2022-05-01')
		,('YesterdayWinLoss','MaxUserId','0')
		,('YesterdayWinLoss','MaxUserIdUAT','0')
		,('YesterdayWinLoss','IncludeRealCurrencyUAT','0')
		,('YesterdayWinLoss','SendLastNotificationId','0')
		,('YesterdayWinLoss','SendLastNotificationIdUAT','0')
		,('YesterdayWinLoss','SyncSettingPRO','0')
		
		,('ProblemAccount','BatchSize','1000')
		,('ProblemAccount','JobStatus','Completed')
		,('ProblemAccount','JobStatusUAT','Completed')
		,('ProblemAccount','LastRuntime','2022-05-01')
		,('ProblemAccount','LastRuntimeUAT','2022-05-01')
		,('ProblemAccount','ServiceFlag','1')
		,('ProblemAccount','ServiceFlagUAT','1')
		,('ProblemAccount','MaxLogId','634812')
		,('ProblemAccount','MaxLogIdUAT','0')
		,('ProblemAccount','IncludeRealCurrencyUAT','0')
		,('ProblemAccount','SendLastNotificationId','0')
		,('ProblemAccount','SendLastNotificationIdUAT','0')
		,('ProblemAccount','SyncSettingPRO','0')
		
		
		,('MemberWinLossLimit','BatchSize','1000')
		,('MemberWinLossLimit','JobStatus','Completed')
		,('MemberWinLossLimit','JobStatusUAT','Completed')
		,('MemberWinLossLimit','LastRuntime','2022-06-19 23:05:00')
		,('MemberWinLossLimit','LastRuntimeUAT','2022-06-19 23:05:00')
		,('MemberWinLossLimit','ServiceFlag','1')
		,('MemberWinLossLimit','ServiceFlagUAT','1')
		,('MemberWinLossLimit','MaxLogID','0')
		,('MemberWinLossLimit','MaxLogIDUAT','100033')
		,('MemberWinLossLimit','IncludeRealCurrencyUAT','0')
		,('MemberWinLossLimit','SendLastNotificationId','0')
		,('MemberWinLossLimit','SendLastNotificationIdUAT','3476275')
		,('MemberWinLossLimit','SyncSettingPRO','0')
) n (ServiceName, SettingName, Value)

