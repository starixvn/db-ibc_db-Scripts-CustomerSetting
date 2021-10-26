/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20211006@Johnson
	Task: add database structure for job update DangerLevel 
	DB: DBCust/CustDB
*/
--step1 : Add new tables CustDangerWinlossInfo, CustDangerLevelInfo
--run at @DBCUST/CustDB

CREATE TABLE [dbo].[CustDangerWinlossInfo](
	[CustID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[IsParlay] [bit] NULL,
	[Winloss] [money] NULL,
	[CreatedDate] [datetime] NULL,
	[BatchNo] [int] NULL
) ON [DATA]
GO

CREATE CLUSTERED INDEX [CIX_CustDangerWinlossInfo] ON [dbo].[CustDangerWinlossInfo]
(
	[CustID] ASC,
	[BatchNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO


CREATE NONCLUSTERED INDEX [IX_CreatedDate] ON [dbo].[CustDangerWinlossInfo]
(
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

CREATE TABLE [dbo].[CustDangerLevelInfo](
	[Custid] [int] NOT NULL,
	[BatchNo] [int] NOT NULL,
	[Soccer] [tinyint] NULL,
	[Basketball] [tinyint] NULL,
	[UpdateSoccer] [bit] NULL,
	[UpdateBasketball] [bit] NULL,
	[Status] [varchar](100) NULL,
	[Description] [varchar](1000) NULL,	
	[CreatedDate] [datetime] NULL	
) ON [DATA]
GO

CREATE CLUSTERED INDEX [CIX_CustDangerLevelInfo] ON [dbo].[CustDangerLevelInfo]
(
	[CustID] ASC,
	[BatchNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO


CREATE NONCLUSTERED INDEX [IX_CreatedDate] ON [dbo].[CustDangerLevelInfo]
(
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
GO

