/*
	Created: 20201016@Johnson
	Task : database structure for auto feedback winlimit [redmine:#142194]
*/

--run on  DBCRM/bodb_CRM	
CREATE TABLE [dbo].[crmWinLimitFeedbackInfo](
	[LogID] [int] NULL,
	[CustID] [int] NULL,
	[HeadlineID] [int] NULL,
	[HeadlineName] [varchar](50) NULL,
	[RelatedCustID] [int] NULL,
	[ProductID] [int] NULL,
	[ProductGroup] [varchar](200) NULL,
	[Level] [varchar](50) NULL,
	[MaxWinLimitSetting] [money] NULL,
	[TotalWinAmt] [money] NULL,
	[TotalWinAmt_RM] [money] NULL,
	[ReachedTime] [datetime] NULL,
	[BettypeIDList] [varchar](1024) NULL,
	[Status] [varchar](20) NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedTime] [datetime] NULL,
	[Description] [varchar](1000) NULL,
	[RetryCount] [tinyint] NULL
) ON [DATA] 
GO

CREATE CLUSTERED INDEX [CIX_crmWinLimitFeedbackInfo] ON [dbo].[crmWinLimitFeedbackInfo] 
(
	[LogID] ASC,	
	[CustID] ASC,
	[Status] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [IX_CreatedDate] ON [dbo].[crmWinLimitFeedbackInfo] 
(
	[CreatedDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

--step 2: Run on CUSTDB/DBCUST
--create index on WinLimit_CustGameMonitoring_History
CREATE NONCLUSTERED INDEX [IX_WinlostDate_LogID] ON [dbo].[WinLimit_CustGameMonitoring_History] 
(
	[WinlostDate] ASC,
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO





