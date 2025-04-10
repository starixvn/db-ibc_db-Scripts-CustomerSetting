/*<info serverAlias="DBLOG-bodb_CustomerLog"></info>*/
/*
	Created: 20250410@Eden
	Task: Create log table for AI chatbot [#RedmineID:#218357]
	DB: DBLOG/bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserLog_AI_ChatBot]') AND type in (N'U'))
DROP TABLE [dbo].[UserLog_AI_ChatBot]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserLog_AI_ChatBot](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[LogTime] [datetime] NULL,
	[UserID] [int] NULL,
	[CustID] [int] NULL,
	[SubAccID] [int] NULL,
	[SessionID] [uniqueidentifier] NULL,
	[SenderID] [tinyint] NULL,
	[ReceiverID] [tinyint] NULL,
	[TrackingValue] [nvarchar](max) NULL,
	[MsgDate] [datetime] NULL,
	[IsAction] [bit] NULL,
	[MsgType] [varchar](100) NULL,
	[RespondTime] [int] NULL,
 CONSTRAINT [PK_UserLog_AI_ChatBot] PRIMARY KEY NONCLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA] TEXTIMAGE_ON [DATA]
GO

ALTER TABLE [dbo].[UserLog_AI_ChatBot] ADD  CONSTRAINT DF_UserLog_AI_ChatBot_LogTime DEFAULT (getdate()) FOR [LogTime]
GO

CREATE CLUSTERED INDEX CIX_UserLog_AI_ChatBot ON [UserLog_AI_ChatBot](custid ASC, [LogTime] ASC)
GO

