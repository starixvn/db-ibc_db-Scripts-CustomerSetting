/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250411@Winfred	
	Task: In-House
	DB: bodb02
	
	Revisions:
		- 20250411@Winfred: [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]

	Example:			
*/
--===================================================================================
-- Run Phase sau
--ALTER TABLE dbo.CustomerClassSpreadClass_UAT ADD [ID] [INT] NULL
--GO
/***************************************************************************/
IF EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassPeakHourRanger')
DROP TABLE CustomerClassPeakHourRanger;
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassPeakHourRanger')
BEGIN
	CREATE TABLE [dbo].[CustomerClassPeakHourRanger]
	(
		[RangeID] [INT] NOT NULL
		,[WeekDay] [TINYINT] NOT NULL
		,[StartRange] [TIME] NOT NULL
		,[EndRange] [TIME] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassPeakHourRanger] PRIMARY KEY CLUSTERED ([RangeID],[WeekDay],[StartRange],[EndRange]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPeakHourRanger] ADD CONSTRAINT [DF_CustomerClassPeakHourRanger_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassPeakHourRanger] ADD CONSTRAINT [DF_CustomerClassPeakHourRanger_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_CustomerClassPeakHourRanger_RepUpdateTime] ON [dbo].[CustomerClassPeakHourRanger] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPeakHourRanger exists!!!'
END
GO
/***************************************************************************/
IF EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadLeagueGroup')
DROP TABLE CustomerClassSpreadLeagueGroup;
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadLeagueGroup')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup]
	(
		[PolicyID] [INT] NOT NULL
		,[LeagueGroupID] [SMALLINT] NOT NULL
		,[ID] [INT] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSpreadLeagueGroup] PRIMARY KEY CLUSTERED ([PolicyID],[LeagueGroupID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadLeagueGroup] ADD CONSTRAINT [DF_CustomerClassSpreadLeagueGroup_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSpreadLeagueGroup] ADD CONSTRAINT [DF_CustomerClassSpreadLeagueGroup_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadLeagueGroup_RepUpdateTime] ON [dbo].[CustomerClassSpreadLeagueGroup] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadLeagueGroup exists!!!'
END
GO
/***************************************************************************/
-- Run Phase sau
--IF EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadLeagueGroup_UAT')
--DROP TABLE CustomerClassSpreadLeagueGroup_UAT;
--IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadLeagueGroup_UAT')
--BEGIN
--	CREATE TABLE [dbo].[CustomerClassSpreadLeagueGroup_UAT]
--	(
--		[PolicyID] [INT] NOT NULL
--		,[LeagueGroupID] [SMALLINT] NOT NULL
--		,[ID] [INT] NULL
--		,[RepUpdateTime] [DATETIME2](7) NULL
--		,[isDeleted] [BIT] NULL
--		,CONSTRAINT [PK_CustomerClassSpreadLeagueGroup_UAT] PRIMARY KEY CLUSTERED ([PolicyID],[LeagueGroupID]) ON [DATA]
--	) ON [DATA]

--	ALTER TABLE [dbo].[CustomerClassSpreadLeagueGroup_UAT] ADD CONSTRAINT [DF_CustomerClassSpreadLeagueGroup_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
--	ALTER TABLE [dbo].[CustomerClassSpreadLeagueGroup_UAT] ADD CONSTRAINT [DF_CustomerClassSpreadLeagueGroup_UAT_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
--	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadLeagueGroup_UAT_RepUpdateTime] ON [dbo].[CustomerClassSpreadLeagueGroup_UAT] 
--	(
--	  [RepUpdateTime] ASC
--	)ON [DATA]
--END
--ELSE 
--BEGIN
--	SELECT 'Table CustomerClassSpreadLeagueGroup_UAT exists!!!'
--END
--GO
/***************************************************************************/




