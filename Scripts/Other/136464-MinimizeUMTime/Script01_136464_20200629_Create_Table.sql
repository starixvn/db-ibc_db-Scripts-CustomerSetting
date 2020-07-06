/*<info serverAlias="DBCUST-CustDB"></info>*/
/*
	Created: 20200629@Eden
	Task: Create UMConfig table [Redmine:#136507]	
		SettingType : SettingType of ProductSettingDetail Table
		FunctionType : 1.Edit , 2.Addnew, 3...
	DB: DBCUST/CustDB
*/

USE [CustDB]
GO
--ALTER TABLE [dbo].[UMConfig] DROP CONSTRAINT [DF_UMConfig_IsLive]
--GO
--DROP TABLE [dbo].[UMConfig]
--GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UMConfig](
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
	[LastModifyDTS] [datetime] NULL,
CONSTRAINT [PK_UMConfig] PRIMARY KEY CLUSTERED 
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [BetRestriction]

) ON [Data]

GO
--ALTER TABLE [dbo].[UMConfig] ADD  CONSTRAINT [DF_UMConfig_IsLive]  DEFAULT ((0)) FOR [IsLive]
--ALTER TABLE [dbo].[UMConfig] ADD  CONSTRAINT [DF_UMConfig_FunctionType]  DEFAULT ((1)) FOR [FunctionType]
GO

