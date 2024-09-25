/*<info serverAlias="DBACC-bodb02,DBTP-bodb02"></info>*/
/*
	Created: Eden@20240604
	Task: Create new tables to store bet setting for 3rd products - Credit [Redmine: #204358]   
	DB: DBACC-bodb02,DBTP-bodb02
*/
/*
DROP TABLE [BetSetting3rd_Agent]
DROP TABLE [BetSetting3rd_Member]
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BetSetting3rd_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL ,
	[MaxBet] [money] NULL ,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[RepUpdateTime] [DATETIME2] NULL,
 CONSTRAINT [PK_BetSetting3rd_Agent] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetSetting3rd_table]
) ON [BetSetting3rd_table]

GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BetSetting3rd_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,
	[MaxPerNumber] [money] NULL,
	[RepUpdateTime] [DATETIME2] NULL,
 CONSTRAINT [PK_BetSetting3rd_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetSetting3rd_table]
) ON [BetSetting3rd_table]

GO
