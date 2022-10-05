/*<info serverAlias="DBCUST-CUSTDB"></info>*/
/*
	Created: Eden@20220824
	Task: CREATE TABLES FOR FLEXIBLE INITIAL SETTING - DEPOSIT [Redmine: #169648]   
	DB: DBCUST/CUSTDB
*/
USE [CustDB]
GO
/*
DROP TABLE [dbo].[Dep_Initial_ProductConfig]
DROP TABLE [dbo].[Dep_Initial_ProductConfig_Detail]
DROP TABLE [dbo].[Dep_Initial_BetSetting]
DROP TABLE [dbo].[Dep_Initial_Super]
DROP TABLE [dbo].[Dep_Initial_StepByConfig]
DROP TABLE [dbo].[Dep_ProductSettingType]
GO
*/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dep_Initial_ProductConfig](
	[ConfigID] [int] NOT NULL IDENTITY(1,1) NOT FOR REPLICATION,
	[ProductID] [tinyint] NOT NULL,
	[SportTypeList] [varchar](300) NOT NULL,
	[BetTypeList] [varchar](300) NOT NULL,
	[Site] [varchar](max) NOT NULL,
	[Currency] [varchar](max) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[IsTest] [bit] NOT NULL,
	[Status] [tinyint] NULL,
	[CurrentStep] [tinyint] NULL,
	[ProcessedStep] [varchar](500) NULL,
	[Remark] [varchar](1000) NULL,
 CONSTRAINT [PK_Dep_Initial_ProductConfig] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO


CREATE TABLE [dbo].[Dep_Initial_ProductConfig_Detail](
	[ConfigID] [int] NOT NULL,
	[SportType] [smallint] NOT NULL,
	[BetType] [smallint] NOT NULL,
	[IsLive] [bit] NOT NULL,
	[SettingType] [tinyint] NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[DefaultValueSuper] [decimal](11,8) NULL,
	[DefaultValueMaster] [decimal](11,8) NULL,
	[DefaultValueAgent] [decimal](11,8) NULL,
	[DefaultValueMember] [decimal](11,8) NULL,
	[SpecialRequirement] [varchar](MAX) NULL,
 CONSTRAINT [PK_Dep_Initial_ProductConfig_Detail] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC,
	[SportType] ASC,
	[BetType] ASC,
	[IsLive] ASC,
	[SettingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

CREATE TABLE [dbo].[Dep_Initial_BetSetting](
	 ConfigID int NOT NULL
	,Currency int NOT NULL
	,SportType smallint NOT NULL
	,BetType smallint NOT NULL
	,MinBet	money NULL
	,MaxBet	money NULL
	,MaxPerMatch money NULL
	,MaxPerNumber money NULL
	,MaxPayoutPerMatch money NULL
 CONSTRAINT [PK_Dep_Initial_Dep_Initial_BetSetting] PRIMARY KEY CLUSTERED 
(
	[ConfigID] ASC,
	[Currency] ASC,
	[SportType] ASC,
	[BetType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]
GO

CREATE TABLE [dbo].[Dep_Initial_Super](
	[CustID] [int] NOT NULL,
	[CurrentStep] [tinyint] NULL,
 CONSTRAINT [PK_Dep_Initial_Super] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]

GO

CREATE TABLE [dbo].[Dep_Initial_StepByConfig](
	[StepID] [tinyint] NOT NULL,
	[IsScanCustomer] [BIT] NULL,
	[SortOrder] [tinyint] IDENTITY(1,1)
) ON [DATA]

GO

CREATE TABLE [dbo].[Dep_ProductSettingType](
	SettingType [tinyint] NOT NULL,
	SettingName [varchar](30) NULL,
	SettingNameDetail [varchar](30) NULL
 CONSTRAINT [PK_Dep_ProductSettingType] PRIMARY KEY CLUSTERED 
(
	[SettingType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DATA]
) ON [DATA]



