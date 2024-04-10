/*<info serverAlias="DBSIC-bodb02,DBCTG-bodb02"></info>*/
/*
	Created: 20240202@Luke
	DB: DBSIC-bodb02,DBCTG-bodb02
	Task: Auto Transfer Enhancement - Phase 3 [Redmine: #195551]
*/
--DBSIC
USE [bodb02]
GO

ALTER TABLE [dbo].[Age_ClearBalanceCust_Process]
ADD [NotifyStatus] BIT CONSTRAINT DF_Age_ClearBalanceCust_Process_NotifyStatus DEFAULT(0)
GO

CREATE NONCLUSTERED INDEX [IX_NotifyStatus] ON [dbo].[Age_ClearBalanceCust_Process]
(
	[NotifyStatus] ASC,
	[SuperId] ASC,
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Others_table]
GO

