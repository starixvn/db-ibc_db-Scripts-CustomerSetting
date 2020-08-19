/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200818@Eden
	Task: Create BetLimitControlDefaultSetting table [Redmine:#139701]	
	DB: DBCUST/CustDB
*/
--DROP TABLE [BetLimitControlDefaultSetting]
USE [CustDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BetLimitControlDefaultSetting](
	[CustID] [int] NOT NULL,
	[BetLimitTypeID] [int] NOT NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
CONSTRAINT [PK_BetLimitControlDefaultSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[BetLimitTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]

) ON [BetRestriction]

GO
