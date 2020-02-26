/*
	Created: Eden
	Date: 20200226
	Task: Create table VRSetting_AutoUpdate_VirtualRate [Redmine:#126243]	
	DB: DBCust/CustDB
*/
USE [CustDB]
GO
--DROP TABLE [dbo].[VRSetting_AutoUpdate_VirtualRate]
--GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VRSetting_AutoUpdate_VirtualRate](
	[CustId] [int] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SportType] [int] NOT NULL,
	[VRLeagueGroupId] [smallint] NOT NULL,
	[VRBettypeGroupId] [smallint] NOT NULL,
	[BetType] [int] NOT NULL,
	[VirtualMultiplier] [smallmoney] NULL,
	[CreatedDate] [datetime] NULL,
	CONSTRAINT [PK_VRSetting_AutoUpdate_VirtualRate] PRIMARY KEY CLUSTERED 
	(
		[CustId] ASC,
		[SportType] ASC,
		[IsLive] ASC,
		[VRLeagueGroupId] ASC,
		[VRBettypeGroupId] ASC,
		[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON virtualrate_table
) ON virtualrate_table
GO


