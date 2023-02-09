/*<info serverAlias="DBBOT-TESTDB053"></info>*/
--/*
--	Date: 2/8/2023 1:03:18
--	Created: Helios 
--	Task: Feedback Feature [redmine : #]
--	DB: DBBOT/DB-61\DevDB053
--	DB: DBBOT/TESTDB053
--*/

USE [bodb_ChatBot]
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustFeedback](
	[CustID] [int] NOT NULL,
	[Comment] [nvarchar](4000) NULL,
	[Rate] [tinyint] NULL,
	[CreatedDate] [smalldatetime] NULL,
) 
GO
SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_CustFeedback]    Script Date: 2/8/2023 4:06:18 PM ******/
CREATE CLUSTERED INDEX [IX_CustFeedback] ON [dbo].[CustFeedback]
(
	[CustID] ASC , 
	[CreatedDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO