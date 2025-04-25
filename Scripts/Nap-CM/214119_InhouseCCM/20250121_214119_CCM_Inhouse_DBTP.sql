/*<info serverAlias="IRS_DBTP-bodb02 "></info>*/
/*
	Created: 20241008@Winfred
	DB: IRS_DBTP-bodb02
	Task: Apply Inhouse replication for Customer Class
	Revisions:
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #214119]
*/
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassPolicyManagement]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyManagement]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyManagement]
	(
		[PolicyID] [INT] IDENTITY(1,1) NOT NULL
		,[PolicyTitle] [VARCHAR](500) NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassPolicyManagement] PRIMARY KEY CLUSTERED ([PolicyID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPolicyManagement] ADD CONSTRAINT [DF_CustomerClassPolicyManagement_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassPolicyManagement] ADD CONSTRAINT [DF_CustomerClassPolicyManagement_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyManagement exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyManagement]') AND name = N'IX_CustomerClassPolicyManagement_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassPolicyManagement_RepUpdateTime] ON [dbo].[CustomerClassPolicyManagement]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassPolicyManagement_UAT]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyManagement_UAT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyManagement_UAT]
	(
		[PolicyID] [INT] IDENTITY(1,1) NOT NULL
		,[PolicyTitle] [VARCHAR](500) NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassPolicyManagement_UAT] PRIMARY KEY CLUSTERED ([PolicyID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPolicyManagement_UAT] ADD CONSTRAINT [DF_CustomerClassPolicyManagement_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassPolicyManagement_UAT] ADD CONSTRAINT [DF_CustomerClassPolicyManagement_UAT_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyManagement_UAT exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyManagement_UAT]') AND name = N'IX_CustomerClassPolicyManagement_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassPolicyManagement_UAT_RepUpdateTime] ON [dbo].[CustomerClassPolicyManagement_UAT] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassPolicyRule]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyRule]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyRule]
	(
		[PolicyID] [INT] NOT NULL
		,[RuleID] [INT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassPolicyRule] PRIMARY KEY CLUSTERED ([PolicyID],[RuleID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPolicyRule] ADD CONSTRAINT [DF_CustomerClassPolicyRule_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassPolicyRule] ADD CONSTRAINT [DF_CustomerClassPolicyRule_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyRule exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyRule]') AND name = N'IX_CustomerClassPolicyRule_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassPolicyRule_RepUpdateTime] ON [dbo].[CustomerClassPolicyRule] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassPolicyRule_UAT]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyRule_UAT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyRule_UAT]
	(
		[PolicyID] [INT] NOT NULL
		,[RuleID] [INT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassPolicyRule_UAT] PRIMARY KEY CLUSTERED ([PolicyID],[RuleID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPolicyRule_UAT] ADD CONSTRAINT [DF_CustomerClassPolicyRule_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassPolicyRule_UAT] ADD CONSTRAINT [DF_CustomerClassPolicyRule_UAT_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyRule_UAT exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyRule_UAT]') AND name = N'IX_CustomerClassPolicyRule_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassPolicyRule_UAT_RepUpdateTime] ON [dbo].[CustomerClassPolicyRule_UAT] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassRule]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRule]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassRule]
	(
		[RuleID] [INT] IDENTITY(1,1) NOT NULL
		,[CustomerClass] [SMALLINT] NOT NULL
		,[RuleTitle] [VARCHAR](500) NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[IsLive] [TINYINT] NOT NULL
		,[DiffBalanceRatio] [DECIMAL](9,2) NULL
		,[BetDelay] [DECIMAL](9,2) NULL
		,[NextBetInterval] [SMALLINT] NULL
		,[SuperBetInterval] [SMALLINT] NULL
		,[SiteBetInterval] [SMALLINT] NULL
		,[MinBet] [INT] NULL
		,[MaxBet] [INT] NULL
		,[MaxPerMatch] [INT] NULL
		,[RepeatedBets] [TINYINT] NULL
		,[SeizeBetTicket] [TINYINT] NULL
		,[PeakHourSpreadAdjustment] [SMALLINT] NULL
		,[AgentBetInterval] [SMALLINT] NULL
		,[Enable] [BIT] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[DisableParlay] [BIT] NULL
		,[CustomerClassDetail] [SMALLINT] NULL
		,[TopPriority] [BIT] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassRule] PRIMARY KEY NONCLUSTERED ([RuleID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassRule] ADD CONSTRAINT [DF_CustomerClassRule_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassRule] ADD CONSTRAINT [DF_CustomerClassRule_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRule exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRule]') AND name = N'IX_CustomerClassRule_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassRule_RepUpdateTime] ON [dbo].[CustomerClassRule] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassRule_UAT]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRule_UAT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassRule_UAT]
	(
		[RuleID] [INT] IDENTITY(1,1) NOT NULL
		,[CustomerClass] [SMALLINT] NOT NULL
		,[RuleTitle] [VARCHAR](500) NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[IsLive] [TINYINT] NOT NULL
		,[DiffBalanceRatio] [DECIMAL](9,2) NULL
		,[BetDelay] [DECIMAL](9,2) NULL
		,[NextBetInterval] [SMALLINT] NULL
		,[SuperBetInterval] [SMALLINT] NULL
		,[SiteBetInterval] [SMALLINT] NULL
		,[MinBet] [INT] NULL
		,[MaxBet] [INT] NULL
		,[MaxPerMatch] [INT] NULL
		,[RepeatedBets] [TINYINT] NULL
		,[SeizeBetTicket] [TINYINT] NULL
		,[EnableParlay] [BIT] NULL
		,[PeakHourSpreadAdjustment] [SMALLINT] NULL
		,[AgentBetInterval] [SMALLINT] NULL
		,[Enable] [BIT] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[DisableParlay] [BIT] NULL
		,[CustomerClassDetail] [SMALLINT] NULL
		,[TopPriority] [BIT] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassRule_UAT] PRIMARY KEY NONCLUSTERED ([RuleID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassRule_UAT] ADD CONSTRAINT [DF_CustomerClassRule_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassRule_UAT] ADD CONSTRAINT [DF_CustomerClassRule_UAT_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRule_UAT exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRule_UAT]') AND name = N'IX_CustomerClassRule_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassRule_UAT_RepUpdateTime] ON [dbo].[CustomerClassRule_UAT] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassRuleLeagueGroup]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRuleLeagueGroup]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassRuleLeagueGroup]
	(
		[RuleID] [INT] NOT NULL
		,[LeagueGroupID] [SMALLINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassRuleLeagueGroup] PRIMARY KEY CLUSTERED ([RuleID],[LeagueGroupID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassRuleLeagueGroup] ADD CONSTRAINT [DF_CustomerClassRuleLeagueGroup_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassRuleLeagueGroup] ADD CONSTRAINT [DF_CustomerClassRuleLeagueGroup_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRuleLeagueGroup exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRuleLeagueGroup]') AND name = N'IX_CustomerClassRuleLeagueGroup_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassRuleLeagueGroup_RepUpdateTime] ON [dbo].[CustomerClassRuleLeagueGroup] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassRuleLeagueGroup_UAT]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRuleLeagueGroup_UAT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassRuleLeagueGroup_UAT]
	(
		[RuleID] [INT] NOT NULL
		,[LeagueGroupID] [SMALLINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassRuleLeagueGroup_UAT] PRIMARY KEY CLUSTERED ([RuleID],[LeagueGroupID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassRuleLeagueGroup_UAT] ADD CONSTRAINT [DF_CustomerClassRuleLeagueGroup_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassRuleLeagueGroup_UAT] ADD CONSTRAINT [DF_CustomerClassRuleLeagueGroup_UAT_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRuleLeagueGroup_UAT exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRuleLeagueGroup_UAT]') AND name = N'IX_CustomerClassRuleLeagueGroup_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassRuleLeagueGroup_UAT_RepUpdateTime] ON [dbo].[CustomerClassRuleLeagueGroup_UAT] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSetting]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSetting]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSetting]
	(
		[custid] [INT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[CustomerClass] [SMALLINT] NULL
		,[ModifiedDate] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSetting] PRIMARY KEY CLUSTERED ([custid],[SportType]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSetting] ADD CONSTRAINT [DF_CustomerClassSetting_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSetting] ADD CONSTRAINT [DF_CustomerClassSetting_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSetting exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSetting]') AND name = N'IX_CustomerClassSetting_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSetting_RepUpdateTime] ON [dbo].[CustomerClassSetting] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSiteManagement]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSiteManagement]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSiteManagement]
	(
		[PolicyID] [INT] NOT NULL
		,[Site] [NVARCHAR](50) NOT NULL
		,[Currency] [INT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSiteManagement] PRIMARY KEY CLUSTERED ([PolicyID],[Site],[Currency],[Platform]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSiteManagement] ADD CONSTRAINT [DF_CustomerClassSiteManagement_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSiteManagement] ADD CONSTRAINT [DF_CustomerClassSiteManagement_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSetting exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSiteManagement]') AND name = N'IX_CustomerClassSiteManagement_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSiteManagement_RepUpdateTime] ON [dbo].[CustomerClassSiteManagement] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSiteManagement_UAT]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSiteManagement_UAT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSiteManagement_UAT]
	(
		[PolicyID] [INT] NOT NULL
		,[Site] [NVARCHAR](50) NOT NULL
		,[Currency] [TINYINT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSiteManagement_UAT] PRIMARY KEY CLUSTERED ([PolicyID],[Site],[Currency],[Platform]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSiteManagement_UAT] ADD CONSTRAINT [DF_CustomerClassSiteManagement_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSiteManagement_UAT] ADD CONSTRAINT [DF_CustomerClassSiteManagement_UAT_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSiteManagement_UAT exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSiteManagement_UAT]') AND name = N'IX_CustomerClassSiteManagement_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSiteManagement_UAT_RepUpdateTime] ON [dbo].[CustomerClassSiteManagement_UAT] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSpread]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpread]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpread]
	(
		[PolicyID] [INT] IDENTITY(1,1) NOT NULL
		,[PolicyTitle] [VARCHAR](500) NOT NULL
		,[Spread] [DECIMAL](4,2) NULL
		,[Enable] [BIT] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[IsLive] [TINYINT] NULL
		,[Type] [TINYINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSpread] PRIMARY KEY CLUSTERED ([PolicyID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpread] ADD CONSTRAINT [DF_CustomerClassSpread_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSpread] ADD CONSTRAINT [DF_CustomerClassSpread_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpread exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpread]') AND name = N'IX_CustomerClassSpread_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpread_RepUpdateTime] ON [dbo].[CustomerClassSpread] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSpread_UAT]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpread_UAT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpread_UAT]
	(
		[PolicyID] [INT] IDENTITY(1,1) NOT NULL
		,[PolicyTitle] [VARCHAR](500) NOT NULL
		,[Spread] [DECIMAL](4,2) NULL
		,[Enable] [BIT] NOT NULL
		,[IsTest] [TINYINT] NOT NULL
		,[LastModifiedUser] [INT] NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[IsLive] [TINYINT] NULL
		,[Type] [TINYINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSpread_UAT] PRIMARY KEY CLUSTERED ([PolicyID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpread_UAT] ADD CONSTRAINT [DF_CustomerClassSpread_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSpread_UAT] ADD CONSTRAINT [DF_CustomerClassSpread_UAT_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpread_UAT exists!!!'

	IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassSpread_UAT'))
	BEGIN
		ALTER TABLE [CustomerClassSpread_UAT] ADD RepUpdateTime DATETIME2 NULL 
	END
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpread_UAT]') AND name = N'IX_CustomerClassSpread_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpread_UAT_RepUpdateTime] ON [dbo].[CustomerClassSpread_UAT] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSpreadClass]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadClass]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadClass]
	(
		[PolicyID] [INT] NOT NULL
		,[CustomerClass] [SMALLINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSpreadClass] PRIMARY KEY CLUSTERED ([PolicyID],[CustomerClass]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadClass] ADD CONSTRAINT [DF_CustomerClassSpreadClass_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSpreadClass] ADD CONSTRAINT [DF_CustomerClassSpreadClass_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadClass exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadClass]') AND name = N'IX_CustomerClassSpreadClass_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadClass_RepUpdateTime] ON [dbo].[CustomerClassSpreadClass] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSpreadClass_UAT]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadClass_UAT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadClass_UAT]
	(
		[PolicyID] [INT] NOT NULL
		,[CustomerClass] [SMALLINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSpreadClass_UAT] PRIMARY KEY CLUSTERED ([PolicyID],[CustomerClass]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadClass_UAT] ADD CONSTRAINT [DF_CustomerClassSpreadClass_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSpreadClass_UAT] ADD CONSTRAINT [DF_CustomerClassSpreadClass_UAT_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadClass_UAT exists!!!'

	IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassSpreadClass_UAT'))
	BEGIN
		ALTER TABLE [CustomerClassSpreadClass_UAT] ADD RepUpdateTime DATETIME2 NULL 
	END
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadClass_UAT]') AND name = N'IX_CustomerClassSpreadClass_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadClass_UAT_RepUpdateTime] ON [dbo].[CustomerClassSpreadClass_UAT] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[VRMemberBigStake]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VRMemberBigStake]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[VRMemberBigStake]
	(
		[CustID] [INT] NOT NULL
		,[Type] [TINYINT] NOT NULL
		,[FirstBetDate] [DATE] NULL
		,[Status] [TINYINT] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_VRMemberBigStake] PRIMARY KEY CLUSTERED ([CustID],[Type]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[VRMemberBigStake] ADD CONSTRAINT [DF_VRMemberBigStake_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[VRMemberBigStake] ADD CONSTRAINT [DF_VRMemberBigStake_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table VRMemberBigStake exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRMemberBigStake]') AND name = N'IX_VRMemberBigStake_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_VRMemberBigStake_RepUpdateTime] ON [dbo].[VRMemberBigStake] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSpreadDetail]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadDetail]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadDetail]
	(
		[PolicyID] [INT] NOT NULL
		,[SiteID] [INT] NOT NULL
		,[Currency] [INT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSpreadDetail] PRIMARY KEY CLUSTERED ([PolicyID],[SiteID],[Currency],[Platform],[SportType]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadDetail] ADD CONSTRAINT [DF_CustomerClassSpreadDetail_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSpreadDetail] ADD CONSTRAINT [DF_CustomerClassSpreadDetail_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadDetail exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadDetail]') AND name = N'IX_CustomerClassSpreadDetail_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadDetail_RepUpdateTime] ON [dbo].[CustomerClassSpreadDetail] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSMQueue]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSMQueue]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSMQueue]
	(
		[ID] [INT] IDENTITY(1,1) NOT NULL
		,[PolicySites] [NVARCHAR](MAX) NOT NULL
		,[UserID] [INT] NULL
		,[IsTest] [TINYINT] NOT NULL
		,[IsOverwrite] [BIT] NOT NULL
		,[IP] [NVARCHAR](50) NOT NULL
		,[ActionID] [BIT] NOT NULL
		,[LastModifiedTime] [DATETIME] NULL
		,[BatchID] [TINYINT] NOT NULL
		,[Status] [TINYINT] NOT NULL
		,[ErrCode] [INT] NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSMQueue] PRIMARY KEY CLUSTERED ([ID]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSMQueue] ADD CONSTRAINT [DF_CustomerClassSMQueue_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSMQueue] ADD CONSTRAINT [DF_CustomerClassSMQueue_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSMQueue exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSMQueue]') AND name = N'IX_CustomerClassSMQueue_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSMQueue_RepUpdateTime] ON [dbo].[CustomerClassSMQueue] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/
