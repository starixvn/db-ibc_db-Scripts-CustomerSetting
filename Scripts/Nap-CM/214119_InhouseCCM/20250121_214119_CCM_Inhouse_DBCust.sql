/*<info serverAlias="DBCust-CustDB"></info>*/
/*
	Created: 20250121@Winfred
	DB: DBCust-CustDB
	Task: Apply Inhouse replication for Customer Class
	Task: 
		- 20250121@Winfred: [NAP CM] Scale Out DBCUST - Apply Inhouse replication for Customer Class[Redmine: #214119]
*/
/***************************************************************************/
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassPolicyManagement_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassPolicyManagement] DROP CONSTRAINT [DF_CustomerClassPolicyManagement_RepUpdateTime]
--END
--GO
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassPolicyRule_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassPolicyRule] DROP CONSTRAINT [DF_CustomerClassPolicyRule_RepUpdateTime]
--END
--GO
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassRule_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassRule] DROP CONSTRAINT [DF_CustomerClassRule_RepUpdateTime]
--END
--GO
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassRuleLeagueGroup_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassRuleLeagueGroup] DROP CONSTRAINT [DF_CustomerClassRuleLeagueGroup_RepUpdateTime]
--END
--GO
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassSetting_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassSetting] DROP CONSTRAINT [DF_CustomerClassSetting_RepUpdateTime]
--END
--GO
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassSiteManagement_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassSiteManagement] DROP CONSTRAINT [DF_CustomerClassSiteManagement_RepUpdateTime]
--END
--GO
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassSpread_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassSpread] DROP CONSTRAINT [DF_CustomerClassSpread_RepUpdateTime]
--END
--GO
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassSpreadClass_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassSpreadClass] DROP CONSTRAINT [DF_CustomerClassSpreadClass_RepUpdateTime]
--END
--GO
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassSpreadDetail_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassSpreadDetail] DROP CONSTRAINT [DF_CustomerClassSpreadDetail_RepUpdateTime]
--END
--GO
--IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CustomerClassSpreadDetail_UAT_RepUpdateTime]') AND type = 'D')
--BEGIN
--	ALTER TABLE [dbo].[CustomerClassSpreadDetail_UAT] DROP CONSTRAINT [DF_CustomerClassSpreadDetail_UAT_RepUpdateTime]
--END
--GO

IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassPolicyRule_UAT'))
BEGIN
	ALTER TABLE [CustomerClassPolicyRule_UAT] ADD RepUpdateTime DATETIME2 NULL 
	
	ALTER TABLE [dbo].[CustomerClassPolicyRule_UAT] ADD  CONSTRAINT [DF_CustomerClassPolicyRule_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassPolicyManagement_UAT'))
BEGIN
	ALTER TABLE [CustomerClassPolicyManagement_UAT] ADD RepUpdateTime DATETIME2 NULL 
	
	ALTER TABLE [dbo].[CustomerClassPolicyManagement_UAT] ADD  CONSTRAINT [DF_CustomerClassPolicyManagement_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassRule_UAT'))
BEGIN
	ALTER TABLE [CustomerClassRule_UAT] ADD RepUpdateTime DATETIME2 NULL 

	ALTER TABLE [dbo].[CustomerClassRule_UAT] ADD  CONSTRAINT [DF_CustomerClassRule_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassRuleLeagueGroup_UAT'))
BEGIN
	ALTER TABLE [CustomerClassRuleLeagueGroup_UAT] ADD RepUpdateTime DATETIME2 NULL 

	ALTER TABLE [dbo].[CustomerClassRuleLeagueGroup_UAT] ADD  CONSTRAINT [DF_CustomerClassRuleLeagueGroup_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime]
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassSiteManagement_UAT'))
BEGIN
	ALTER TABLE [CustomerClassSiteManagement_UAT] ADD RepUpdateTime DATETIME2 NULL

	ALTER TABLE [dbo].[CustomerClassSiteManagement_UAT] ADD  CONSTRAINT [DF_CustomerClassSiteManagement_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime] 
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassSpread_UAT'))
BEGIN
	ALTER TABLE [CustomerClassSpread_UAT] ADD RepUpdateTime DATETIME2 NULL 

	ALTER TABLE [dbo].[CustomerClassSpread_UAT] ADD  CONSTRAINT [DF_CustomerClassSpread_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime] 
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassSpreadClass_UAT'))
BEGIN
	ALTER TABLE [CustomerClassSpreadClass_UAT] ADD RepUpdateTime DATETIME2 NULL 

	ALTER TABLE [dbo].[CustomerClassSpreadClass_UAT] ADD CONSTRAINT [DF_CustomerClassSpreadClass_UAT_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime] 
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'VRMemberBigStake'))
BEGIN
	ALTER TABLE [VRMemberBigStake] ADD RepUpdateTime DATETIME2 NULL 

	ALTER TABLE [dbo].[VRMemberBigStake] ADD  CONSTRAINT [DF_VRMemberBigStake_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime] 
END
GO
IF NOT EXISTS(SELECT 1 FROM sys.columns WHERE Name = N'RepUpdateTime' AND Object_ID = Object_ID(N'CustomerClassSMQueue'))
BEGIN
	ALTER TABLE [CustomerClassSMQueue] ADD RepUpdateTime DATETIME2 NULL 

	ALTER TABLE [dbo].[CustomerClassSMQueue] ADD  CONSTRAINT [DF_CustomerClassSMQueue_RepUpdateTime]  DEFAULT (sysdatetime()) FOR [RepUpdateTime] 
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyRule_UAT]') AND name = N'IX_CustomerClassPolicyRule_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassPolicyRule_UAT_RepUpdateTime] ON [dbo].[CustomerClassPolicyRule_UAT]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassPolicyManagement_UAT]') AND name = N'IX_CustomerClassPolicyManagement_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassPolicyManagement_UAT_RepUpdateTime] ON [dbo].[CustomerClassPolicyManagement_UAT]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRule_UAT]') AND name = N'IX_CustomerClassRule_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassRule_UAT_RepUpdateTime] ON [dbo].[CustomerClassRule_UAT]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassRuleLeagueGroup_UAT]') AND name = N'IX_CustomerClassRuleLeagueGroup_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassRuleLeagueGroup_UAT_RepUpdateTime] ON [dbo].[CustomerClassRuleLeagueGroup_UAT]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSiteManagement_UAT]') AND name = N'IX_CustomerClassSiteManagement_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSiteManagement_UAT_RepUpdateTime] ON [dbo].[CustomerClassSiteManagement_UAT]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpread_UAT]') AND name = N'IX_CustomerClassSpread_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpread_UAT_RepUpdateTime] ON [dbo].[CustomerClassSpread_UAT]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSpreadClass_UAT]') AND name = N'IX_CustomerClassSpreadClass_UAT_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSpreadClass_UAT_RepUpdateTime] ON [dbo].[CustomerClassSpreadClass_UAT]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VRMemberBigStake]') AND name = N'IX_VRMemberBigStake_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_VRMemberBigStake_RepUpdateTime] ON [dbo].[VRMemberBigStake]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CustomerClassSMQueue]') AND name = N'IX_CustomerClassSMQueue_RepUpdateTime')
	CREATE NONCLUSTERED INDEX [IX_CustomerClassSMQueue_RepUpdateTime] ON [dbo].[CustomerClassSMQueue]
	(
		[RepUpdateTime] ASC
	) ON [DATA]
GO

IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassPolicyManagement_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyManagement_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPolicyManagement_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassPolicyManagement_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassPolicyManagement_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassPolicyManagement_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyManagement_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassPolicyManagement_UAT_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyManagement_UAT_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPolicyManagement_UAT_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassPolicyManagement_UAT_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassPolicyManagement_UAT_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassPolicyManagement_UAT_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyManagement_UAT_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassPolicyRule_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyRule_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[RuleID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPolicyRule_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassPolicyRule_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassPolicyRule_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassPolicyRule_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyRule_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassPolicyRule_UAT_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassPolicyRule_UAT_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[RuleID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassPolicyRule_UAT_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassPolicyRule_UAT_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassPolicyRule_UAT_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassPolicyRule_UAT_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassPolicyRule_UAT_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassRule_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassRule_Del_InHouse]
	(
		[RuleID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassRule_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassRule_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassRule_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassRule_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRule_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassRule_UAT_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassRule_UAT_Del_InHouse]
	(
		[RuleID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassRule_UAT_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassRule_UAT_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassRule_UAT_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassRule_UAT_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRule_UAT_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassRuleLeagueGroup_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassRuleLeagueGroup_Del_InHouse]
	(
		[RuleID] [INT] NOT NULL
		,[LeagueGroupID] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassRuleLeagueGroup_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassRuleLeagueGroup_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassRuleLeagueGroup_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassRuleLeagueGroup_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRuleLeagueGroup_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassRuleLeagueGroup_UAT_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassRuleLeagueGroup_UAT_Del_InHouse]
	(
		[RuleID] [INT] NOT NULL
		,[LeagueGroupID] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassRuleLeagueGroup_UAT_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassRuleLeagueGroup_UAT_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassRuleLeagueGroup_UAT_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassRuleLeagueGroup_UAT_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassRuleLeagueGroup_UAT_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSetting_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSetting_Del_InHouse]
	(
		[custid] [INT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSetting_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSetting_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSetting_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSetting_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSetting_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSiteManagement_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSiteManagement_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[Site] [NVARCHAR](50) NOT NULL
		,[Currency] [INT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSiteManagement_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSiteManagement_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSiteManagement_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSiteManagement_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSiteManagement_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSiteManagement_UAT_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSiteManagement_UAT_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[Site] [NVARCHAR](50) NOT NULL
		,[Currency] [TINYINT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSiteManagement_UAT_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSiteManagement_UAT_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSiteManagement_UAT_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSiteManagement_UAT_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSiteManagement_UAT_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpread_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpread_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpread_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSpread_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSpread_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSpread_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpread_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpread_UAT_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpread_UAT_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpread_UAT_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSpread_UAT_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSpread_UAT_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSpread_UAT_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpread_UAT_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadClass_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadClass_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[CustomerClass] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadClass_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSpreadClass_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSpreadClass_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSpreadClass_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadClass_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadClass_UAT_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadClass_UAT_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[CustomerClass] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadClass_UAT_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSpreadClass_UAT_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSpreadClass_UAT_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSpreadClass_UAT_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadClass_UAT_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'VRMemberBigStake_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[VRMemberBigStake_Del_InHouse]
	(
		[CustID] [INT] NOT NULL
		,[Type] [TINYINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[VRMemberBigStake_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_VRMemberBigStake_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_VRMemberBigStake_Del_InHouse_RepUpdateTime] ON [dbo].[VRMemberBigStake_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table VRMemberBigStake_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadDetail_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadDetail_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[SiteID] [INT] NOT NULL
		,[Currency] [INT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadDetail_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSpreadDetail_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSpreadDetail_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSpreadDetail_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadDetail_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSMQueue_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSMQueue_Del_InHouse]
	(
		[ID] [INT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSMQueue_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSMQueue_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSMQueue_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSMQueue_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSMQueue_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
IF NOT EXISTS (SELECT * FROM sys.OBJECTS WHERE NAME = 'CustomerClassSpreadDetail_UAT_Del_InHouse')
BEGIN
	CREATE TABLE [dbo].[CustomerClassSpreadDetail_UAT_Del_InHouse]
	(
		[PolicyID] [INT] NOT NULL
		,[SiteID] [INT] NOT NULL
		,[Currency] [INT] NOT NULL
		,[Platform] [TINYINT] NOT NULL
		,[SportType] [SMALLINT] NOT NULL
		) ON [DATA]

	ALTER TABLE [dbo].[CustomerClassSpreadDetail_UAT_Del_InHouse] ADD [RepUpdateTime] DATETIME2(7) CONSTRAINT [DF_CustomerClassSpreadDetail_UAT_Del_InHouse_RepUpdateTime] DEFAULT (SYSDATETIME())

	CREATE CLUSTERED INDEX [CIX_CustomerClassSpreadDetail_UAT_Del_InHouse_RepUpdateTime] ON [dbo].[CustomerClassSpreadDetail_UAT_Del_InHouse]([RepUpdateTime] ASC) ON [DATA]
END
ELSE 
BEGIN
	SELECT 'Table CustomerClassSpreadDetail_UAT_Del_InHouse exists!!!'
END
GO
/***************************************************************************/
