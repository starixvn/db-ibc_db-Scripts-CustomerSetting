/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20250411@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]
*/
-- Peak Hour Spread
--===================================================================================
--ALTER TABLE dbo.CustomerClassSpreadClass ADD [ID] [INT] NULL
--GO
ALTER TABLE dbo.CustomerClassSpreadClass_UAT ADD [ID] [INT] NULL
GO
/***************************************************************************/
--ALTER TABLE dbo.CustomerClassSpreadDetail ADD [ID] [INT] NULL
--GO
--ALTER TABLE dbo.CustomerClassSpreadDetail_UAT ADD [ID] [INT] NULL
--GO
/***************************************************************************/
IF EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadLeagueGroup')
BEGIN
	DROP TABLE CustomerClassSpreadLeagueGroup
END
GO

CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup](
	[PolicyID] [INT] NOT NULL,
	[LeagueGroupID] [SMALLINT] NOT NULL,
	[ID] [INT] NULL,
	[RepUpdateTime] DATETIME2 NULL ,
 CONSTRAINT [PK_CustomerClassSpreadLeagueGroup] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[LeagueGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustomerClassSpreadLeagueGroup] ADD  CONSTRAINT [DF_CustomerClassSpreadLeagueGroup_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadLeagueGroup]') AND name = N'IX_CustomerClassSpreadLeagueGroup_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadLeagueGroup_RepUpdateTime] ON [dbo].[CustomerClassSpreadLeagueGroup]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassPeakHourRanger')
BEGIN
	DROP TABLE CustomerClassPeakHourRanger
END
GO
CREATE TABLE [dbo].[CustomerClassPeakHourRanger](
	[RangeID] [INT] IDENTITY(1,1) NOT NULL,
	[WeekDay] [TINYINT] NOT NULL,
	[StartRange] [TIME](1) NOT NULL,
	[EndRange] [TIME](1) NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [INT] NULL,
	[LastModifiedTime] [DATETIME] NULL,
	[RepUpdateTime] DATETIME2 NULL ,
 CONSTRAINT [PK_CustomerClassPeakHourRanger] PRIMARY KEY CLUSTERED 
(
	[WeekDay] ASC,
	[StartRange] ASC,
	[EndRange] ASC,
	[RangeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO
ALTER TABLE [dbo].[CustomerClassPeakHourRanger] ADD  CONSTRAINT [DF_CustomerClassPeakHourRanger_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPeakHourRanger]') AND name = N'IX_CustomerClassPeakHourRanger_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassPeakHourRanger_RepUpdateTime] ON [dbo].[CustomerClassPeakHourRanger]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadLeagueGroup_UAT')
BEGIN
	DROP TABLE CustomerClassSpreadLeagueGroup_UAT
END
GO

CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup_UAT](
	[PolicyID] [INT] NOT NULL,
	[LeagueGroupID] [SMALLINT] NOT NULL,
	[ID] [INT] NULL,
	[RepUpdateTime] DATETIME2 NULL ,
 CONSTRAINT [PK_CustomerClassSpreadLeagueGroup_UAT] PRIMARY KEY CLUSTERED 
(
	[PolicyID] ASC,
	[LeagueGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO

ALTER TABLE [dbo].[CustomerClassSpreadLeagueGroup_UAT] ADD  CONSTRAINT [DF_CustomerClassSpreadLeagueGroup_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadLeagueGroup_UAT]') AND name = N'IX_CustomerClassSpreadLeagueGroup_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadLeagueGroup_UAT_RepUpdateTime] ON [dbo].[CustomerClassSpreadLeagueGroup_UAT]
	(
		[RepUpdateTime] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [DATA]
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadLeagueGroup_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[LeagueGroupID] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadLeagueGroup_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSpreadLeagueGroup_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSpreadLeagueGroup_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSpreadLeagueGroup_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadLeagueGroup_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadLeagueGroup_UAT_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup_UAT_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[LeagueGroupID] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadLeagueGroup_UAT_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSpreadLeagueGroup_UAT_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSpreadLeagueGroup_UAT_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSpreadLeagueGroup_UAT_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadLeagueGroup_UAT_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassPeakHourRanger_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassPeakHourRanger_Del_InHouse]
	(
		[RangeID] [INT] NOT NULL
		,[WeekDay] [TINYINT] NOT NULL
		,[StartRange] [TIME] NOT NULL
		,[EndRange] [TIME] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPeakHourRanger_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassPeakHourRanger_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassPeakHourRanger_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassPeakHourRanger_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPeakHourRanger_Del_InHouse exists!!!'
END
GO
/***************************************************************************/