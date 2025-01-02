/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20241209@Tacy
	Task: Insert RefID, UpdateTime for tracing back data of BalancePendingDebitGame & BalancePendingCreditGame [Redmine: #214868]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

--BalancePendingDebitGame

ALTER TABLE BalancePendingDebitGame ADD RefID BIGINT NULL
GO

ALTER TABLE BalancePendingDebitGame ADD UpdateTime DATETIME
GO

--Default value
ALTER TABLE [dbo].[BalancePendingDebitGame] ADD CONSTRAINT [DF_BalancePendingDebitGame_UpdateTime]  DEFAULT (GETDATE()) FOR [UpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_BalancePendingDebitGame_UpdateTime] ON [dbo].[BalancePendingDebitGame]
(
	[UpdateTime] ASC
) INCLUDE (custid) WITH (ONLINE = ON)
GO
--------------------------------------------------------
--BalancePendingCreditGame

ALTER TABLE BalancePendingCreditGame ADD RefID BIGINT NULL
GO

ALTER TABLE BalancePendingCreditGame ADD UpdateTime DATETIME
GO

--Default value
ALTER TABLE [dbo].[BalancePendingCreditGame] ADD CONSTRAINT [DF_BalancePendingCreditGame_UpdateTime]  DEFAULT (GETDATE()) FOR [UpdateTime]
GO

CREATE NONCLUSTERED INDEX [IX_BalancePendingCreditGame_UpdateTime] ON [dbo].[BalancePendingCreditGame]
(
	[UpdateTime] ASC
) INCLUDE (custid) WITH (ONLINE = ON)
GO