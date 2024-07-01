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
( NAME = N'bodb_History', FILENAME = N'/mnt/DiskG/CustDB_History/CustDB_History.mdf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
LOG ON 
( NAME = N'CustDB_History_log', FILENAME = N'/mnt/DiskG/CustDB_History/CustDB_History_log.ldf' , SIZE = 4096MB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

USE CustDB_History
GO
ALTER DATABASE [CustDB_History] ADD FILEGROUP [CustSetting_table] 
GO
ALTER DATABASE [CustDB_History] ADD FILE 
( NAME = N'bodb_CustSetting_01', FILENAME = N'/mnt/DiskG/CustDB_History/bodb_CustSetting_01.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'bodb_CustSetting_02', FILENAME = N'/mnt/DiskG/CustDB_History/bodb_CustSetting_02.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'bodb_CustSetting_03', FILENAME = N'/mnt/DiskG/CustDB_History/bodb_CustSetting_03.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [CustSetting_table]
GO

--grant permission for web accounts
CREATE USER [wsv_alp] FOR LOGIN [wsv_alp] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO wsv_alp
GO

CREATE USER [wsv_xnap] FOR LOGIN [wsv_xnap] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO wsv_xnap
GO

CREATE USER [wsv_nap] FOR LOGIN [wsv_nap] WITH DEFAULT_SCHEMA=[dbo]
GO

GRANT CONNECT,INSERT TO wsv_nap
GO

/*
ALTER DATABASE [CustDB_History] ADD FILEGROUP [CustSetting_table] 
GO
ALTER DATABASE [CustDB_History] ADD FILE 
( NAME = N'bodb_CustSetting_01', FILENAME = N'/mnt/DiskG/CustDB_History/bodb_CustSetting_01.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'bodb_CustSetting_02', FILENAME = N'/mnt/DiskG/CustDB_History/bodb_CustSetting_02.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
( NAME = N'bodb_CustSetting_03', FILENAME = N'/mnt/DiskG/CustDB_History/bodb_CustSetting_03.ndf' , SIZE = 4096MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB )
TO FILEGROUP [CustSetting_table]
GO

*/
DROP TABLE BetSetting_Agent_History
GO

CREATE TABLE [dbo].[BetSetting_Agent_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,	
	[MaxPayoutPerMatch] [money] NULL,
	[UpdateTime] [datetime] NOT NULL,
CONSTRAINT [PK_BetSetting_Agent_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)) ON [CustSetting_table]

GO

ALTER TABLE [dbo].[BetSetting_Agent_History] ADD  CONSTRAINT [DF_BetSetting_Agent_History_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO
/*
CREATE CLUSTERED INDEX [IX_BetSetting_Agent_History] ON [dbo].[BetSetting_Agent_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
GO
*/
DROP TABLE BetSetting_Member_History
GO

CREATE TABLE [dbo].[BetSetting_Member_History](
	[rID] [bigint] NOT NULL IDENTITY(1,1),
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,	
	[MaxPayoutPerMatch] [money] NULL,
	[UpdateTime] [datetime] NOT NULL,
CONSTRAINT [PK_BetSetting_Member_History] PRIMARY KEY CLUSTERED 
(
	[rID] ASC
)) ON [CustSetting_table]

GO

ALTER TABLE [dbo].[BetSetting_Member_History] ADD  CONSTRAINT [DF_BetSetting_Member_History_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO
/*
CREATE CLUSTERED INDEX [IX_BetSetting_Member_History] ON [dbo].[BetSetting_Member_History]
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [CustSetting_table]
GO
*/