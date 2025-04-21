/*<info serverAlias="DBCustRepl-ReplCustDB" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250411@Winfred	
	Task: In-House
	DB: ReplCustDB
	
	Revisions:
		- 20250411@Winfred: [NAP CM] Customer Class - Add Peak Hour Spread on rule setting [186118]

	Example:			
*/
--===================================================================================
ALTER TABLE dbo.CustomerClassSpreadClass ADD [ID] [INT] NULL
GO
--ALTER TABLE dbo.CustomerClassSpreadClass_UAT ADD [ID] [INT] NULL
--GO
/***************************************************************************/
ALTER TABLE dbo.CustomerClassSpreadDetail ADD [ID] [INT] NULL
GO
--ALTER TABLE dbo.CustomerClassSpreadDetail_UAT ADD [ID] [INT] NULL
--GO
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




