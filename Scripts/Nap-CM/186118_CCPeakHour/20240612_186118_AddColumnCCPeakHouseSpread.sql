/*<info serverAlias="DBCUST-CustDB"></info>*/
USE CustDB
GO
/*
	Created: 20240612@Winfred
	DB: DBCUST/CustDB
	Task:  [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]
*/
-- Peak Hour Spread
--===================================================================================
ALTER TABLE dbo.CustomerClassSpread ADD IsLive TINYINT NULL
GO

ALTER TABLE dbo.CustomerClassSpread ADD Type TINYINT NOT NULL CONSTRAINT [DF_CustomerClassSpread_Type] DEFAULT ((1))
GO

UPDATE dbo.CustomerClassSpread SET Type = 1
GO

--DROP TABLE CustomerClassSpreadLeagueGroup
--Go
CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup](
	[PolicyID] [int] NOT NULL,
	[LeagueGroupID] [smallint] NOT NULL,
	[RepUpdateTime] DATETIME2 NULL ,
 CONSTRAINT [PK_CustomerClassSpreadLeagueGroup] PRIMARY KEY CLUSTERED 
(
	[LeagueGroupID] ASC,
	[PolicyID] ASC
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
--DROP TABLE CustomerClassPeakHourRanger
--Go
CREATE TABLE [dbo].[CustomerClassPeakHourRanger](
	[RangeID] [int] IDENTITY(1,1) NOT NULL,
	[WeekDay] [tinyint] NOT NULL,
	[StartRange] [Time](1) NOT NULL,
	[EndRange] [Time](1) NOT NULL,
	[IsTest] [TINYINT]  NOT NULL,
	[LastModifiedUser] [int] NULL,
	[LastModifiedTime] [datetime] NULL,
 CONSTRAINT [PK_CustomerClassPeakHourRanger] PRIMARY KEY CLUSTERED 
(
	[WeekDay] ASC,
	[StartRange] ASC,
	[EndRange] ASC,
	[RangeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [DATA]
) ON [DATA]
GO
--================================UAT===================================================
ALTER TABLE dbo.CustomerClassSpread_UAT ADD IsLive TINYINT NULL
GO

ALTER TABLE dbo.CustomerClassSpread_UAT ADD Type TINYINT NOT NULL CONSTRAINT [DF_CustomerClassSpread_UAT_Type] DEFAULT ((1))
GO
--DROP TABLE CustomerClassSpreadLeagueGroup_UAT
--Go
CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup_UAT](
	[PolicyID] [int] NOT NULL,
	[LeagueGroupID] [smallint] NOT NULL,
	[RepUpdateTime] DATETIME2 NULL ,
 CONSTRAINT [PK_CustomerClassSpreadLeagueGroup_UAT] PRIMARY KEY CLUSTERED 
(
	[LeagueGroupID] ASC,
	[PolicyID] ASC
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
