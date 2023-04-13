/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230328@Tacy
	Task : Create new table Age_FeedbackFunc
		https://nexdev.net/issues/185515
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Age_FeedbackFunc](
	[FuncID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [tinyint] NOT NULL,		-- 1 ~ fb by control 1; 2 ~ fb by control 2
	[FuncNameEN] [nvarchar](50) NULL,
	[FuncNameCN3] [nvarchar](50) NULL,
	[FuncNameCH] [nvarchar](50) NULL,
	[FuncNameCS] [nvarchar](50) NULL,
	[FuncNameTH] [nvarchar](50) NULL,
	[FuncNameJP] [nvarchar](50) NULL,
	[FuncNameKO] [nvarchar](50) NULL,
 CONSTRAINT [PK_Age_FeedbackFunc] PRIMARY KEY CLUSTERED 
(
	[FuncID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [DATA]
GO