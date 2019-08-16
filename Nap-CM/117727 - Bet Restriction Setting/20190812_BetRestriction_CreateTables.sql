/*
	Created by: Eden
	Date: 20190812
	Task: Create new tables for BetRestriction [Redmine:#117727]	
	DB: DBCUST/CustDB
	Replication : add to CustDB_Custsetting publication
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

/****** Object:  Table [dbo].[BetRestriction_Site]    Script Date: 8/12/2019 8:24:31 AM ******/
IF EXISTS( SELECT 1 FROM sys.tables WHERE NAME LIKE 'BetRestriction_Site' AND SCHEMA_NAME(schema_id) = 'dbo' )
	DROP TABLE [dbo].[BetRestriction_Site]
GO

/****** Object:  Table [dbo].[BetRestriction_Setting]    Script Date: 8/12/2019 8:24:31 AM ******/
IF EXISTS( SELECT 1 FROM sys.tables WHERE NAME LIKE 'BetRestriction_Setting' AND SCHEMA_NAME(schema_id) = 'dbo' )
	DROP TABLE [dbo].[BetRestriction_Setting]
GO

/****** Object:  Table [dbo].[BetRestriction_Customer]    Script Date: 8/12/2019 8:24:31 AM ******/
IF EXISTS( SELECT 1 FROM sys.tables WHERE NAME LIKE 'BetRestriction_Customer' AND SCHEMA_NAME(schema_id) = 'dbo' )
	DROP TABLE [dbo].[BetRestriction_Customer]
GO

/****** Object:  Table [dbo].[BetRestriction_Currency]    Script Date: 8/12/2019 8:24:31 AM ******/
IF EXISTS( SELECT 1 FROM sys.tables WHERE NAME LIKE 'BetRestriction_Currency' AND SCHEMA_NAME(schema_id) = 'dbo' )
	DROP TABLE [dbo].[BetRestriction_Currency]
GO

/****** Object:  Table [dbo].[BetRestriction_Currency]    Script Date: 8/12/2019 8:24:31 AM ******/
CREATE TABLE [dbo].[BetRestriction_Currency](
	[ExchangeID] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[LiveBetAccept] [smallint] NOT NULL,
	[SeizeBetTicket] [tinyint] NULL,
	[FollowAccount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ExchangeID] ASC,
	[SportType] ASC,
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO

/****** Object:  Table [dbo].[BetRestriction_Customer]    Script Date: 8/12/2019 8:24:31 AM ******/
CREATE TABLE [dbo].[BetRestriction_Customer](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[LiveBetAccept] [smallint] NOT NULL,
	[SeizeBetTicket] [tinyint] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[FollowAccount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO

/****** Object:  Table [dbo].[BetRestriction_Setting]    Script Date: 8/12/2019 8:24:31 AM ******/
CREATE TABLE [dbo].[BetRestriction_Setting](
	[SettingID] [smallint] IDENTITY (1,1) NOT FOR REPLICATION NOT NULL,
	[SportType] [smallint] NOT NULL,
	[RestrictionLevel] [varchar](30) NOT NULL,
	[IsLicensee] [bit] NOT NULL,
	[BackEndStatus] [tinyint] NOT NULL,
	[LiveBetAcceptStatus] [bit] NOT NULL,
	[SeizeBetTicketStatus] [bit] NOT NULL,
	[BetLimitStatus] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SettingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO

/****** Object:  Table [dbo].[BetRestriction_Site]    Script Date: 8/12/2019 8:24:31 AM ******/
CREATE TABLE [dbo].[BetRestriction_Site](
	[SiteID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[LiveBetAccept] [smallint] NOT NULL,
	[SeizeBetTicket] [tinyint] NULL,
	[FollowAccount] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SiteID] ASC,
	[SportType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO

