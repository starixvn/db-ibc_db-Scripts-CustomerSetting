/*<info serverAlias="DBLOG-bodb_CustomerLog, DBSIC-bodb_CustomerLog"></info>*/
/*
	Created: 20250527@Eden
	Task: Log Transfer for Cash - [223896]  
	DB: DBLOG-bodb_CustomerLog,DBSIC- bodb_CustomerLog
*/
USE [bodb_CustomerLog]
GO

--ALTER TABLE [dbo].[Cash_UserLog_Transfer] DROP CONSTRAINT [DF_Cash_UserLog_Transfer_LogDate]
--GO
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cash_UserLog_Transfer]') AND type in (N'U'))
--DROP TABLE [dbo].[Cash_UserLog_Transfer]
--GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cash_UserLog_Transfer](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[LogDate] [datetime] NOT NULL,
	[UserID] [int] NOT NULL,
	[FromCustID] [int] NULL,
	[ToCustID] [int] NULL,
	[IP] [varchar](45) NULL,
	[Doing] [varchar](1000) NULL,
	CONSTRAINT [PK_Cash_UserLog_Transfer] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[Cash_UserLog_Transfer] ADD  CONSTRAINT [DF_Cash_UserLog_Transfer_LogDate]  DEFAULT (getdate()) FOR [LogDate]
GO


