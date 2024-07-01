/*<info serverAlias="DBCustRepl-ReplCustDB"></info>*/
/*
	Created: 20240626@Johnson
	Task: Database structure change to scale out dbcust [redmine: #199915]
	DB: DBCustRepl-ReplCustDB
*/ 
ALTER DATABASE ReplCustDB ADD FILEGROUP [CustSetting_table] 
GO

ALTER DATABASE ReplCustDB  ADD FILE  
( NAME = N'CustSetting_table_01', FILENAME = N'/mnt/DiskG/ReplCustDB/CustSetting_table_01.NDF' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'CustSetting_table_02', FILENAME = N'/mnt/DiskG/ReplCustDB/CustSetting_table_02.NDF' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'CustSetting_table_03', FILENAME = N'/mnt/DiskG/ReplCustDB/CustSetting_table_03.NDF' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'CustSetting_table_04', FILENAME = N'/mnt/DiskG/ReplCustDB/CustSetting_table_04.NDF' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [CustSetting_table]
GO

CREATE TABLE [dbo].[BetSetting_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,	
	[MaxPayoutPerMatch] [money] NULL,
	[RepUpdateTime]	[datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_BetSetting_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
) ON [CustSetting_table]

GO

CREATE NONCLUSTERED INDEX IX_BetSetting_Agent_RepUpdateTime ON BetSetting_Agent(RepUpdateTime ASC) 
GO

ALTER TABLE [dbo].[BetSetting_Agent] ADD  CONSTRAINT [DF_BetSetting_Agent_MinBet]  DEFAULT ((0)) FOR [MinBet]
GO

ALTER TABLE [dbo].[BetSetting_Agent] ADD  CONSTRAINT [DF_BetSetting_Agent_MaxBet]  DEFAULT ((0)) FOR [MaxBet]
GO

ALTER TABLE [dbo].[BetSetting_Agent] ADD  CONSTRAINT [DF_BetSetting_Agent_MPM]  DEFAULT ((0)) FOR [MaxPerMatch]
GO

ALTER TABLE [dbo].[BetSetting_Agent] ADD  CONSTRAINT [DF_BetSetting_Agent_MPPM]  DEFAULT ((0)) FOR [MaxPayoutPerMatch]
GO

ALTER TABLE [dbo].[BetSetting_Agent] ADD  CONSTRAINT [DF_BetSetting_Agent_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO


CREATE TABLE [dbo].[BetSetting_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,	
	[MaxPayoutPerMatch] [money] NULL,
	[RepUpdateTime]	[datetime2](7) NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_BetSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
) ON [CustSetting_table]

GO

CREATE NONCLUSTERED INDEX IX_BetSetting_Member_RepUpdateTime ON BetSetting_Member(RepUpdateTime ASC) 
GO

ALTER TABLE [dbo].[BetSetting_Member] ADD  CONSTRAINT [DF_BetSetting_Member_MinBet]  DEFAULT ((0)) FOR [MinBet]
GO

ALTER TABLE [dbo].[BetSetting_Member] ADD  CONSTRAINT [DF_BetSetting_Member_MaxBet]  DEFAULT ((0)) FOR [MaxBet]
GO

ALTER TABLE [dbo].[BetSetting_Member] ADD  CONSTRAINT [DF_BetSetting_Member_MPM]  DEFAULT ((0)) FOR [MaxPerMatch]
GO

ALTER TABLE [dbo].[BetSetting_Member] ADD  CONSTRAINT [DF_BetSetting_Member_MPPM]  DEFAULT ((0)) FOR [MaxPayoutPerMatch]
GO

ALTER TABLE [dbo].[BetSetting_Member] ADD  CONSTRAINT [DF_BetSetting_Member_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO

