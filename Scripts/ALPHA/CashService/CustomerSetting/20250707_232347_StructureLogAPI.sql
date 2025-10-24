/*<info serverAlias="DBLOG-bodb_CustomerLog, DBSIC-bodb_CustomerLog, DBCUST-bodb_CustomerLog"></info>*/
/*
	Created: 20250707@Elodie
	Task: Alpha - Agency Cash Service - log API [#232347] 
	DB: DBLOG/bodb_CustomerLog 
*/
USE [bodb_CustomerLog]
GO

CREATE TABLE [dbo].[Cash_UserLog_API](
	[LogId] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LogDate] [datetime] NULL,
	[CustId] [int] NULL,
	[UserId] [int] NULL,
	[SubAccId] [int] NULL,
	[From] [varchar](100) NULL,
	[To] [varchar](100) NULL,
	[FuncName] [varchar](100) NULL,
	[Duration] [int] NULL,
	[RequestUrl] [varchar](max) NULL,
	[RequestBody] [nvarchar](max) NULL,
	[ResponseBody] [nvarchar](max) NULL,
	[StatusCode] int, 
	[Exception] [varchar](max) NULL
)ON [UserLog_RunSP]
GO

ALTER TABLE [dbo].[Cash_UserLog_API] ADD CONSTRAINT [DF_Cash_UserLog_API_logdate]  DEFAULT (getdate()) FOR [logdate]
GO


