/*<info serverAlias="DBBOT-bodb_ChatBot" executers="bodbDownlineNet" isFunction="0" isNested="0"></info>*/

/*
	Created: 20220509@Malcolm
	DB: DBBOT-bodb_ChatBot
	Task: Initialize Data
*/

UPDATE BotSystemSetting WITH(ROWLOCK)
	SET Value = '27622177'
WHERE ServiceName = 'PersonalMessage' AND SettingName LIKE '%MaxMsgTargetId%'

UPDATE BotSystemSetting WITH(ROWLOCK)
	SET Value = '657434'
WHERE ServiceName = 'ProblemAccount' AND SettingName LIKE '%MaxLogId%'

UPDATE BotSystemSetting WITH(ROWLOCK)
	SET Value = '0'
WHERE ServiceName = 'MemberWinLossLimit' AND SettingName LIKE '%MaxLogID%'

UPDATE BotSystemSetting WITH(ROWLOCK)
	SET Value = '0'
WHERE SettingName LIKE '%LastNotificationId%'

