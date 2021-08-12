/*<info serverAlias="DBTP-bodb_CustHistory"></info>*/
/*
	Created: 20210513@Winfred
	Task : Create table CustMaxPayoutSetting_Member_History [Redmine:#154104]
	DB:  DBTP/bodb_CustHistory 
*/
USE bodb_CustHistory
GO

CREATE TABLE [dbo].[CustMaxPayoutSetting_Member_History](
	[UpdateTime] [datetime] NOT NULL,
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[SingleMatchParlay] [money] NOT NULL,
	[Combo2] [money] NOT NULL,
	[Combo35] [money] NOT NULL,
	[ComboOver6] [money] NOT NULL,
) ON [DATA]

GO
CREATE CLUSTERED INDEX [CustMaxPayoutSetting_Member_His_Index] ON [dbo].[CustMaxPayoutSetting_Member_History] 
(
	[UpdateTime] ASC,
	[CustID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO


ALTER TABLE [dbo].[CustMaxPayoutSetting_Member_History] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO
ALTER TABLE [dbo].[CustMaxPayoutSetting_Member_History] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_SingleMatchParlay]  DEFAULT ((0)) FOR [SingleMatchParlay]
GO
ALTER TABLE [dbo].[CustMaxPayoutSetting_Member_History] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_Combo2]  DEFAULT ((0)) FOR [Combo2]
GO
ALTER TABLE [dbo].[CustMaxPayoutSetting_Member_History] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_Combo35]  DEFAULT ((0)) FOR [Combo35]
GO
ALTER TABLE [dbo].[CustMaxPayoutSetting_Member_History] ADD  CONSTRAINT [DF_CustMaxPayoutSetting_Member_History_ComboOver6]  DEFAULT ((0)) FOR [ComboOver6]
GO
