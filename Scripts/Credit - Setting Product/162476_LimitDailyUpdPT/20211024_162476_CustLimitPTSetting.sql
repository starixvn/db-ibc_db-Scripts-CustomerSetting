/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 202110263@Winfred
	Task : Create table CustLimitPTSetting [Redmine:#162476]
	DB:  DBCUST/CustDB 
	Replication : add to CustDB_Custsetting publication
*/
USE CustDB
GO

CREATE TABLE [dbo].[CustLimitPTSetting](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[ActorID] [int] NOT NULL,
	[PTCount] [tinyint] NOT NULL,
	[LastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_CustLimitPTSetting] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[ActorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
ALTER TABLE [dbo].[CustLimitPTSetting] ADD  CONSTRAINT [DF_CustLimitPTSetting_PTCount]  DEFAULT ((0)) FOR [PTCount]
GO
