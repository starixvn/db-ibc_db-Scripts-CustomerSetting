/*<info serverAlias="IRS_DBTP-bodb02" executers="" isFunction="0" isNested="0"></info>*/
/*
	Created: 20250313@Winfred	
	Task:  [NAP CM] Customer - Increase Bet Limit In-House 
	DB: IRS_DBTP-bodb02
	
	Revisions:
		- 20250313@Winfred:  [NAP CM] Customer - Increase Bet Limit Created [RedmineID: #218073]

	Example:			
*/
--DROP TABLE [dbo].[SVIPMaxBetPlayer]
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'SVIPMaxBetPlayer')
BEGIN
	CREATE TABLE [dbo].[SVIPMaxBetPlayer]
	(
		[SiteID] [INT] NOT NULL
		,[custid] [INT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[Bettype] [SMALLINT] NOT NULL
		,[Multiplier] [DECIMAL](9,2) NULL
		,[Note] [NVARCHAR](1000) NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_SVIPMaxBetPlayer] PRIMARY KEY CLUSTERED ([SiteID],[custid],[SportType],[Bettype]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[SVIPMaxBetPlayer] ADD CONSTRAINT [DF_SVIPMaxBetPlayer_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[SVIPMaxBetPlayer] ADD CONSTRAINT [DF_SVIPMaxBetPlayer_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_SVIPMaxBetPlayer_RepUpdateTime] ON [dbo].[SVIPMaxBetPlayer] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table SVIPMaxBetPlayer exists!!!'
END
GO
/***************************************************************************/
--DROP TABLE [dbo].[SVIPMaxBetHistory]
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'SVIPMaxBetHistory')
BEGIN
	CREATE TABLE [dbo].[SVIPMaxBetHistory]
	(
		[ID] [INT] IDENTITY(1,1) NOT NULL
		,[SiteID] [INT] NOT NULL
		,[custid] [INT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[Bettype] [SMALLINT] NOT NULL
		,[Multiplier] [DECIMAL](9,2) NULL
		,[IsTest] [TINYINT] NOT NULL
		,[Action] [VARCHAR](10) NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_SVIPMaxBetHistory] PRIMARY KEY CLUSTERED ([ID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[SVIPMaxBetHistory] ADD CONSTRAINT [DF_SVIPMaxBetHistory_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[SVIPMaxBetHistory] ADD CONSTRAINT [DF_SVIPMaxBetHistory_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
	
	CREATE NONCLUSTERED INDEX [IX_SVIPMaxBetHistory_RepUpdateTime] ON [dbo].[SVIPMaxBetHistory] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table SVIPMaxBetHistory exists!!!'
END
GO
/***************************************************************************/




