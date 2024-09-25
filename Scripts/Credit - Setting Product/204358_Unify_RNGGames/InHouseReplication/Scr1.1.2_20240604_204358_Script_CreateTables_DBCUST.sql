/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20240604
	Task: Create new tables to store bet setting for 3rd products - Credit [Redmine: #204358]   
	DB: DBCUST-CUSTDB
*/
/*
DROP TABLE [BetSetting3rd_Agent]
DROP TABLE [BetSetting3rd_Member]
DROP TABLE [BetSetting3rd_Agent_Del_Inhouse]
DROP TABLE [BetSetting3rd_Member_Del_Inhouse]
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[BetSetting3rd_Agent](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL CONSTRAINT [DF_BetSetting3rd_Agent_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_BetSetting3rd_Agent_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_BetSetting3rd_Agent_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_BetSetting3rd_Agent_MPN]  DEFAULT ((0)),
	[RepUpdateTime] [DATETIME2] NULL CONSTRAINT DF_BetSetting3rd_Agent_RepUpdateTime DEFAULT SYSDATETIME(),
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
	[MinBet] [money] NULL CONSTRAINT [DF_BetSetting3rd_Member_MinBet]  DEFAULT ((0)),
	[MaxBet] [money] NULL CONSTRAINT [DF_BetSetting3rd_Member_MaxBet]  DEFAULT ((0)),
	[MaxPerMatch] [money] NULL CONSTRAINT [DF_BetSetting3rd_Member_MPM]  DEFAULT ((0)),
	[MaxPerNumber] [money] NULL CONSTRAINT [DF_BetSetting3rd_Member_MPN]  DEFAULT ((0)),
	[RepUpdateTime] [DATETIME2] NULL CONSTRAINT DF_BetSetting3rd_Member_RepUpdateTime DEFAULT SYSDATETIME(),
 CONSTRAINT [PK_BetSetting3rd_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetSetting3rd_table]
) ON [BetSetting3rd_table]

GO

--------Deleted Table - CustDB Only----------
CREATE TABLE [dbo].BetSetting3rd_Agent_Del_Inhouse(
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2]  NOT NULL,
)  ON [BetSetting3rd_table]

CREATE TABLE [dbo].BetSetting3rd_Member_Del_Inhouse(
	[CustID] [int] NOT NULL,
	[Sporttype] [smallint] NOT NULL,
	[Bettype] [smallint] NOT NULL,
	[RepUpdateTime] [datetime2]  NOT NULL,
)  ON [BetSetting3rd_table]

--Create indexes:
CREATE NONCLUSTERED INDEX IX_BetSetting3rd_Agent_RepUpdateTime ON BetSetting3rd_Agent(RepUpdateTime ASC) ON [BetSetting3rd_index]
CREATE NONCLUSTERED INDEX IX_BetSetting3rd_Member_RepUpdateTime ON BetSetting3rd_Member(RepUpdateTime ASC)  ON [BetSetting3rd_index]
CREATE CLUSTERED INDEX IX_BetSetting3rd_Agent_Del_Inhouse ON BetSetting3rd_Agent_Del_Inhouse(RepUpdateTime ASC)  ON [BetSetting3rd_index]
CREATE CLUSTERED INDEX IX_BetSetting3rd_Member_Del_Inhouse ON BetSetting3rd_Member_Del_Inhouse(RepUpdateTime ASC)  ON [BetSetting3rd_index]
GO
