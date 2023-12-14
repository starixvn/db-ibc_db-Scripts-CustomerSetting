/*<info serverAlias="DBLOG-bodb_CustomerLog" executers="" viewers="" isFunction="0"></info>*/

ALTER TABLE [sb].[FailedMessageMonitoring] ADD IsSentMail BIT
GO

ALTER TABLE [sb].[FailedMessageMonitoring] ADD  CONSTRAINT [DF_FailedMessageMonitoring_IsSentMail]  DEFAULT ((0)) FOR [IsSentMail]
GO

