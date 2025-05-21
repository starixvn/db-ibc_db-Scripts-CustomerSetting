/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: 20241008@Winfred
	DB: DBCUST/CustDB
	Task:  Enlarge bet limit requirement
	Revisions:
		- 20250220@Winfred: [NAP CM] - Enlarge bet limit requirement [RedmineID: #218073]
*/

--DROP TABLE [dbo].[SVIPMaxBetPlayer]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SVIPMaxBetPlayer]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[SVIPMaxBetPlayer](
		[SiteID] [int] NOT NULL,
		[custid] [int] NOT NULL,
		[SportType] [smallint] NOT NULL,
		[Bettype] [smallint] NOT NULL,
		[Multiplier] [decimal](9,2) NULL,
		[Note] [Nvarchar](1000) NULL,
		[IsTest] [TINYINT] NOT NULL,
		[LastModifiedUser] [INT] NULL,
		[LastModifiedTime] [DATETIME] NULL,
		[RepUpdateTime] [datetime2](7) NULL,
	 CONSTRAINT [PK_SVIPMaxBetPlayer] PRIMARY KEY CLUSTERED 
	(
		[SiteID] ASC,
		[custid] ASC,
		[SportType] ASC,
		[Bettype] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SVIPMaxBetPlayer]') AND name = N'IX_SVIPMaxBetPlayer_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_SVIPMaxBetPlayer_RepUpdateTime] ON [dbo].[SVIPMaxBetPlayer]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SVIPMaxBetPlayer_RepUpdateTime]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[SVIPMaxBetPlayer] ADD  CONSTRAINT [DF_SVIPMaxBetPlayer_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END
GO


--DROP TABLE [dbo].[SVIPMaxBetHistory]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SVIPMaxBetHistory]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[SVIPMaxBetHistory](
		[ID] [INT] IDENTITY(1,1) NOT NULL,
		[SiteID] [int] NOT NULL,
		[custid] [int] NOT NULL,
		[SportType] [smallint] NOT NULL,
		[Bettype] [smallint] NOT NULL,
		[Multiplier] [decimal](9,2) NULL,
		[IsTest] [TINYINT] NOT NULL,
		[Action] [varchar](10) NULL,
		[LastModifiedUser] [INT] NULL,
		[LastModifiedTime] [DATETIME] NULL,
		[RepUpdateTime] [datetime2](7) NULL,
	 CONSTRAINT [PK_SVIPMaxBetHistory] PRIMARY KEY NONCLUSTERED 
	(
		[ID] 
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
ELSE
BEGIN
	DROP TABLE [dbo].[SVIPMaxBetHistory]

	CREATE TABLE [dbo].[SVIPMaxBetHistory](
		[ID] [INT] IDENTITY(1,1) NOT NULL,
		[SiteID] [int] NOT NULL,
		[custid] [int] NOT NULL,
		[SportType] [smallint] NOT NULL,
		[Bettype] [smallint] NOT NULL,
		[Multiplier] [decimal](9,2) NULL,
		[IsTest] [TINYINT] NOT NULL,
		[Action] [varchar](10) NULL,
		[LastModifiedUser] [INT] NULL,
		[LastModifiedTime] [DATETIME] NULL,
		[RepUpdateTime] [datetime2](7) NULL,
	 CONSTRAINT [PK_SVIPMaxBetHistory] PRIMARY KEY NONCLUSTERED 
	(
		[ID] 
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
	) ON [DATA]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SVIPMaxBetHistory]') AND name = N'IX_SVIPMaxBetHistory')
BEGIN
	CREATE CLUSTERED INDEX [IX_SVIPMaxBetHistory] ON [dbo].[SVIPMaxBetHistory] 
	(
		[SiteID] ,
		[custid] ,
		[SportType] ,
		[Bettype],
		[ID]
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = ON, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SVIPMaxBetHistory]') AND name = N'IX_SVIPMaxBetHistory_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_SVIPMaxBetHistory_RepUpdateTime] ON [dbo].[SVIPMaxBetHistory]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SVIPMaxBetPlayer_RepUpdateTime]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[SVIPMaxBetHistory] ADD  CONSTRAINT [DF_SVIPMaxBetHistory_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END
GO
