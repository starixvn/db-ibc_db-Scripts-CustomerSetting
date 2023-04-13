/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230328@Tacy
	Task : Create new table Age_FeedbackArea
		https://nexdev.net/issues/185515
	DB: DBBOT.bodb_ChatBot 
*/

USE [bodb_ChatBot]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Age_FeedbackArea](
	[FuncID] [int] NOT NULL,
	[AreaID] [int] IDENTITY(1,1) NOT NULL,
	[AreaNameEN] [nvarchar](150) NULL,
	[AreaNameCN3] [nvarchar](150) NULL,
	[AreaNameCH] [nvarchar](150) NULL,
	[AreaNameCS] [nvarchar](150) NULL,
	[AreaNameTH] [nvarchar](150) NULL,
	[AreaNameJP] [nvarchar](150) NULL,
	[AreaNameKO] [nvarchar](150) NULL,
 CONSTRAINT [PK_Age_FeedbackArea] PRIMARY KEY CLUSTERED 
(
	[FuncID] ASC,
	[AreaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [DATA]
GO