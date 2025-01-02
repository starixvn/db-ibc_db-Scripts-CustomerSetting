/*<info serverAlias="DBTXN-bodb02"></info>*/

/*
	Creator: 20241209@Tacy
	Task: Create tables BalancePendingDebitGame_History & BalancePendingCreditGame_History [Redmine: #214868]
	Database:	DBTXN-bodb02
*/
USE bodb02
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--[BalancePendingCreditGame_History]
CREATE TABLE [dbo].[BalancePendingCreditGame_History](
	[rn]			[bigint] NULL,
	[custid]		[int] NULL,
	[winlostdate]	[smalldatetime] NULL,
	[Balance]		[money] NULL,
	[bettype]		[smallint] NULL,
	[GameTypeID]	[smallint] NULL,
	[RefID]			[bigint] NULL,
	[UpdateTime]	[datetime] NULL,
	[LogDate]		[datetime] NULL,
) ON [BALANCE]
GO

ALTER TABLE [dbo].[BalancePendingCreditGame_History] ADD  CONSTRAINT [DF_BalancePendingCreditGame_History_LogDate]  DEFAULT (GETDATE()) FOR [LogDate]
GO

CREATE CLUSTERED INDEX [CIX_BalancePendingCreditGame_History_LogDate] ON [dbo].[BalancePendingCreditGame_History]
(
	[LogDate] ASC
)
GO
----------------------------------------------------------
--[BalancePendingDebitGame_History]
CREATE TABLE [dbo].[BalancePendingDebitGame_History](
	[rn]			[bigint] NULL,
	[custid]		[int] NULL,
	[winlostdate]	[smalldatetime] NULL,
	[Balance]		[money] NULL,
	[bettype]		[smallint] NULL,
	[GameTypeID]	[smallint] NULL,
	[RefID]			[bigint] NULL,
	[UpdateTime]	[datetime] NULL,
	[LogDate]		[datetime] NULL,
) ON [BALANCE]
GO

ALTER TABLE [dbo].[BalancePendingDebitGame_History] ADD  CONSTRAINT [DF_BalancePendingDebitGame_History_LogDate]  DEFAULT (GETDATE()) FOR [LogDate]
GO

CREATE CLUSTERED INDEX [CIX_BalancePendingDebitGame_History_LogDate] ON [dbo].[BalancePendingDebitGame_History]
(
	[LogDate] ASC
)
GO