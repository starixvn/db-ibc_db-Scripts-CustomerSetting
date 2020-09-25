/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200925@Eden
	Task: Create UMConfig_UAT table --> clone structure from UMConfig Table for UAT testing [Redmine:#136464]	
	DB: DBCUST/CustDB and DBTXN/CustDB
*/

USE [CustDB]
GO
--DROP TABLE [dbo].[UMConfig_UAT]
--GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UMConfig_UAT](
	[ProductID] [tinyint] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
	[FunctionType] [tinyint] NOT NULL,
	[SiteID] [int] NOT NULL,
	[Currency] [int] NOT NULL,
	[SuperID] [int] NOT NULL,
	[BeginTime] [smalldatetime] NULL,
	[EndTime] [smalldatetime] NULL,
	[Time_Stamp] [TimeStamp] NULL,
CONSTRAINT [PK_UMConfig_UAT] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC,
	[SportType] ASC,
	[SettingType] ASC,
	[FunctionType] ASC,
	[SiteID] ASC,
	[Currency] ASC,
	[SuperID] ASC,
	[BetType] ASC,
	[IsLive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Data]

) ON [Data]
GO
