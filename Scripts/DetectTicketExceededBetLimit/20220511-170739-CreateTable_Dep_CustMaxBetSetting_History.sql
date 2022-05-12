/*<info serverAlias="DBCust-CustDB,DBTP-bodb02"></info>*/

/*
	Created: 20220511@Tacy
	Task: https://nexdev.net/issues/170739 [RedmineID: #170739]
	Database: DBCust/CustDB, DBTP/bodb02
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dep_CustMaxBetSetting_History](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[OldMaxBet] [money] NULL,
	[OldMaxPerMatch] [money] NULL,
	[OldStakeLevelList] [varchar](200) NULL,
	[UpdateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Dep_CustMaxBetSetting_History] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[UpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO