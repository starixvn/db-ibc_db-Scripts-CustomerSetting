/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20210513@Winfred
	Task : Create table CustMaxPayoutSetting_Member [Redmine:#154104]
	DB:  DBCUST/CustDB 
	Replication : add to CustDB_Custsetting publication
*/
USE CustDB
GO

CREATE TABLE [dbo].[CustMaxPayoutSetting_Member](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[SingleMatchParlay] [money] NOT NULL,
	[Combo2] [money] NOT NULL,
	[Combo35] [money] NOT NULL,
	[ComboOver6] [money] NOT NULL,
 CONSTRAINT [PK_CustMaxPayoutSetting_Member] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
ALTER TABLE [dbo].[CustMaxPayoutSetting_Member] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_SingleMatchParlay]  DEFAULT ((0)) FOR [SingleMatchParlay]
GO
ALTER TABLE [dbo].[CustMaxPayoutSetting_Member] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_Combo2]  DEFAULT ((0)) FOR [Combo2]
GO
ALTER TABLE [dbo].[CustMaxPayoutSetting_Member] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_Combo35]  DEFAULT ((0)) FOR [Combo35]
GO
ALTER TABLE [dbo].[CustMaxPayoutSetting_Member] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_ComboOver6]  DEFAULT ((0)) FOR [ComboOver6]
GO
