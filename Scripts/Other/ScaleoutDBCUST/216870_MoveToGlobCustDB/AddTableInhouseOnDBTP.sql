/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250305@Johnson	
	Task: In-House
	DB: 
	
	Revisions:
		- 20250305@Johnson: Created [RedmineID: #216870]

	Example:			
*/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'Winlimit_ProductGlobalSetting')
BEGIN
	CREATE TABLE [dbo].[Winlimit_ProductGlobalSetting]
	(
		[ProductID] [INT] NOT NULL
		,[BetTypeID] [SMALLINT] NOT NULL
		,[GroupID] [INT] NOT NULL
		,[GroupName] [VARCHAR](200) NULL
		,[Level1] [MONEY] NULL
		,[Level2] [MONEY] NULL
		,[Level3] [MONEY] NULL
		,[Level101] [MONEY] NULL
		,[Level102] [MONEY] NULL
		,[blockedTransferLvl3] [BIT] NULL
		,[Currency] [INT] NOT NULL
		,[IsDeposit] [BIT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_Winlimit_ProductGlobalSetting] PRIMARY KEY CLUSTERED ([ProductID],[BetTypeID],[GroupID],[Currency],[IsDeposit]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting] ADD CONSTRAINT [DF_Winlimit_ProductGlobalSetting_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[Winlimit_ProductGlobalSetting] ADD CONSTRAINT [DF_Winlimit_ProductGlobalSetting_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_Winlimit_ProductGlobalSetting_RepUpdateTime] ON [dbo].[Winlimit_ProductGlobalSetting] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table Winlimit_ProductGlobalSetting exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'Winlimit_Group')
BEGIN
	CREATE TABLE [dbo].[Winlimit_Group]
	(
		[GroupID] [INT] NOT NULL
		,[GroupName] [VARCHAR](200) NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_Winlimit_Group] PRIMARY KEY CLUSTERED ([GroupID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[Winlimit_Group] ADD CONSTRAINT [DF_Winlimit_Group_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[Winlimit_Group] ADD CONSTRAINT [DF_Winlimit_Group_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_Winlimit_Group_RepUpdateTime] ON [dbo].[Winlimit_Group] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table Winlimit_Group exists!!!'
END
GO
/***************************************************************************/




