/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 202110263@Winfred
	Task : Create table LimitPTDailySetting [Redmine:#162476]
	DB:  DBCUST/CustDB 
	Replication : add to CustDB_Custsetting publication
*/
USE CustDB
GO
--DROP TABLE LimitPTDailySetting
CREATE TABLE [dbo].[LimitPTDailySetting](
	[ProductID] [tinyint] NOT NULL,
	[CustID] [int] NOT NULL,
	[Currency] [tinyint] NOT NULL,
	[SiteID] [int] NOT NULL ,
	[MaxCount] [tinyint] NOT NULL ,
	[Type] [tinyint] NOT NULL ,
	[SettingStatus] [tinyint] NOT NULL ,
 CONSTRAINT [PK_LimitPTDailySetting] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[CustID] ASC,
	[Currency] ASC,
	[SiteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO
ALTER TABLE [dbo].[LimitPTDailySetting] ADD  CONSTRAINT [DF_LimitPTDailySetting_CustID]  DEFAULT ((0)) FOR [CustID]
GO
ALTER TABLE [dbo].[LimitPTDailySetting] ADD  CONSTRAINT [DF_LimitPTDailySetting_Currency]  DEFAULT ((0)) FOR [Currency]
GO
ALTER TABLE [dbo].[LimitPTDailySetting] ADD  CONSTRAINT [DF_LimitPTDailySetting_SiteID]  DEFAULT ((0)) FOR [SiteID]
GO
