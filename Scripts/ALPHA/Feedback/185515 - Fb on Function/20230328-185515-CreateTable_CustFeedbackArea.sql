/*<info serverAlias="DBBOT-bodb_ChatBot"></info>*/
/*
	Created: 20230328@Tacy
	Task : Create new table CustFeedbackArea
		https://nexdev.net/issues/185515
	DB: DBBOT.bodb_ChatBot 
*/
USE [bodb_ChatBot]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CustFeedbackArea](
	[CustID] [int] NOT NULL,
	[Subaccid] [int] NOT NULL,
	[FuncID] [int] NOT NULL,
	[AreaID] [int] NOT NULL,
	[Rate] [tinyint] NULL
) ON [DATA]
GO

CREATE CLUSTERED INDEX IX_CustFeedbackArea ON CustFeedbackArea ([CustID], [FuncID])	