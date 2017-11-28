/*
	Created by: Elodie
	Date: 20170915
	Task: Prepare structure to manage headline max loss [Redmine:#82892]	
*/
----------------------------------------------------------------
--Add new table to DBAGE.bodb_Age.dbo.LimitLoss_HeadlineSetting-
----------------------------------------------------------------
USE [bodb_Age]
GO

/****** Object:  Table [dbo].[LimitLoss_HeadlineSetting] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].LimitLoss_HeadlineSetting(
	[GroupHeadlineID] [int] NOT NULL,
	[MaxLoss] [money] NOT NULL,
	[TotalBalance] [money] NULL,
	[LevelID] [tinyint] NOT NULL,
	[YesterdayBalance] [money] NULL,
	[OldLevelID] [tinyint] NULL,
 CONSTRAINT [PK_LimitLoss_HeadlineSetting] PRIMARY KEY CLUSTERED 
(
	[GroupHeadlineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [ageDATA]
) ON [ageDATA]

GO

ALTER TABLE [dbo].LimitLoss_HeadlineSetting ADD  CONSTRAINT [DF_LimitLoss_HeadlineSetting_LevelID]  DEFAULT ((0)) FOR [LevelID]
GO


ALTER TABLE LimitLoss_Setting ALTER COLUMN MaxLoss MONEY NULL