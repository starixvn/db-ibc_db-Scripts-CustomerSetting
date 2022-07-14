/*<info serverAlias="DBBOT-bodb_ChatBot" executers="bodbDownlineNet" isFunction="0" isNested="0"></info>*/

/*
	Created: 20220509@Malcolm
	DB: DBBOT-bodb_ChatBot
	Task: Initialize Data
*/

TRUNCATE TABLE CustBotNotification
GO

TRUNCATE TABLE  NotificationReferenceLog
GO
-- PersonalMessage
UPDATE BotSystemSetting WITH(ROWLOCK, UPDLOCK)
	SET Value = ''
WHERE ServiceName = 'PersonalMessage' AND SettingName = 'MaxMsgTargetId'

-- YesterdayWinLoss
UPDATE BotSystemSetting WITH(ROWLOCK, UPDLOCK)
	SET Value = '2022-05-01'
WHERE ServiceName = 'YesterdayWinLoss' AND SettingName = 'WinlostDate'

UPDATE BotSystemSetting WITH(ROWLOCK, UPDLOCK)
	SET Value = '0'
WHERE ServiceName = 'YesterdayWinLoss' AND SettingName = 'MaxUserId'

-- ProblemAccount
UPDATE BotSystemSetting WITH(ROWLOCK, UPDLOCK)
	SET Value = '0'
WHERE ServiceName = 'ProblemAccount' AND SettingName = 'MaxLogId'

-- MemberWinLossLimit
UPDATE BotSystemSetting WITH(ROWLOCK, UPDLOCK)
	SET Value = '0'
WHERE ServiceName = 'MemberWinLossLimit' AND SettingName = 'MaxLogID'

-- Update Send Notiftication
UPDATE BotSystemSetting WITH(ROWLOCK, UPDLOCK)
	SET Value = '0'
WHERE SettingName IN ('SendLastNotificationId', 'SendLastNotificationIdUAT')