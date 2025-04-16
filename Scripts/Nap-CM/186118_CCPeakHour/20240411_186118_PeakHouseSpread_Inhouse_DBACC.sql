/*<info serverAlias="DBACC-bodb02 "></info>*/
USE CustDB
GO
/*
	Created: 20250411@Winfred
	DB: DBACC-bodb02
	Task:  [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]
*/
-- Peak Hour Spread
--===================================================================================
ALTER TABLE dbo.CustomerClassSpreadClass ADD [ID] [INT] NULL
GO
ALTER TABLE dbo.CustomerClassSpreadClass_UAT ADD [ID] [INT] NULL
GO
/***************************************************************************/
ALTER TABLE dbo.CustomerClassSpreadDetail ADD [ID] [INT] NULL
GO
ALTER TABLE dbo.CustomerClassSpreadDetail_UAT ADD [ID] [INT] NULL
GO
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
/***************************************************************************/
