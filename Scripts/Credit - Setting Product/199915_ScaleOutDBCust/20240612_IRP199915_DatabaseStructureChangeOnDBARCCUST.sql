/*<info serverAlias="DBARCCUST-bodb_Customer"></info>*/
/*
	Created: 20240612@Johnson
	Task: Database structure change to scale out dbcust [redmine: #199915]
	DB: DBARCCUST/bodb_Customer
*/ 


CREATE TABLE [dbo].[BetSetting_Agent_old](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,	
	[MaxPayoutPerMatch] [money] NULL,
 CONSTRAINT [PK_BetSetting_Agent_old] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Custsetting_table]
) ON [Custsetting_table]

GO

ALTER TABLE [dbo].[BetSetting_Agent_old] ADD  CONSTRAINT [DF_BetSetting_Agent_old_MinBet]  DEFAULT ((0)) FOR [MinBet]
GO

ALTER TABLE [dbo].[BetSetting_Agent_old] ADD  CONSTRAINT [DF_BetSetting_Agent_old_MaxBet]  DEFAULT ((0)) FOR [MaxBet]
GO

ALTER TABLE [dbo].[BetSetting_Agent_old] ADD  CONSTRAINT [DF_BetSetting_Agent_old_MPM]  DEFAULT ((0)) FOR [MaxPerMatch]
GO

ALTER TABLE [dbo].[BetSetting_Agent_old] ADD  CONSTRAINT [DF_BetSetting_Agent_old_MPPM]  DEFAULT ((0)) FOR [MaxPayoutPerMatch]
GO



CREATE TABLE [dbo].[BetSetting_Member_old](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[MinBet] [money] NULL,
	[MaxBet] [money] NULL,
	[MaxPerMatch] [money] NULL,	
	[MaxPayoutPerMatch] [money] NULL,
 CONSTRAINT [PK_BetSetting_Member_old] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Custsetting_table]
) ON [Custsetting_table]

GO

ALTER TABLE [dbo].[BetSetting_Member_old] ADD  CONSTRAINT [DF_BetSetting_Member_old_MinBet]  DEFAULT ((0)) FOR [MinBet]
GO

ALTER TABLE [dbo].[BetSetting_Member_old] ADD  CONSTRAINT [DF_BetSetting_Member_old_MaxBet]  DEFAULT ((0)) FOR [MaxBet]
GO

ALTER TABLE [dbo].[BetSetting_Member_old] ADD  CONSTRAINT [DF_BetSetting_Member_old_MPM]  DEFAULT ((0)) FOR [MaxPerMatch]
GO

ALTER TABLE [dbo].[BetSetting_Member_old] ADD  CONSTRAINT [DF_BetSetting_Member_old_MPPM]  DEFAULT ((0)) FOR [MaxPayoutPerMatch]
GO

