/*
	Created: 20200310@Eden
	Task: Create table VRSetting_AutoUpdate_ByExcel [RM#128749]
	DB: DBCUST/CustDB
*/
USE [CustDB]
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
