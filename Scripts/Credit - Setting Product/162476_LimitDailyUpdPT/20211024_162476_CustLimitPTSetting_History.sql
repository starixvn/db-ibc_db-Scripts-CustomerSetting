/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 202110263@Winfred
	Task : Create table CustLimitPTSetting_History [Redmine:#162476]
	DB:  DBTP/bodb_CustHistory 
*/
USE bodb_CustHistory
GO

CREATE TABLE [dbo].[CustLimitPTSetting_History](
	[UpdateTime] [datetime] NOT NULL,
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[ActorID] [int] NOT NULL,
	[PTCount] [tinyint] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_CustLimitPTSetting_History] PRIMARY KEY CLUSTERED 
(
	[UpdateTime] ASC,
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[ActorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
ALTER TABLE [dbo].[CustLimitPTSetting_History] ADD  CONSTRAINT [DF_CustLimitPTSetting_History_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO
ALTER TABLE [dbo].[CustLimitPTSetting_History] ADD  CONSTRAINT [DF_CustLimitPTSetting_History_PTCount]  DEFAULT ((0)) FOR [PTCount]
GO
