/*
	Created: 20200528@Eden
	Task: Create Bet Limit Control tables [Redmine:#132736]	
	DB: DBCUST/CustDB
	Replication : add to CustDB_Custsetting publication
*/

USE [CustDB]
GO
--DROP TABLE [dbo].[BetLimitControlType]
--GO
--DROP TABLE [dbo].[BetLimitControlTypeDetail]
--GO
--DROP TABLE [dbo].[BetLimitControlCustSetting]
--GO
--DROP TABLE [dbo].[BetLimitControlProduct]
--GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BetLimitControlProduct](
	[ProductID] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BetLimitControlCustSetting](
	[CustID] [int] NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[BetLimitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BetLimitControlTypeDetail](
	[BetLimitTypeID] [int] NOT NULL,
	[ProductID] [tinyint] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[LeagueGroupID] [int] NOT NULL,
	[LeagueID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BetLimitTypeID] ASC,
	[Sporttype] ASC,
	[Bettype] ASC,
	[LeagueGroupID] ASC,
	[LeagueID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[BetLimitControlType](
	[BetLimitTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[BetLimitType] [varchar](50) NOT NULL,
	[BeginTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[LiveIndicator] [tinyint] NOT NULL,
	[RestrictVIP] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BetLimitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]
) ON [BetRestriction]

GO


