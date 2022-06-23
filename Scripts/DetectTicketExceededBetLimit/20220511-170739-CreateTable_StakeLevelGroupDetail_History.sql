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

CREATE TABLE [dbo].[StakeLevelGroupDetail_History](
	[ID] [int] identity,
	[StakeLevelID] [int] NOT NULL,
	[GameTypeID] [int] NOT NULL,
	[MaxLabel] [nvarchar](50) NULL,
	[MaxStake] [decimal](19, 8) NULL,
	[MaxGameStake] [decimal](19, 8) NULL,
	[UpdateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_StakeLevelGroupDetail_History] PRIMARY KEY CLUSTERED 
(
	[StakeLevelID] ASC,
	[GameTypeID] ASC,
	[UpdateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [BetRestriction]
) ON [BetRestriction]
GO