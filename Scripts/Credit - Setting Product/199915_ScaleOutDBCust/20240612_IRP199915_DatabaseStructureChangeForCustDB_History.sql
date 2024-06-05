/*<info serverAlias="DBCUST-CustDB_History"></info>*/
/*
	Created: 20240612@Johnson
	Task: Database structure change to scale out dbcust [redmine: #199915]
	DB: DBCUST/CustDB_History
*/ 
use master
GO

CREATE DATABASE [CustDB_History]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'bodb_History', FILENAME = N'/mnt/DiskG/CustDB_History/CustDB_History.mdf' , SIZE = 233344KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [CustSetting_table] 
( NAME = N'bodb_CustSetting_01', FILENAME = N'/mnt/DiskG/CustDB_History/bodb_CustSetting_01.ndf' , SIZE = 1051648KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
( NAME = N'bodb_CustSetting_02', FILENAME = N'/mnt/DiskG/CustDB_History/bodb_CustSetting_02.ndf' , SIZE = 265216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
( NAME = N'bodb_CustSetting_03', FILENAME = N'/mnt/DiskG/CustDB_History/bodb_CustSetting_03.ndf' , SIZE = 396288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
LOG ON 
( NAME = N'CustDB_History_log', FILENAME = N'/mnt/DiskG/CustDB_History/CustDB_History_log.ldf' , SIZE = 23416192KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

USE CustDB_History
GO

CREATE TABLE [dbo].[BetSetting_Agent_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[UpdateTime] [datetime] NOT NULL
) ON [CustSetting_table]

GO

ALTER TABLE [dbo].[BetSetting_Agent_History] ADD  CONSTRAINT [DF_BetSetting_Agent_History_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO

CREATE CLUSTERED INDEX [IX_BetSetting_Agent_History] ON [dbo].[BetSetting_Agent_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
GO

CREATE TABLE [dbo].[BetSetting_Member_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[MaxPayoutPerMatch] [money] NULL,
	[UpdateTime] [datetime] NOT NULL
) ON [CustSetting_table]

GO

ALTER TABLE [dbo].[BetSetting_Member_History] ADD  CONSTRAINT [DF_BetSetting_Member_History_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO

CREATE CLUSTERED INDEX [IX_BetSetting_Member_History] ON [dbo].[BetSetting_Member_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
GO
