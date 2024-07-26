/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: Luke
	Date: 20240312
	Task:  Telegram Chatbot - Notify Member Last bets [Redmine: #193689]
	DB: DBBOT/bodb_ChatBot
*/

DROP INDEX [IX_ServiceNameSettingName] ON dbo.BotSystemSetting
GO

ALTER TABLE dbo.BotSystemSetting ALTER COLUMN [Value] VARCHAR(MAX)
GO

CREATE NONCLUSTERED INDEX [IX_ServiceNameSettingName] ON [dbo].[BotSystemSetting]
(
	[ServiceName] ASC,
	[SettingName] ASC
)
INCLUDE([Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO