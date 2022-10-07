/*<info serverAlias="DBBOT-bodb_Chatbot"></info>*/
/*
	Created: 20221007@Johnson
	Task: Add new index for BotSystemSetting [#RedmineID:#176397]
	DB: DBBOT/bodb_Chatbot
*/

CREATE NONCLUSTERED INDEX [IX_ServiceNameSettingName] ON [dbo].[BotSystemSetting]
(
	[ServiceName] ASC,
	[SettingName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO


