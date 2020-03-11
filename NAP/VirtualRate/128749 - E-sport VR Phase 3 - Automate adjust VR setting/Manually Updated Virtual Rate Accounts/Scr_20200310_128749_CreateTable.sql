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

--DROP TABLE [dbo].[VRSetting_AutoUpdate_ByExcel]

CREATE TABLE [dbo].[VRSetting_AutoUpdate_ByExcel](
	[SessionID] [UNIQUEIDENTIFIER] NOT NULL,
	[CustId] [int] NOT NULL,
	[SportType] [int] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[LevelID] [int] NOT NULL,
	[VirtualMultiplier] [smallmoney] NULL,
	[ImportedBy] [int] NULL,
	[CreatedDate] [datetime] NULL DEFAULT GETDATE()
CONSTRAINT [PK_VRSetting_AutoUpdate_VirtualRate] PRIMARY KEY CLUSTERED 
(	
	[SessionID] ASC,
	[CustId] ASC,
	[LevelID] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON virtualrate_table
) ON virtualrate_table
GO
