/*
	Created: 20200310@Eden
	Task: Create table VRSettingManualUpdAcc [RM#128749]
	DB: DBCUST/CustDB
*/
USE [CustDB]
GO
--DROP TABLE [dbo].[VRSettingManualUpdAcc]
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[VRSettingManualUpdAcc](
	[SportType] [smallint] NOT NULL,
	[CustID] [int] NOT NULL
 CONSTRAINT [PK_VRSettingManualUpdAcc] PRIMARY KEY CLUSTERED 
(
	[SportType] ASC,
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [virtualrate_table]
) ON [virtualrate_table]

GO


CREATE TABLE [dbo].[VRSetting_AutoUpdate_VirtualRate_ByExcel](
	[CustId] [int] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SportType] [int] NOT NULL,
	[VRLeagueGroupId] [int] NOT NULL,
	[VRBettypeGroupId] [int] NOT NULL,
	[Bettype] [int] NOT NULL,
	[VirtualMultiplier] [smallmoney] NULL,
	[CreatedDate] [datetime] NULL DEFAULT GETDATE(),
	[ImportedBy] [int] NOT NULL
CONSTRAINT [PK_VRSetting_AutoUpdate_VirtualRate] PRIMARY KEY CLUSTERED 
	(
		[CustId] ASC,
		[SportType] ASC,
		[IsLive] ASC,
		[VRLeagueGroupId] ASC,
		[VRBettypeGroupId] ASC,
		[Bettype] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON virtualrate_table
) ON virtualrate_table
GO