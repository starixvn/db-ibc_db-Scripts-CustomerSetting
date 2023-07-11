/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
USE bodb_CustomerLog
GO
/*
	Created: 20230428@Winfred
	DB: DBLOG/bodb_CustomerLog
	Task:  Alpha - Notify abnormal login via Telegram chatbot
	Revisions:
		- 20230428@Winfred:  Alpha - Notify abnormal login via Telegram chatbot [RedmineID: #183746]
*/

DROP TABLE [dbo].[CustAbnormalLogin]

CREATE TABLE [dbo].[CustAbnormalLogin](
	[LoginID] [BIGINT] NOT NULL,
	[LoginTime] [datetime] NULL,
	[LoginName] [varchar](50)  NOT NULL,
	[CustID] [int] NULL,
	[SubAccountID] [int] NULL,
	[UserAgent] [varchar](1000)  NOT NULL,
	[IP] [varchar](45)  NOT NULL,
	[OS] [varchar](40)  NOT NULL,
	[Browser] [varchar](40)  NOT NULL,
	[Device] [varchar](40)  NOT NULL,
	[ChildLoginID] [int] NULL,
	[Status] [tinyint] NULL,
	[CreatedDate] [smalldatetime] NULL,
 CONSTRAINT [PK_CustAbnormalLogin] PRIMARY KEY NONCLUSTERED
(
	[LoginID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]

GO

CREATE CLUSTERED INDEX [CIX_CustAbnormalLogin] ON [dbo].[CustAbnormalLogin] 
(
	[Status] ASC,
	[LoginTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

CREATE NONCLUSTERED INDEX [PX_CustAbnormalLogin_LoginTime] ON [dbo].[CustAbnormalLogin] 
(
	[LoginTime] ASC
)INCLUDE (LoginID, CustID, SubAccountID)
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
GO