--DROP TABLE [dbo].[CustomerClassSpreadDetail_UAT]
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadDetail_UAT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadDetail_UAT]
	(
		[PolicyID] [INT] NOT NULL
		,[SiteID] [INT] NOT NULL
		,[Currency] [INT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		,[RepUpdateTime] [DATETIME2](7) NULL
		,[isDeleted] [BIT] NULL
		,CONSTRAINT [PK_CustomerClassSpreadDetail_UAT] PRIMARY KEY CLUSTERED ([PolicyID],[SiteID],[Currency],[Platform],[SportType]) ON [DATA]
	) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadDetail_UAT] ADD CONSTRAINT [DF_CustomerClassSpreadDetail_UAT_isDeleted]  DEFAULT ((0)) FOR [isDeleted]
	
	ALTER TABLE [dbo].[CustomerClassSpreadDetail_UAT] ADD CONSTRAINT [DF_CustomerClassSpreadDetail_UAT_RepUpdateTime]  DEFAULT (SYSDATETIME()) FOR [RepUpdateTime]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadDetail_UAT exists!!!'
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadDetail_UAT]') AND name = N'IX_CustomerClassSpreadDetail_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadDetail_UAT_RepUpdateTime] ON [dbo].[CustomerClassSpreadDetail_UAT] 
	(
	  [RepUpdateTime] ASC
	)ON [DATA]
GO
/***************************************************************************/